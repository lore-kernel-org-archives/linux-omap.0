From: <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 11/25] net: cadence: switch to using
 nvmem_get_mac_address()
Date: Sun, 18 Nov 2018 15:42:34 +0000
Message-ID: <bd51c2fb-9f86-450a-74d1-0cba5c9e9cee@microchip.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-12-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-12-brgl@bgdev.pl>
Content-Language: en-US
Content-ID: <79F765BA4327334388470161DA7A66DE@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: brgl@bgdev.pl, nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, dwmw2@infradead.org, computersforpeace@gmail.com, boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at, davem@davemloft.net, grygorii.strashko@ti.com, srinivas.kandagatla@linaro.org, andrew@lunn.ch, f.fainelli@gmail.com, robh+dt@kernel.org, frowand.list@gmail.com, wsa@the-dreams.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bgolaszewski@baylibre.com
List-Id: linux-omap@vger.kernel.org

T24gMTMvMTEvMjAxOCBhdCAxNTowMSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToNCj4gRnJv
bTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4NCj4gDQo+
IFdlIG5vdyBoYXZlIGEgZ2VuZXJhbGl6ZWQgaGVscGVyIHJvdXRpbmUgdG8gcmVhZCB0aGUgTUFD
IGFkZHJlc3MgZnJvbQ0KPiBudm1lbSB3aGljaCB0YWtlcyBzdHJ1Y3QgZGV2aWNlIGFzIGFyZ3Vt
ZW50LiBUaGUgbnZtZW0gc3Vic3lzdGVtIHdpbGwNCj4gdGhlbiB0cnkgZGV2aWNlIHRyZWUgZmly
c3QgYmVmb3JlIGFsbCBvdGhlciBwb3RlbnRpYWwgcHJvdmlkZXJzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4NCg0K
QWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0K
PiAtLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIHwgMiAr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IGluZGV4IDFkODZi
NGQ1NjQ1YS4uZDlhMjA4ZjdiYjQwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVu
Y2UvbWFjYl9tYWluLmMNCj4gQEAgLTQwNTUsNyArNDA1NSw3IEBAIHN0YXRpYyBpbnQgbWFjYl9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlpZiAobWFjKSB7DQo+ICAg
CQlldGhlcl9hZGRyX2NvcHkoYnAtPmRldi0+ZGV2X2FkZHIsIG1hYyk7DQo+ICAgCX0gZWxzZSB7
DQo+IC0JCWVyciA9IG9mX2dldF9udm1lbV9tYWNfYWRkcmVzcyhucCwgYnAtPmRldi0+ZGV2X2Fk
ZHIpOw0KPiArCQllcnIgPSBudm1lbV9nZXRfbWFjX2FkZHJlc3MoJnBkZXYtPmRldiwgYnAtPmRl
di0+ZGV2X2FkZHIpOw0KPiAgIAkJaWYgKGVycikgew0KPiAgIAkJCWlmIChlcnIgPT0gLUVQUk9C
RV9ERUZFUikNCj4gICAJCQkJZ290byBlcnJfb3V0X2ZyZWVfbmV0ZGV2Ow0KPiANCg0KDQotLSAN
Ck5pY29sYXMgRmVycmUNCg==
