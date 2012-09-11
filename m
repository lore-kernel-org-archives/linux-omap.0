From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] mtd: nand: omap2: fix error path
Date: Tue, 11 Sep 2012 06:30:22 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E19C0@DBDE01.ent.ti.com>
References: <1347344934-28103-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39439 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663Ab2IKGa1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 02:30:27 -0400
In-Reply-To: <1347344934-28103-1-git-send-email-afzal@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

K1RvbnkNCg0KT24gVHVlLCBTZXAgMTEsIDIwMTIgYXQgMTE6NTg6NTQsIE1vaGFtbWVkLCBBZnph
bCB3cm90ZToNCj4gTGV0IHByb2JlIHJldHVybiBlcnJvciB2YWx1ZSBpZiBncG1jIHRlcm1pbmFs
DQo+IGNvdW50IGludGVycnVwdCBjb3VsZCBub3QgYmUgb2J0YWluZWQNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFmemFsIE1vaGFtbWVkIDxhZnphbEB0aS5jb20+DQo+IC0tLQ0KPiBIaSwNCj4gDQo+
IE15IGNvbW1pdCAobm93IGluIGwtby9kZXZlbC1ncG1jKSwNCj4gDQo+ICJiZDQxNTZmICBtdGQ6
IG5hbmQ6IG9tYXAyOiB1c2UgZ3BtYyBwcm92aWRlZCBpcnFzIg0KPiANCj4gZGlkIG5vdCBwcm9w
b2dhdGUgZXJyb3IgY29kZSBwcm9wZXJseSBkdWUgdG8NCj4gd2hpY2ggdGhpcyBmaXggd2FzIHJl
cXVpcmVkLg0KPiANCj4gQnV0IHRoaXMgaGFzIG5vdCBiZWVuIG1lbnRpb25lZCBpbiBjb21taXQg
bWVzc2FnZQ0KPiBhcyBpdCBpcyBub3QgeWV0IGluIG1haW5saW5lLg0KPiANCj4gUmVnYXJkcw0K
PiBBZnphbA0KPiANCj4gIGRyaXZlcnMvbXRkL25hbmQvb21hcDIuYyB8ICAgIDEgKw0KPiAgMSBm
aWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9vbWFwMi5jIGIvZHJpdmVycy9tdGQvbmFuZC9vbWFw
Mi5jDQo+IGluZGV4IDMzN2NmMGEuLjI3MjkzZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L25hbmQvb21hcDIuYw0KPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL29tYXAyLmMNCj4gQEAgLTE0
MDQsNiArMTQwNCw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IG9tYXBfbmFuZF9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlpbmZvLT5ncG1jX2lycV9jb3VudCA9IHBs
YXRmb3JtX2dldF9pcnEocGRldiwgMSk7DQo+ICAJCWlmIChpbmZvLT5ncG1jX2lycV9jb3VudCA8
PSAwKSB7DQo+ICAJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJlcnJvciBnZXR0aW5nIGNvdW50IGly
cVxuIik7DQo+ICsJCQllcnIgPSAtRU5PREVWOw0KPiAgCQkJZ290byBvdXRfcmVsZWFzZV9tZW1f
cmVnaW9uOw0KPiAgCQl9DQo+ICAJCWVyciA9IHJlcXVlc3RfaXJxKGluZm8tPmdwbWNfaXJxX2Nv
dW50LAlvbWFwX25hbmRfaXJxLA0KPiAtLSANCj4gMS43LjAuNA0KPiANCj4gDQoNCg==
