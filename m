From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] AM437x: Add rtc-only + DDR mode support
Date: Tue, 9 Apr 2019 07:20:06 -0700
Message-ID: <20190409142006.GB2839@atomide.com>
References: <20190403045742.2243-1-j-keerthy@ti.com>
 <20190408172654.GL49658@atomide.com>
 <20190408174349.GM49658@atomide.com>
 <643643f2-c855-5cb6-79b5-96a4f9752955@ti.com>
 <accde963-4cb0-2db3-d482-f6ca1a386398@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <accde963-4cb0-2db3-d482-f6ca1a386398@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, d-gerlach@ti.com, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBLZWVydGh5IDxqLWtlZXJ0aHlAdGkuY29tPiBbMTkwNDA5IDA1OjIxXToKPiAKPiAKPiBPbiAw
OS8wNC8xOSA5OjI5IEFNLCBLZWVydGh5IHdyb3RlOgo+ID4gCj4gPiAKPiA+IE9uIDA4LzA0LzE5
IDExOjEzIFBNLCBUb255IExpbmRncmVuIHdyb3RlOgo+ID4gPiAqIFRvbnkgTGluZGdyZW4gPHRv
bnlAYXRvbWlkZS5jb20+IFsxOTA0MDggMTA6MjZdOgo+ID4gPiA+ICogS2VlcnRoeSA8ai1rZWVy
dGh5QHRpLmNvbT4gWzE5MDQwMiAyMTo1N106Cj4gPiA+ID4gPiBDaGFuZ2VzIGluIHYzOgo+ID4g
PiA+ID4gCj4gPiA+ID4gPiDCoMKgICogRXhwb3J0ZWQgb3V0IG9tYXBfcnRjX3Bvd2Vyb2ZmX3By
b2dyYW0gZnVuY3Rpb24gJiByZW1vdmVkCj4gPiA+ID4gPiDCoMKgwqDCoCB0aGUgcGF0Y2ggdG8g
YWRkIGEgZ2VuZXJpYyBydGMgaW50ZXJmYWNlIGFzIGl0IGlzIHNwZWNpZmljCj4gPiA+ID4gPiDC
oMKgwqDCoCB0byBhbTQzIGF0IHRoZSBtb21lbnQuCj4gPiA+ID4gCj4gPiA+ID4gVGhhbmtzIEkn
bGwgYmUgYXBwbHlpbmcgdGhpcyBzZXJpZXMgaW50byBvbWFwLWZvci12NS4yL2FtNC1wbQo+ID4g
PiA+IHRvZGF5Lgo+ID4gPiAKPiA+ID4gU29ycnkgY29ycmVjdGlvbiBmb3IgdGhlIGJyYW5jaCBu
YW1lZCBhYm92ZS4gSSBub3RpY2VkIGEgYnVpbGQKPiA+ID4gd2FybmluZyBhbmQgZm9sZGVkIGlu
IHRoZSBmb2xsb3dpbmcgZml4LiBXZSBuZWVkIHRvIHJldHVybgo+ID4gPiAtRUlOVkFMIGlmIHRt
MmJjZCgpIGZhaWxzIGxpa2Ugd2UgZG8gZWxzZXdoZXJlIGluIHRoZSBkcml2ZXIuCj4gPiA+IAo+
ID4gPiBTbyBJIGp1c3QgcHVzaGVkIG91dCBhIG5ldyBicmFuY2ggb21hcC1mb3ItdjUuMi9hbTQt
cG0tdjIuCj4gPiA+IFBsZWFzZSBqdXN0IGlnbm9yZSB0aGUgZWFybGllciBicmFuY2ggb21hcC1m
b3ItdjUuMi9hbTQtcG0uCj4gPiAKPiA+IFRoYW5rcyBUb255IQo+IAo+IFRvbnksCj4gCj4gU2Vl
bXMgbGlrZSB5b3VyIGZvci1uZXh0IGlzIGEgbGl0dGxlIGJlaGluZC4gSGVuY2UgeW91IG5vdGlj
ZWQgdGhlCj4gY29tcGlsYXRpb24gZXJyb3Igd2hpY2ggaSBkaWQgbm90IG5vdGljZS4gVGhlIHJ0
YyBkcml2ZXIgcGF0Y2ggaSBmb3JtYXR0ZWQKPiBmcm9tIHlvdXIgZm9yLW5leHQgYnJhbmNoIGRv
ZXMgbm90IGFwcGx5IGNsZWFubHkgb24gbGludXgtbmV4dCBhcyB0aGVyZSBhcmUKPiBtb3JlIHBh
dGNoZXMgYWxyZWFkeSBhcHBsaWVkIGJ5IEFsZXhhbmRyZSBvbiBuZXh0Lgo+IAo+IFNvIHRoZSBw
YXRjaCB5b3UgbWFkZSB0byByZXR1cm4gLUVJTlZBTCBpcyBubyBsb25nZXIgbmVlZGVkIG9uIGxh
dGVzdCBuZXh0LgoKWWVhaCBJIG5vdGljZWQgdGhlcmUncyBub3cgYSBtaW5vciBjb25mbGljdCB3
aXRoIHRoZSBydGMKdHJlZSBjaGFuZ2VzLCB0aGF0J3MgdHJpdmlhbCB0byByZXNvbHZlIHRob3Vn
aC4KClJlZ2FyZHMsCgpUb255CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
