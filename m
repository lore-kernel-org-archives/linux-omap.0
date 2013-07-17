From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 7/9] ARM: dts: omap5-uevm: update LDO6 voltage to 1.2V
Date: Wed, 17 Jul 2013 11:45:36 -0500
Message-ID: <1374079538-19548-8-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, J Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Y29tbWl0IGUwMGMyN2VmM2I0YzIzZTM5ZDBhNzdiN2M4ZTViZTQ0YzI4MDAxYzcKKEFSTTogZHRz
OiBPTUFQNTogQWRkIFBhbG1hcyBNRkQgbm9kZSBhbmQgcmVndWxhdG9yIG5vZGVzKQppbnRyb2R1
Y2VkIHJlZ3VsYXRvciBlbnRyaWVzIGZvciBPTUFQNXVFVk0uCgpIb3dldmVyLCBUaGUgcmVndWxh
dG9yIGluZm9ybWF0aW9uIGlzIGJhc2VkIG9uIGFuIG9sZGVyIHRlbXBvcmFyeQpwcmUtcHJvZHVj
dGlvbiBib2FyZCB2YXJpYW50IGFuZCBkb2VzIG5vdCByZWZsZWN0IHByb2R1Y3Rpb24gYm9hcmQK
NzUwLTI2MjgtWFhYIGJvYXJkcy4KCkxETzYgc3VwcGxpZXMgdGhlIGJvYXJkIHNwZWNpZmllZCBW
RERTXzFWMl9XS1VQIHN1cHBseSBnb2luZyB0bwpsZG9fZW11X3drdXAvdmRkc19oc2ljLiBUbyBz
dGF5IHdpdGhpbiB0aGUgU29DIHNwZWNpZmljYXRpb24gc3VwcGx5CjEuMlYgaW5zdGVhZCBvZiAx
LjVWLgoKUmVwb3J0ZWQtYnk6IE1hcmMgSsO8dHRuZXIgPG0tanVldHRuZXJAdGkuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPgotLS0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL29tYXA1LXVldm0uZHRzIHwgICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL29t
YXA1LXVldm0uZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUtdWV2bS5kdHMKaW5kZXggMTU1
MGQ2YS4uM2ZmNTg3NCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUtdWV2bS5k
dHMKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDUtdWV2bS5kdHMKQEAgLTM4OCw4ICszODgs
OCBAQAogCQkJCWxkbzZfcmVnOiBsZG82IHsKIAkJCQkJLyogVkREU18xVjJfV0tVUDogaHNpYy9s
ZG9fZW11X3drdXAgKi8KIAkJCQkJcmVndWxhdG9yLW5hbWUgPSAibGRvNiI7Ci0JCQkJCXJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDE1MDAwMDA+OwotCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwxNTAwMDAwPjsKKwkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTIwMDAw
MD47CisJCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDEyMDAwMDA+OwogCQkJCQlyZWd1
bGF0b3ItYWx3YXlzLW9uOwogCQkJCQlyZWd1bGF0b3ItYm9vdC1vbjsKIAkJCQl9OwotLSAKMS43
LjkuNQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
