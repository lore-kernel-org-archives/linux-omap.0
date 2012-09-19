From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Wed, 19 Sep 2012 13:43:05 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E60D5@DBDE01.ent.ti.com>
References: <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com> <20120911184606.GN23092@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9E4DFE@DBDE01.ent.ti.com>
 <20120917225023.GJ11762@atomide.com> <20120917231001.GK11762@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39195 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab2ISNnM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 09:43:12 -0400
In-Reply-To: <20120917231001.GK11762@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

SGkgVG9ueSwNCg0KT24gVHVlLCBTZXAgMTgsIDIwMTIgYXQgMDQ6NDA6MDIsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6DQo+ICogVG9ueSBMaW5kZ3JlbiA8dG9ueUBhdG9taWRlLmNvbT4gWzEyMDkxNyAx
NTo1NF06DQoNCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHdpdGggdGhlIGF0dGFjaGVkIHBh
dGNoID8NCj4gPiANCj4gPiBHYXZlIGl0IGEgcXVpY2sgdHJ5IGFuZCBpdCBzZWVtZWQgdG8gd29y
ay4uIEJ1dCB3aGVuIEkgdHJpZWQNCj4gPiByZWJhc2luZyBteSBwYXRjaGVzIGZvciB0aGUgY2J1
cyB0byBrZWVwIHRoaW5ncyB3b3JraW5nIHdpdGgNCj4gPiB0aGUgd2F0Y2hkb2csIEkgcmFuIGlu
dG8gbXVsdGlwbGUgbWVyZ2UgY29uZmxpY3RzIHdpdGgNCj4gPiBjdXJyZW50IGxpbnV4IG5leHQg
YW5kIGdhdmUgdXAuDQo+IA0KPiBPSyB3ZW50IGJhY2sgdG8gbXkgb3JpZ2luYWwgYnJhbmNoIHdp
dGhvdXQgY3VycmVudCBsaW51eA0KPiBuZXh0IGFuZCB3aXRoIHRoZSBuZXcgY2J1cyArIHJldHUg
ZHJpdmVyIGZyb20gQWFybyBhcHBsaWVkLg0KPiBDb25maXJtZWQgaXQncyBub3cgd29ya2luZyBv
biBuODAwIHR1c2I2MDEwLg0KDQpUaGFua3MgZm9yIGNoZWNraW5nIGFuZCBjb25maXJtaW5nLg0K
DQo+ID4gQ2FyZSB0byByZXBvc3QgdGhpcyBzZXJpZXMgdXBkYXRlZCBhZ2FpbnN0IGN1cnJlbnQg
bGludXgNCj4gPiBuZXh0Pw0KPiA+IA0KPiA+IEknbSBhZnJhaWQgSSd2ZSBwcmV0dHkgbXVjaCBs
b3N0IHRyYWNrIG9mIGFsbCB0aGUgcGF0Y2hlcw0KPiA+IGFuZCByYXRoZXIgbm90IHN0YXJ0IHJl
c29sdmluZyB0aGUgY29uZmxpY3RzIGFzIEknbSBzdXJlDQo+ID4gSSdsbCBicmVhayBzb21ldGhp
bmcgZWxzZSA6KQ0KPiANCj4gWW91IHNob3VsZCBzdGlsbCByZXBvc3QgdGhlIHdob2xlIHVwZGF0
ZWQgc2VyaWVzIGFnYWluc3QNCj4gbGludXggbmV4dC4NCg0KTmV3IHVwZGF0ZWQgdmVyc2lvbiAt
IHY3LCBiYXNlZCBvdmVyIGxpbnV4IG5leHQgaGFzIGJlZW4gcG9zdGVkLg0KDQpSZWdhcmRzDQpB
ZnphbA0K
