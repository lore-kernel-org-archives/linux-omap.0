From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv6 3/4] drm/omap: add framedone interrupt support
Date: Fri, 31 May 2019 15:23:32 +0300
Message-ID: <bbe14265-4499-4a55-ef94-9def2df365d7@ti.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <20190523200756.25314-4-sebastian.reichel@collabora.com>
 <9eb23a5d-438e-7b25-e7cb-8b734a150e43@ti.com>
 <20190529215530.mi3fjlsaziq22mw5@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190529215530.mi3fjlsaziq22mw5@earth.universe>
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
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, Tony Lindgren <tony@atomide.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMzAvMDUvMjAxOSAwMDo1NSwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6Cgo+IE9oIHNvcnJ5
LCBJIG1pc3NlZCB0aGUgcGFydCB0aGF0IG9tYXBfaXJxX3dhaXRfaW5pdCgpIGFjdHVhbGx5Cj4g
ZW5hYmxlcyB0aGUgZnJhbWVkb25lIGlycS4gSXQgc2hvdWxkIGJlIGVub3VnaCB0byBqdXN0IGRy
b3AgdGhlCj4gd2FybmluZyAoYW5kIHRoZSBjdXJseSBicmFja2V0cykgdG8ga2VlcCBleGlzdGlu
ZyBiZWhhdmlvdXIuIFRoZQo+IGNvZGUgZXhpdHMgZWFybHkgd2l0aCB0aGUgYWJvdmUgd2Fybmlu
ZyBmb3IgYW55IGV4aXN0aW5nIGNvZGUgKHNpbmNlCj4gdGhhdCBkb2VzIG5vdCByZWdpc3RlciBh
IGZyYW1lZG9uZSBoYW5kbGVyKS4gRFNJIG9uIHRoZSBvdGhlciBoYW5kCj4gZG9lcyBub3QgcmVh
Y2ggdGhlIG9tYXBfaXJxX3dhaXRfaW5pdCgpIHBhcnQuIFJlZ2FyZGluZyBjb21iaW5pbmcKPiB0
aGUgbG9naWM6IEkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55dGhpbmcgdG8gY29tYmluZSByaWdo
dCBub3cuCj4gSXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHNpbXBsaWZ5IHRoZSBsb2dpYyBhZnRl
ciBEU0kgaGFzIGJlZW4KPiBjb252ZXJ0ZWQgdG8gZHJtX3BhbmVsIHN0eWxlLCBzaW5jZSB0aGlz
IHdpbGwgbW92ZSB0aGUgdXBkYXRlIGxvZ2ljCj4gZm9yIHRoZSBzY3JlZW4gY29udGVudCBmcm9t
IHRoZSBwYW5lbCBkcml2ZXIgdG8gRFNJIGNvcmUuCj4gCj4gVExEUjogSXQncyBlbm91Z2ggdG8g
cmVtb3ZlIHRoZSB3YXJuaW5nLiBEbyB5b3UgbmVlZCBhIG5ldwo+IHN1Ym1pc3Npb24gZm9yIHRo
aXM/CgpPay4gTm8sIEkgY2FuIGVkaXQgdGhlIHBhdGNoLgoKTmlrb2xhdXMsIGFyZSB5b3UgYWJs
ZSB0byB0ZXN0IERTSSB2aWRlb21vZGUgd2l0aCB0aGVzZSBwYXRjaGVzPwoKICBUb21pCgotLSAK
VGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVs
c2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNp
bGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
