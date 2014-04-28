From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 2/4] ARM: dts: am335x-evm: use phandles for USB and DMA refs
Date: Mon, 28 Apr 2014 10:58:30 -0300
Message-ID: <1398693512-5355-2-git-send-email-guido@vanguardiasur.com.ar>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>, bcousson@baylibre.com, tony@atomide.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

VXNlIHBoYW5kbGVzIGluc3RlYWQgb2YgdW5pdCBhZHJlc3NlcyB0byByZWZlcmVuY2UgdXNiIGFu
ZCBkbWEgbm9kZXMuClRoaXMgbWFrZXMgdGhlIERUIG1vcmUgcm9idXN0IGFuZCByZWFkYWJsZS4K
ClNpZ25lZC1vZmYtYnk6IEd1aWRvIE1hcnTDrW5leiA8Z3VpZG9AdmFuZ3VhcmRpYXN1ci5jb20u
YXI+Ci0tLQogYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5kdHMgfCAxMiArKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LWV2bS5kdHMgYi9hcmNoL2FybS9ib290
L2R0cy9hbTMzNXgtZXZtLmR0cwppbmRleCA2MDI4MjE3Li5lODAyNjI3IDEwMDY0NAotLS0gYS9h
cmNoL2FybS9ib290L2R0cy9hbTMzNXgtZXZtLmR0cworKysgYi9hcmNoL2FybS9ib290L2R0cy9h
bTMzNXgtZXZtLmR0cwpAQCAtMzMxLDI4ICszMzEsMjggQEAKICZ1c2IgewogCXN0YXR1cyA9ICJv
a2F5IjsKIAotCWNvbnRyb2xANDRlMTA2MjAgeworCSZ1c2JfY3RybF9tb2QgewogCQlzdGF0dXMg
PSAib2theSI7CiAJfTsKIAotCXVzYi1waHlANDc0MDEzMDAgeworCSZ1c2IwX3BoeSB7CiAJCXN0
YXR1cyA9ICJva2F5IjsKIAl9OwogCi0JdXNiLXBoeUA0NzQwMWIwMCB7CisJJnVzYjFfcGh5IHsK
IAkJc3RhdHVzID0gIm9rYXkiOwogCX07CiAKLQl1c2JANDc0MDEwMDAgeworCSZ1c2IwIHsKIAkJ
c3RhdHVzID0gIm9rYXkiOwogCX07CiAKLQl1c2JANDc0MDE4MDAgeworCSZ1c2IxIHsKIAkJc3Rh
dHVzID0gIm9rYXkiOwogCQlkcl9tb2RlID0gImhvc3QiOwogCX07CiAKLQlkbWEtY29udHJvbGxl
ckA0NzQwMjAwMCAgeworCSZjcHBpNDFkbWEgIHsKIAkJc3RhdHVzID0gIm9rYXkiOwogCX07CiB9
OwotLSAKMS45LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
