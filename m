From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Mon, 26 Oct 2009 05:18:21 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
 <1256361352-9968-1-git-send-email-nm@ti.com>
 <1256361352-9968-2-git-send-email-nm@ti.com>
 <1256361352-9968-3-git-send-email-nm@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE01B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484AbZJZKSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 06:18:23 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE01B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHLCBNYW5qdW5hdGggS29uZGFp
YWgNCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI2LCAyMDA5IDM6NDAgQU0NCj4gVG86IE1lbm9u
LCBOaXNoYW50aDsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEltYmVydG9uIEd1
aWxoZW07IE1pa2UgQ2hhbjsgTmF5YWssIFJhamVuZHJhOyBSb2dlciBRdWFkcm9zOyBLYWxsZQ0K
PiBKb2tpbmllbWk7IFJlZGR5LCBUZWVydGg7IEtldmluIEhpbG1hbjsgUGF1bCBXYWxtc2xleTsg
SG9nYW5kZXIgSm91bmkNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAyLzIgdjNdIE9NQVAzOiBQTTog
U1I6IFNtYXJ0UmVmbGV4IFJlZmFjdG9yIFJldjQuMA0KPiANCj4gDQo+IEFzIHBlciB5b3VyIGNv
bW1lbnRzIGZvciBvdGhlciBwYXRjaGVzIHdoZW4gZXZlciB0aGVyZSBpcyB1ZGVsYXkgdXNhZ2Us
DQo+IGNwdV9yZWxheCBpcyB0aGUgYmV0dGVyIG9wdGlvbi4gSSBzZWUgdGhlcmUgYXJlIGxvdCBv
ZiB1ZGVsYXkoLi4uKSBjYWxscw0KPiB1c2VkIGluIHRoaXMgcGF0Y2guIFdoeSBjYW4ndCB5b3Ug
dXNlIGNwdV9yZWxheCgpIG9yIHNjaGVkdWxlKCkuDQo+IEFueSBzcGVjaWZpYyByZWFzb24/DQo+
IA0KRG9u4oCZdCByZWFsbHkgd2FudCB0byBkbyBjcHVfcmVsYXggaW4gaXJxX2xvY2tlZCBjb250
ZXh0Li4gaWYgeW91IGxvb2sgYXQgdGhlIGNvZGUgZmxvdywgdGhlIGNhbGwgZnJvbSBjcHVfaWRs
ZSBpcyBpbiBpcnFfbG9ja2VkLi4gRnVydGhlciB0aGlzIGRlbGF5IGlzIHBhcnQgb2YgYnJpbmcg
dXAgZm9ybSBzYXZlZCBjb250ZXh0IHdoZXJlIHRoZXJlIGlzIG5vdGhpbmcgZWxzZSBzY2hlZHVs
ZWQgKyB3ZSBkb27igJl0IHdhbnQgYW55dGhpbmcgZWxzZSBzY2hlZHVsZWQgKGFuZCBjYXVzaW5n
IGEgY2hhbmdlIGluIHNjaGVkdWxpbmcgZGVjaXNpb24pLiBTbyB1bmZvcnR1bmF0ZWx5LCB1bmxp
a2Ugc3RhbmRhcmQgZHJpdmVycywgdGhpcyBjYW5ub3QgdXNlIHRoZSBzYW1lIHJlYXNvbmluZy4N
Cg0KUmVnYXJkcywNCk5pc2hhbnRoIE1lbm9uDQo=
