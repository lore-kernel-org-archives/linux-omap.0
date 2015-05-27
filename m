From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 6/7] drm/tilcdc: Force building of DRM_TILCDC_SLAVE_COMPAT
Date: Wed, 27 May 2015 12:23:00 +0300
Message-ID: <463a4ab497c1747e33a100e11274717ab71927d5.1432718049.git.jsarha@ti.com>
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

SWYgSSByZWFkIERvY3VtZW50YXRpb24va2J1aWxkL21ha2VmaWxlcy50eHQgc2VjdGlvbiAzLjYg
cmlnaHQsIHRoaXMKcGF0Y2ggc2hvdWxkIG5vdCBiZSBuZWVkZWQuIEhvd2V2ZXIsIHdpdGhvdXQg
dGhpcyBwYXRjaCB0aGUgb2JqZWN0cwpuZWVkZWQgZm9yIERSTV9USUxDRENfU0xBVkVfQ09NUEFU
IGFyZSBub3QgbGlua2VkLCBpZiBEUk1fVElMQ0RDIGlzCmJ1aWx0IGFzIG1vZHVsZS4KClNpZ25l
ZC1vZmYtYnk6IEp5cmkgU2FyaGEgPGpzYXJoYUB0aS5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L01ha2VmaWxlIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL01ha2VmaWxlIGIvZHJpdmVycy9n
cHUvZHJtL01ha2VmaWxlCmluZGV4IDdkNDk0NGUuLjYwODFmYTYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9NYWtlZmlsZQorKysgYi9kcml2ZXJzL2dwdS9kcm0vTWFrZWZpbGUKQEAgLTYw
LDcgKzYwLDcgQEAgb2JqLSQoQ09ORklHX0RSTV9BVE1FTF9ITENEQykJKz0gYXRtZWwtaGxjZGMv
CiBvYmotJChDT05GSUdfRFJNX1JDQVJfRFUpICs9IHJjYXItZHUvCiBvYmotJChDT05GSUdfRFJN
X1NITU9CSUxFKSArPXNobW9iaWxlLwogb2JqLSQoQ09ORklHX0RSTV9PTUFQKQkrPSBvbWFwZHJt
Lwotb2JqLSQoQ09ORklHX0RSTV9USUxDREMpCSs9IHRpbGNkYy8KK29iai15CQkJKz0gdGlsY2Rj
Lwogb2JqLSQoQ09ORklHX0RSTV9RWEwpICs9IHF4bC8KIG9iai0kKENPTkZJR19EUk1fQk9DSFMp
ICs9IGJvY2hzLwogb2JqLSQoQ09ORklHX0RSTV9NU00pICs9IG1zbS8KLS0gCjEuOS4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
