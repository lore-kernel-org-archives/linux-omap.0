From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH/RESEND 9/9] drm/tilcdc: replace late_initcall with
 module_init
Date: Tue, 24 Jun 2014 17:04:36 -0500
Message-ID: <53A9F5F4.3030806@ti.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1403014631-18072-10-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?B?R3VpZG8gTWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?B?RXplcXVpZWwgR2FyY8OtYQ==?= <ezequiel@vanguardiasur.com.ar>, Daniel Mack <zonque@gmail.com>
List-Id: linux-omap@vger.kernel.org

T24gMDYvMTcvMjAxNCAwOToxNyBBTSwgR3VpZG8gTWFydMOtbmV6IHdyb3RlOgo+IFVzZSBtb2R1
bGVfaW5pdCBpbnN0ZWFkIG9mIGxhdGVfaW5pdGNhbGwsIGFzIGlzIHRoZSBub3JtIGZvciBtb2R1
bGFyCj4gZHJpdmVycy4KPgo+IG1vZHVsZV9pbml0IHdhcyB1c2VkIHVudGlsIDZlOGRlMGJkNmE1
MWZkZWViZDVkOTc1YzRmY2M0MjZmNzMwYjMzOWIKPiAoImRybS90aWxjZGM6IGFkZCBlbmNvZGVy
IHNsYXZlICh2MikiKSBjaGFuZ2VkIGl0IHRvIGEgbGF0ZV9pbml0Y2FsbCwKPiBidXQgaXQgZG9l
cyBub3QgZXhwbGFpbiB3aHkuIFRlc3RzIHNob3cgaXQncyB3b3JraW5nIHByb3Blcmx5IHdpdGgK
PiBtb2R1bGVfaW5pdC4KPgoKSWYgSSByZWNhbGwsIHRoZSBsYXRlX2luaXRjYWxsIHN0dWZmIHdh
cyBkb25lIHRvIHRyeSBhbmQgbWFrZSBzdXJlIHRoZSAKdGRhOTk4eC9pMmMgc3Vic3lzdGVtIGNh
bWUgdXAgYmVmb3JlIHRpbGNkYy4gSG93ZXZlciBpdCBkaWRuJ3QgYWx3YXlzIAp3b3JrIHNvIHdl
IGFkZGVkIGNvbW1pdDogMzlkZTYxOTQxMzFjMTU1OTAxZjk2Njg2YTA2MzIxMjY1NmQ4MGMyZSB0
byB0cnkgCmFuZCBlbnN1cmUgdGhlIG9yZGVyaW5nLiAgVGhpcyBtaWdodCBiZSB3aHkgY2hhbmdp
bmcgYmFjayB0byBtb2R1bGVfaW5pdCAKaXMgZmluZSAoYW5kIEkgYWdyZWUgd2l0aCB5b3VyIGFz
c2Vzc21lbnQgZnJvbSBteSB0ZXN0aW5nKS4KCj4gU2lnbmVkLW9mZi1ieTogR3VpZG8gTWFydMOt
bmV6IDxndWlkb0B2YW5ndWFyZGlhc3VyLmNvbS5hcj4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS90aWxjZGMvdGlsY2RjX2Rydi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Rp
bGNkYy90aWxjZGNfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYwo+
IGluZGV4IDJjODYwYzQuLjZiZTYyM2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rp
bGNkYy90aWxjZGNfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19k
cnYuYwo+IEBAIC02MjksNyArNjI5LDcgQEAgc3RhdGljIHZvaWQgX19leGl0IHRpbGNkY19kcm1f
ZmluaSh2b2lkKQo+ICAgCXRpbGNkY190ZnA0MTBfZmluaSgpOwo+ICAgfQo+Cj4gLWxhdGVfaW5p
dGNhbGwodGlsY2RjX2RybV9pbml0KTsKPiArbW9kdWxlX2luaXQodGlsY2RjX2RybV9pbml0KTsK
PiAgIG1vZHVsZV9leGl0KHRpbGNkY19kcm1fZmluaSk7Cj4KPiAgIE1PRFVMRV9BVVRIT1IoIlJv
YiBDbGFyayA8cm9iZGNsYXJrQGdtYWlsLmNvbSIpOwo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
