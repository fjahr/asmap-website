---
layout: page
title: Sourcing Data
permalink: /sourcing-data/
---

The major challenge remaining for ASmap is to source and aggregate data about which AS owns which IP address range. Several entities, public and private, make BGP announcement data available. The following data sources represent the current state of research, and all remain incomplete or problematic in some way.

#### RIPE RIS

RIPE RIS has been used as the source for all ASMaps so far, but the project describes itself the data as "useful for looking at the state of the BGP Internet, debugging/post-mortems of events in BGP, and tracking of long-term trends in BGP" [RIS docs](https://ris.ripe.net/docs/mrt/). As such, data is collected for research purposes to observe and examine malicious behavior after the fact and learn from it. This means RIS would go out of its way to include data such as BGP hijacks and fat-finger type of leaks. There is no filtering or clean-up (after a leak was identified) of this data. The RRC's location and functionality are also publicly known so sending malicious announcements with the goal of getting them into RIS is comparatively easy.

This means the RIS data is not used anywhere else to inform routing decisions directly, to my knowledge we would be the first to use the data in this way. RIS is also a more centralized solution than the alternatives, though RIPE remains an important data source and thus would not be a sound data source to build on.

I believe we fare best if we only use RIPE RIS and comparable data sources as the input of last resort, when certain mappings are not available anywhere else.

#### RPKI

We can download RPKI ROAs and build a prefix to AS mapping from it that is validated by the trust chain from one of the RIRs. This gives us a much higher quality of data.

Open-source validator software that does most of the heavy lifting for us is available. The most likely candidates to be used are rpki-client [8] and Routinator [9] as shown by analysis of a variety of factors recently [10].

The downside of RPKI is that its data is not complete since RPKI is not as widely deployed as we would like. If RPKI is not deployed by an AS their prefixes cannot be validated and will not be present in an RPKI repository. In my last test a few weeks ago, I found about 60% of the Bitcoin network can be validated. This is a good base but not enough.

On the plus side: RPKI adoption is growing [11] so we can expect further improvements in data completeness over time. To some degree, it would also be interesting to call the wider bitcoin community's attention to this and ask them to check if their hosting provider has already implemented RPKI and if that is not the case message them that it would be a good idea to do it.

#### IRR

The IRR (Internet Routing Registry) is a distributed set of databases that are individually operated by organizations and contain routing information for networks on the internet. It is used by network operators to register and maintain information about the internet routes that they use to reach other networks. IRR is the de-facto bridging option for route filtering today even though they have a very loose security model. This has been known for a long time. There’s no cryptographic signing of records. Records exist within some IRRs that are both clearly false and incomplete, often due to a lack of maintenance of the party that announced the outdated information.

There are multiple suppliers of IRR data, and some are better than others. Particularly those IRRs that are not bound to a specific RIR, such as RADB and AltDB seem to be more vulnerable. A recent attack in the crypto space was able due to AltDB's open nature [6]. RADB is also open, only requiring a membership fee. However, the IRR DBs operated by the RIRs provide not perfect but much better security since they have the actual data of their customers, they can compare received data with. They manage all the prefixes and can verify the registration of IRR objects with address ownership information [7].

IRR is not a perfect data source, but the data should still be of higher quality than the RIPE RIS data. This is why I propose to use the RIR IRR DBs as additional input for the prefix to AS mapping and prefer their input over RIPE RIS mappings.

#### Combining sources (merging)

Kartograf uses RPKI as the base dataset, and augments it with IRR and RIS data if needed. If the base RPKI dataset doesn’t map a specific IP range yet (partially or fully) but the augmenting dataset has a mapping for this IP range then this new mapping will be added.

There seems to be no good way to improve or audit the ASmap's data quality by applying generic validation rules, detecting errors, or comparing data from one source to itself from different points in time. This makes even basic auditing of the ASMap data input nearly impossible as it functions today. The reason is that the global internet routing table is a very complex data set that is constantly in flux and does not follow any systematic rules for public announcement. Unfortunately, there seems to be no silver bullet.

