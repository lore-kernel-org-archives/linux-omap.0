From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 06:04:22 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
 <51D26CFA.5090500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51D26CFA.5090500@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "khilman@linaro.org" <khilman@linaro.org>, "Cousson,
 Benoit" <b-cousson@ti.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bedia,
 Vaibhav" <vaibhav.bedia@ti.com>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBKdWwgMDIsIDIwMTMgYXQgMTE6MzI6MzQsIE5vcmksIFNla2hhciB3cm90ZToNCj4g
T24gNi8yOC8yMDEzIDM6MDUgUE0sIEhlYmJhciBHdXJ1cmFqYSB3cm90ZToNCj4gPiBPbiBzb21l
IHBsYXRmb3JtcyAobGlrZSBBTTMzeHgpLCBhIHNwZWNpYWwgcmVnaXN0ZXIgKFJUQ19JUlFXQUtF
RU4pDQo+ID4gaXMgYXZhaWxhYmxlIHRvIGVuYWJsZSBBbGFybSBXYWtldXAgZmVhdHVyZS4gVGhp
cyByZWdpc3RlciBuZWVkcyB0byBiZQ0KPiA+IHByb3Blcmx5IGhhbmRsZWQgZm9yIHRoZSBydGN3
YWtlIHRvIHdvcmsgcHJvcGVybHkuDQo+ID4gDQo+ID4gUGxhdGZvcm1zIHVzaW5nIHN1Y2ggSVAg
c2hvdWxkIHNldCAidGksYW0zMzUyLXJ0YyIgaW4gcnRjIGRldmljZSBkdA0KPiA+IGNvbXBhdGli
aWxpdHkgbm9kZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIZWJiYXIgR3VydXJhamEgPGd1
cnVyYWphLmhlYmJhckB0aS5jb20+DQo+ID4gQ2M6IEdyYW50IExpa2VseSA8Z3JhbnQubGlrZWx5
QGxpbmFyby5vcmc+DQo+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2IuaGVycmluZ0BjYWx4ZWRhLmNv
bT4NCj4gPiBDYzogUm9iIExhbmRsZXkgPHJvYkBsYW5kbGV5Lm5ldD4NCj4gPiBDYzogU2VraGFy
IE5vcmkgPG5zZWtoYXJAdGkuY29tPg0KPiA+IENjOiBLZXZpbiBIaWxtYW4gPGtoaWxtYW5AbGlu
YXJvLm9yZz4NCj4gPiBDYzogQWxlc3NhbmRybyBadW1tbyA8YS56dW1tb0B0b3dlcnRlY2guaXQ+
DQo+ID4gQ2M6IHJ0Yy1saW51eEBnb29nbGVncm91cHMuY29tDQo+ID4gQ2M6IGRldmljZXRyZWUt
ZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnDQo+ID4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmcNCj4gPiAtLS0NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IC0jZGVmaW5lCU9NQVBfUlRDX0RBVEFf
REE4MzBfSURYCTENCj4gPiArI2RlZmluZQlPTUFQX1JUQ19EQVRBX0RBODMwX0lEWAkJMQ0KPiA+
ICsjZGVmaW5lCU9NQVBfUlRDX0RBVEFfQU0zMzVYX0lEWAkyDQo+ID4gIA0KPiA+ICBzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBvbWFwX3J0Y19kZXZ0eXBlW10gPSB7DQo+ID4gIAl7
DQo+ID4gQEAgLTMwOSw2ICszMjEsOSBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZV9p
ZCBvbWFwX3J0Y19kZXZ0eXBlW10gPSB7DQo+ID4gIAl9LCB7DQo+ID4gIAkJLm5hbWUJPSAiZGE4
MzAtcnRjIiwNCj4gPiAgCQkuZHJpdmVyX2RhdGEgPSBPTUFQX1JUQ19IQVNfS0lDS0VSLA0KPiA+
ICsJfSwgew0KPiA+ICsJCS5uYW1lCT0gImFtMzM1eC1ydGMiLA0KPiANCj4gbWF5IGJlIHVzZSBh
bTMzNTItcnRjIGhlcmUganVzdCB0byBrZWVwIHRoZSBwbGF0Zm9ybSBkZXZpY2UgbmFtZSBhbmQg
b2YNCj4gY29tcGF0aWJsZSBpbiBzeW5jLg0KDQpDb3JyZWN0LiBJIHdpbGwgdXBkYXRlIHRoZSBz
YW1lIGluIHYyLg0KDQo+IA0KPiA+ICsJCS5kcml2ZXJfZGF0YSA9IE9NQVBfUlRDX0hBU19LSUNL
RVIgfCBPTUFQX1JUQ19IQVNfSVJRV0FLRUVOLA0KPiA+ICAJfSwNCj4gPiAgCXt9LA0KPiANCj4g
SXQgaXMgYmV0dGVyIHRvIHVzZSB0aGUgaW5kZXggZGVmaW5lZCBhYm92ZSBpbiB0aGUgc3RhdGlj
IGluaXRpYWxpemF0aW9uDQo+IHNvIHRoZXkgcmVtYWluIGluIHN5bmMuDQoNClNvcnJ5LiBJIGRp
ZG7igJl0IGdldCB0aGlzLg0KDQo+IA0KPiAJLi4uDQo+IAlbT01BUF9SVENfREFUQV9EQTgzMF9J
RFhdID0gew0KPiAJCS5uYW1lCT0gImRhODMwLXJ0YyIsDQo+IAkJLmRyaXZlcl9kYXRhID0gT01B
UF9SVENfSEFTX0tJQ0tFUiwNCj4gCX0sDQo+IAkuLi4NCj4gDQo+ID4gIH07DQo+ID4gQEAgLTMx
OCw2ICszMzMsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvbWFwX3J0Y19v
Zl9tYXRjaFtdID0gew0KPiA+ICAJewkuY29tcGF0aWJsZQk9ICJ0aSxkYTgzMC1ydGMiLA0KPiA+
ICAJCS5kYXRhCQk9ICZvbWFwX3J0Y19kZXZ0eXBlW09NQVBfUlRDX0RBVEFfREE4MzBfSURYXSwN
Cj4gPiAgCX0sDQo+ID4gKwl7CS5jb21wYXRpYmxlCT0gInRpLGFtMzM1Mi1ydGMiLA0KPiA+ICsJ
CS5kYXRhCQk9ICZvbWFwX3J0Y19kZXZ0eXBlW09NQVBfUlRDX0RBVEFfQU0zMzVYX0lEWF0sDQo+
ID4gKwl9LA0KPiA+ICAJe30sDQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IG9tYXBfcnRjX29mX21hdGNoKTsNCj4gDQo+IEFwYXJ0IGZyb20gdGhlc2UgbWlub3IgaXNzdWVz
LCB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IEFja2VkLWJ5OiBTZWtoYXIgTm9y
aSA8bnNla2hhckB0aS5jb20+DQo+IA0KPiBUaGFua3MsDQo+IFNla2hhcg0KPiANCg0KDQpSZWdh
cmRzLCANCkd1cnVyYWphDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
