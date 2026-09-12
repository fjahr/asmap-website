---
layout: default
title: Glossary
permalink: /glossary/
nav_order: 6
---


## Glossary

------------

#### **AS**: Autonomous System
An autonomous system is a large network or group of networks that presents a well-defined routing policy to the Internet. An autonomous system is controlled by an administrative entity, be it governmental, public, or private, and controls IP address ranges it has been issued by its local RIR.

#### **ASN**: Autonomous System Number
Every autonomous system is assigned a 16 or 32 bit integer to uniquely identify it when broadcasting messages over BGP.

#### **ASPA**: Autonomous System Provider Authorization
An emerging [standard](https://datatracker.ietf.org/doc/draft-ietf-sidrops-aspa-verification/) for guaranteeing route path integrity amongst BGP peers, therby preventing route hijacks and malicious route announcements.

#### **BGP**: Border Gateway Protocol
A protocol for autonomous systems to communicate routing policies to other autonomous systems. See [Cloudflare](https://www.cloudflare.com/learning/security/glossary/what-is-bgp/).

#### **RIR**: Regional Internet Registry
Five regional registries administer the planet’s IP address space.
- **AFRINIC**: Africa
- **APNIC**: South and East Asia, including Oceania
- **ARIN**: US & Canada
- **LACNIC**: South and Central America, Mexico, and the Caribbean
- **RIPE NCC**: Europe, Russia, Middle East

#### **RIS**: Routing Information Service
RIS is a routing data collection platform run by RIPE. See [homepage](https://www.ripe.net/analyse/internet-measurements/routing-information-service-ris/).

#### **ROA**: Route Origin Authorization
A ROA is a cryptographically signed object that states which Autonomous System is authorized to originate a particular IP address prefix or set of prefixes. See [ARIN](https://www.arin.net/resources/manage/rpki/roa_request/).

#### **RPKI**: Resource Public Key Infrastructure
From [ARIN](https://www.arin.net/resources/manage/rpki/), “RPKI uses cryptographically verifiable statements to ensure that Internet number resources are certifiably linked to the stated holders of those resources. This enables resource holders to attest which Autonomous System Numbers (ASNs) should originate their prefixes (i.e. blocks of IP addresses). Network operators can compare Border Gateway Protocol (BGP) announcements from the global Internet routing table with RPKI validity data to make informed decisions to enhance their routing security.” See [RFC](https://datatracker.ietf.org/doc/html/rfc6480).


#### **TAL**: Trust Anchor Locator
A file containing the necessary data (RPKI repository location and public key) to validate certificates and routes in a given AS, as well as create ROAs which are attested to by an entity’s RPKI. See [RFC8630](https://www.rfc-editor.org/rfc/rfc8630).

--------------------
