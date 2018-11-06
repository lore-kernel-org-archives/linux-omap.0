From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] drm/omap: dsi: Fix missing of_platform_depopulate()
Date: Tue,  6 Nov 2018 07:28:02 -0800
Message-ID: <20181106152802.38599-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
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
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

V2UncmUgbWlzc2luZyBhIGNhbGwgdG8gb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZSgpIG9uIGVycm9y
cyBmb3IgZHNpLgpMb29rcyBsaWtlIGRzcyBpcyBhbHJlYWR5IGRvaW5nIHRoaXMuCgpTaWduZWQt
b2ZmLWJ5OiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9vbWFwZHJtL2Rzcy9kc2kuYyB8IDggKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L29tYXBkcm0vZHNzL2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vZHNzL2RzaS5jCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL2Rzcy9kc2kuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vb21hcGRybS9kc3MvZHNpLmMKQEAgLTU0MjksMTUgKzU0MjksMTkgQEAgc3RhdGljIGludCBk
c2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAl9CiAKIAlyID0gb2ZfcGxh
dGZvcm1fcG9wdWxhdGUoZGV2LT5vZl9ub2RlLCBOVUxMLCBOVUxMLCBkZXYpOwotCWlmIChyKQor
CWlmIChyKSB7CiAJCURTU0VSUigiRmFpbGVkIHRvIHBvcHVsYXRlIERTSSBjaGlsZCBkZXZpY2Vz
OiAlZFxuIiwgcik7CisJCWdvdG8gZXJyX3VuaW5pdF9vdXRwdXQ7CisJfQogCiAJciA9IGNvbXBv
bmVudF9hZGQoJnBkZXYtPmRldiwgJmRzaV9jb21wb25lbnRfb3BzKTsKIAlpZiAocikKLQkJZ290
byBlcnJfdW5pbml0X291dHB1dDsKKwkJZ290byBlcnJfb2ZfZGVwb3B1bGF0ZTsKIAogCXJldHVy
biAwOwogCitlcnJfb2ZfZGVwb3B1bGF0ZToKKwlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7
CiBlcnJfdW5pbml0X291dHB1dDoKIAlkc2lfdW5pbml0X291dHB1dChkc2kpOwogZXJyX3BtX2Rp
c2FibGU6Ci0tIAoyLjE5LjEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
