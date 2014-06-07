From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 5/9] drm/tilcdc: panel: fix leak when unloading the module
Date: Sat,  7 Jun 2014 00:02:04 -0300
Message-ID: <1402110128-30471-6-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

VGhlIGRyaXZlciBkaWQgbm90IHVucmVnaXN0ZXIgdGhlIGFsbG9jYXRlZCBmcmFtZWJ1ZmZlciwg
d2hpY2ggY2F1c2VkCm1lbW9yeSBsZWFrcyAoYW5kIG1lbW9yeSBtYW5hZ2VyIFdBUk5zKSB3aGVu
IHVubG9hZGluZy4gQWxzbywgdGhlCmZyYW1lYnVmZmVyIGRldmljZSB1bmRlciAvZGV2IHN0aWxs
IGV4aXN0ZWQgYWZ0ZXIgdW5sb2FkaW5nLgoKQWRkIGEgY2FsbCB0byBkcm1fZmJkZXZfY21hX2Zp
bmkgd2hlbiB1bmxvYWRpbmcgdGhlIG1vZHVsZSB0byBwcmV2ZW50CmJvdGggaXNzdWVzLgoKU2ln
bmVkLW9mZi1ieTogR3VpZG8gTWFydMOtbmV6IDxndWlkb0B2YW5ndWFyZGlhc3VyLmNvbS5hcj4K
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3Rp
bGNkY19kcnYuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfZHJ2LmMgYi9kcml2ZXJzL2dwdS9k
cm0vdGlsY2RjL3RpbGNkY19kcnYuYwppbmRleCAxNzFhODIwLi5kZTM0NjU3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vdGlsY2RjL3RpbGNkY19kcnYuYwpAQCAtMTIyLDYgKzEyMiw3IEBAIHN0YXRpYyBpbnQgdGls
Y2RjX3VubG9hZChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2KQogCXN0cnVjdCB0aWxjZGNfZHJtX3By
aXZhdGUgKnByaXYgPSBkZXYtPmRldl9wcml2YXRlOwogCXN0cnVjdCB0aWxjZGNfbW9kdWxlICpt
b2QsICpjdXI7CiAKKwlkcm1fZmJkZXZfY21hX2ZpbmkocHJpdi0+ZmJkZXYpOwogCWRybV9rbXNf
aGVscGVyX3BvbGxfZmluaShkZXYpOwogCWRybV9tb2RlX2NvbmZpZ19jbGVhbnVwKGRldik7CiAJ
ZHJtX3ZibGFua19jbGVhbnVwKGRldik7Ci0tIAoyLjAuMC5yYzIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
