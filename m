From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v7 08/11] ARM: OMAP2+: gpmc: generic timing calculation
Date: Fri, 28 Sep 2012 04:52:53 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9F5240@DBDE01.ent.ti.com>
References: <cover.1348058726.git.afzal@ti.com>
 <6b20c05230f22380802936f83377e94823488fa8.1348058726.git.afzal@ti.com>
 <5063C6E6.50109@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9EA17D@DBDE01.ent.ti.com>
 <50646DBC.5090809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45686 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab2I1ExD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 00:53:03 -0400
In-Reply-To: <50646DBC.5090809@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

SGkgSm9uLA0KDQpPbiBUaHUsIFNlcCAyNywgMjAxMiBhdCAyMDo0NjoxMiwgSHVudGVyLCBKb24g
d3JvdGU6DQo+IE9uIDA5LzI3LzIwMTIgMDU6MDcgQU0sIE1vaGFtbWVkLCBBZnphbCB3cm90ZToN
Cg0KPiA+PiBPciBtYXliZSBzaG91bGQgdGhlIHRpbWluZ3MgYmUgZ3JvdXBlZCBhcyAuLi4NCj4g
Pj4NCj4gPj4gR2VuZXJhbA0KPiA+PiBSZWFkIEFzeW5jDQo+ID4+IFJlYWQgQXN5bmMgQWRkcmVz
cy9EYXRhIE11bHRpcGxleGVkDQo+ID4+IFJlYWQgU3luYw0KPiA+PiBSZWFkIFN5bmMgQWRkcmVz
cy9EYXRhIE11bHRpcGxleGVkDQo+ID4+IFdyaXRlIEFzeW5jDQo+ID4+IFdyaXRlIEFzeW5jIEFk
ZHJlc3MvRGF0YSBNdWx0aXBsZXhlZA0KPiA+PiBXcml0ZSBTeW5jDQo+ID4+IFdyaXRlIFN5bmMg
QWRkcmVzcy9EYXRhIE11bHRpcGxleGVkDQo+ID4+DQo+ID4+IFRoZXJlIG1heSBiZSBzb21lIGR1
cGxpY2F0aW9uIGJ1dCBpdCB3aWxsIGJlIGNsZWFyIHdoZXJlIHRoaW5ncyBsaWtlIEFEVg0KPiA+
PiB0aW1pbmcgYXBwbGllcy4NCj4gPiANCj4gPiBJIHdvdWxkIHByZWZlciB0byBrZWVwIGl0IGNv
bmNpc2UsIGJ1dCBubyBzdHJvbmcgb3BpbmlvbiBvbiBpdCwgaWYgeW91DQo+ID4gcHJlZmVyIGFz
IGFib3ZlLCBJIHdpbGwgY2hhbmdlIGl0Lg0KPiANCj4gSSB0aGluayB0aGF0IGlmIHRoZXNlIHJl
cHJlc2VudCB0aGUgbWFpbiB1c2UtY2FzZSBjb25maWd1cmF0aW9ucyB0aGlzDQo+IGNvdWxkIGFk
ZCBzb21lIHZhbHVlLg0KDQpPaw0KDQo+ID4+PiArCWdwbWNfY29udmVydF9wc190b19ucyhncG1j
X3QpOw0KPiA+IA0KPiA+PiBJIGFtIHdvbmRlcmluZyBpZiB3ZSBjb3VsZCBhdm9pZCB0aGlzIGFi
b3ZlIGZ1bmN0aW9uIGFuZCB0aGVuIC4uLg0KPiA+IA0KPiA+IFRoaXMgd2lsbCBiZSByZW1vdmVk
IG9uY2UgaXQgaXMgY29uZmlybWVkIHRoYXQgYWxsIHRoZSBwZXJpcGhlcmFscw0KPiA+IHVzaW5n
IGN1c3RvbSBydW50aW1lIGNhbGN1bGF0aW9uIGNhbiB3b3JrIHdpdGggdGhpcyBnZW5lcmljDQo+
ID4gcm91dGluZS4gVGhlbiBhbGwgY2FsY3VsYXRpb24gd291bGQgYmUgcHVyZWx5IGluIHBzLg0K
PiANCj4gT2ssIGdyZWF0LiBNYXkgYmUgYWRkIGEgVE9ETyBoZXJlIHRvIG1ha2UgdGhpcyBjbGVh
ciB0aGF0IHRoaXMgaXMgdGVtcG9yYXJ5Lg0KDQpTdXJlDQoNClJlZ2FyZHMNCkFmemFsDQo=
