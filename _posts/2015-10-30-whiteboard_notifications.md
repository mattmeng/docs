---
title: Whiteboard Notifications
authors:
  - name: David Handy
    email: David.Handy@intel.com
layout: post
categories: rfc whiteboard
date:   2015-10-30 10:15:00
---

## Introduction
Whiteboard currently runs our suite of system tests against every build of 
select Jenkins projects. Users can already view the results of completed test
runs in the whiteboard UI. Additionally, emails are sent when a test run
completes, summarizing the test results. These emails are sent out to a fairly
static list of people on each run. The purpose of this document is to identify
what information should be sent in notifications, who should receive them, and
when the notifications should be sent.

## Summary 

This document will detail a system for notifying engineers and other interested
parties about the status of test runs. When a test transitions from working to
broken, all engineers who committed to the project between the working and the
broken build will receive emails stating that they may have broken the build.
They will continue to receive these emails each build until the broken tests
are fixed. In addition, there will be a system allowing people to subscribe to
test results with the following parameters:

* What tests do I care about?
  * Specific branches
  * Specific test tags
* What do I want to see?
  * Specific test results (what tests are broken? what is their output?)
  * Overall test run summary
  * Trends of test results over time
  * Custom templates (when the above options don't leave you feeling satisfied)
* When do I want a notification?
  * Every build
  * Only when the test run fails
  * Only when the test run changes state
    * A previously working test breaks
    * A previously broken test is fixed
    * When either of the above occurs

## Who Should Recieve Notifications?

### Committers Who May Have Broken the Build

When a test fails, if it was succeeding on the previous test run, it is likely
that the failure was caused by one of the commits that was included since the
last test run. Therefore, a notification will be sent to each committer 
detailing what test results have changed and inviting them to figure out
whether their commit is the offender.

### Interested Parties

In addition to notifications sent to those who committed to core before it
broke, other people will be interested in data about automation runs. There
will, therefore, be a system that allows a user to select what information
they want to see, as well as when they want to receive it (selecting from the
options enumerated in "When Should Notifications be Sent?"). 

A user will be able to select the types of information (enumerated in the
section "What Information Should be Included in Notifications?"), as well 
as selecting which branches they want notifications about, and whether they
only want information about tests associated with certaion tags.

NOTE: The notifications to committers from the previous section will receive 
emails regardless of their settings in this system.

## What Information Should be Included in Notifications?

There are several different types of notification data that whiteboard will be
able to send to subscribers. These include specific test results, overall
result summaries of a test run, and trends of test runs over time.

### Specific Test Results

Specific test result notifications will include a list of all failing tests,
with the command-line output from the test. There will be a dedicated section
for new failures (tests that are now failing but weren't with the previous 
run), but all tests currently failing will be detailed. 

NOTE: This is the notification format that will be sent to committers who may
have broken the build.

### Overall Result Summary

Overall result summaries will contain the information that is currently being
sent from whiteboard, namely: Total number of tests, number of tests passed,
number of tests failed, number of tests skipped and, where available, coverage
metrics. This information is more pertinent to those who are more interested in
a high level understanding of the current health of the project than with the 
specific issues detected.

### Trends of Test Runs Over Time

Trends of test runs over time will contain the same numbers as the overall
result summary, but will display trends indicating the change in these numbers
over time. This type of information is relevant to those who are asking
questions like "Is [insert practice or tool] making a positive difference in
our project?".

### Custom Notification Templates

In addition to the pre-built notification types, users will be able to create
custom templates if there is a specific type of information they desire which
can be gleaned from the data that whiteboard stores about test runs. 

## When Should Notifications be Sent?

In general, we have identified three triggers that may cause different types of
users to be interested in receiving opt-in notifications. Some users may desire
to see data about tests every time a test runs. For most, however, this will
make it more difficult to separate informational notifications from more
critical notifications about a negative change in the test results. Therefore,
users will have two other modes to choose from. They may elect to receive a 
notification every time there is a test failure (meaning they would get a
notification on every test run until all failures are fixed), or they may
elect to only receive notifications when a test transitions state (either goes
from working to broken, or vice versa). A user may further elect to receive 
notification only when it transitions from good to bad (when something breaks),
when it transitions from bad to good (when it is fixed), or both. 

NOTE: Those who were identified as potential committers of broken code will
automatically receive notifications every build until the tests that 
transitioned from working to broken in the original build are all again 
passing.
