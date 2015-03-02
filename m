From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 3/6] drm/tilcdc: Add support for external compontised
 DRM encoder
Date: Mon, 2 Mar 2015 16:01:35 +0000
Message-ID: <20150302160135.GA29584@n2100.arm.linux.org.uk>
References: <cover.1424961754.git.jsarha@ti.com>
 <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <92792bb4f64fb1b7f26e687ec159d870d0e7a81a.1424961754.git.jsarha@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, detheridge@ti.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCBGZWIgMjYsIDIwMTUgYXQgMDQ6NTU6MzJQTSArMDIwMCwgSnlyaSBTYXJoYSB3cm90
ZToKPiArCXJldCA9IGNvbXBvbmVudF9iaW5kX2FsbChkZXYtPmRldiwgZGV2KTsKPiArCWlmIChy
ZXQgPCAwKSB7Cj4gKwkJZGV2X2VycihkZXYtPmRldiwgIkJpbmRpbmcgc3ViY29tcG9uZW50cyBm
YWlsZWQ6ICVkXG4iLCByZXQpOwoKRG8geW91IG5lZWQgdG8gcHJpbnQgdGhpcz8gIFRoZSBjb21w
b25lbnQgaGVscGVyIGlzIGFscmVhZHkgZmFpcmx5CnZlcmJvc2UgYWJvdXQgd2hhdCBzdWNjZWVk
cyBhbmQgZmFpbHMuCgo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNvbXBvbmVudF9tYXN0ZXJfb3Bz
IHRpbGNkY19jb21wX29wcyA9IHsKPiArCS5hZGRfY29tcG9uZW50cyA9IHRpbGNkY19hZGRfZXh0
ZXJuYWxfY29tcG9uZW50cywKCkknZCBtdWNoIHJhdGhlciB5b3UgdXNlZCB0aGUgbmV3IG1hdGNo
aW5nIHN1cHBvcnQgcmF0aGVyIHRoYW4gdXNpbmcgdGhlCm9sZCAuYWRkX2NvbXBvbmVudHMuICBU
aGUgbmV3IG1hdGNoaW5nIHN1cHBvcnQgaXMgbW9yZSBlZmZpY2llbnQgYXMgeW91Cm9ubHkgaGF2
ZSB0byBzY2FuIERUIG9uY2UsIHJhdGhlciB0aGFuIGVhY2ggdGltZSB3ZSB0cnkgdG8gcHJvYmUu
ICBUaGF0CndpbGwgbWVhbi4uLgoKPiBAQCAtNjEzLDEyICs2NDMsMTIgQEAgc3RhdGljIGludCB0
aWxjZGNfcGRldl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAJCXJldHVy
biAtRU5YSU87Cj4gIAl9CgpZb3UgbmVlZCB0byBidWlsZCBhIHN0cnVjdCBjb21wb25lbnRfbWF0
Y2ggYXJyYXkgaGVyZSB1c2luZwpjb21wb25lbnRfbWF0Y2hfYWRkKCkuLi4KCj4gIAo+IC0JcmV0
dXJuIGRybV9wbGF0Zm9ybV9pbml0KCZ0aWxjZGNfZHJpdmVyLCBwZGV2KTsKPiArCXJldHVybiBj
b21wb25lbnRfbWFzdGVyX2FkZCgmcGRldi0+ZGV2LCAmdGlsY2RjX2NvbXBfb3BzKTsKCmFuZCB0
aGVuIGZpbmFsbHkgcmVnaXN0ZXIgdGhlIG9wcyB3aXRoIGNvbXBvbmVudF9tYXN0ZXJfYWRkX3dp
dGhfbWF0Y2goKS4KClRoYW5rcy4KCi0tIApGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5l
OiBjdXJyZW50bHkgYXQgMTAuNU1icHMgZG93biA0MDBrYnBzIHVwCmFjY29yZGluZyB0byBzcGVl
ZHRlc3QubmV0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
