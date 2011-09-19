From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH
 v15 06/12] OMAP: dmtimer: switch-over to platform device driver)
Date: Mon, 19 Sep 2011 10:52:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A0FBC@dbde02.ent.ti.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
 <1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
 <20110914214533.GA30941@atomide.com>
 <CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
 <20110915165810.GA2284@atomide.com> <20110915170548.GB2284@atomide.com>
 <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
 <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
 <20110917013531.GB2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57581 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab1ISFWP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 01:22:15 -0400
In-Reply-To: <20110917013531.GB2937@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>

SGkgVG9ueSwNCg0KT24gU2F0LCBTZXAgMTcsIDIwMTEgYXQgMDc6MDU6MzEsIFRvbnkgTGluZGdy
ZW4gd3JvdGU6DQo+IA0KPiBBZnphbCwgY2FyZSB0byBjaGVjayBpZiB0aGF0IHdvcmtzIGZvciBB
TTMzNVgvVEk4MTZYL1RJODE0WD8NCg0KV2l0aCBmb2xsb3dpbmcgcGF0Y2ggb3ZlciB5b3Vycywg
QU0zMzVYICh0aGUgb25seSBib2FyZCB3aXRoIG1lKSBib290cyB1cCBmaW5lLg0KDQpSZWdhcmRz
DQpBZnphbA0KDQpGcm9tIGZmNjRhMjM5ZTYwZjliNTE3ODYwZWIyZmU5YzRmODhhMTg4Y2E1MWQg
TW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBBZnphbCBNb2hhbW1lZCA8YWZ6YWxAdGku
Y29tPg0KRGF0ZTogTW9uLCAxOSBTZXAgMjAxMSAxMDowNjo1OSArMDUzMA0KU3ViamVjdDogW1BB
VENIXSBBUk06IE9NQVA6IGRtdGltZXIgcmVnaXN0ZXIgc2FmZSBhY2Nlc3MNCg0KQWNjZXNzIGRt
dGltZXIgcmVnaXN0ZXJzIGFmdGVyIHNldHRpbmcgaXQncyBwYXJlbnQNCmNsb2NrLiBJZiBkZWZh
dWx0IHBhcmVudCBpcyBub3QgcGh5c2ljYWxseSBwcmVzZW50LA0KYWNjZXNzaW5nIHJlZ2lzdGVy
IGNhdXNlcyBhYm9ydCwgc28gYWNjZXNzIHJlZ2lzdGVycw0KYWZ0ZXIgcHJvcGVyIHBhcmVudCBp
cyBzZXQuDQoNClNpZ25lZC1vZmYtYnk6IEFmemFsIE1vaGFtbWVkIDxhZnphbEB0aS5jb20+DQot
LS0NCiBhcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMgfCAgICAyICstDQogMSBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9tYWNoLW9tYXAyL3RpbWVyLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3RpbWVyLmMNCmlu
ZGV4IDE3NDZjNjkuLmFiYWJjNGQgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3Rp
bWVyLmMNCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvdGltZXIuYw0KQEAgLTE3Miw3ICsxNzIs
NiBAQCBzdGF0aWMgaW50IF9faW5pdCBvbWFwX2RtX3RpbWVyX2luaXRfb25lKHN0cnVjdCBvbWFw
X2RtX3RpbWVyICp0aW1lciwNCiAgICAgICAgfQ0KDQogICAgICAgIG9tYXBfaHdtb2RfZW5hYmxl
KG9oKTsNCi0gICAgICAgX19vbWFwX2RtX3RpbWVyX2luaXRfcmVncyh0aW1lcik7DQoNCiAgICAg
ICAgc3lzX3RpbWVyX3Jlc2VydmVkIHw9ICgxIDw8IChncHRpbWVyX2lkIC0gMSkpOw0KDQpAQCAt
MTkwLDYgKzE4OSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXBfZG1fdGltZXJfaW5pdF9vbmUo
c3RydWN0IG9tYXBfZG1fdGltZXIgKnRpbWVyLA0KICAgICAgICAgICAgICAgICAgICAgICAgY2xr
X3B1dChzcmMpOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KKyAgICAgICBfX29tYXBf
ZG1fdGltZXJfaW5pdF9yZWdzKHRpbWVyKTsNCiAgICAgICAgX19vbWFwX2RtX3RpbWVyX3Jlc2V0
KHRpbWVyLCAxLCAxKTsNCiAgICAgICAgdGltZXItPnBvc3RlZCA9IDE7DQoNCi0tDQoxLjYuMi40
DQo=
