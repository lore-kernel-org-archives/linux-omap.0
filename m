From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 15/19] omap2: omapfb: allow building it with COMPILE_TEST
Date: Thu,  5 Apr 2018 16:29:42 -0400
Message-ID: <f0947227675df4a774949500b6ee4cac1485b494.1522959716.git.mchehab@s-opensource.com>
References: <cover.1522959716.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1522959716.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522959716.git.mchehab@s-opensource.com>
References: <cover.1522959716.git.mchehab@s-opensource.com>
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

VGhpcyBkcml2ZXIgYnVpbGRzIGNsZWFubHkgd2l0aCBDT01QSUxFX1RFU1QsIGFuZCBpdCBpcwpu
ZWVkZWQgaW4gb3JkZXIgdG8gYWxsb3cgYnVpbGRpbmcgZHJpdmVycy9tZWRpYSBvbWFwMgpkcml2
ZXIuCgpTbywgY2hhbmdlIHRoZSBsb2dpYyB0aGVyZSB0byBhbGxvdyBidWlsZGluZyBpdC4KClNp
Z25lZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBzLW9wZW5zb3VyY2Uu
Y29tPgotLS0KIGRyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvS2NvbmZpZyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21h
cDIvS2NvbmZpZwppbmRleCAwOTIxYzRkZTg0MDcuLjgyMDA4Njk5ZDI1MyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9LY29uZmlnCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJk
ZXYvb21hcDIvS2NvbmZpZwpAQCAtMSw0ICsxLDQgQEAKLWlmIEFSQ0hfT01BUDJQTFVTCitpZiBB
UkNIX09NQVAyUExVUyB8fCBDT01QSUxFX1RFU1QKIAogc291cmNlICJkcml2ZXJzL3ZpZGVvL2Zi
ZGV2L29tYXAyL29tYXBmYi9LY29uZmlnIgogCi0tIAoyLjE0LjMKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
