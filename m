From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 09/12] ARM: OMAP2+: powerdomain: skip register reads for
 powerdomains known to be on
Date: Wed, 26 Dec 2012 06:21:46 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6CF8@DBDE01.ent.ti.com>
References: <20121209200108.3196.12452.stgit@dusk.lan>
 <20121209200327.3196.27686.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46062 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab2LZGVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 01:21:52 -0500
In-Reply-To: <20121209200327.3196.27686.stgit@dusk.lan>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>

SGkgUGF1bCwNCg0KT24gTW9uLCBEZWMgMTAsIDIwMTIgYXQgMDE6MzM6MjgsIFBhdWwgV2FsbXNs
ZXkgd3JvdGU6DQo+IFRoZXJlJ3Mgbm8gbmVlZCB0byBkZXRlcm1pbmUgdGhlIGN1cnJlbnQgcG93
ZXIgc3RhdGUgZm9yIHBvd2VyZG9tYWlucw0KPiB0aGF0IG11c3QgYmUgb24gd2hpbGUgdGhlIGtl
cm5lbCBpcyBydW5uaW5nLiAgV2UgbWFyayB0aGVzZQ0KPiBwb3dlcmRvbWFpbnMgd2l0aCBhIG5l
dyBmbGFnLCBQV1JETV9BQ1RJVkVfV0lUSF9LRVJORUwuICBBbnkNCj4gcG93ZXJkb21haW4gbWFy
a2VkIHdpdGggdGhhdCBmbGFnIGlzIHJlcG9ydGVkIGFzIGJlaW5nIGluIHRoZSBPTiBwb3dlcg0K
PiBzdGF0ZSB3aGlsZSB0aGUga2VybmVsIGlzIHJ1bm5pbmcuDQpbLi4uXQ0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbnMzM3h4X2RhdGEuYyBiL2FyY2gvYXJt
L21hY2gtb21hcDIvcG93ZXJkb21haW5zMzN4eF9kYXRhLmMNCj4gaW5kZXggODY5YWRiOC4uYWNi
MTQ4YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbnMzM3h4
X2RhdGEuYw0KPiArKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluczMzeHhfZGF0
YS5jDQo+IEBAIC0xMjMsNyArMTIzLDggQEAgc3RhdGljIHN0cnVjdCBwb3dlcmRvbWFpbiBtcHVf
MzN4eF9wd3JkbSA9IHsNCj4gIAkucHdyc3RzdF9vZmZzCQk9IEFNMzNYWF9QTV9NUFVfUFdSU1RT
VF9PRkZTRVQsDQo+ICAJLnB3cnN0cwkJCT0gUFdSU1RTX09GRl9SRVRfT04sDQo+ICAJLnB3cnN0
c19sb2dpY19yZXQJPSBQV1JTVFNfT0ZGX1JFVCwNCj4gLQkuZmxhZ3MJCQk9IFBXUkRNX0hBU19M
T1dQT1dFUlNUQVRFQ0hBTkdFLA0KPiArCS5mbGFncwkJCT0gKFBXUkRNX0hBU19MT1dQT1dFUlNU
QVRFQ0hBTkdFIHwNCj4gKwkJCQkgICBQV1JETV9BQ1RJVkVfV0lUSF9LRVJORUwpLA0KDQpJbiBj
YXNlIG9mIEFNMzN4eCwgdGhpcyBmbGFnIHNob3VsZCBiZSBzZXQgZm9yIFBFUiBhbmQgV0tVUCBw
d3JkbXMgYWxzby4NCkVNSUYsIEwzLCBMNCBldGMgY29tZSB1bmRlciBQRVIgc28gdGhpcyBkb21h
aW4gY2FuJ3QgdHJhbnNpdGlvbiBvbiBhbiBhY3RpdmUNCnN5c3RlbS4gUFJDTSBhbmQgQ29udHJv
bCBtb2R1bGUgY29tZSB1bmRlciBXS1VQLCBzbyB0aGUgV0tVUCBzaG91bGQgdGhlIGtlcm5lbA0K
c2hvdWxkIGF0dGVtcHQgdG8gdHJhbnNpdGlvbiBXS1VQIGRvbWFpbiBhbHNvLg0KDQpSZWdhcmRz
LA0KVmFpYmhhdg0KDQo=
