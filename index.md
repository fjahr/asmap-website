---
layout: default
title: Home
nav_order: 1
---

## The ASmap Project
---------

The ASmap project exists to provide the ability to generate maps of IP address ranges to the Autonomous System (AS) they belong to, and use these ASmaps in Bitcoin Core.

Any distributed system is, to some extent, subject to attacks like an [eclipse attack](https://bitcoinops.org/en/topics/eclipse-attacks/), where weaknesses in peer discovery lead to nodes being partitioned from the broader network. Bitcoin Core's peer management prevents attacks of this type by grouping peers by their IP address range, and blocking connections above a certain count of peers from a given network. However, a single AS entity can control many IP address ranges, and in recent years these IP ranges have started to change hands more frequently. What we want is a map of IP addresses to the AS they belong to, so that a node can ensure that it is not connecting to peers under the control of a single AS. Grouping our peers by AS makes these types of attacks much more difficult: by using the ASmap feature in Core, a node can further prevent getting partitioned from the network.

Since [Core 20.0](https://github.com/bitcoin/bitcoin/blob/master/doc/release-notes/release-notes-0.20.0.md#new-settings), users can pass their own ASmap file to Core. In order to generate such a map, however, we need to source the most complete and up-to-date set of IP-to-AS mappings. Beginning with [Core 31.0](https://github.com/bitcoin/bitcoin/blob/master/doc/release-notes/release-notes-31.0.md#p2p-and-network-changes), an ASmap is embedded directly with the release binary, but the feature remains off by default. This website is intended to present the current state of research on sourcing this data, generating such mappings, and using them in Core.

Development typically occurs in the [asmap](https://github.com/asmap/) organization on Github, with publicly available datasets posted to the [asmap-data](https://github.com/bitcoin-core/asmap-data) repository.

Generating the ASmap relies on data that must be sourced from best-effort public announcements in several places and parsed carefully to detect errors and misattributions. To learn more about the sourcing of this AS data, see [Sourcing Data](/content/data-sourcing.md).

