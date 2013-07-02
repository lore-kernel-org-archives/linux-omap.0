From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 11:39:28 +0530
Message-ID: <51D26E98.9040303@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
	<1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
	<51D26CFA.5090500@ti.com>
	<1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EC4E7AB-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,  Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

T24gNy8yLzIwMTMgMTE6MzQgQU0sIEhlYmJhciwgR3VydXJhamEgd3JvdGU6Cj4gT24gVHVlLCBK
dWwgMDIsIDIwMTMgYXQgMTE6MzI6MzQsIE5vcmksIFNla2hhciB3cm90ZToKPj4gT24gNi8yOC8y
MDEzIDM6MDUgUE0sIEhlYmJhciBHdXJ1cmFqYSB3cm90ZToKPj4+IE9uIHNvbWUgcGxhdGZvcm1z
IChsaWtlIEFNMzN4eCksIGEgc3BlY2lhbCByZWdpc3RlciAoUlRDX0lSUVdBS0VFTikKPj4+IGlz
IGF2YWlsYWJsZSB0byBlbmFibGUgQWxhcm0gV2FrZXVwIGZlYXR1cmUuIFRoaXMgcmVnaXN0ZXIg
bmVlZHMgdG8gYmUKPj4+IHByb3Blcmx5IGhhbmRsZWQgZm9yIHRoZSBydGN3YWtlIHRvIHdvcmsg
cHJvcGVybHkuCj4+Pgo+Pj4gUGxhdGZvcm1zIHVzaW5nIHN1Y2ggSVAgc2hvdWxkIHNldCAidGks
YW0zMzUyLXJ0YyIgaW4gcnRjIGRldmljZSBkdAo+Pj4gY29tcGF0aWJpbGl0eSBub2RlLgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IEhlYmJhciBHdXJ1cmFqYSA8Z3VydXJhamEuaGViYmFyQHRpLmNv
bT4KPj4+IENjOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBsaW5hcm8ub3JnPgo+Pj4gQ2M6
IFJvYiBIZXJyaW5nIDxyb2IuaGVycmluZ0BjYWx4ZWRhLmNvbT4KPj4+IENjOiBSb2IgTGFuZGxl
eSA8cm9iQGxhbmRsZXkubmV0Pgo+Pj4gQ2M6IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4K
Pj4+IENjOiBLZXZpbiBIaWxtYW4gPGtoaWxtYW5AbGluYXJvLm9yZz4KPj4+IENjOiBBbGVzc2Fu
ZHJvIFp1bW1vIDxhLnp1bW1vQHRvd2VydGVjaC5pdD4KPj4+IENjOiBydGMtbGludXhAZ29vZ2xl
Z3JvdXBzLmNvbQo+Pj4gQ2M6IGRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnCj4+
PiBDYzogbGludXgtZG9jQHZnZXIua2VybmVsLm9yZwo+Pj4gLS0tCj4+Cj4+IFsuLi5dCj4+Cj4+
PiAtI2RlZmluZQlPTUFQX1JUQ19EQVRBX0RBODMwX0lEWAkxCj4+PiArI2RlZmluZQlPTUFQX1JU
Q19EQVRBX0RBODMwX0lEWAkJMQo+Pj4gKyNkZWZpbmUJT01BUF9SVENfREFUQV9BTTMzNVhfSURY
CTIKPj4+ICAKPj4+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBvbWFwX3J0Y19k
ZXZ0eXBlW10gPSB7Cj4+PiAgCXsKPj4+IEBAIC0zMDksNiArMzIxLDkgQEAgc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2VfaWQgb21hcF9ydGNfZGV2dHlwZVtdID0gewo+Pj4gIAl9LCB7Cj4+
PiAgCQkubmFtZQk9ICJkYTgzMC1ydGMiLAo+Pj4gIAkJLmRyaXZlcl9kYXRhID0gT01BUF9SVENf
SEFTX0tJQ0tFUiwKPj4+ICsJfSwgewo+Pj4gKwkJLm5hbWUJPSAiYW0zMzV4LXJ0YyIsCj4+Cj4+
IG1heSBiZSB1c2UgYW0zMzUyLXJ0YyBoZXJlIGp1c3QgdG8ga2VlcCB0aGUgcGxhdGZvcm0gZGV2
aWNlIG5hbWUgYW5kIG9mCj4+IGNvbXBhdGlibGUgaW4gc3luYy4KPiAKPiBDb3JyZWN0LiBJIHdp
bGwgdXBkYXRlIHRoZSBzYW1lIGluIHYyLgo+IAo+Pgo+Pj4gKwkJLmRyaXZlcl9kYXRhID0gT01B
UF9SVENfSEFTX0tJQ0tFUiB8IE9NQVBfUlRDX0hBU19JUlFXQUtFRU4sCj4+PiAgCX0sCj4+PiAg
CXt9LAo+Pgo+PiBJdCBpcyBiZXR0ZXIgdG8gdXNlIHRoZSBpbmRleCBkZWZpbmVkIGFib3ZlIGlu
IHRoZSBzdGF0aWMgaW5pdGlhbGl6YXRpb24KPj4gc28gdGhleSByZW1haW4gaW4gc3luYy4KPiAK
PiBTb3JyeS4gSSBkaWRu4oCZdCBnZXQgdGhpcy4KPiAKClNlZSBleGFtcGxlIGJlbG93IEkgcHJv
dmlkZWQuIElmIGl0cyBzdGlsbCBub3QgY2xlYXIsIGxldCBtZSBrbm93IHdoYXQKaXMgbm90IGNs
ZWFyLgoKPj4gCS4uLgo+PiAJW09NQVBfUlRDX0RBVEFfREE4MzBfSURYXSA9IHsKPj4gCQkubmFt
ZQk9ICJkYTgzMC1ydGMiLAo+PiAJCS5kcml2ZXJfZGF0YSA9IE9NQVBfUlRDX0hBU19LSUNLRVIs
Cj4+IAl9LAoKVGhhbmtzLApTZWtoYXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KRGF2aW5jaS1saW51eC1vcGVuLXNvdXJjZSBtYWlsaW5nIGxpc3QKRGF2
aW5jaS1saW51eC1vcGVuLXNvdXJjZUBsaW51eC5kYXZpbmNpZHNwLmNvbQpodHRwOi8vbGludXgu
ZGF2aW5jaWRzcC5jb20vbWFpbG1hbi9saXN0aW5mby9kYXZpbmNpLWxpbnV4LW9wZW4tc291cmNl
Cg==
