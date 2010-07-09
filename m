From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 2/2] omap3: sr: improve errors handling
Date: Fri, 9 Jul 2010 11:00:02 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C0133957982@dlee02.ent.ti.com>
References: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
	 <1278681612-10521-2-git-send-email-dedekind1@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB032391F34E@dbde02.ent.ti.com>
	 <1278690245.9953.142.camel@localhost>  <4C374585.7030104@ti.com>
 <1278690635.9953.148.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47966 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757244Ab0GIQAH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 12:00:07 -0400
In-Reply-To: <1278690635.9953.148.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcnRlbSBCaXR5dXRza2l5IFtt
YWlsdG86ZGVkZWtpbmQxQGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKdWx5IDA5LCAyMDEw
IDEwOjUxIEFNDQo+IA0KPiBPbiBGcmksIDIwMTAtMDctMDkgYXQgMTA6NTEgLTA1MDAsIE5pc2hh
bnRoIE1lbm9uIHdyb3RlOg0KPiA+ID4gU28gdGhlIGxvZ2ljIGlzOg0KPiA+ID4NCj4gPiA+IDEu
IFRoZSBzdWJqZWN0IGxpbmUgaXMgYSBzaG9ydCBkZXNjcmlwdGlvbiB3aGljaCBnaXZlcyB0aGUg
aWRlYSB3aGF0DQo+IHRoZQ0KPiA+ID4gY29tbWl0IGlzIGFib3V0LiBTbywgbXkgc3ViamVjdCBs
aW5lIHNheXM6DQo+ID4gPiAgIDEuMS4gSXQgaXMgYWJvdXQgb21hcDMgKHdoaWNoIGlzIHRydWUp
DQo+ID4gPiAgIDEuMi4gSXQgaXMgYWJvdXQgc3IgKHdoaWNoIGlzIHRydWUpDQo+ID4gSSB0aGlu
ayBUaGFyYSdzIGNvbnRlbnRpb24gaXMgdGhhdCB0aGlzIGlzIG9tYXBfZGV2aWNlIHJlbGF0ZWQt
IHllYWggU1INCj4gPiBpcyBvbmUgb2YgdGhlIHVzZXJzIG9mIG9tYXBfZGV2aWNlLCBidXQgdGhl
cmUgYXJlIG11Y2ggbW9yZSBmb2xrcyB1c2luZw0KPiA+IG9tYXBfZGV2aWNlIGluIGwtbyB0b2Rh
eS4NCj4gDQo+IEkgc2VlLiBJJ2xsIHRyeSB0byBjb21lIHVwIHdpdGggYSBiZXR0ZXIgcHJlZml4
LCBidXQgaWYgeW91IHN1Z2dlc3QgbWUgYQ0KPiBnb29kIHN1YmplY3QgbGluZSwgSSdsbCBiZSBn
cmF0ZWZ1bCA6LSkNCg0KU3ViamVjdDogb21hcDogZGV2aWNlOiBpbXByb3ZlIGVycm9ycyBoYW5k
bGluZw0KDQpEbyBub3QgZm9yZ2V0IHRvIGNoZWNrIHRoZSAncGxhdGZvcm1fZGV2aWNlX2FkZF9k
YXRhKCknIGVycm9yIGNvZGUNCmluICdvbWFwX2RldmljZV9idWlsZF9zcygpJy4NCg0KSG93IGRv
ZXMgdGhhdCBzb3VuZD8NCg0K
