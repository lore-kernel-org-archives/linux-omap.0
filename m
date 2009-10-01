From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 01/04] OMAP4: PMIC: Add support for twl6030 irq
 framework
Date: Thu, 1 Oct 2009 19:42:14 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAEE9099@dbde02.ent.ti.com>
References: <1254399807-3909-1-git-send-email-balajitk@ti.com>
 <20091001131616.GU32041@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932277AbZJAOMs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Oct 2009 10:12:48 -0400
In-Reply-To: <20091001131616.GU32041@smtp.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@canonical.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "wim@iguana.be" <wim@iguana.be>, "timo.t.kokkonen@nokia.com" <timo.t.kokkonen@nokia.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "Nayak, Rajendra" <rnayak@ti.com>

QW1pdCwNCg0KPHNuaXA+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFt
aXQgS3VjaGVyaWEgW21haWx0bzphbWl0Lmt1Y2hlcmlhQHZlcmR1cmVudC5jb21dIE9uIEJlaGFs
ZiBPZiBBbWl0DQo+IEt1Y2hlcmlhDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDAxLCAyMDA5
IDY6NDYgUE0NCj4gVG86IEtyaXNobmFtb29ydGh5LCBCYWxhamkgVA0KPiBDYzogbGludXgtb21h
cEB2Z2VyLmtlcm5lbC5vcmc7IHNhbWVvQGxpbnV4LmludGVsLmNvbTsgd2ltQGlndWFuYS5iZTsN
Cj4gdGltby50Lmtva2tvbmVuQG5va2lhLmNvbTsgYmVuLWxpbnV4QGZsdWZmLm9yZzsgbHJnQHNs
aW1sb2dpYy5jby51azsNCj4gYnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb207IHBf
Z29ydG1ha2VyQHlhaG9vLmNvbTsNCj4gYS56dW1tb0B0b3dlcnRlY2guaXQ7IE5heWFrLCBSYWpl
bmRyYTsgU2hpbGlta2FyLCBTYW50b3NoDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDEvMDRd
IE9NQVA0OiBQTUlDOiBBZGQgc3VwcG9ydCBmb3IgdHdsNjAzMCBpcnENCj4gZnJhbWV3b3JrDQo+
IA0KDQo+ID4gKw0KPiA+ICsJc3RhdHVzID0gcmVxdWVzdF9pcnEoaXJxX251bSwgaGFuZGxlX3R3
bDYwMzBfcGloLCBJUlFGX0RJU0FCTEVELA0KPiA+ICsJCQkJIlRXTDYwMzAtUElIIiwgJmlycV9l
dmVudCk7DQo+IA0KPiBUaGVyZSBpcyBubyBuZWVkIGZvciB0aGUga3RocmVhZCBoYWNrIGFueW1v
cmUgbm93IHRoYXQgdGhyZWFkZWQgaXJxcyBhcmUNCj4gYXZhaWxhYmxlIHRvIGV2ZXJ5b25lICgy
LjYuMzItcmMxKQ0KPiANCj4gU28gYWJvdmUgd291bGQgYmVjb21lLA0KPiAgICAgICAgIHN0YXR1
cyA9IHJlcXVlc3RfdGhyZWFkZWRfaXJxKGlycV9udW0sIGhhbmRsZV90d2w2MDMwX3BpaCwNCj4g
dHdsNjAzMF9pcnFfdGhyZWFkLCBJUlFGX0RJU0FCTEVELA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJUV0w2MDMwLVBJSCIsICZpcnFfZXZlbnQpOw0KPiB3aGVyZSwNCj4gIGhhbmRs
ZV90d2w2MDMwX3BpaCBpcyB0aGUgaGFyZCBpcnEgaGFuZGxlciB0aGF0IG1hc2sgdGhlIGludGVy
cnVwdA0KPiAgdHdsNjAzMF9pcnFfdGhyZWFkIGlzIGEgc2xlZXBpbmcgY2FsbCBjYWxsZWQgYnkg
dGhlIGlycSBmcmFtZXdvcmsNCj4gDQo+IFlvdSBtaWdodCBhbHNvIGJlIGFibGUgdG8gZG8gYXdh
eSB3aXRoIGhhbmRsZV90d2w2MDMwX3BpaCBlbnRpcmVseSBhbmQNCj4gcGFzcw0KPiBOVUxMLiBU
aGF0IGFsb25nIHdpdGggYSBJUlFGX09ORVNIT1QgZmxhZyB0aGUgdGhlIHJlcXVlc3RfdGhyZWFk
ZWRfaXJxDQo+IHJvdXRpbmUgc2hvdWxkIGF1dG9tYXRpY2FsbHkgbWFzayB0aGUgaXJxIHVudGls
IHRoZSBzbGVlcGluZyBjYWxsIHJldHVybnMuDQo+IA0KPiBJIGFtIHdvcmtpbmcgb24gZG9pbmcg
dGhpcyB0byB0aGUgdHdsNDAzMCBkcml2ZXIgY3VycmVudGx5LCBpZiBhbnlib2R5DQo+IGVsc2UN
Cj4gaXNuJ3QuDQpUaGlzIGlzIGludGVyZXN0aW5nIGFuZCBjYW4gaW1wcm92ZSB0aGUgVFdMIGZy
YW1ld29yay4gS2VlcCB1cyBwb3N0ZWQgYWJvdXQgeW91ciB0ZXN0aW5nIG9uIFRXTDQwMzAuDQoN
ClRoYW5rcyAhIQ0KDQpSZWdhcmRzDQpTYW50b3NoIA0KDQo=
