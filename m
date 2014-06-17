From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH/RESEND 6/9] drm/tilcdc: fix release order on exit
Date: Tue, 17 Jun 2014 11:17:08 -0300
Message-ID: <1403014631-18072-7-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

VW5yZWdpc3RlciByZXNvdXJjZXMgaW4gdGhlIGNvcnJlY3Qgb3JkZXIgb24gdGlsY2RjX2RybV9m
aW5pLCB3aGljaCBpcwp0aGUgcmV2ZXJzZSBvcmRlciB0aGV5IHdlcmUgcmVnaXN0ZXJlZCBkdXJp
bmcgdGlsY2RjX2RybV9pbml0LgoKVGhpcyBhbHNvIG1lYW5zIHVucmVnaXN0ZXJpbmcgdGhlIGRy
aXZlciBiZWZvcmUgcmVsZWFzaW5nIGl0cyByZXNvdXJjZXMuCgpTaWduZWQtb2ZmLWJ5OiBHdWlk
byBNYXJ0w61uZXogPGd1aWRvQHZhbmd1YXJkaWFzdXIuY29tLmFyPgpDYzogPHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc+ICN2My45KwotLS0KIGRyaXZlcnMvZ3B1L2RybS90aWxjZGMvdGlsY2RjX2Ry
di5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYwppbmRleCA0OTBhZWU3Li4wMDZh
MzBlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYwpAQCAtNjI5LDEwICs2MjksMTAg
QEAgc3RhdGljIGludCBfX2luaXQgdGlsY2RjX2RybV9pbml0KHZvaWQpCiBzdGF0aWMgdm9pZCBf
X2V4aXQgdGlsY2RjX2RybV9maW5pKHZvaWQpCiB7CiAJREJHKCJmaW5pIik7Ci0JdGlsY2RjX3Rm
cDQxMF9maW5pKCk7Ci0JdGlsY2RjX3NsYXZlX2ZpbmkoKTsKLQl0aWxjZGNfcGFuZWxfZmluaSgp
OwogCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZ0aWxjZGNfcGxhdGZvcm1fZHJpdmVyKTsK
Kwl0aWxjZGNfcGFuZWxfZmluaSgpOworCXRpbGNkY19zbGF2ZV9maW5pKCk7CisJdGlsY2RjX3Rm
cDQxMF9maW5pKCk7CiB9CiAKIGxhdGVfaW5pdGNhbGwodGlsY2RjX2RybV9pbml0KTsKLS0gCjIu
MC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmkt
ZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
