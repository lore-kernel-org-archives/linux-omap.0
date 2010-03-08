From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] omap2_mcspi.c: Clock divider range check wrong for OMAP3
Date: Mon, 8 Mar 2010 17:33:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCAD0E@dbde02.ent.ti.com>
References: <1268049411.2558.76.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50339 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab0CHMEA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 07:04:00 -0500
In-Reply-To: <1268049411.2558.76.camel@quad>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Scott Ellis <scott@jumpnowtek.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

U2NvdHQgRWxsaXMgd3JvdGU6DQo+IA0KPiBUaGUgY2xvY2sgZGl2aWRlciByYW5nZSBjaGVjayBp
cyB3cm9uZyBmb3IgdGhlIE9NQVAzLg0KPiANCj4gVGhlIE1DU1BJX0NIeENPTkYuQ0xLRCByZWdp
c3RlciBmaWVsZCBoYXMgYSBtYXggdmFsdWUgMHgwQyANCj4gbm90IDB4MEYuIFJlZmVyZW5jZSB3
YXMgdGhlIE9NQVAzIFRSTSBSZXYuIEQgbWFudWFsLg0KPiANCj4gSSBkb24ndCBrbm93IHdoZXRo
ZXIgdGhlIG9sZCB2YWx1ZSB3YXMgY29ycmVjdCBmb3IgT01BUDI0eHh4IA0KPiBib2FyZHMgc28g
SSBwdXQgaW4gc29tZSAjaWZkZWYgc3R1ZmYuIE1heWJlIHNvbWVvbmUgd2l0aCBhY2Nlc3MNCj4g
dG8gdGhlIE9NQVAyNHh4eCBtYW51YWwgY291bGQgY2hlY2sgaWYgdGhhdCBpcyBuZWNlc3Nhcnku
DQo+IA0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2NvdHQgRWxsaXMgPHNjb3R0QGp1bXBub3d0ZWsu
Y29tPg0KDQoNCkkgdG9vayBhIGxvb2sgYXQgY3VycmVudCAzNHh4IFRSTSAoUmV2IFopIGFuZCAy
NDMwIFRSTQ0KKFJldiBaIGFnYWluKS4gWW91J3JlIHJpZ2h0IGluIHRoYXQgdGhlIDM0MzAgaGFz
IGEgbWF4DQp2YWx1ZSBvZiAweDBDIGZvciB0aGlzIGZpZWxkLg0KDQpUaGUgMjQzMCBUUk0gc2F5
cyAweDBGIGlzIHZhbGlkIGZvciB0aGUgY29ycmVzcG9uZGluZw0KZmllbGQgdGhlcmUuDQoNCk5v
dCByZWFsbHkgc3VyZSB3aGF0IGlzIHRoZSBjb3JyZWN0IHZhbHVlLCBidXQgYXQgbGVhc3QNCnRo
ZSBkb2N1bWVudGF0aW9uIHNheXMgeW91J3JlIHJpZ2h0Lg0KDQpIb3BlIHRoaXMgaGVscHMuDQoN
Ci0gQW5hbmQNCg0K
