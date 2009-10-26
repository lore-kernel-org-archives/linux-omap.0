From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 2/2 v3] OMAP3: PM: SR: SmartReflex Refactor Rev4.0
Date: Mon, 26 Oct 2009 20:39:07 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE306@dbde02.ent.ti.com>
References: <OMAP3:PM:SR: SmartReflex Refactor Rev3.0>
 <1256361352-9968-1-git-send-email-nm@ti.com>
 <1256361352-9968-2-git-send-email-nm@ti.com>
 <1256361352-9968-3-git-send-email-nm@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940253EFE01B@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43730 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbZJZPJS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Oct 2009 11:09:18 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AC22837@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Hogander Jouni <jouni.hogander@nokia.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lbm9uLCBOaXNoYW50aCAN
Cj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI2LCAyMDA5IDM6NDggUE0NCj4gVG86IEcsIE1hbmp1
bmF0aCBLb25kYWlhaDsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEltYmVydG9u
IEd1aWxoZW07IE1pa2UgQ2hhbjsgTmF5YWssIFJhamVuZHJhOyBSb2dlciANCj4gUXVhZHJvczsg
S2FsbGUgSm9raW5pZW1pOyBSZWRkeSwgVGVlcnRoOyBLZXZpbiBIaWxtYW47IFBhdWwgDQo+IFdh
bG1zbGV5OyBIb2dhbmRlciBKb3VuaQ0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvMiB2M10gT01B
UDM6IFBNOiBTUjogU21hcnRSZWZsZXggUmVmYWN0b3IgUmV2NC4wDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRywgTWFuanVuYXRoIEtvbmRhaWFoDQo+ID4g
U2VudDogTW9uZGF5LCBPY3RvYmVyIDI2LCAyMDA5IDM6NDAgQU0NCj4gPiBUbzogTWVub24sIE5p
c2hhbnRoOyBsaW51eC1vbWFwQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBJbWJlcnRvbiBHdWls
aGVtOyBNaWtlIENoYW47IE5heWFrLCBSYWplbmRyYTsgUm9nZXIgDQo+IFF1YWRyb3M7IEthbGxl
DQo+ID4gSm9raW5pZW1pOyBSZWRkeSwgVGVlcnRoOyBLZXZpbiBIaWxtYW47IFBhdWwgV2FsbXNs
ZXk7IA0KPiBIb2dhbmRlciBKb3VuaQ0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yIHYzXSBP
TUFQMzogUE06IFNSOiBTbWFydFJlZmxleCANCj4gUmVmYWN0b3IgUmV2NC4wDQo+ID4gDQo+ID4g
DQo+ID4gQXMgcGVyIHlvdXIgY29tbWVudHMgZm9yIG90aGVyIHBhdGNoZXMgd2hlbiBldmVyIHRo
ZXJlIGlzIA0KPiB1ZGVsYXkgdXNhZ2UsDQo+ID4gY3B1X3JlbGF4IGlzIHRoZSBiZXR0ZXIgb3B0
aW9uLiBJIHNlZSB0aGVyZSBhcmUgbG90IG9mIA0KPiB1ZGVsYXkoLi4uKSBjYWxscw0KPiA+IHVz
ZWQgaW4gdGhpcyBwYXRjaC4gV2h5IGNhbid0IHlvdSB1c2UgY3B1X3JlbGF4KCkgb3Igc2NoZWR1
bGUoKS4NCj4gPiBBbnkgc3BlY2lmaWMgcmVhc29uPw0KPiA+IA0KPiBEb27igJl0IHJlYWxseSB3
YW50IHRvIGRvIGNwdV9yZWxheCBpbiBpcnFfbG9ja2VkIGNvbnRleHQuLiBpZiANCj4geW91IGxv
b2sgYXQgdGhlIGNvZGUgZmxvdywgdGhlIGNhbGwgZnJvbSBjcHVfaWRsZSBpcyBpbiANCj4gaXJx
X2xvY2tlZC4uIEZ1cnRoZXIgdGhpcyBkZWxheSBpcyBwYXJ0IG9mIGJyaW5nIHVwIGZvcm0gDQo+
IHNhdmVkIGNvbnRleHQgd2hlcmUgdGhlcmUgaXMgbm90aGluZyBlbHNlIHNjaGVkdWxlZCArIHdl
IA0KPiBkb27igJl0IHdhbnQgYW55dGhpbmcgZWxzZSBzY2hlZHVsZWQgKGFuZCBjYXVzaW5nIGEg
Y2hhbmdlIGluIA0KPiBzY2hlZHVsaW5nIGRlY2lzaW9uKS4gU28gdW5mb3J0dW5hdGVseSwgdW5s
aWtlIHN0YW5kYXJkIA0KPiBkcml2ZXJzLCB0aGlzIGNhbm5vdCB1c2UgdGhlIHNhbWUgcmVhc29u
aW5nLg0KPiANCg0KTkFLLiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIFNSIGZ1bmN0aW9ucyB3
aWxsIGJlIGNhbGxlZCBkdXJpbmcgdm9sdGFnZSANCnNjYWxpbmcgYWxzby4gVm9sdGFnZSBzY2Fs
aW5nIHdpbGwgaGFwcGVuIGluIG5vbiBJUlEgbG9ja2VkIGNvbnRleHQuDQoNClBsZWFzZSBjbGFy
aWZ5IGlmIEkgYW0gd3JvbmcuDQoNCi1NYW5qdW5hdGgNCg==
