---
layout: page
title: Bitcoin Core
permalink: /bitcoin-core/
---

## Motivation

Since the usage of ASMap for peer bucketing is positive for a user's peer diversity which results in higher security, we want to encourage usage of ASMap among users. However, currently the adoption of the ASMap feature needs to be assumed to be minimal since the activation of is first requires creating or procuring an ASMap file and then passing it as an option to the node during startup. Aside from the common wisdom that most users don't change the defaults this is hindered further by the fact that there is no trustworthy source that regularly provides ASMap files for download and the tools available for creating an ASMap file are scattered across multiple projects.

## ToDos

There are only a handful of changes necessary in the Bitcoin Core project with the goal of tool consolidation and the actual embedding of the data. A list of the related issues and PRs is maintained in the [project tracking issue on GitHub](https://github.com/bitcoin/bitcoin/issues/28794).

## ASMap usage and deployment in practice

Aside from the code changes mentioned above, a process needs to be defined how the data to be embedded is created. Based on a previous proposal and some previous feedback the current suggestion for this is as follows:

- A repository for management of ASMap data is created under the bitcoin core org (see [fjahr/asmap-data](https://github.com/bitcoin/bitcoin/issues/28794) for an example of how this might look in practice).
- Any contributor can open issues to coordinate the collaborative creation of a new ASMap file (see coordinated launch in Kartograf, and a [the example in fjahr/asmap-data](https://github.com/fjahr/asmap-data/issues/4)). If multiple collaborators have created a result file with the same hash, this improves trust in the validity of input data and the final result. Effectively the trust in the input data is federated.
- Independent of a previous collaboration any user can open PRs to the repository, adding the raw input data as well as the final result to the repository. Reviewers can reproduce the final result from the raw input files and confirm that the raw input file was not manipulated. Reviewers may prefer files that were previously created by multiple collaborators.
- Any user that would like to run their node with a fresh ASMap file can now turn to the asmap-data repository in the bitcoin core org and download the latest ASMap file available.
- As a new Bitcoin Core release nears, any contributor can take any of the files from the asmap-data repository and open a PR to Bitcoin Core with this file to suggest it be the file that is embedded in the final release. It will be up to reviewers to decide if the particular file is good enough or if a different one is preferred.
