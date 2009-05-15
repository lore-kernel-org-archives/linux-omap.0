From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 7/8] ARM: OMAP3: Fix number of GPIO lines for 34xx
Date: Fri, 15 May 2009 07:59:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A0CE3@dbde02.ent.ti.com>
References: <20090514175116.12080.12871.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58040 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754498AbZEOC3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 May 2009 22:29:51 -0400
In-Reply-To: <20090514175116.12080.12871.stgit@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom Rix <Tom.Rix@windriver.com>

PiANCj4gRnJvbTogVG9ueSBMaW5kZ3JlbiA8UGFuZGl0YT4NCg0KVHlwbz8NCg0KPiANCj4gQXMg
cGVyIDM0MzAgVFJNLCB0aGVyZSBhcmUgNiBiYW5rcyBbMCB0byAxOTFdDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBUb20gUml4IDxUb20uUml4QHdpbmRyaXZlci5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFZpa3JhbSBQYW5kaXRhIDx2aWtyYW0ucGFuZGl0YUB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vcGxh
dC1vbWFwL2dwaW8uYyB8ICAgIDIgKy0NCj4gIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21h
cC9ncGlvLmMgYi9hcmNoL2FybS9wbGF0LW9tYXAvZ3Bpby5jDQo+IGluZGV4IDE3ZDdhZmUuLmVl
MGIyMWYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9ncGlvLmMNCj4gKysrIGIv
YXJjaC9hcm0vcGxhdC1vbWFwL2dwaW8uYw0KPiBAQCAtMzA3LDcgKzMwNyw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGdwaW9fdmFsaWQoaW50IGdwaW8pDQo+ICAJCXJldHVybiAwOw0KPiAgCWlmIChj
cHVfaXNfb21hcDI0eHgoKSAmJiBncGlvIDwgMTI4KQ0KPiAgCQlyZXR1cm4gMDsNCj4gLQlpZiAo
Y3B1X2lzX29tYXAzNHh4KCkgJiYgZ3BpbyA8IDE2MCkNCj4gKwlpZiAoY3B1X2lzX29tYXAzNHh4
KCkgJiYgZ3BpbyA8IDE5MikNCj4gIAkJcmV0dXJuIDA7DQo+ICAJcmV0dXJuIC0xOw0KPiAgfQ0K
PiANCg==
