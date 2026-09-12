---
layout: default
title: About
permalink: /about/
nav_order: 2
---

## AS, RIR, and BGP
---------

_The following is introductory information on Autonomous Systems (AS) and BGP, as well as prior art on ASmap. A [Glossary](/glossary) is provided._

The allocation of IP address space on the Internet begins with the *Internet Assigned Numbers Authority* (IANA), which allocates IP address ranges to a *Regional Internet Registry* (RIR). This RIR then assigns IP address ranges to an AS they control. They then announce to the world which AS controls which IP address range via the *Border Gateway Protocol* (BGP).

Governments around the world have their own reserved ranges, as do *Internet Service Providers* (ISP) and some commercial entities. For example, Amazon has their own AS, as does Cloudflare, and therefore each has control over IP addresses in a given range. Cloudflare has a [good explainer](https://www.cloudflare.com/learning/network-layer/what-is-an-autonomous-system/) about AS and where they fit in the Internet’s architecture. Each AS is given a number to be identified by.

### The Problem

The central problem is that sharing a route via BGP relies on trust, in the sense that an AS implicitly trusts the routes that are shared with them. We are presented with the challenge that _the root address space protocol of the Internet has no measures against malicious announcements or errors_, and so an important part of the ASmap project is to develop heuristics to parse the BGP data correctly, to the extent possible.

 Bitcoin Core began implementing some measures to address eclipse attacks several years ago. From Gleb Naumenko's July 2020 "Call to Action" [post](https://blog.bitmex.com/call-to-action-testing-and-improving-asmap/):

> "To increase the cost of these attacks, Bitcoin Core started diversifying peer connections by what is called a netgroup bucketing. For instance, if you take a simple IP address like “172.16.254.1”, Bitcoin Core connects to at most one IP which looks like “172.16.any.any” (if possible).

> The assumption was that it would be more difficult for an attacker to create fake nodes in different netgroups. This was based on the expectation that netgroups roughly correspond to regions and internet providers, therefore running fake nodes would require negotiating with many actors and make bulk deals less useful.

> [...] Unfortunately, the assumption that netgroups correspond to regions and internet providers no longer holds. Over the past years, IPv4 addresses have become more fluid, in the sense that they are traded between entities and resulting mapping is now in many cases near-random. For example, Amazon now controls many IP ranges."

What is needed is a way to map a network to the AS that owns it, in order to bucket peers by AS instead of by netgroups. This is what the `-asmap` flag in Bitcoin Core enables. To learn how to use it, see [Usage](/usage); to learn how to make such a map of the Internet in the first place, see [Sourcing Data](/sourcing-data).
