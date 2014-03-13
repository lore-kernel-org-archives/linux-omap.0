From: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 13/18] dma: edma: Print the direction value as well when
 it is not supported
Date: Thu, 13 Mar 2014 13:03:14 +0000
Message-ID: <1394715793.28803.240.camel@smile.fi.intel.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
	 <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394702320-21743-14-git-send-email-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-ID: <41A220705C2C6041A5907B14F67B3C4B@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "joelf@ti.com" <joelf@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, "nsekhar@ti.com" <nsekhar@ti.com>, Jyri Sarha <jsarha@ti.com>, "mporter@linaro.org" <mporter@linaro.org>, "Koul, Vinod" <vinod.koul@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCAyMDE0LTAzLTEzIGF0IDExOjE4ICswMjAwLCBQZXRlciBVamZhbHVzaSB3cm90ZToN
Cj4gSW4gY2FzZSBvZiBub3Qgc3VwcG9ydGVkIGRpcmVjdGlvbiBpdCBpcyBiZXR0ZXIgdG8gcHJp
bnQgdGhlIGRpcmVjdGlvbiBhbHNvLg0KPiBJdCBpcyB1bmxpa2VseSwgYnV0IGluIHN1Y2ggYW4g
ZXZlbnQgaXQgaGVscHMgd2l0aCB0aGUgZGVidWdnaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2RtYS9lZG1hLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZWRtYS5jIGIv
ZHJpdmVycy9kbWEvZWRtYS5jDQo+IGluZGV4IDQ3YWJhYWM3ZWIxOC4uNjlkZDRlM2RlNjdlIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS9lZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvZWRt
YS5jDQo+IEBAIC00MjYsNyArNDI2LDcgQEAgc3RhdGljIHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVz
Y3JpcHRvciAqZWRtYV9wcmVwX3NsYXZlX3NnKA0KPiAgCQlkZXZfd2lkdGggPSBlY2hhbi0+Y2Zn
LmRzdF9hZGRyX3dpZHRoOw0KPiAgCQlidXJzdCA9IGVjaGFuLT5jZmcuZHN0X21heGJ1cnN0Ow0K
PiAgCX0gZWxzZSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiJXM6IGJhZCBkaXJlY3Rpb24/XG4iLCBf
X2Z1bmNfXyk7DQo+ICsJCWRldl9lcnIoZGV2LCAiJXM6IGJhZCBkaXJlY3Rpb246ICVkXG4iLCBf
X2Z1bmNfXywgZGlyZWN0aW9uKTsNCg0KSXMgaXQgcG9zc2libGUgdG8gaGF2ZSBkaXJlY3Rpb24g
bGVzcyB0aGFuIHplcm8/IE1heWJlICV1Pw0KDQo+ICAJCXJldHVybiBOVUxMOw0KPiAgCX0NCj4g
IA0KPiBAQCAtNTE5LDcgKzUxOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2Ny
aXB0b3IgKmVkbWFfcHJlcF9kbWFfY3ljbGljKA0KPiAgCQlkZXZfd2lkdGggPSBlY2hhbi0+Y2Zn
LmRzdF9hZGRyX3dpZHRoOw0KPiAgCQlidXJzdCA9IGVjaGFuLT5jZmcuZHN0X21heGJ1cnN0Ow0K
PiAgCX0gZWxzZSB7DQo+IC0JCWRldl9lcnIoZGV2LCAiJXM6IGJhZCBkaXJlY3Rpb24/XG4iLCBf
X2Z1bmNfXyk7DQo+ICsJCWRldl9lcnIoZGV2LCAiJXM6IGJhZCBkaXJlY3Rpb246ICVkXG4iLCBf
X2Z1bmNfXywgZGlyZWN0aW9uKTsNCg0KRGl0dG8uDQoNCj4gIAkJcmV0dXJuIE5VTEw7DQo+ICAJ
fQ0KPiAgDQoNCg0KLS0gDQpBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVs
LmNvbT4NCkludGVsIEZpbmxhbmQgT3kNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBGaW5sYW5kIE95ClJl
Z2lzdGVyZWQgQWRkcmVzczogUEwgMjgxLCAwMDE4MSBIZWxzaW5raSAKQnVzaW5lc3MgSWRlbnRp
dHkgQ29kZTogMDM1NzYwNiAtIDQgCkRvbWljaWxlZCBpbiBIZWxzaW5raSAKClRoaXMgZS1tYWls
IGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZv
cgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBv
ciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIg
YW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=
