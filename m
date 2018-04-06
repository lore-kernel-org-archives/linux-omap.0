From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 2/2] media: omapfb: relax compilation if COMPILE_TEST
Date: Fri,  6 Apr 2018 11:33:20 -0400
Message-ID: <c318fd1c9f79995c6c2e4e82ca99ff494b2afb7b.1523028795.git.mchehab@s-opensource.com>
References: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
In-Reply-To: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
References: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

VGhlIGRlcGVuZGVuY3kgb2YgRFJNX09NQVAgPSBuIGNhbiBiZSByZWxheGVkIGZvciBqdXN0CmNv
bXBpbGF0aW9uIHRlc3QuCgpUaGlzIGFsbG93cyBidWlsZGluZyB0aGUgb21hcDNpc3AgZHJpdmVy
IHdpdGggYWxseWVzY29uZmlnCm9uIEFSTS4KClNpZ25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhv
IENoZWhhYiA8bWNoZWhhYkBzLW9wZW5zb3VyY2UuY29tPgotLS0KIGRyaXZlcnMvdmlkZW8vZmJk
ZXYvb21hcDIvb21hcGZiL0tjb25maWcgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L29t
YXAyL29tYXBmYi9LY29uZmlnIGIvZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvS2Nv
bmZpZwppbmRleCBlNjIyNmFlZWQxN2UuLmU0Mjc5NGE1ZTI2YyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy92aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvS2NvbmZpZworKysgYi9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L29tYXAyL29tYXBmYi9LY29uZmlnCkBAIC00LDcgKzQsNyBAQCBjb25maWcgT01BUDJfVlJG
QgogbWVudWNvbmZpZyBGQl9PTUFQMgogICAgICAgICB0cmlzdGF0ZSAiT01BUDIrIGZyYW1lIGJ1
ZmZlciBzdXBwb3J0IgogICAgICAgICBkZXBlbmRzIG9uIEZCCi0gICAgICAgIGRlcGVuZHMgb24g
RFJNX09NQVAgPSBuCisgICAgICAgIGRlcGVuZHMgb24gRFJNX09NQVAgPSBuIHx8IENPTVBJTEVf
VEVTVAogCiAgICAgICAgIHNlbGVjdCBGQl9PTUFQMl9EU1MKIAlzZWxlY3QgT01BUDJfVlJGQiBp
ZiBBUkNIX09NQVAyIHx8IEFSQ0hfT01BUDMKLS0gCjIuMTQuMwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
