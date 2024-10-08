---
layout: default
title: In Bitcoin Core
permalink: /bitcoin-core/
nav_order: 3
---

## ASmap in Bitcoin Core

---------------------

Using an ASmap file in one's Bitcoin Core configuration is already strictly better than the default, and so we want to encourage usage of ASmap among users. However, currently the adoption of the ASmap feature must be assumed to be minimal, since doing so requires creating or procuring an ASMap file and then passing it as an option to the node during startup. Aside from the common wisdom that most users don't change the defaults, there is no trusted way to provide ASmap files for download.

## Usage

`bitcoind` will accept a compressed ASmap file with the `-asmap` startup option.
You can download a pre-made [latest_asmap.dat](https://github.com/asmap/asmap-data/blob/main/latest_asmap.dat) file in the [asmap-data](https://github.com/asmap/asmap-data) repo.

#### Create an ASmap with Kartograf

You can choose to generate an ASmap file yourself. [Kartograf](https://github.com/asmap/kartograf) is a tool that fetches AS data from multiple sources, combines them, and produces a file with raw map data that can be used in Bitcoin Core after being compressed.

#### Compress it with `asmap-tool`

If you generate a file yourself, you must compress it before passing it to `bitcoind`. [asmap-tool](https://github.com/bitcoin/bitcoin/tree/master/contrib/asmap) is a Python script to help encode/compress an ASmap file. `asmap-tool` is included in the Bitcoin Core repository.

#### ASmap Health Check

If an ASmap is provided when starting bitcoind, a health check will run during startup and then every 24 hours. It logs the level of coverage the ASmap provides for all the clearnet addresses known to our node. For example:
```
ASMap Health Check: 32546 clearnet peers are mapped to 3127 ASNs with 113 peers being unmapped
```
Meaning, there are AS mappings available for the IPs of 32546 of our peers. 113 peers don't have an AS mapping for their IP in the provided ASmap.

#### ASmap fields in RPC

If ASmap is enabled, the `getpeerinfo` RPC command's response will include `mapped_as` field, indicating which AS this peer's IP was mapped to via the given ASmap, if any.

Similarly, the `getrawaddrman` RPC command's response will include `source_mapped_as` field, indicating which AS this peer's source IP was mapped to, if any (as of Bitcoin Core [v28.0](https://github.com/bitcoin/bitcoin/blob/1147e72953d1f262111a4b1d5a438a8394511bc7/src/rpc/net.cpp#L1160)).

#### Inspecting assignment changes between two ASmaps

The `contrib/asmap-tool.py` script provides a `diff-addrs` command to show changes in AS mappings between two ASmaps. The output will show the peer IP addresses, and their new status: assigned (or reassigned) from previous AS to the new AS. It takes a set of peers in the format of the `getnodeaddresses` RPC, and two different ASmaps to measure changes as arguments:
```
$ contrib/asmap/asmap-tool.py diff-addrs <asmap-1> <asmap-2> <(bitcoin-cli getnodeaddresses 0)
```
This allows a node operator to see the changes that a known IP address's AS assignment underwent in a given timespan, defined by the times at which the ASmaps was generated. If an `unassigned` value is returned as either the original or latest AS assignment, it means that the ASmap provided did not have a mapping for the IP address given.

## TODO

See the project [tracking issue](https://github.com/bitcoin/bitcoin/issues/28794) on GitHub.

Changes required to Bitcoin Core are fairly minimal, with the goal of tool consolidation and the actual embedding of the data. Embedding an ASmap file at release time is the next significant milestone.

## ASMap usage and deployment in practice

Aside from the code changes mentioned above, a process needs to be defined regarding how the data embedded with Bitcoin Core is created. Based on a previous proposal and some previous feedback the current proposal for this is as follows:

- A repository for management of ASMap data is created under the bitcoin core org (see [asmap/asmap-data](https://github.com/bitcoin/bitcoin/issues/28794) for an example of how this might look in practice).
- Any contributor can open issues to coordinate the collaborative creation of a new ASMap file (see coordinated launch in Kartograf, and a [the example in asmap/asmap-data](https://github.com/asmap/asmap-data/issues/4)). If multiple collaborators have created a result file with the same hash, this improves trust in the validity of input data and the final result. Effectively the trust in the input data is federated.
- Independent of a previous collaboration, any user can open PRs to the repository, adding the raw input data as well as the final result to the repository. Reviewers can reproduce the final result from the raw input files and confirm that the raw input file was not manipulated. Reviewers may prefer files that were previously created by multiple collaborators.
- Any user that would like to run their node with a fresh ASMap file can now turn to the asmap-data repository in the bitcoin core org and download the latest ASMap file available.
- As a new Bitcoin Core release nears, any contributor can take any of the files from the asmap-data repository and open a PR to Bitcoin Core with this file to suggest it be the file that is embedded in the final release. It will be up to reviewers to decide if the particular file is good enough or if a different one is preferred.
