From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] mtd: nand: omap2: Fix oobfree offset
Date: Fri, 19 Jul 2013 20:54:42 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E9720@DBDE04.ent.ti.com>
References: <1374225202-26518-1-git-send-email-t.gamez@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44094 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3GSUzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 16:55:41 -0400
In-Reply-To: <1374225202-26518-1-git-send-email-t.gamez@phytec.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?B?VGVyZXNhIEfDoW1leg==?= <t.gamez@phytec.de>
Cc: "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

PiANCj4gVGhlIGNhbGN1bGF0aW9uIG9mIHRoZSBvb2JmcmVlWzBdLm9mZnNldCBpcyB3cm9uZyB3
aGVuIHVzaW5nIEJDSDgNCj4gYW5kIGVsbS4NCj4gDQo+IFRoZSBsYXlvdXQtPmVjY2J5dGVzIGlz
IGFscmVhZHkgc3RlcHMqaW5mby0+bmFuZC5lY2MuYnl0ZXMuIFRoZSBzZWNvbmQNCj4gbXVsdGlw
bGljYXRpb24gd2l0aCBzdGVwcyBpcyB0b28gbXVjaCBhbmQgd2lsbCBjcmVhdGUgYSB2YWx1ZQ0K
PiBsYXJnZXIgdGhhbiB0aGUgb29iIGFyZWEuDQo+IA0KPiBGaXhlZCB0aGUgY2FsY3VsYXRpb24u
DQo+IA0KVGhpcyBpcyBhbHJlYWR5IGZpeGVkIGluIA0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvcGlwZXJtYWlsL2xpbnV4LW10ZC8yMDEzLUp1bHkvMDQ3NTM0Lmh0bWwNCg0KQ2FuIHlvdSBw
bGVhc2UgcHVsbC1pbiB0aGUgd2hvbGUgc2VyaWVzLCBhbmQgdGVzdCBpdCA/DQpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbXRkLzIwMTMtSnVseS8wNDc1MzAuaHRt
bA0KDQoNCndpdGggcmVnYXJkcywgcGVrb24NCg==
