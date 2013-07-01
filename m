From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v3 1/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Mon, 1 Jul 2013 10:02:52 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E29F6@DBDE04.ent.ti.com>
References: <1372010299-30141-1-git-send-email-pekon@ti.com>
	 <1372010299-30141-2-git-send-email-pekon@ti.com>
 <1372666588.22014.43.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42067 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab3GAKI3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jul 2013 06:08:29 -0400
In-Reply-To: <1372666588.22014.43.camel@sauron.fi.intel.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "arnd@arndb.de" <arnd@arndb.de>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Benoit Cousson (benoit.cousson@linaro.org)" <benoit.cousson@linaro.org>

PiBIaSBQZWtvbiwNCj4gDQo+IE9uIFN1biwgMjAxMy0wNi0yMyBhdCAyMzoyOCArMDUzMCwgUGVr
b24gR3VwdGEgd3JvdGU6DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKw0KPiA+IHwgRUNDIHNjaGVtZQkJ
CQl8RUNDIGNhbGN1bGF0aW9ufEVycm9yDQo+IGRldGVjdGlvbnwNCj4gPiArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0t
LS0rDQo+ID4gfE9NQVBfRUNDX0hBTU1JTkdfQ09ERV9ERUZBVUxUCQl8Uy9XCQl8Uy9XDQo+IAkJ
fA0KPiA+IHxPTUFQX0VDQ19IQU1NSU5HX0NPREVfSFcJCXxIL1cgKEdQTUMpCXxTL1cNCj4gCXwN
Cj4gPiB8T01BUF9FQ0NfSEFNTUlOR19DT0RFX0hXX1JPTUNPREUJfEgvVyAoR1BNQykJfFMvVw0K
PiAJCXwNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rDQo+ID4gfChyZXF1aXJlcyBDT05GSUdfTVREX05B
TkRfRUNDX0JDSCkJfAkJfA0KPiAJfA0KPiA+IHxPTUFQX0VDQ19CQ0g4X0NPREVfSFdfREVURUNU
SU9OX1NXCXxIL1cgKEdQTUMpCXxTL1cNCj4gCQl8DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tKw0KPiA+
IHwocmVxdWlyZXMgQ09ORklHX01URF9OQU5EX09NQVBfQkNIKQl8CQl8DQo+IAkJfA0KPiA+IHxP
TUFQX0VDQ19CQ0g4X0NPREVfSFcJCQl8SC9XIChHUE1DKQl8SC9XDQo+IChFTE0pCXwNCj4gPiAr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0rDQo+IA0KPiBUaGlzIGlzIGEgbmljZSB0YWJsZSwgYW5kIHlvdSBhcmUg
ZG9pbmcgdmVyeSBnb29kIGpvYiBjbGVhcmx5DQo+IGNsYXNzaWZ5aW5nIHdoYXQgaXMgZ29pbmcg
b24uIEknZCBzdWdnZXN0IHRvIGFsc28gcHV0IHN0dWZmIGxpa2UgdGhpcyB0bw0KPiBjb21tZW50
cyBpbiB0aGUgY29kZS4NCj4gDQpbUGVrb25dOiBUaGFua3MgZm9yIGVuY291cmFnZW1lbnQsIHdv
dWxkIGluY2x1ZGUgbW9yZSBpbmxpbmUgY29tbWVudHMgaW4gZnV0dXJlLg0KDQo+ID4gVGhpcyBw
YXRjaA0KPiA+IC0gc2VwYXJhdGVzIHRoZSBjb25maWd1cmF0aW9ucyBmb3IgdmFyaW91cyBFQ0Mg
c2NoZW1lcy4NCj4gPiAtIGZpeGVzIGRlcGVuZGVuY3kgaXNzdWVzIGJhc2VkIG9uIEtjb25maWcg
b3B0aW9ucy4NCj4gPiAtIGNsZWFucyB1cCByZWR1bmRhbnQgY29kZQ0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUGVrb24gR3VwdGEgPHBla29uQHRpLmNvbT4NCj4gDQo+IFRoaXMgZG9lcyBub3Qg
YXBwbHkgdG8gbDItbXRkLmdpdCwgY291bGQgeW91IHBsZWFzZSByZS1iYXNlPw0KPiANCltQZWtv
bl06IHJlYmFzZWQgdG8gbDItbXRkLmdpdA0KLSB1cGRhdGVkIFtQYXRjaCAzLzRdIHdoaWNoIGNv
bmZsaWN0ZWQgd2l0aCBjb21taXQgJzI2MzMxYzA0JyB3aGljaCB0b3VjaGVkIG9tYXAyLmMuDQot
IFBsZWFzZSBpZ25vcmUgW1BhdGNoIDQvNF0gYXMgaXTigJlzIGEgRFQgdXBkYXRlLCB3aGljaCBh
ZGRzIG9uIHRvcCBvZiBCZW5vaXQncyB0cmVlICh3aGljaCBoYXMgTkFORCBub2RlIGNvbW1pdHMg
dG9vKS4NCg0KVGhhbmtzIGZvciBhY2NlcHRpbmcuLg0Kd2l0aCByZWdhcmRzLCBwZWtvbg0KDQo+
IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gQXJ0ZW0gQml0eXV0c2tpeQ0KDQo=
