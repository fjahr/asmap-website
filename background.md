---
layout: page
title: Background
permalink: /background/
---

The following is background information on Autonomous Systems (AS) and BGP, as well as prior art on ASmap.

The allocation of IP address space on the Internet begins with the Internet Assigned Numbers Authority (IANA), which allocates IP address ranges to a Regional Internet Registry (RIR). This RIR then assigns IP address ranges to an AS they control. They then announce to the world which AS controls which IP address range via the Border Gateway Protocol (BGP).

Governments around the world have their own reserved ranges, as do Internet Service Providers (ISP) and some commercial entities. For example, Amazon has their own AS, as does Cloudflare, and therefore each has control over IP addresses in a given range. Cloudflare has a good explainer about AS and where they fit in the Internet’s architecture. Each AS is given a number to be identified by.

The central problem is that sharing a route via BGP relies on trust, in the sense that an AS implicitly trusts the routes that are shared with them. We are presented with the challenge that _the root address space protocol of the Internet has no measures against malicious announcements or errors_, and so an important part of the ASmap project is to develop heuristics to parse the BGP data correctly, to the extent possible.

 Bitcoin Core began implementing some measures to address eclipse attacks several years ago. From Gleb Naumenko's July 2020 "Call to Action" post:

> "To increase the cost of these attacks, Bitcoin Core started diversifying peer connections by what is called a netgroup bucketing. For instance, if you take a simple IP address like “172.16.254.1”, Bitcoin Core connects to at most one IP which looks like “172.16.any.any” (if possible).

> The assumption was that it would be more difficult for an attacker to create fake nodes in different netgroups. This was based on the expectation that netgroups roughly correspond to regions and internet providers, therefore running fake nodes would require negotiating with many actors and make bulk deals less useful.

> [...] Unfortunately, the assumption that netgroups correspond to regions and internet providers no longer holds. Over the past years, IPv4 addresses have become more fluid, in the sense that they are traded between entities and resulting mapping is now in many cases near-random. For example, Amazon now controls many IP ranges."

In Core 20.0, you could pass an asmap file via the `-asmap=<filepath>` option to ensure that your peerset was diverse enough according to AS and not just netgroup bucketing. By mapping IP ranges to AS numbers, we can build a map of the Internet address space. This would be useful to Core users, but also many other audiences who would benefit from a precise, continuous view of IP address ranges and their controlling entities.

## Existing work

rrybarczyk wrote asmap-rs to download and parse RIS raw data from the RIPE NCC and produce a IP-to-AS map file.

fjahr wrote kartograf sources data from RIPE, RPKI, and IRR databases, parses and combines the data, to produce an IP-to-AS map file.

brunoerg, sipa, and naumekogs contributed much of the work behind integrating ASmap data in Core.

Once a map file is generated via either script, one can compress it with sipa's asmap python script. The compression is necessary as Bitcoin Core will only accept a compressed file to use for its bucketing logic.
