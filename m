From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
 read/write
Date: Mon, 25 Oct 2010 11:04:57 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBDDEFAA@dbde02.ent.ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	 <1285063280-4057-10-git-send-email-manjugk@ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
	 <20101007185630.GA26435@n2100.arm.linux.org.uk>  <4CAE2475.4090607@ti.com>
 <1287964909.5674.22.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53981 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0JYFf0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Oct 2010 01:35:26 -0400
In-Reply-To: <1287964909.5674.22.camel@macbook.infradead.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, "Menon, Nishanth" <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

RGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgV29v
ZGhvdXNlIFttYWlsdG86ZHdtdzJAaW5mcmFkZWFkLm9yZ10gDQo+IFNlbnQ6IE1vbmRheSwgT2N0
b2JlciAyNSwgMjAxMCA1OjMyIEFNDQo+IFRvOiBNZW5vbiwgTmlzaGFudGgNCj4gQ2M6IFJ1c3Nl
bGwgS2luZyAtIEFSTSBMaW51eDsgRywgTWFuanVuYXRoIEtvbmRhaWFoOyANCj4gbGludXgtb21h
cEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyANCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgMDkvMTBdIE9NQVAyLzM6IENvbnZlcnQgd3JpdGUvcmVhZCANCj4gZnVuY3Rpb25zIHRvIHJh
dyByZWFkL3dyaXRlDQo+IA0KPiBPbiBUaHUsIDIwMTAtMTAtMDcgYXQgMTQ6NTAgLTA1MDAsIE5p
c2hhbnRoIE1lbm9uIHdyb3RlOg0KPiA+IG15IGNvbW1lbnQgYmVpbmcgdGhhdCBieSBtb3Zpbmcg
e3JlYWQsd3JpdGV9W3dsYl0gdG8gX19yYXcgdmVyc2lvbnMgDQo+ID4gZG9udCBzb2x2ZSB0aGUg
cmVhbCBpc3N1ZSBvZiBuYW1lc3BhY2UgaGVyZS4gZml4IHNob3VsZCBiZSBpbiANCj4gPiBhcmNo
L2FybS9pbmNsdWRlL2FzbS9pby5oIElNSE8uIHNvIHRoYXQgdGhlcmUgYXJlIG5vIA0KPiBvdmVy
bGFwcyBhcyB0aGlzLg0KPiANCj4gSW5kZWVkLiBUaGlzIHBhdGNoIGlzIGNvbXBsZXRlIG5vbnNl
bnNlLg0KDQpub25zZW5zZT8gVGhlcmUgYXJlIHR3byB0eXBlcyBvZiBmaXhlcyBwcm9wb3NlZCB0
byBmaXggdGhlc2Ugc3BhcnNlIHdhcm5pbmdzLg0KMS4gd2l0aCB0aGlzIHBhdGNoDQoyLiBmaXhp
bmcgaW4gaW8uaA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8yNTAxNzEvDQoN
CjFzdCBvcHRpb24gaXMgYWxyZWFkeSBtZXJnZWQgd2l0aCAyLjYuMzcgbWVyZ2Ugd2luZG93Lg0K
DQpJZiAyIGdldCBhY2NlcHRlZCwgYWxsIF9fcmF3X3JlYWQvd3JpdGUgd2lsbCBnZXQgcmVwbGFj
ZWQgd2l0aCByZWFkbC93cml0ZWwuDQoNCkFwYXJ0IGZyb20gdGhvc2UgdHdvLCBkbyB5b3UgaGF2
ZSBhbnkgb3RoZXIgYWx0ZXJuYXRlIGlkZWEgdG8gZml4IHRoZXNlIHNwYXJzZSB3YXJuaW5ncz8N
Cg0KLU1hbmp1bmF0aA==
