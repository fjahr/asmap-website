---
layout: default
title: Usage
permalink: /usage/
nav_order: 3
---

## ASmap in Bitcoin Core

---------------------

Using an ASmap file in one's Bitcoin Core configuration is already strictly better than the default, and so we want to encourage usage of ASmap among users.

Starting with Core 20.0, you can pass an ASmap file via the `-asmap=<filepath>` option. Sourcing the data and generating these ASmaps require some tooling.

Beginning with Core v31, an ASmap is embedded directly with the release binary, but the feature remains off by default. To enable it (as of September 2026), pass `-asmap=1` or pass an explicit filepath `-asmap=/path/to/asmap/dat`.

## Usage

`bitcoind` will accept a compressed ASmap file with the `-asmap` startup option.
You can download a pre-made [latest_asmap.dat](https://github.com/bitcoin-core/asmap-data/blob/main/latest_asmap.dat) file in the [asmap-data](https://github.com/bitcoin-core/asmap-data) repo. The `latest_asmap.dat` generated prior to a release cutoff date is embedded into the Core release.

### Create an ASmap with Kartograf

You can choose to generate an ASmap file yourself. [Kartograf](https://github.com/fjahr/kartograf) is a tool that fetches AS data from multiple sources, combines them, and produces a file with raw map data that can be used in Bitcoin Core after being compressed.

### Compress it with `asmap-tool`

If you generate a file yourself, you must compress it before passing it to `bitcoind`. [asmap-tool](https://github.com/bitcoin/bitcoin/tree/master/contrib/asmap) is a Python script to help encode/compress an ASmap file. `asmap-tool` is included in the Bitcoin Core repository.

### ASmap Health Check

If an ASmap is provided when starting bitcoind, a health check will run during startup and then every 24 hours. It logs the level of coverage the ASmap provides for all the clearnet addresses known to our node. For example:
```
ASMap Health Check: 32546 clearnet peers are mapped to 3127 ASNs with 113 peers being unmapped
```
Meaning, there are AS mappings available for the IPs of 32546 of our peers. 113 peers don't have an AS mapping for their IP in the provided ASmap.

### ASmap fields in RPC

If ASmap is enabled, the `getpeerinfo` RPC command's response will include `mapped_as` field, indicating which AS this peer's IP was mapped to via the given ASmap, if any.

Similarly, the `getrawaddrman` RPC command's response will include `source_mapped_as` field, indicating which AS this peer's source IP was mapped to, if any (as of Bitcoin Core [v28.0](https://github.com/bitcoin/bitcoin/blob/1147e72953d1f262111a4b1d5a438a8394511bc7/src/rpc/net.cpp#L1160)).

## Prior work

fjahr, brunoerg, naumekogs, and sipa contributed much of the work behind integrating ASmap data in Core.

------------------
