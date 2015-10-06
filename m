From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] memory: omap-gpmc: dump "before" state before first
 modification
Date: Tue,  6 Oct 2015 22:07:49 +0200
Message-ID: <1444162070-22034-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

V2hlbiBncG1jX2NzX3Nob3dfdGltaW5ncyBpcyBjYWxsZWQgaW4gZ3BtY19jc19zZXRfdGltaW5n
cygpCmdwbWNfY3NfcHJvZ3JhbV9zZXR0aW5ncygpIHdhcyBhbHJlYWR5IHJ1biB3aGljaCBtb2Rp
ZmllcyB0aGUgQ09ORklHMQpyZWdpc3Rlci4gU28gdG8gYmUgbW9yZSB1c2VmdWwgZG8gdGhlICJi
ZWZvcmUiIGR1bXAgZWFybGllci4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy9tZW1vcnkvb21hcC1n
cG1jLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lbW9yeS9vbWFwLWdwbWMuYyBiL2RyaXZlcnMvbWVt
b3J5L29tYXAtZ3BtYy5jCmluZGV4IDMyYWMwNDlmMmJjNC4uNjUxNWRmYzJiODA1IDEwMDY0NAot
LS0gYS9kcml2ZXJzL21lbW9yeS9vbWFwLWdwbWMuYworKysgYi9kcml2ZXJzL21lbW9yeS9vbWFw
LWdwbWMuYwpAQCAtNjk2LDcgKzY5Niw2IEBAIGludCBncG1jX2NzX3NldF90aW1pbmdzKGludCBj
cywgY29uc3Qgc3RydWN0IGdwbWNfdGltaW5ncyAqdCwKIAlpbnQgZGl2OwogCXUzMiBsOwogCi0J
Z3BtY19jc19zaG93X3RpbWluZ3MoY3MsICJiZWZvcmUgZ3BtY19jc19zZXRfdGltaW5ncyIpOwog
CWRpdiA9IGdwbWNfY2FsY19kaXZpZGVyKHQtPnN5bmNfY2xrKTsKIAlpZiAoZGl2IDwgMCkKIAkJ
cmV0dXJuIGRpdjsKQEAgLTE5ODgsNiArMTk4Nyw3IEBAIHN0YXRpYyBpbnQgZ3BtY19wcm9iZV9n
ZW5lcmljX2NoaWxkKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCiAJaWYgKHJldCA8IDAp
CiAJCWdvdG8gZXJyOwogCisJZ3BtY19jc19zaG93X3RpbWluZ3MoY3MsICJiZWZvcmUgZ3BtY19j
c19wcm9ncmFtX3NldHRpbmdzIik7CiAJcmV0ID0gZ3BtY19jc19wcm9ncmFtX3NldHRpbmdzKGNz
LCAmZ3BtY19zKTsKIAlpZiAocmV0IDwgMCkKIAkJZ290byBlcnI7Ci0tIAoyLjYuMAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
