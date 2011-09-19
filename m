From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add support for dmtimer v2 ip (Re: [PATCH
 v15 06/12] OMAP: dmtimer: switch-over to platform device driver)
Date: Mon, 19 Sep 2011 09:36:17 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4C80288@dbde02.ent.ti.com>
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
Received: from arroyo.ext.ti.com ([192.94.94.40]:46880 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1ISEGa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Sep 2011 00:06:30 -0400
In-Reply-To: <20110917013531.GB2937@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

VG9ueSBMaW5kZ3JlbiB3cm90ZSBvbiBTYXR1cmRheSwgU2VwdGVtYmVyIDE3LCAyMDExIDc6MDYg
QU06DQoNCj4gZGV2aWNlIGRyaXZlcikNCj4gDQo+ICogRGViQmFybWEsIFRhcnVuIEthbnRpIDx0
YXJ1bi5rYW50aUB0aS5jb20+IFsxMTA5MTYgMDE6NTZdOg0KPj4gWy4uLl0NCj4gDQo+IEFmemFs
LCBjYXJlIHRvIGNoZWNrIGlmIHRoYXQgd29ya3MgZm9yIEFNMzM1WC9USTgxNlgvVEk4MTRYPw0K
PiBJdCB0cmllZCBpdCBicmllZmx5IHdpdGggb21hcDQgZ3B0aW1lcjMgYXMgdGhlIGNsb2NrZXZl
bnQgYW5kDQo+IENPTkZJR19MT0NBTF9USU1FUiBkaXNhYmxlZC4gDQo+IA0KPiBUaGUgcGF0Y2gg
aXMgYWdhaW5zdCB0aGUgY3VycmVudCBjbGVhbnVwIGJyYW5jaCBpbiBsaW51eC1vbWFwDQo+IHRy
ZWUuDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gVG9ueQ0KPiANCj4gDQo+IEZyb206IFRvbnkgTGlu
ZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+DQo+IERhdGU6IEZyaSwgMTYgU2VwIDIwMTEgMTU6NDQ6
MjAgLTA3MDANCj4gU3ViamVjdDogW1BBVENIXSBBUk06IE9NQVA6IEFkZCBzdXBwb3J0IGZvciBk
bXRpbWVyIHYyIGlwDQo+IA0KWy4uLl0NCg0KVG9ueSwNCktlcm5lbCBib290cyBmaW5lIG9uIFRJ
ODE2WCAoc2hvdWxkIGFsc28gYm9vdCBvbiBUSTgxNFgpIHdpdGggeW91ciBwYXRjaA0KYW5kIHBh
dGNoZXMgKGluY2x1ZGluZyBPU0MgY2xvY2sgZml4KSBmcm9tIHNlcmllcw0KaHR0cDovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9saW51eC1vbWFwL21zZzU3MDExLmh0bWwgIA0KDQpUaGFua3MuDQoN
CiAgIEhlbWFudA==
