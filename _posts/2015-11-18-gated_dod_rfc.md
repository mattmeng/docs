---
title: Gated Definition of Done Review RFC
authors:
  - name: JT Dewey
    email: jt.dewey@intel.com
  - name: Matt Meng
    email: matt.meng@intel.com
layout: post
categories: rfc dod quality
date:   2015-11-18 12:00:00
---

To discuss this RFC, please visit [https://discourse.ida.lab/t/gated-definition-of-done-review-rfc/55/1](https://discourse.ida.lab/t/gated-definition-of-done-review-rfc/55/1).

![Gated DoD Review](/files/gates.png)

### Vision

In order to provide Engineering with a process that protects the product from unexpected bugs (as much as is possible) and to promote a flexible, developer-driven testing paradigm, we propose the following gated definition of done review process.

#### Problem

Consider several factors that are important when discussing the gated DoD review process:

* **Accountability:** The DoD provides Managers with a list of deliverables that can be tracked and statistically reported on.  It gives them confidence that tasks are getting accomplished and provides them a mechanism to follow up with teams.
* **Reporting:** Management often desires the ability to track progress on stories.  By providing a simple gated mechanism, we can report "this story is on gate 3" and provide immediate feedback on the progress of the story.
* **Eliminate Silos of Knowledge:** This process promotes mentorship and learning by sharing knowledge through planning and reviews.  Developers who have much of the knowledge of a specific area are said to be a silo of knowledge.  This process attempts to help spread the knowledge around.
* **Ownership:** It should give teams a sense of ownership, because much of the DoD should be negotiated by teams with the PO.
* **Time Investment:** A process that helps to validate the completion of the DoD should be as lightweight as possible so as to avoid burdening the team and others with unnecessary work.
* **Group Discussion and Healthy Debate:** Opening up discussion to everyone improves the quality of the final solution.  Healthy and respectful debate fosters creativity and promotes the best ideas.  The review process should facilitate discussion and debate.
* **Self-Improvement:** There is always something you can learn.  Having someone skilled review and constructively criticize ones work can help one become a better developer.  The review shouldn't be dreaded as a critiquing session, but as a self-improvement opportunity.
* **Commitment to the Definition of Done:** Above all other points, we must make it our culture to only accept a 100% complete DoD, at every level (from Developer to VP).

#### Solution

The process we propose attempts to split the burden of work among several parties such that everyone shares in the added burden of the process.  There are four gates that must be passed by each story or defect before it can be finished and merged into a mainline branch.  If any gate is not completed, the story or defect is reevaluated and does not move forward.

### Gate 1: Team Planning

![Gate 1](/files/gate_1.png)

#### Vision: The Design Review

This gate establishes the DoD for the story or defect.  Its purpose is to give the team a chance to help define the DoD and refine their ability to estimate.  The Scrum Team assigned to work on the story or defect are responsible for working with the PO to accomplish the following:

#### Responsibilities

1. While the number of unit tests is variable, the team should commit to 100% code coverage for new, and where possible old, code.
2. Decides which BVT, Basic and/or Comprehensive level tests need to be included for each story or group of stories. Add them to the definition of done for each story (so that it is recorded).
3. If it is a story:
  * Create acceptance criteria for the story to be considered complete (which are testable, thorough and documented in the VersionOne story).
  * Include at least one Acceptance level test built according to the acceptance criteria.
4. Includes this additional work in estimates.
5. Records in the story/defect possible areas of impact that could/should be tested (see [Area of Impact Report](#area-of-impact-report)).
6. After everything is accepted by the PO and the story is committed to by the team, the **Scrum Master** marks the story/defect as having completed Gate 1.
7. *In exceptional circumstances, the **PO** can authorize overriding gate 1 by marking his/her authorization in the story/defect and enumerating the points above that are being overridden.*

#### Deliverables

* Augmented VersionOne stories or Bugzilla defects that include:
  * Refined definition of done with tailored testing requirements
  * Potentially impacted areas
  * Acceptance criteria
  * Record of Gate 1 completion

### Gate 2: Team and PO Review (*The Informal Code Review*)

![Gate 2](/files/gate_2.png)

#### Vision: The Informal Code Review

This gate gives the team an opportunity to have the PO evaluate their work and whether it meets the DoD as outlined in [Gate 1](#gate-1-team-planning).  Its purpose is to give the PO a chance to decide whether or not the work done meets the acceptance criteria and DoD.

#### Responsibilities

1. Team members review each other's work on a regular basis (as in during the sprint, not necessarily at the end), also paying close attention to the number of new tests and their pass/fail status.
2. Teams should work toward a completed DoD.
3. The team member responsible for the burden of work creates a WIP Merge Request (using the "WIP:" tag in GitLab) that records the definition of done and how it has been achieved (see [Merge Request DoD Template](#merge-request-dod-template) below).
4. Review areas of impact and reports them to Architecture team (see [Area of Impact Report](#area-of-impact-report) below).
5. Validate automation passes.
6. The **Product Owner** records definition of done completion in the Merge Request and signs-off on it.  **He/she** also records the completion of Gate 2 in the story/defect.
7. *In exceptional circumstances, the **PO** can authorize overriding gate 2 by marking his/her authorization in the story/defect and enumerating the points above that are being overridden.*

#### Deliverables

* Completed Story
* Completed Tests
* Completed DoD
* Passing Automation
* WIP Merge Request
* Area of Impact Report
* Record of Gate 2 completion in VersionOne

### Gate 3: Mentor Review

![Gate 3](/files/gate_3.png)

#### Vision: The Formal Code Review

This gate gives the team an opportunity to have their work evaluated by a peer and receive constructive criticism on improvements that could be made in the future.  Its purpose is to help spread knowledge around about product areas as well as best practices and software development principles.  **This is not a gate that is meant to make the team go back and fix trivial issues.  Only major issues should prevent the story or defect from moving forward.**

#### Responsibilities

1. Mentors can meet together at a scheduled time in an open format to resolve these merge requests together.
2. Ensures completeness of code changes and tests.
3. Reviews Areas of Impact Report.
4. Validates definition of done completion.
5. Validates automation passes.
6. Validates best practices are followed.
7. Returns to the team if incomplete, otherwise records their authorization for the merge to happen.
8. Removes WIP from the title of the Merge Request.
9. Assigns the Merge Request to the Release Team.
10. Records the completion of Gate 3 in the story or defect.
11. *In exceptional circumstances, the **PO** can authorize overriding gate 3 by marking his/her authorization in the story/defect and enumerating the points above that are being overridden.*

#### Deliverables

* Completed authorization from the Mentor
* Merge Request assigned to Release Team
* Record of Gate 3 completion in VersionOne

### Gate 4: Release Team Review

![Gate 4](/files/gate_4.png)

#### Vision: Zipping up our Dress Pants

This gate allows the Release Team to validate that everything has been taken care of and to record the completion of the story or defect.  Its purpose is to tie up all loose ends and validate that the process has been followed.

#### Responsibilities

1. Validate 100% definition of done completion.
2. Validate all automation passes.
3. Validate sign-off from Product Owner and Mentors.
4. Perform the merge.
5. Record the story in the release notes.
6. Record the completion of Gate 4 in the story or defect.
7. *In exceptional circumstances, the **PO** can authorize overriding gate 4 by marking his/her authorization in the story/defect and enumerating the points above that are being overridden.*

#### Deliverables

* Completed story merged into the appropriate branch
* Updated release notes
* Record of Gate 4 completion in VersionOne

## Templates

### Merge Request DoD Template

The merge request DoD template is based on the type of content being merged.  To add a new merge request:

1. Go to the [core/core](https://git.ida.lab/core/core) project in Gitlab.
2. Select [Merge Requests](https://git.ida.lab/core/core/merge_requests) on the left side navigation menu.
3. Click the [New Merge Request](https://git.ida.lab/core/core/merge_requests/new) button.
4. Fill out the following details:

<dl>
  <dt>Title</dt>
  <dd>The title should begin with the VersionOne or Bugzilla identifier and a succinct summary of the subject of the merge request. Add "[WIP]" or "WIP:" to make it a work-in-progress merge request.</dd>
  <dt>Description</dt>
  <dd>Should contain a more detailed explanation of the merge request (potentially coming from the story or bug description).  Additionally, contains the definition of done relevant to the story type as found below.  The definition of done can **contain links to design documentation, threat models, etc**.  This section is essentially the team's proof of completion.</dd>
  <dt>Assign to</dt>
  <dd>Assign to the appropriate party according to the gate status of the merge request.</dd>
  <dt>Milestone</dt>
  <dd>Leave blank.</dd>
  <dt>Labels</dt>
  <dd>Label as "story" or "defect" as appropriate.  Feel free to add additional labels as appropriate.</dd>
</dl>

You should have something that looks like the following:

![Merge Request](/files/gate_merge_request_1.png)

#### Story DoD

This template is generic and should be customized to fit the story.  Where appropriate, adding and removing items is encouraged.

{% highlight bash %}
#### Definition of Done

- [ ] Documentation
  - [ ] Design Review (*Architects, Mentors and Team*)
  - [ ] Acceptance Criteria (*Architects, Mentors and Team*)
  - [ ] Area of Impact Report (*Architects, Mentors and Team*)
  - [ ] Supportability Documents (*Team*)
- [ ] Formal Code Review (Includes reviewing automation. *Architects and Mentors*)
- [ ] Automation Passes (*All*)
  - [ ] *A customized list of new or modified automation for this epic goes here.*
  - [ ] *Manually tested where necessary.  All manual tests are approved here.*
- [ ] Demo (*PO and Team*)
{% endhighlight %}

#### Defect DoD

This template is generic and should be customized to fit the story.  Where appropriate, adding and removing items is encouraged.

{% highlight bash %}
- [ ] Area of Impact Report (*Architects, Mentors and Team*)
- [ ] Formal Code Review (Includes reviewing automation. *Architects and Mentors*)
- [ ] Automation Passes (*All*)
  - [ ] *A customized list of new or modified automation for this epic goes here.*
  - [ ] *Manually tested where necessary.  All manual tests are approved here.*
- [ ] Target Version reviewed (*Team and Release Team*)
{% endhighlight %}

### Area of Impact Report

An area of impact report should simply identify potential areas affected by the change, including APIs, utility functions or methods, objects, features, etc.  The purpose of the report is to provide the Architecture team with data on how pieces are linked together, as well as to detail areas of concern developers should be interested in as they develop.
