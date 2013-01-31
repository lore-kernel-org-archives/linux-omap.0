From: "Kumar, Anil" <anilkumar.v@ti.com>
Subject: RE: [PATCH] arm: dts: omap4-sdp: Add I2c pinctrl data
Date: Thu, 31 Jan 2013 02:32:27 +0000
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C1B46@DBDE01.ent.ti.com>
References: <1359371865-27907-1-git-send-email-sourav.poddar@ti.com>
	 <1359527158.14894.37.camel@cumari.coelho.fi> <5108C052.3070604@ti.com>
	 <F3DBB1B3EF102E4994C89758CFCA32412C16DD@DBDE01.ent.ti.com>
	 <5108DE5F.5090803@ti.com> <1359536770.14894.38.camel@cumari.coelho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56387 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab3AaCcm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jan 2013 21:32:42 -0500
In-Reply-To: <1359536770.14894.38.camel@cumari.coelho.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Coelho, Luciano" <coelho@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Poddar, Sourav" <sourav.poddar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>

T24gV2VkLCBKYW4gMzAsIDIwMTMgYXQgMTQ6MzY6MTAsIENvZWxobywgTHVjaWFubyB3cm90ZToN
Cj4gT24gV2VkLCAyMDEzLTAxLTMwIGF0IDE0OjE4ICswNTMwLCBTYW50b3NoIFNoaWxpbWthciB3
cm90ZToNCj4gPiBPbiBXZWRuZXNkYXkgMzAgSmFudWFyeSAyMDEzIDAyOjEzIFBNLCBLdW1hciwg
QW5pbCB3cm90ZToNCj4gPiA+IEhpIFNvdXJhdiwNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEphbiAz
MCwgMjAxMyBhdCAxMjoxMDoxOCwgUG9kZGFyLCBTb3VyYXYgd3JvdGU6DQo+ID4gPj4gSGkgTHVj
aWFubywNCj4gPiA+PiBPbiBXZWRuZXNkYXkgMzAgSmFudWFyeSAyMDEzIDExOjU1IEFNLCBMdWNp
YW5vIENvZWxobyB3cm90ZToNCj4gPiA+Pj4gSGkgU291cmF2LA0KPiA+ID4+Pg0KPiA+ID4+PiBP
biBNb24sIDIwMTMtMDEtMjggYXQgMTY6NDcgKzA1MzAsIFNvdXJhdiBQb2RkYXIgd3JvdGU6DQo+
ID4gPj4+PiBCb290aW5nIDMuOC1yYzQgb20gb21hcCA0NDMwc2RwIHJlc3VsdHMgaW4gdGhlIGZv
bGxvd2luZyBlcnJvcg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IG9tYXBfaTJjIDQ4MDcwMDAwLmkyYzog
ZGlkIG5vdCBnZXQgcGlucyBmb3IgaTJjIGVycm9yOiAtMTkNCj4gPiA+Pj4+IFsgICAgMS4wMjQy
NjFdIG9tYXBfaTJjIDQ4MDcwMDAwLmkyYzogYnVzIDAgcmV2MC4xMiBhdCAxMDAga0h6DQo+ID4g
Pj4+PiBbICAgIDEuMDMwMTgxXSBvbWFwX2kyYyA0ODA3MjAwMC5pMmM6IGRpZCBub3QgZ2V0IHBp
bnMgZm9yIGkyYyBlcnJvcjogLTE5DQo+ID4gPj4+PiBbICAgIDEuMDM3Mzg0XSBvbWFwX2kyYyA0
ODA3MjAwMC5pMmM6IGJ1cyAxIHJldjAuMTIgYXQgNDAwIGtIeg0KPiA+ID4+Pj4gWyAgICAxLjA0
Mzc2Ml0gb21hcF9pMmMgNDgwNjAwMDAuaTJjOiBkaWQgbm90IGdldCBwaW5zIGZvciBpMmMgZXJy
b3I6IC0xOQ0KPiA+ID4+Pj4gWyAgICAxLjA1MDk2NF0gb21hcF9pMmMgNDgwNjAwMDAuaTJjOiBi
dXMgMiByZXYwLjEyIGF0IDEwMCBrSHoNCj4gPiA+Pj4+IFsgICAgMS4wNTY4MjNdIG9tYXBfaTJj
IDQ4MDdhMDAwLmkyYzogZGlkIG5vdCBnZXQgcGlucyBmb3IgaTJjIGVycm9yOiAtMTkNCj4gPiA+
Pj4+IFsgICAgMS4wNjQwMjVdIG9tYXBfaTJjIDQ4MDdhMDAwLmkyYzogYnVzIDMgcmV2MC4xMiBh
dCA0MDAga0h6DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gVGhpcyBoYXBwZW5zIGJlY2F1c2Ugb21hcDQg
ZHRzIGZpbGUgaXMgbm90IGFkYXB0ZWQgdG8gdXNlIGkyYyB0aHJvdWdoIHBpbmN0cmwNCj4gPiA+
Pj4+IGZyYW1ld29yay4gUG9wdWxhdGluZyBpMmMgcGluY3RybCBkYXRhIHRvIGdldCByaWQgb2Yg
dGhlIGVycm9yLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFRlc3RlZCBvbiBvbWFwNDQzMCBzZHAgd2l0
aCAzLjgtcmM0IGtlcm5lbC4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBTb3Vy
YXYgUG9kZGFyIDxzb3VyYXYucG9kZGFyQHRpLmNvbT4NCj4gPiA+Pj4+IFJlcG9ydGVkLWJ5OiBT
YW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPg0KPiA+ID4+Pj4gLS0t
DQo+ID4gPj4+IENvdWxkIHlvdSBkbyB0aGUgc2FtZSB0aGluZyBmb3IgcGFuZGE/IEknbSBnZXR0
aW5nIHRoZSBzYW1lIGtpbmQgb2YNCj4gPiA+Pj4gZXJyb3JzIHdpdGggaXQ6DQo+ID4gPg0KPiA+
ID4gb21hcDQgdXNlcyBwaW5jdHJsLXNpbmdsZSBkcml2ZXIgZm9yIHBpbm11eCB3aXRoIERULiBD
dXJyZW50bHkNCj4gPiA+IHBpbmN0cmwtc2luZ2xlIGRyaXZlciBpcyBnZXR0aW5nIHVwIGFmdGVy
IEkyQyBkcml2ZXIuIFNvIEkyYyBjYW5ub3QNCj4gPiA+IHVzZSBwaW5jdHJsLiBUaGUgYmVsb3cg
cGF0Y2ggc29sdmUgdGhpcyBpc3N1ZQ0KPiA+ID4NCj4gPiA+IGh0dHA6Ly93d3cuZ29zc2FtZXIt
dGhyZWFkcy5jb20vbGlzdHMvbGludXgva2VybmVsLzE2NjkwNjcNCj4gPiA+DQo+ID4gPiBDYW4g
eW91IHRyeSB3aXRoIHRoaXMgPyBpdCBtYXkgc29sdmUgaXQuDQo+ID4gPg0KPiA+IE9NQVAgaTJj
IGRyaXZlciBhbHJlYWR5IHRha2VzIGNhcmUgb2YgLUVQUk9CRV9ERUZFUi4gVGhlIGlzc3VlDQo+
ID4gYXMgeW91IHNlZSBmcm9tIHRoZSBsb2cgaXMgbm90IHByb2JlIGZhaWx1cmUgYnV0IG1pc3Np
bmcgdGhlDQo+ID4gcGluIGluZm9ybWF0aW9uIGluIERUIGJsb2IuIEFuZCB0aGF0cyB3aGF0IHBh
dGNoIGRvZXMuDQo+IA0KPiBZZXMsIFNhbnRvc2ggaXMgcmlnaHQuICBJIHRyaWVkIHRoaXMgcGF0
Y2gsIGJ1dCBpdCBkaWRuJ3QgZml4IHRoZQ0KPiB3YXJuaW5ncy4NCg0KU29ycnksIEkgbWlzdW5k
ZXJzdG9vZCB0aGlzIGlzc3VlLg0KDQpBbmlsIA0KDQo=
