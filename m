From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 9/9] drm/tilcdc: replace late_initcall with module_init
Date: Sat,  7 Jun 2014 00:02:08 -0300
Message-ID: <1402110128-30471-10-git-send-email-guido@vanguardiasur.com.ar>
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
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

VXNlIG1vZHVsZV9pbml0IGluc3RlYWQgb2YgbGF0ZV9pbml0Y2FsbCwgYXMgaXMgdGhlIG5vcm0g
Zm9yIG1vZHVsYXIKZHJpdmVycy4KCm1vZHVsZV9pbml0IHdhcyB1c2VkIHVudGlsIDZlOGRlMGJk
NmE1MWZkZWViZDVkOTc1YzRmY2M0MjZmNzMwYjMzOWIKKCJkcm0vdGlsY2RjOiBhZGQgZW5jb2Rl
ciBzbGF2ZSAodjIpIikgY2hhbmdlZCBpdCB0byBhIGxhdGVfaW5pdGNhbGwsCmJ1dCBpdCBkb2Vz
IG5vdCBleHBsYWluIHdoeS4gVGVzdHMgc2hvdyBpdCdzIHdvcmtpbmcgcHJvcGVybHkgd2l0aApt
b2R1bGVfaW5pdC4KClNpZ25lZC1vZmYtYnk6IEd1aWRvIE1hcnTDrW5leiA8Z3VpZG9AdmFuZ3Vh
cmRpYXN1ci5jb20uYXI+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3RpbGNkYy90aWxjZGNfZHJ2LmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdGlsY2RjL3RpbGNkY19kcnYuYyBiL2RyaXZlcnMv
Z3B1L2RybS90aWxjZGMvdGlsY2RjX2Rydi5jCmluZGV4IDcwMjMxNWYuLjgwZTY2OTcgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90aWxjZGMvdGlsY2RjX2Rydi5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS90aWxjZGMvdGlsY2RjX2Rydi5jCkBAIC02MjksNyArNjI5LDcgQEAgc3RhdGljIHZv
aWQgX19leGl0IHRpbGNkY19kcm1fZmluaSh2b2lkKQogCXRpbGNkY190ZnA0MTBfZmluaSgpOwog
fQogCi1sYXRlX2luaXRjYWxsKHRpbGNkY19kcm1faW5pdCk7Cittb2R1bGVfaW5pdCh0aWxjZGNf
ZHJtX2luaXQpOwogbW9kdWxlX2V4aXQodGlsY2RjX2RybV9maW5pKTsKIAogTU9EVUxFX0FVVEhP
UigiUm9iIENsYXJrIDxyb2JkY2xhcmtAZ21haWwuY29tIik7Ci0tIAoyLjAuMC5yYzIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
