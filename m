From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/3] clk: introduce omap_clk_associate
Date: Wed, 15 Oct 2008 17:42:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620365CA801E@dlee02.ent.ti.com>
References: <1223333252-25687-1-git-send-email-me@felipebalbi.com>
	<alpine.DEB.2.00.0810141039580.15253@utopia.booyaka.com>
	<20081014172921.GJ20247@frodo>	<200810141047.44803.david-b@pacbell.net>
	<20081014180634.GL20247@frodo> <20081014205925.GK8150@atomide.com>
	<1224018598.4977.27.camel@localhost>	<20081014212409.GL8150@atomide.com>
	<87wsgabcp0.fsf@trdhcp146196.ntc.nokia.com>
	<alpine.DEB.2.00.0810150106370.8581@utopia.booyaka.com>
 <87wsga9fip.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40497 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbYJOWmd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 18:42:33 -0400
In-Reply-To: <87wsga9fip.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?SMO2Z2FuZGVyIEpvdW5p?= <jouni.hogander@nokia.com>, ext Paul Walmsley <paul@pwsan.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Igor Stoppa <igor.stoppa@nokia.com>, Felipe Balbi <me@felipebalbi.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

DQo+IEZyb206IEjDtmdhbmRlciBKb3VuaSBbbWFpbHRvOmpvdW5pLmhvZ2FuZGVyQG5va2lhLmNv
bV0NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE1LCAyMDA4IDg6MDQgQU0NCg0KPiBMMyBh
bmQgTDQgYXJlIGFueXdheSBvbiB3aGVuIG5vdCBpbiB3ZmksIGJlY2F1c2Ugb2Ygc2xlZXAvd2tk
ZXAsIHNvIG5vDQo+IHBvd2VyIHNhdmUuIFRoaXMgaXMgdGhlIGNhc2UgYXQgbGVhc3Qgd2l0aCBP
TUFQMyBub3Qgc3VyZSBhYm91dCBPTUFQMi4NCg0KUHJvYmFibHkgc29tZSBzYXZpbmdzIGluc2lk
ZSBvZiBpbmRpdmlkdWFsIGRvbWFpbnMgd2hlbiB0aGV5IGFyZSBpbiBpZGxlIGxpa2UgY2FtZXJh
LiAgRGVmaWFudGx5IGludGVybmFsIGF1dG9nYXRpbmcgaW4gQ29ydGV4QTggc2F2ZXMgcG93ZXIg
aWYgTVBVIGRvbWFpbiBpcyBpbiBpZGxlLiAgLi4uIFJlY2FsbCBpZiBEU1AgaXMgdXAgYW5kIHJ1
bm5pbmcgTDMvTDQgbWlnaHQgYmUgdXAsIGJ1dCBNUFUgY291bGQgYmUgaW4gV0ZJIHdpdGggaXRz
IGRvbWFpbiBnYXRlZCBvZmYgKGFsc28gaW4gSU5BQ1RJVkUvUkVUL09GRikuDQoNCkEgMXN0IG9y
ZGVyIHBvd2VyIHdhc3RlciBpcyBmYW4gb3V0IGZyb20gTDMvTDQgYXMgeW91IHNheS4NCg0KRnV0
dXJlIE9NQVBzIGFkZCBtb3JlIGRvbWFpbnMgdG8gcmVkdWNlIGZhbiBvdXQgZWZmZWN0IGV2ZW4g
aWYgTDMvTDQgaXMgb24uDQoNCj4gSW4gbWFueSBtb2R1bGVzIHRoZXJlIGlzIGFsc28gcG9zc2li
aWxpdHkgdG8gZ2F0ZSBpY2sgYnkgSFcgd2hlbiBub3QNCj4gaW4gd2ZpIChzZWUgQVVUT0lETEUg
aW4gU1lDT05GSUcpLiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcyBidXQNCj4gZXh0cmVtZWx5IGFs
c28gZmNrcyBjb3VsZCBiZSB0YWtlbiBjYXJlIGJ5IEhXIChzZWUgQ0xPQ0tBQ1RJVklUWSBpbg0K
PiBTWVNDT05GSUcpLg0KDQpNb2R1bGUgQVVUT0lETEUgY2FuIHNhdmUgcG93ZXIgYnkgc2VsZWN0
aXZlIGdhdGluZyBpbnNpZGUgdGhlIG1vZHVsZS4gIEFuIGVhc3kgZXhwZXJpbWVudCBpcyB0byBt
ZWFzdXJlIHBvd2VyIHdoaWxlIHN0b3BwZWQgaW4gdGhlIGRlYnVnZ2VyIGFuZCBlbmFibGUvZGlz
YWJsZSBpbmRpdmlkdWFsIGF1dG8gaWRsZXMuICBZb3UnbGwgYmUgc3VycHJpc2VkIGhvdyBtdWNo
IHlvdSBnZXQgYmFjayBvbiBzb21ldGhpbmcgbGlrZSBzZWN1cml0eSBhY2NlbGVyYXRvcnMgKGFs
bCBJLWNsb2NrLCBzbyBnYXRpbmcgaW5zaWRlIG9mIG1vZHVsZXMgaGVscHMsIGV2ZW4gaWYgbDMv
bDQgaXMgdXApLg0KDQpDbG9jayBhY3Rpdml0eSBpbiBzb21lIG1vZHVsZXMgZG9lcyBkbyBleHRy
YSBnYXRpbmcgYXQgc2VnbWVudCBpZGxlIHRpbWUuDQoNClJlZ2FyZHMsDQpSaWNoYXJkIFcuDQoN
Cg==
