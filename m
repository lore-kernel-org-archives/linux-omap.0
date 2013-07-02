From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 06:11:01 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4E7CC@DBDE04.ent.ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
	<51D26CFA.5090500@ti.com>
	<1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
	<51D26E98.9040303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51D26E98.9040303-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBKdWwgMDIsIDIwMTMgYXQgMTE6Mzk6MjgsIE5vcmksIFNla2hhciB3cm90ZToNCj4g
T24gNy8yLzIwMTMgMTE6MzQgQU0sIEhlYmJhciwgR3VydXJhamEgd3JvdGU6DQo+ID4gT24gVHVl
LCBKdWwgMDIsIDIwMTMgYXQgMTE6MzI6MzQsIE5vcmksIFNla2hhciB3cm90ZToNCj4gPj4gT24g
Ni8yOC8yMDEzIDM6MDUgUE0sIEhlYmJhciBHdXJ1cmFqYSB3cm90ZToNCj4gPj4+IE9uIHNvbWUg
cGxhdGZvcm1zIChsaWtlIEFNMzN4eCksIGEgc3BlY2lhbCByZWdpc3RlciAoUlRDX0lSUVdBS0VF
TikNCj4gPj4+IGlzIGF2YWlsYWJsZSB0byBlbmFibGUgQWxhcm0gV2FrZXVwIGZlYXR1cmUuIFRo
aXMgcmVnaXN0ZXIgbmVlZHMgdG8gYmUNCj4gPj4+IHByb3Blcmx5IGhhbmRsZWQgZm9yIHRoZSBy
dGN3YWtlIHRvIHdvcmsgcHJvcGVybHkuDQo+ID4+Pg0KPiA+Pj4gUGxhdGZvcm1zIHVzaW5nIHN1
Y2ggSVAgc2hvdWxkIHNldCAidGksYW0zMzUyLXJ0YyIgaW4gcnRjIGRldmljZSBkdA0KPiA+Pj4g
Y29tcGF0aWJpbGl0eSBub2RlLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEhlYmJhciBH
dXJ1cmFqYSA8Z3VydXJhamEuaGViYmFyQHRpLmNvbT4NCj4gPj4+IENjOiBHcmFudCBMaWtlbHkg
PGdyYW50Lmxpa2VseUBsaW5hcm8ub3JnPg0KPiA+Pj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2IuaGVy
cmluZ0BjYWx4ZWRhLmNvbT4NCj4gPj4+IENjOiBSb2IgTGFuZGxleSA8cm9iQGxhbmRsZXkubmV0
Pg0KPiA+Pj4gQ2M6IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4NCj4gPj4+IENjOiBLZXZp
biBIaWxtYW4gPGtoaWxtYW5AbGluYXJvLm9yZz4NCj4gPj4+IENjOiBBbGVzc2FuZHJvIFp1bW1v
IDxhLnp1bW1vQHRvd2VydGVjaC5pdD4NCj4gPj4+IENjOiBydGMtbGludXhAZ29vZ2xlZ3JvdXBz
LmNvbQ0KPiA+Pj4gQ2M6IGRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnDQo+ID4+
PiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4gLS0tDQo+ID4+DQo+ID4+IFsu
Li5dDQo+ID4+DQo+ID4+PiAtI2RlZmluZQlPTUFQX1JUQ19EQVRBX0RBODMwX0lEWAkxDQo+ID4+
PiArI2RlZmluZQlPTUFQX1JUQ19EQVRBX0RBODMwX0lEWAkJMQ0KPiA+Pj4gKyNkZWZpbmUJT01B
UF9SVENfREFUQV9BTTMzNVhfSURYCTINCj4gPj4+ICANCj4gPj4+ICBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RldmljZV9pZCBvbWFwX3J0Y19kZXZ0eXBlW10gPSB7DQo+ID4+PiAgCXsNCj4gPj4+
IEBAIC0zMDksNiArMzIxLDkgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgb21h
cF9ydGNfZGV2dHlwZVtdID0gew0KPiA+Pj4gIAl9LCB7DQo+ID4+PiAgCQkubmFtZQk9ICJkYTgz
MC1ydGMiLA0KPiA+Pj4gIAkJLmRyaXZlcl9kYXRhID0gT01BUF9SVENfSEFTX0tJQ0tFUiwNCj4g
Pj4+ICsJfSwgew0KPiA+Pj4gKwkJLm5hbWUJPSAiYW0zMzV4LXJ0YyIsDQo+ID4+DQo+ID4+IG1h
eSBiZSB1c2UgYW0zMzUyLXJ0YyBoZXJlIGp1c3QgdG8ga2VlcCB0aGUgcGxhdGZvcm0gZGV2aWNl
IG5hbWUgYW5kIG9mDQo+ID4+IGNvbXBhdGlibGUgaW4gc3luYy4NCj4gPiANCj4gPiBDb3JyZWN0
LiBJIHdpbGwgdXBkYXRlIHRoZSBzYW1lIGluIHYyLg0KPiA+IA0KPiA+Pg0KPiA+Pj4gKwkJLmRy
aXZlcl9kYXRhID0gT01BUF9SVENfSEFTX0tJQ0tFUiB8IE9NQVBfUlRDX0hBU19JUlFXQUtFRU4s
DQo+ID4+PiAgCX0sDQo+ID4+PiAgCXt9LA0KPiA+Pg0KPiA+PiBJdCBpcyBiZXR0ZXIgdG8gdXNl
IHRoZSBpbmRleCBkZWZpbmVkIGFib3ZlIGluIHRoZSBzdGF0aWMgaW5pdGlhbGl6YXRpb24NCj4g
Pj4gc28gdGhleSByZW1haW4gaW4gc3luYy4NCj4gPiANCj4gPiBTb3JyeS4gSSBkaWRu4oCZdCBn
ZXQgdGhpcy4NCj4gPiANCj4gDQo+IFNlZSBleGFtcGxlIGJlbG93IEkgcHJvdmlkZWQuIElmIGl0
cyBzdGlsbCBub3QgY2xlYXIsIGxldCBtZSBrbm93IHdoYXQNCj4gaXMgbm90IGNsZWFyLg0KPiAN
Cj4gPj4gCS4uLg0KPiA+PiAJW09NQVBfUlRDX0RBVEFfREE4MzBfSURYXSA9IHsNCj4gPj4gCQku
bmFtZQk9ICJkYTgzMC1ydGMiLA0KPiA+PiAJCS5kcml2ZXJfZGF0YSA9IE9NQVBfUlRDX0hBU19L
SUNLRVIsDQo+ID4+IAl9LA0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJbiB0aGlz
IGNhc2Ugd2lsbCBpdCBvayBpZiBJIHVwZGF0ZSB0aGUgcHJldmlvdXMNCm1lbWJlciBhbHNvLg0K
DQo+IA0KPiBUaGFua3MsDQo+IFNla2hhcg0KPiANCg0KDQpSZWdhcmRzLCANCkd1cnVyYWphDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpEYXZpbmNpLWxp
bnV4LW9wZW4tc291cmNlIG1haWxpbmcgbGlzdApEYXZpbmNpLWxpbnV4LW9wZW4tc291cmNlQGxp
bnV4LmRhdmluY2lkc3AuY29tCmh0dHA6Ly9saW51eC5kYXZpbmNpZHNwLmNvbS9tYWlsbWFuL2xp
c3RpbmZvL2RhdmluY2ktbGludXgtb3Blbi1zb3VyY2UK
