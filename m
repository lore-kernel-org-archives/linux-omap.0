From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Thu, 6 Sep 2012 07:39:19 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58269 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966Ab2IFHjY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 03:39:24 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

SGkgVG9ueSwNCg0KT24gTW9uLCBTZXAgMDMsIDIwMTIgYXQgMTE6MDQ6MTAsIE1vaGFtbWVkLCBB
ZnphbCB3cm90ZToNCj4gT24gTW9uLCBBdWcgMjcsIDIwMTIgYXQgMTQ6MDQ6NDQsIE1vaGFtbWVk
LCBBZnphbCB3cm90ZToNCj4gPiBPbiBTYXQsIEF1ZyAyNSwgMjAxMiBhdCAwMToxNjozMCwgVG9u
eSBMaW5kZ3JlbiB3cm90ZToNCg0KPiA+ID4gVGhpcyBoYW5ncyBuODAwIGR1cmluZyB0aGUgYm9v
dC4NCg0KUGF1bCByZXBvcnRlZCB0aGF0IG44MDAgc3RvcHBlZCBib290aW5nIG9uIE9NQVAgYmFz
ZWxpbmUgWzFdDQpkdWUgdG8gYW4gbW1jIGlzc3VlIGFuZCBoYXMgcG9zdGVkIGEgc29sdXRpb24g
WzJdLg0KDQpBcmUgeW91IGZhY2luZyB0aGUgc2FtZSBpc3N1ZSA/LCBpZiBzbywgdGhlbiBpdCBp
cyBub3QNCmR1ZSB0byB0aGlzIHNlcmllcy4NCg0KSSB0cmllZCB0byBnZXQgYW4gbjgwMCwgYnV0
IGhhcyBiZWVuIHVuc3VjY2Vzc2Z1bC4NCg0KUmVnYXJkcw0KQWZ6YWwNCg0KWzFdIGh0dHA6Ly9t
YXJjLmluZm8vP2w9bGludXgtb21hcCZtPTEzNDY4NTk4ODUxNzU4MCZ3PTINClsyXSBodHRwOi8v
d3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJuZWwvbXNnMTkwODc5Lmh0bWwNCg0KDQo+ID4g
DQo+ID4gU2hhbGwgSSByZWFkIHRoZSBhYm92ZSBhcyBuODAwIGJvb3Qgd2l0aG91dCBwYXRjaCAx
MC8xMCwNCj4gPiBidXQgd2l0aCB0aGUgb3RoZXIgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyA/DQo+
ID4gDQo+ID4gQXMgcGVyIHRoZSBib2FyZCBmaWxlLCBuODAwIGhhcyB0dXNiNjAxMCBhcyB3ZWxs
IGFzDQo+ID4gT25lTkFORCBpbiBzeW5jIHJlYWQgJiBhc3luYyB3cml0ZSBtb2RlLCB3YXMgT25l
TkFORA0KPiA+IHdvcmtpbmcgd2l0aG91dCAxMC8xMC4NCj4gPiANCj4gPiBEbyB5b3UgaGF2ZSBh
bnkgaWRlYSwgd2hpY2ggdGltaW5nIGNvdWxkIGhhdmUgZ29uZSB3cm9uZywNCj4gPiBjYW4geW91
IHBsZWFzZSBzZW50IG1lIERFQlVHIGVuYWJsZWQgZ3BtYyBsb2cgd2l0aCBhbmQNCj4gPiB3aXRo
b3V0IDEwLzEwLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ugc2VudCBtZSBHUE1DIERFQlVHIGVuYWJs
ZWQgbG9ncyB3aXRoIGFuZA0KPiB3aXRob3V0IHRoaXMgc2VyaWVzLg0KDQo=
