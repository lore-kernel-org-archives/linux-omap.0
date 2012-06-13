From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Wed, 13 Jun 2012 12:18:15 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998CF2@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com> <20120613120457.GO12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50273 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab2FMMSX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 08:18:23 -0400
In-Reply-To: <20120613120457.GO12766@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

SGkgVG9ueSwNCg0KT24gV2VkLCBKdW4gMTMsIDIwMTIgYXQgMTc6MzQ6NTgsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6DQogDQo+ID4gSSBhbSBub3Qgc3VyZSBpZiBJIGFtIG1pc3Npbmcgc29tZXRoaW5n
LCBidXQgaXQgYXBwZWFycyB0aGF0IHBkZXYgd2lsbA0KPiA+IGFsd2F5cyBiZSBOVUxMIGhlcmUg
YXMgaXQgaXMgYSBsb2NhbCB1bmluaXRpYWxpc2VkIHZhcmlhYmxlLg0KPiANCj4gVGhpcyBhbHNv
IGNyZWF0ZXMgYSBuZXcgd2FybmluZzoNCj4gDQo+IGFyY2gvYXJtL21hY2gtb21hcDIvZ3BtYy5j
OiBJbiBmdW5jdGlvbiDigJhncG1jX2NyZWF0ZV9kZXZpY2XigJk6DQo+IGFyY2gvYXJtL21hY2gt
b21hcDIvZ3BtYy5jOjE0MzQ6IHdhcm5pbmc6IOKAmHBkZXbigJkgbWF5IGJlIHVzZWQgdW5pbml0
aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uDQoNCkkgdXNlIGFuIGludGVybmFsIHRvb2xjaGFpbiwg
dGhhdCBkb2VzIG5vdCBnaXZlIHdhcm5pbmcsICBzZWVtcyBJIG5lZWQgdG8NCmNoZWNrIHdpdGgg
Y29kZXNvdXJjZXJ5Lg0KDQo+IA0KPiA+IE5vdCBzdXJlIEkgc2VlIHRoZSBwb2ludCBpbiB0aGUg
YWJvdmUgZnVuY3Rpb24uIFdoeSBub3QgZGVjbGFyZSB0aGUNCj4gPiBncG1jX2RldmljZV9kYXRh
IHN0cnVjdCBhcyBzdGF0aWMgaW4gdGhlIGZpbGUgYW5kIGFjY2VzcyBpdCBkaXJlY3RseQ0KPiA+
IGluc3RlYWQgb2YgcGFzc2luZyBpdCBpbiBvbWFwX2dwbWNfaW5pdCgpLiBUaGUgcG9zdGNvcmVf
aW5pdCBjYW4gdGhlbg0KPiA+IGNhbGwgb21hcF9ncG1jX2luaXQoKSBkaXJlY3RseS4NCj4gPiAN
Cj4gPiBTaG91bGRuJ3QgdGhlIHBvc3RfaW5pdGNhbGwgYmUgYWRkZWQgaW4gcGF0Y2ggIzQsIHdo
ZW4gdGhlIGRyaXZlciBpcw0KPiA+IGNyZWF0ZWQ/DQo+IA0KPiBUaGVyZSBzaG91bGQgbm8gbG9u
Z2VyIGJlIGFueSBuZWVkIHRvIGluaXRpYWxpemUgR1BNQyBlYXJseS4gSXQgc2hvdWxkDQo+IGJl
aGF2ZSBsaWtlIGFueSBvdGhlciBkZXZpY2UgZHJpdmVyLCBhbmQgYWxzbyB3b3JrIGFzIGEgbG9h
ZGFibGUgbW9kdWxlLg0KDQpPbmNlIGRyaXZlciBtaWdyYXRpb24gaXMgY29tcGxldGUgZm9yIGFs
bCB0aGUgYm9hcmRzLCB3ZSBjYW4gcmVtb3ZlIHRoZQ0KaW5pdGNhbGwgYW5kIG1ha2UgaXQgbG9h
ZGFibGUuDQoNCkJ1dCB0aWxsIHRoYXQgdGltZSBhcyB3ZSBuZWVkIHRvIHN1cHBvcnQgYm90aCBv
bGQgJiBuZXcgaW50ZXJmYWNlLA0KSSBmZWVsIHRoaXMgaXMgbmVjZXNzYXJ5IGFzIG9sZCBpbnRl
cmZhY2Ugd291bGQgaGFwcGVuIGluIGFyY2ggaW5pdGNhbGwsDQphbmQgb2xkIGdwbWNfaW5pdCBp
cyBub3cgZ3BtY19wcm9iZSwgYW5kIGhlbmNlIGl0IG5lZWRzIHRvIGdldCBleGVjdXRlZA0KYmVm
b3JlIGFyY2ggaW5pdGNhbGwsIG5lY2Vzc2l0YXRpbmcgdGhpcy4NCg0KUmVnYXJkcw0KQWZ6YWwN
Cg==
