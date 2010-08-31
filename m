From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH 16/20] Get DISPC base addr with platform device
Date: Tue, 31 Aug 2010 14:44:46 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA75F@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	 <1282579089-10487-2-git-send-email-svadivu@ti.com>
	 <1282579089-10487-3-git-send-email-svadivu@ti.com>
	 <1282579089-10487-4-git-send-email-svadivu@ti.com>
	 <1282579089-10487-5-git-send-email-svadivu@ti.com>
	 <1282579089-10487-6-git-send-email-svadivu@ti.com>
	 <1282579089-10487-7-git-send-email-svadivu@ti.com>
	 <1282579089-10487-8-git-send-email-svadivu@ti.com>
	 <1282579089-10487-9-git-send-email-svadivu@ti.com>
	 <1282579089-10487-10-git-send-email-svadivu@ti.com>
	 <1282579089-10487-11-git-send-email-svadivu@ti.com>
	 <1282579089-10487-12-git-send-email-svadivu@ti.com>
	 <1282579089-10487-13-git-send-email-svadivu@ti.com>
	 <1282579089-10487-14-git-send-email-svadivu@ti.com>
	 <1282579089-10487-15-git-send-email-svadivu@ti.com>
	 <1282579089-10487-16-git-send-email-svadivu@ti.com>
	 <1282579089-10487-17-git-send-email-svadivu@ti.com>
 <1282741984.9299.223.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502Ab0HaJO4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Aug 2010 05:14:56 -0400
In-Reply-To: <1282741984.9299.223.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

IA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbWkgVmFsa2VpbmVu
IFttYWlsdG86dG9taS52YWxrZWluZW5Abm9raWEuY29tXSANCj4gU2VudDogV2VkbmVzZGF5LCBB
dWd1c3QgMjUsIDIwMTAgNjo0MyBQTQ0KPiBUbzogR3VydXN3YW15LCBTZW50aGlsdmFkaXZ1DQo+
IENjOiBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9yZzsgcGF1bEBwd3Nhbi5jb207IEhpbG1hbiwg
S2V2aW4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxNi8yMF0gR2V0IERJU1BDIGJhc2UgYWRkciB3
aXRoIHBsYXRmb3JtIGRldmljZQ0KPiANCj4gT24gTW9uLCAyMDEwLTA4LTIzIGF0IDE3OjU4ICsw
MjAwLCBleHQgR3VydXN3YW15IFNlbnRoaWx2YWRpdnUgd3JvdGU6DQo+ID4gRnJvbTogU2VudGhp
bHZhZGl2dSBHdXJ1c3dhbXkgPHN2YWRpdnVAdGkuY29tPg0KPiA+IA0KPiA+IERJU1BDIEJhc2Ug
YWRkciBnb3QgZnJvbSB0aGUgcGxhdGZvcm0gZGV2aWNlLiAgSGFkcmNvZGluZyBvZiBiYXNlDQo+
ID4gYWRkciByZW1vdmVkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlbnRoaWx2YWRpdnUg
R3VydXN3YW15IDxzdmFkaXZ1QHRpLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy92aWRlby9v
bWFwMi9kc3MvZGlzcGMuYyB8ICAgIDUgKysrLS0NCj4gPiAgMSBmaWxlcyBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlkZW8vb21hcDIvZHNzL2Rpc3BjLmMgDQo+IGIvZHJpdmVycy92aWRlby9vbWFwMi9kc3Mv
ZGlzcGMuYw0KPiA+IGluZGV4IGFlMThiNWYuLjhhN2EwODYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy92aWRlby9vbWFwMi9kc3MvZGlzcGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdmlkZW8vb21h
cDIvZHNzL2Rpc3BjLmMNCj4gPiBAQCAtNDAsNyArNDAsNiBAQA0KPiA+ICAjaW5jbHVkZSAiZHNz
LmgiDQo+ID4gIA0KPiA+ICAvKiBESVNQQyAqLw0KPiA+IC0jZGVmaW5lIERJU1BDX0JBU0UJCQkw
eDQ4MDUwNDAwDQo+ID4gIA0KPiA+ICAjZGVmaW5lIERJU1BDX1NaX1JFR1MJCQlTWl8xSw0KPiAN
Cj4gSSBndWVzcyAqX1NaX1JFR1MgYXJlIG5vdCBuZWVkZWQgYW55bW9yZSBmb3IgYW55IG9mIHRo
ZSBibG9ja3MuDQo+IA0KSXRzIHN0aWxsIG5lZWRlZCBmb3IgdGhlIGRlZmluaXRpb24gb2YgYXJy
YXkgc2l6ZSB1c2VkIGZvciBzYXZlL3Jlc3RvcmUsDQpVbmxlc3Mgd2UgZ28gZm9yIHBvaW50ZXJz
IHRvIGRvIGR5bmFtaWMgYWxsb2NhdGlvbiBvZiByZWdpc3RlciBzaXplLg0KDQo+ICBUb21pDQo+
IA0KPiANCj4g
