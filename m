From: =?UTF-8?q?V=C3=ADctor=20Manuel=20J=C3=A1quez=20Leal?=
	<vjaquez@igalia.com>
Subject: [PATCH v2] omap: dmtimer: convert printk to pr_err / WARN
Date: Thu,  6 Oct 2011 19:30:02 +0200
Message-ID: <1317922204-12512-1-git-send-email-vjaquez@igalia.com>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Joe Perches <joe@perches.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-omap@vger.kernel.org

Q29udmVydCBhIHByaW50ayhLRVJOX0VSUikgbWVzc2FnZSBpbiB0aGUgZHJpdmVyIHRvIHByX2Vy
cigpLCBhbmQKdXNlIFdBUk4oKSBpbnN0ZWFkIG9mIGEgY3VzdG9tIGxvZyBtZXNzYWdlIHdpdGgg
YSBzdGFjayBkdW1wLgoKU2lnbmVkLW9mZi1ieTogVsOtY3RvciBNYW51ZWwgSsOhcXVleiBMZWFs
IDx2amFxdWV6QGlnYWxpYS5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1vbWFwL2RtdGltZXIuYyB8
ICAgIDYgKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jIGIvYXJjaC9h
cm0vcGxhdC1vbWFwL2RtdGltZXIuYwppbmRleCBlZTlmNmViLi5kZWFkMGYzIDEwMDY0NAotLS0g
YS9hcmNoL2FybS9wbGF0LW9tYXAvZG10aW1lci5jCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9k
bXRpbWVyLmMKQEAgLTMyMiw3ICszMjIsNyBAQCBzdGF0aWMgdm9pZCBvbWFwX2RtX3RpbWVyX3dh
aXRfZm9yX3Jlc2V0KHN0cnVjdCBvbWFwX2RtX3RpbWVyICp0aW1lcikKIAl3aGlsZSAoIShvbWFw
X2RtX3RpbWVyX3JlYWRfcmVnKHRpbWVyLCBPTUFQX1RJTUVSX1NZU19TVEFUX1JFRykgJiAxKSkg
ewogCQljKys7CiAJCWlmIChjID4gMTAwMDAwKSB7Ci0JCQlwcmludGsoS0VSTl9FUlIgIlRpbWVy
IGZhaWxlZCB0byByZXNldFxuIik7CisJCQlwcl9lcnIoIlRpbWVyIGZhaWxlZCB0byByZXNldFxu
Iik7CiAJCQlyZXR1cm47CiAJCX0KIAl9CkBAIC0zOTcsOSArMzk3LDcgQEAgc3RydWN0IG9tYXBf
ZG1fdGltZXIgKm9tYXBfZG1fdGltZXJfcmVxdWVzdF9zcGVjaWZpYyhpbnQgaWQpCiAJc3Bpbl9s
b2NrX2lycXNhdmUoJmRtX3RpbWVyX2xvY2ssIGZsYWdzKTsKIAlpZiAoaWQgPD0gMCB8fCBpZCA+
IGRtX3RpbWVyX2NvdW50IHx8IGRtX3RpbWVyc1tpZC0xXS5yZXNlcnZlZCkgewogCQlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkbV90aW1lcl9sb2NrLCBmbGFncyk7Ci0JCXByaW50aygiQlVHOiB3
YXJuaW5nIGF0ICVzOiVkLyVzKCk6IHVuYWJsZSB0byBnZXQgdGltZXIgJWRcbiIsCi0JCSAgICAg
ICBfX0ZJTEVfXywgX19MSU5FX18sIF9fZnVuY19fLCBpZCk7Ci0JCWR1bXBfc3RhY2soKTsKKwkJ
V0FSTigxLCAidW5hYmxlIHRvIGdldCB0aW1lciAlZFxuIiwgaWQpOwogCQlyZXR1cm4gTlVMTDsK
IAl9CiAKLS0gCjEuNy42LjMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
