From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 12:38:23 +0300
Message-ID: <94a0d4530905160238g21db0519u2e0ad7a46c6e07b9@mail.gmail.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	 <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	 <20090516092036.GD15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:25940 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZEPJiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:38:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so284269fga.17
        for <linux-omap@vger.kernel.org>; Sat, 16 May 2009 02:38:23 -0700 (PDT)
In-Reply-To: <20090516092036.GD15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

T24gU2F0LCBNYXkgMTYsIDIwMDkgYXQgMTI6MjAgUE0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51
eAo8bGludXhAYXJtLmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4gT24gVHVlLCBNYXkgMDUsIDIwMDkg
YXQgMDM6NDc6MDBQTSArMDMwMCwgSGlyb3NoaSBET1lVIHdyb3RlOgo+PiArc3RhdGljIHN0cnVj
dCByZXNvdXJjZSBvbWFwM19pb21tdV9yZXNbXSA9IHsKPj4gKyDCoCDCoCB7IC8qIENhbWVyYSBJ
U1AgTU1VICovCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgLnN0YXJ0IMKgIMKgIMKgIMKgIMKgPSBP
TUFQM19NTVUxX0JBU0UsCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgLmVuZCDCoCDCoCDCoCDCoCDC
oCDCoD0gT01BUDNfTU1VMV9CQVNFICsgTU1VX1JFR19TSVpFIC0gMSwKPj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCAuZmxhZ3MgwqAgwqAgwqAgwqAgwqA9IElPUkVTT1VSQ0VfTUVNLAo+PiArIMKgIMKg
IH0sCj4+ICsgwqAgwqAgewo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIC5zdGFydCDCoCDCoCDCoCDC
oCDCoD0gT01BUDNfTU1VMV9JUlEsCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgLmZsYWdzIMKgIMKg
IMKgIMKgIMKgPSBJT1JFU09VUkNFX0lSUSwKPj4gKyDCoCDCoCB9LAo+PiArIMKgIMKgIHsgLyog
SVZBMi4yIE1NVSAqLwo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIC5zdGFydCDCoCDCoCDCoCDCoCDC
oD0gT01BUDNfTU1VMl9CQVNFLAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIC5lbmQgwqAgwqAgwqAg
wqAgwqAgwqA9IE9NQVAzX01NVTJfQkFTRSArIE1NVV9SRUdfU0laRSAtIDEsCj4+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgLmZsYWdzIMKgIMKgIMKgIMKgIMKgPSBJT1JFU09VUkNFX01FTSwKPj4gKyDC
oCDCoCB9LAo+PiArIMKgIMKgIHsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCAuc3RhcnQgwqAgwqAg
wqAgwqAgwqA9IE9NQVAzX01NVTJfSVJRLAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIC5mbGFncyDC
oCDCoCDCoCDCoCDCoD0gSU9SRVNPVVJDRV9JUlEsCj4+ICsgwqAgwqAgfSwKPj4gK307Cj4+ICsj
ZGVmaW5lIE5SX0lPTU1VX1JFUyAoQVJSQVlfU0laRShvbWFwM19pb21tdV9yZXMpIC8gMikKPgo+
IFRoaXMgbG9va3MgYWxsIHZlcnkgY29udm9sdXRlZC4gwqBXaHkgbm90IGRvIHNvbWV0aGluZyBs
aWtlOgo+Cj4gc3RhdGljIHVuc2lnbmVkIGxvbmcgaW9tbXVfYmFzZVtdID0gewo+IMKgIMKgIMKg
IMKgT01BUDNfTU1VMV9CQVNFLAo+IMKgIMKgIMKgIMKgT01BUDNfTU1VMl9CQVNFLAo+IH07Cj4K
PiBzdGF0aWMgaW50IGlvbW11X2lycVtdID0gewo+IMKgIMKgIMKgIMKgT01BUDNfTU1VMV9JUlEs
Cj4gwqAgwqAgwqAgwqBPTUFQM19NTVUyX0lSUSwKPiB9OwoKQWxsIHlvdXIgY29tbWVudHMgYXJl
IHByZXR0eSBzaW1pbGFyIHRvIG15IHJlb3JnYW5pemUgcGF0Y2g6Cmh0dHA6Ly9tYXJjLmluZm8v
P2w9bGludXgtb21hcCZtPTEyNDE3MjcxMTMwMzA3NiZ3PTIKCi0tIApGZWxpcGUgQ29udHJlcmFz
Cg==
