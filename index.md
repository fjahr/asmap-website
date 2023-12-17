---
layout: home
---

This website presents background and state of current research on ASMap development and usage.

## Introduction

The ASMap project began in 2019 with the goal to help diversify a node's peerset and prevent reliance on too few Autonomous System (AS) entities. Various attacks have been described which can leverage weaknesses in peer discovery to partition a node from the broader network, for example in the case of an [eclipse attack](https://bitcoinops.org/en/topics/eclipse-attacks/). What we want is a map of IP addresses to the AS they belong to, so that we can ensure a node isn't hosting a number of peers under the control of a single AS entity, and thus raise the cost of an attacker successfully eclipsing our node from the broader network.

Historically, Bitcoin Core has used netgroup bucketing to diversify a node's peer set. However, given the dynamic nature of IP address allocation and their frequent exchange, a given entity may own IP address ranges across many netgroups. Thus netgroup bucketing is insufficient to properly ensure a diverse peer set.

Since Core 20.0, users can pass their own (compressed) ASmap file to core, which will honor the AS map in addition to netgroup bucketing. In order to generate such a map, however, we need to source the most complete and up-to-date set of IP-to-AS mappings. This website is intended to present the current state of research on sourcing this data, generating such mappings, and using them in Core.

Generating the IP-to-AS map relies on data that must be sourced from best-effort public announcements in several places and parsed carefully to detect errors and misattributions. To learn more about the sourcing of this AS data, see [Sourcing Data](../data-sourcing.md).

Index:
- Background and Research
    - [Background](../background)
    - [Sourcing Data](../sourcing-data)
    - [Tools and Resources](../tools-and-resources)
- [Contributing](../contributing.md)
- [In Bitcoin Core](../bitcoin-core.md)
- [Glossary](../glossary)
