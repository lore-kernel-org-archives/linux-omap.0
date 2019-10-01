From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Tue, 1 Oct 2019 08:06:47 -0500
Message-ID: <CAHCN7xLbcQGEEVzLgP3MTp_ej0JnSdOXMgULt4EVSg9B+AjPdw@mail.gmail.com>
References: <20190510194229.20628-1-aford173@gmail.com>
 <854f6130-c8a8-81cb-aa76-4830f218ae54@ti.com>
 <CAHCN7xKocdiWOdmoWQV3POr84qte6WNt0QbQRAwxKSvU8COB_w@mail.gmail.com>
 <0473526e-df0a-94a5-5c22-debd0084ab16@ti.com>
 <36369388-e9c8-22cd-8c19-e2bdf2d0389b@ti.com>
 <eb2eb1f6-3c9b-7ecb-667e-819033af9c14@ti.com>
 <23eba53a-9304-2ceb-d97e-01891ec0b3ed@ti.com>
 <cb028b1e-05ca-9b22-be5d-c63f5fd56cc4@ti.com>
 <F3335195-6EB7-4D44-B884-2F29D9238011@goldelico.com>
 <CAHCN7xL9bFxO=2i1DzmRj6A3XwUNdt=DZeJ2a0EZ0f9gcFTy6g@mail.gmail.com>
 <CAHCN7x+vCfPTRE+zzYUwAXdbBzRotTP2hSOgsHB0FdgBhZV5zA@mail.gmail.com>
 <CAHCN7xJDV=R9Ysjhff7=mEXdciwPP_5LQbHwaUT8KvhSkLKw8A@mail.gmail.com>
 <04306a5e-f9be-35a4-1aa1-5795d780e289@ti.com>
 <3777f1b1-2d9a-334b-b9e7-99dfda2ae29b@ti.com>
 <CAHCN7xJNJca8W_yw5nNY3AmKDSPoLzJ8voPmR1HS3bNcU8uQGg@mail.gmail.com>
 <6cd7c9f0-cb26-588b-dfd1-faf462732549@ti.com>
 <ec718740-bb8f-0d31-3622-89a62bd8fede@ti.com>
 <202ae3b3-f72c-5b5b-4344-be22c8368cc7@ti.com>
 <f01bf6ec-e531-371b-4f66-312b12379273@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f01bf6ec-e531-371b-4f66-312b12379273@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBPY3QgMSwgMjAxOSBhdCA0OjMxIEFNIFRvbWkgVmFsa2VpbmVuIDx0b21pLnZhbGtl
aW5lbkB0aS5jb20+IHdyb3RlOgo+Cj4gT24gMDEvMTAvMjAxOSAxMToxMiwgVGVybyBLcmlzdG8g
d3JvdGU6Cj4gPiBPbiAwMS8xMC8yMDE5IDA4OjA3LCBUb21pIFZhbGtlaW5lbiB3cm90ZToKPiA+
PiBPbiAzMC8wOS8yMDE5IDIwOjQ4LCBUZXJvIEtyaXN0byB3cm90ZToKPiA+Pgo+ID4+PiBIbW1o
LCBhZnRlciBzb21lIHRlc3RpbmcsIGl0IHNlZW1zIHRoZXJlIGlzIGJhZCBzdHVmZiBoYXBwZW5p
bmcgd2l0aAo+ID4+PiB0aGUgZGl2aWRlciBjbG9jayBpbXBsZW1lbnRhdGlvbiwgSSBhbSByZS13
b3JraW5nIGl0IGFzIG9mIG5vdy4KPiA+Pj4gQmFzaWNhbGx5IHdoYXQgaXMgd3JvbmcgaXMgdGhh
dCB3aXRoIGEgZGl2aWRlciBtYXggdmFsdWUgb2Ygc2F5IDE2LAo+ID4+PiB0aGUgZHJpdmVyIGF0
dGVtcHRzIHRvIGNyYWZ0IHRoZSBtYXggdmFsdWUgaW50byBhIG1hc2ssIGJ1dCB0aGlzIGVuZHMK
PiA+Pj4gdXAgYmVpbmcgMHgxZi4gSWYgdGhlIG1heCB2YWx1ZSBpcyAxNSwgaXQgZW5kcyB1cCBp
bnRvIDB4ZiB3aGljaCBpcwo+ID4+PiBjb3JyZWN0Lgo+ID4+Cj4gPj4gT2ssIHRoYXQgZXhwbGFp
bnMgdGhlIG1heCBub3Qgd29ya2luZy4KPiA+Pgo+ID4+IEl0IGRvZXNuJ3QgZXhwbGFpbiB0aGUg
b3RoZXIgaXNzdWUsIHdoZXJlIHRoZSBUUk0gc2F5cyB0aGUgbWF4IGRpdiBpcwo+ID4+IDMyLCBi
dXQgaXQgZG9lcyBub3Qgd29yay4gQnV0IHRha2luZyB0aGUgbWF4IGRpdiBmcm9tIHRoZSBvbGQg
U29DcywKPiA+PiAxNiwgaXMgbm90IGNvcnJlY3QgZWl0aGVyLCBhcyBpdCBzZWVtcyB0aGF0IGRp
dmlkZXJzIHVwIHRvIDMxIHdvcmsgb2suCj4gPj4KPiA+PiAgIFRvbWkKPiA+Pgo+ID4KPiA+IE9r
LCBhdHRhY2hlZCBhIHNlcmllcyB0aGF0IGhvcGVmdWxseSBmaXhlcyBpdCwgYW55IHRlc3Rpbmcg
ZmVlZGJhY2sKPiA+IHdlbGNvbWUgYmVmb3JlIEkgcG9zdCB0aGlzIHByb3Blcmx5Lgo+ID4KPiA+
IFRoaXMgYWxzbyBzdXBwb3J0cyBvbWFwMzZ4eCBkcGxsNF9tNF9jayBkaXZpZGVyIHVwLXRvIDMx
LCBvdGhlciBvbWFwMwo+ID4gZmFtaWx5IGlzIGxpbWl0ZWQgdG8gMTYuCgpUaGFuayB5b3UhICBU
aGlzIHdvcmtzIGZvciBtZS4KCj4KPiBXb3JrcyBmb3IgbWUuIFRoaXMgYWxzbyBuZWVkcyB0aGUg
Y2hhbmdlIHRvIGRzcy5jIHRvIGNoYW5nZSB0aGUgbWF4IGZyb20KPiAzMiB0byAzMS4gSSdsbCBz
ZW5kIGEgcGF0Y2ggZm9yIHRoYXQgc2VwYXJhdGVseS4KClRvbWksCgpEbyB5b3Ugd2FudCBtZSB0
byBwdXNoIGEgcGF0Y2ggdG8gcmVtb3ZlIHRoZQpDT05GSUdfT01BUDJfRFNTX01JTl9GQ0tfUEVS
X1BDSyBoYWNrIG9uY2UgdGhlc2UgcGF0Y2hlcyBoYXZlIGJlZW4KcG9zdGVkPyAgSXQgc2VlbXMg
bGlrZSB0aGUgZGl2aWRlciBmaXggZWxpbWluYXRlcyB0aGUgbmVlZCBmb3IgdGhpcwpoYWNrLgoK
YWRhbQo+Cj4gICBUb21pCj4KPiAtLQo+IFRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBv
cmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgo+IFktdHVubnVzL0J1c2luZXNzIElEOiAw
NjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
