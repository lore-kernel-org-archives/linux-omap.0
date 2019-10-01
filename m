From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Tue, 1 Oct 2019 12:31:38 +0300
Message-ID: <f01bf6ec-e531-371b-4f66-312b12379273@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <202ae3b3-f72c-5b5b-4344-be22c8368cc7@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tero Kristo <t-kristo@ti.com>, Adam Ford <aford173@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>
List-Id: linux-omap@vger.kernel.org

T24gMDEvMTAvMjAxOSAxMToxMiwgVGVybyBLcmlzdG8gd3JvdGU6Cj4gT24gMDEvMTAvMjAxOSAw
ODowNywgVG9taSBWYWxrZWluZW4gd3JvdGU6Cj4+IE9uIDMwLzA5LzIwMTkgMjA6NDgsIFRlcm8g
S3Jpc3RvIHdyb3RlOgo+Pgo+Pj4gSG1taCwgYWZ0ZXIgc29tZSB0ZXN0aW5nLCBpdCBzZWVtcyB0
aGVyZSBpcyBiYWQgc3R1ZmYgaGFwcGVuaW5nIHdpdGggCj4+PiB0aGUgZGl2aWRlciBjbG9jayBp
bXBsZW1lbnRhdGlvbiwgSSBhbSByZS13b3JraW5nIGl0IGFzIG9mIG5vdy4gCj4+PiBCYXNpY2Fs
bHkgd2hhdCBpcyB3cm9uZyBpcyB0aGF0IHdpdGggYSBkaXZpZGVyIG1heCB2YWx1ZSBvZiBzYXkg
MTYsIAo+Pj4gdGhlIGRyaXZlciBhdHRlbXB0cyB0byBjcmFmdCB0aGUgbWF4IHZhbHVlIGludG8g
YSBtYXNrLCBidXQgdGhpcyBlbmRzIAo+Pj4gdXAgYmVpbmcgMHgxZi4gSWYgdGhlIG1heCB2YWx1
ZSBpcyAxNSwgaXQgZW5kcyB1cCBpbnRvIDB4ZiB3aGljaCBpcyAKPj4+IGNvcnJlY3QuCj4+Cj4+
IE9rLCB0aGF0IGV4cGxhaW5zIHRoZSBtYXggbm90IHdvcmtpbmcuCj4+Cj4+IEl0IGRvZXNuJ3Qg
ZXhwbGFpbiB0aGUgb3RoZXIgaXNzdWUsIHdoZXJlIHRoZSBUUk0gc2F5cyB0aGUgbWF4IGRpdiBp
cyAKPj4gMzIsIGJ1dCBpdCBkb2VzIG5vdCB3b3JrLiBCdXQgdGFraW5nIHRoZSBtYXggZGl2IGZy
b20gdGhlIG9sZCBTb0NzLCAKPj4gMTYsIGlzIG5vdCBjb3JyZWN0IGVpdGhlciwgYXMgaXQgc2Vl
bXMgdGhhdCBkaXZpZGVycyB1cCB0byAzMSB3b3JrIG9rLgo+Pgo+PiDCoMKgVG9taQo+Pgo+IAo+
IE9rLCBhdHRhY2hlZCBhIHNlcmllcyB0aGF0IGhvcGVmdWxseSBmaXhlcyBpdCwgYW55IHRlc3Rp
bmcgZmVlZGJhY2sgCj4gd2VsY29tZSBiZWZvcmUgSSBwb3N0IHRoaXMgcHJvcGVybHkuCj4gCj4g
VGhpcyBhbHNvIHN1cHBvcnRzIG9tYXAzNnh4IGRwbGw0X200X2NrIGRpdmlkZXIgdXAtdG8gMzEs
IG90aGVyIG9tYXAzIAo+IGZhbWlseSBpcyBsaW1pdGVkIHRvIDE2LgoKV29ya3MgZm9yIG1lLiBU
aGlzIGFsc28gbmVlZHMgdGhlIGNoYW5nZSB0byBkc3MuYyB0byBjaGFuZ2UgdGhlIG1heCBmcm9t
IAozMiB0byAzMS4gSSdsbCBzZW5kIGEgcGF0Y2ggZm9yIHRoYXQgc2VwYXJhdGVseS4KCiAgVG9t
aQoKLS0gClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAw
MTgwIEhlbHNpbmtpLgpZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2th
L0RvbWljaWxlOiBIZWxzaW5raQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWw=
