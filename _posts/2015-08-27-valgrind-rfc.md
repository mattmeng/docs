---
layout: post
title:  "Valgrind RFC"
authors:
  - name: JT Dewey
    email: jt.dewey@intel.com
  - name: Matt Meng
    email: matt.meng@intel.com
  - name: Eric Terry
    email: eric.terry@intel.com
  - name: Dave Handy
    email: david.handy@intel.com
  - name: Kelly Jensen
    email: kelly.jensen@intel.com
date:   2015-08-27 10:15:00
categories: rfc valgrind
---

## Summary

Steve Ridges asked us in the SI team to look into a memory profiler called Valgrind, to begin to assess memory leak issues that Core may be able to analyze and fix in the product. After research and proof of concepts, we have generated the following findings. We encourage and welcome any and all input as we try to develop an action plan for all involved parties moving forward.

If you have comments about the document below, please leave a comment on the forum post for this topic found [here](http://discourse.ida.lab/t/valgrind-memory-profiler/23).

## Valgrind Findings and Action Plan

### Database (`dbserver`)

#### Problems
* The database currently uses `ExStorage` as its memory manager. This usage is **hardcoded**, making it **impossible** to run Valgrind.

#### Solutions
* The database needs to support a flag for using a different memory profiler

### Middleware (`cpservice`)

#### Problems

* `cpserviced` also uses `ExStorage` and it is hardcoded in the `.lpi` files.
* Valgrind is essentially useless out-of-the-box, because there are thousands of false positives as a result of the FreePascal works.
* It is a *very* manual process to get Valgrind to run on our product.
* Whiteboard automation has timeouts that a slow Valgrind run will encounter. Whiteboard doesn't read the Valgrind XML files and send them out.

#### Solutions

* Although `ExStorage` is hardcoded, through build flags it can be disabled.
* We need a custom version of the FreePascal compiler. This may remove RTL false positives.
* A suppression file can be created to suppress false positives and other unwanted results. We propose that Core Engineering would be the creators of said file.
* A flag on Jenkins that will set a build as a Valgrind build that will automate the process of getting it to run on our product.
* The `cpservice` control script needs to be modified to run `cpserviced` with Valgrind
* Whiteboard can be modified to recognize a Valgrind build, adjust timeouts and read output.

#### Details

* Custom compiler
 * Provided by database team
 * We need a version of the RPM where `fpc.spec` sets the environment variable `OPT='-gv'` on all `make` commands.
* Suppression file
  * `--gen-suppressions=all` flag needs to be set when running Valgrind in order to generate a report that Core can use to create suppressions.
  * The created suppression file needs to be checked in to the core repository. The build script would reference this file.
  * When Valgrind is ran use `--suppressions=/path/to/suppressions.file`
* Jenkins build process
  * It would have a flag for a Valgrind build in the Jenkins GUI
  * Build scripts would:
    * Use the custom FreePascal compiler
    * Take out `-dUseExstorage` from these files `JobServer.lpi`, `ESSDB.lpi`, `ESS.lpi` and `cpserviced.lpi`
    * Compile with `debug=1` and `-gv` set (which allows Valgrind profiler support).
    * Install Valgrind on the box (this can manually be done with `yum install valgrind`)
    * Copy suppression file to the box
    * Set an environment variable to indicate this is a Valgrind build that `cpservicectl` will reference.
* `cpservicectl` modification
  * `cpservicectl` needs to reference the Valgrind environment variable in order to know whether to run `cpserviced` with Valgrind or not
  * Here is an example of how to have `cpservicectl` run `cpserviced` with Valgrind
    * `@command = ( '/usr/bin/valgrind', '--tool=memcheck', '--leak-check=yes', '--show-reachable=yes',
'--suppressions=/root/valgrind.supp', '--error-limit=no', '--xml=yes', '-xml-file=/root/cpserviced_valgrind_leaks.xml', @command );`
* Whiteboard modification
  * It would read the Valgrind flag in the Jenkins build arguments from the Jenkins notification post
  * Adjust timeouts
  * Downloads XML files from the ESM and attaches them to the report emails

## Action Plan Dependencies

Several items in the above action plan rely upon the completion of other items in the plan. The graph below illustrates the dependencies between the various tasks, as well as which task should be completed by core engineering (blue) and which should be completed by the Systems Integration Team (red). Tasks with no dependencies are indicated with a bold border.

![Valgrind Task Dependency Graph](/files/valgrind_partial_order.png)