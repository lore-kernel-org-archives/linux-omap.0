From: "Robey, Caleb" <c-robey@ti.com>
Subject: RE: [PATCH 0/1] ARM: dts: am5729: beaglebone-ai: enable board
Date: Tue, 19 Nov 2019 20:45:06 +0000
Message-ID: <770139b562564445a743e2b7c905e469@ti.com>
References: <20191119202850.18149-1-c-robey@ti.com>
 <a117b152-8fcb-01a8-5a53-2cb615e87111@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a117b152-8fcb-01a8-5a53-2cb615e87111@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Davis, Andrew" <afd@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Jason Kridner <jkridner@gmail.com>, "Vutla, Lokesh" <lokeshvutla@ti.com>, "Kridner, Jason" <jdk@ti.com>, "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>, "Dannenberg, Andreas" <dannenberg@ti.com>, "Hiblot, Jean-Jacques" <jjhiblot@ti.com>, "Bajjuri, Praneeth" <praneeth@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aXMsIEFuZHJldw0K
PiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOSwgMjAxOSAyOjQxIFBNDQo+IFRvOiBSb2JleSwg
Q2FsZWI7IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKYXNvbiBLcmlkbmVyOyBW
dXRsYSwgTG9rZXNoOyBLcmlkbmVyLCBKYXNvbjsgUml6dmksIE1vaGFtbWFkIEZhaXoNCj4gQWJi
YXM7IERhbm5lbmJlcmcsIEFuZHJlYXM7IEhpYmxvdCwgSmVhbi1KYWNxdWVzOyBCYWpqdXJpLCBQ
cmFuZWV0aDsNCj4gU3RyYXNoa28sIEdyeWdvcmlpOyBUb20gUmluaTsgUm9iIEhlcnJpbmc7IE1h
cmsgUnV0bGFuZDsgQmVub8OudCBDb3Vzc29uOw0KPiBUb255IExpbmRncmVuOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDAvMV0gQVJNOiBkdHM6IGFtNTcyOTogYmVhZ2xlYm9uZS1haTogZW5hYmxl
IGJvYXJkDQo+IA0KPiBPbiAxMS8xOS8xOSAzOjI4IFBNLCBDYWxlYiBSb2JleSB3cm90ZToNCj4g
PiBUaGUgZm9sbG93aW5nIHBhdGNoIGFkZHMgdGhlIGRldmljZSB0cmVlIGZpbGUgZm9yIEJlYWds
ZUJvbmUgQUkNCj4gPg0KPiANCj4gDQo+IENvdmVyLWxldHRlciBmb3IgYSBzaW5nbGUgcGF0Y2gg
aXMgcHJvYmFibHkgbm90IG5lZWRlZCwgZXNwZWNpYWxseSB3aGVuDQo+IHlvdSBkb24ndCBhZGQg
YW55dGhpbmcgdXNlZnVsIGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+IA0KPiBBbmRyZXcNCg0KT2th
eSwgdGhhbmsgeW91IGZvciBsZXR0aW5nIG1lIGtub3cgLSBJIHdpbGwga2VlcCB0aGF0IGluIG1p
bmQgaW4gdGhlIGZ1dHVyZS4NCkNhbGViDQogDQo+IA0KPiANCj4gPiBDYWxlYiBSb2JleSAoMSk6
DQo+ID4gICBBUk06IGR0czogYW01NzI5OiBiZWFnbGVib25lLWFpOiBhZGRpbmcgZGV2aWNlIHRy
ZWUNCj4gPg0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2FtNTcyOS1iZWFnbGVib25lYWkuZHRzIHwg
NzgyDQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3ODMg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMv
YW01NzI5LWJlYWdsZWJvbmVhaS5kdHMNCj4gPg0K
