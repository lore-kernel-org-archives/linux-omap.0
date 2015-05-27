From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 1/7] drm/tilcdc: Fix module unloading
Date: Wed, 27 May 2015 12:22:55 +0300
Message-ID: <11f5aeadc96d41a8d40d096d044cc57884ca499c.1432718049.git.jsarha@ti.com>
References: <cover.1432718049.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1432718049.git.jsarha@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: rmk+kernel@arm.linux.org.uk, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Rm9yY2UgY3J0YyBkcG1zIG9mZiBiZWZvcmUgZGVzdHJveWluZyB0aGUgY3J0YyBpbnN0ZWFkIG9m
IGp1c3QKY2hlY2tpbmcgdGhlIGRwbXMgc3RhdGUuIFRoaXMgZml4ZXMgd2FybmluZyBtZXNzYWdl
IGFuZCBmcm96ZW4gcGljdHVyZQphZnRlciB0aWxjZGMgbW9kdWxlIHVubG9hZGluZy4KClNpZ25l
ZC1vZmYtYnk6IEp5cmkgU2FyaGEgPGpzYXJoYUB0aS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L3RpbGNkYy90aWxjZGNfY3J0Yy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdGlsY2Rj
L3RpbGNkY19jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19jcnRjLmMKaW5k
ZXggYzczNTg4NC4uYzJkNTk4MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90
aWxjZGNfY3J0Yy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90aWxjZGMvdGlsY2RjX2NydGMuYwpA
QCAtMTM1LDExICsxMzUsMTIgQEAgc3RhdGljIHZvaWQgc3RvcChzdHJ1Y3QgZHJtX2NydGMgKmNy
dGMpCiAJdGlsY2RjX2NsZWFyKGRldiwgTENEQ19SQVNURVJfQ1RSTF9SRUcsIExDRENfUkFTVEVS
X0VOQUJMRSk7CiB9CiAKK3N0YXRpYyB2b2lkIHRpbGNkY19jcnRjX2RwbXMoc3RydWN0IGRybV9j
cnRjICpjcnRjLCBpbnQgbW9kZSk7CiBzdGF0aWMgdm9pZCB0aWxjZGNfY3J0Y19kZXN0cm95KHN0
cnVjdCBkcm1fY3J0YyAqY3J0YykKIHsKIAlzdHJ1Y3QgdGlsY2RjX2NydGMgKnRpbGNkY19jcnRj
ID0gdG9fdGlsY2RjX2NydGMoY3J0Yyk7CiAKLQlXQVJOX09OKHRpbGNkY19jcnRjLT5kcG1zID09
IERSTV9NT0RFX0RQTVNfT04pOworCXRpbGNkY19jcnRjX2RwbXMoY3J0YywgRFJNX01PREVfRFBN
U19PRkYpOwogCiAJZHJtX2NydGNfY2xlYW51cChjcnRjKTsKIAlkcm1fZmxpcF93b3JrX2NsZWFu
dXAoJnRpbGNkY19jcnRjLT51bnJlZl93b3JrKTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
