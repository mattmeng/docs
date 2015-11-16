---
title: Automation Test Runs for Topic Branches
authors:
  - name: JT Dewey
    email: jt.dewey@intel.com
layout: page
---

In order to have a full test run against your topic branch you will need to configure your branch in Jenkins to notify Whiteboard. Once your topic branch has been registered with Whiteboard, you can then run automation against it, as well as ISO Whiteboard environments to that branch.

#### Configure Your Branch in Jenkins

To do so enter the configure page of the Jenkins project for your build.

Add an endpoint in the Job Notifications Section:

![Add endpoint](/files/jenkins_add_endpoint.png)

Enter `http://whiteboard.ida.lab:8888/jenkins-builds` into the URL field. Change the Event field to `Job Finalized`. Leave the others on their default values.

![Enter URL](/files/jenkins_endpoint.png)

Be sure to click **Save** or **Apply** to keep your changes.

The next time your project builds, it will be registered on Whiteboard.

#### ISO a Whiteboard Environment

Once your branch is registered with Whiteboard, you can ISO Whiteboard environments to that branch. To do this, first go to the [ESMs](https://whiteboard.ida.lab/esms/) page of Whiteboard.

Select the ESM you would like to ISO, and click the ISO button in the actions section.

Select the build you want to use from the Topic Build dropdown.

![Select Build](/files/whiteboard_topic_build.png)

Click `Submit` to ISO the environment using that build.
