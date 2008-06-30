From: "Arun KS" <getarunks@gmail.com>
Subject: [Resend][PATCH 1/3] OMAP2EVM: Adding ethernet support
Date: Mon, 30 Jun 2008 20:39:25 +0530
Message-ID: <dfeb90390806300809w5df7dd14pb299b5dede1319a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13023_20252553.1214838565486"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:36398 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYF3PJ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 11:09:29 -0400
Received: by ti-out-0910.google.com with SMTP id b6so799847tic.23
        for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 08:09:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_13023_20252553.1214838565486
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

OMAP2EVM: Add ethernet support (smc911x)

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c       |   41 ++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-omap2evm.h |    5 ++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index d00e502..bcdf4a6 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -27,11 +27,47 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>

+static struct resource omap2evm_smc911x_resources[] = {
+	[0] =   {
+		.start  = OMAP2EVM_ETHR_START,
+		.end    = (OMAP2EVM_ETHR_START + OMAP2EVM_ETHR_SIZE - 1),
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] =   {
+		.start  = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+		.end    = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device omap2evm_smc911x_device = {
+	.name       = "smc911x",
+	.id     = -1,
+	.num_resources  = ARRAY_SIZE(omap2evm_smc911x_resources),
+	.resource   = &omap2evm_smc911x_resources [0],
+};
+
+static inline void __init omap2evm_init_smc911x(void)
+{
+	int gpio = OMAP2EVM_ETHR_GPIO_IRQ;
+	int ret;
+
+	ret = gpio_request(gpio, "smc911x IRQ");
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to request GPIO %d for smc911x IRQ\n",
+				gpio);
+		return;
+	}
+	gpio_direction_input(gpio);
+
+}
+
 static void __init omap2_evm_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
+	omap2evm_init_smc911x();
 }

 static struct omap_uart_config omap2_evm_uart_config __initdata = {
@@ -53,8 +89,13 @@ static int __init omap2_evm_i2c_init(void)
 	return 0;
 }

+static struct platform_device *omap2_evm_devices[] __initdata = {
+    &omap2evm_smc911x_device,
+};
+
 static void __init omap2_evm_init(void)
 {
+	platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
 	omap_board_config = omap2_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
 	omap_serial_init();
diff --git a/include/asm-arm/arch-omap/board-omap2evm.h
b/include/asm-arm/arch-omap/board-omap2evm.h
index 98273a9..d770c58 100644
--- a/include/asm-arm/arch-omap/board-omap2evm.h
+++ b/include/asm-arm/arch-omap/board-omap2evm.h
@@ -30,7 +30,8 @@
 #define __ASM_ARCH_OMAP2_EVM_H

 /* Placeholder for OMAP2EVM specific defines */
-#define OMAP24XX_ETHR_START		0x08000300
-#define OMAP24XX_ETHR_GPIO_IRQ		149
+#define OMAP2EVM_ETHR_START			0x2c000000
+#define OMAP2EVM_ETHR_SIZE			1024
+#define OMAP2EVM_ETHR_GPIO_IRQ		149

 #endif /* __ASM_ARCH_OMAP2_EVM_H */
-- 
1.5.3.4

------=_Part_13023_20252553.1214838565486
Content-Type: text/x-patch;
 name=0001-OMAP2EVM-Adding-ethernet-support.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fi37spig0
Content-Disposition: attachment;
 filename=0001-OMAP2EVM-Adding-ethernet-support.patch

RnJvbSA2Mzg0ZGJjMTVmMDNiZjY0N2E5MGEzZDc2NzM0YWFlYjU4MGNkNjQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IE1vbiwgMzAgSnVuIDIwMDggMTk6MjE6MzkgKzA1MzAKU3ViamVjdDogW1BBVENIXSBP
TUFQMkVWTTogQWRkaW5nIGV0aGVybmV0IHN1cHBvcnQKCk9NQVAyRVZNOiBBZGQgZXRoZXJuZXQg
c3VwcG9ydCAoc21jOTExeCkKClNpZ25lZC1vZmYtYnk6IEFydW4gS1MgPGFydW5rc0BtaXN0cmFs
c29sdXRpb25zLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMg
ICAgICAgfCAgIDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvYXNtLWFy
bS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaCB8ICAgIDUgKystCiAyIGZpbGVzIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1vbWFwMmV2bS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1v
bWFwMmV2bS5jCmluZGV4IGQwMGU1MDIuLmJjZGY0YTYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvYm9hcmQtb21hcDJldm0uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJk
LW9tYXAyZXZtLmMKQEAgLTI3LDExICsyNyw0NyBAQAogI2luY2x1ZGUgPGFzbS9hcmNoL2JvYXJk
Lmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gvY29tbW9uLmg+CiAKK3N0YXRpYyBzdHJ1Y3QgcmVzb3Vy
Y2Ugb21hcDJldm1fc21jOTExeF9yZXNvdXJjZXNbXSA9IHsKKwlbMF0gPSAgIHsKKwkJLnN0YXJ0
ICA9IE9NQVAyRVZNX0VUSFJfU1RBUlQsCisJCS5lbmQgICAgPSAoT01BUDJFVk1fRVRIUl9TVEFS
VCArIE9NQVAyRVZNX0VUSFJfU0laRSAtIDEpLAorCQkuZmxhZ3MgID0gSU9SRVNPVVJDRV9NRU0s
CisJfSwKKwlbMV0gPSAgIHsKKwkJLnN0YXJ0ICA9IE9NQVBfR1BJT19JUlEoT01BUDJFVk1fRVRI
Ul9HUElPX0lSUSksCisJCS5lbmQgICAgPSBPTUFQX0dQSU9fSVJRKE9NQVAyRVZNX0VUSFJfR1BJ
T19JUlEpLAorCQkuZmxhZ3MgID0gSU9SRVNPVVJDRV9JUlEsCisJfSwKK307CisKK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG9tYXAyZXZtX3NtYzkxMXhfZGV2aWNlID0geworCS5uYW1l
ICAgICAgID0gInNtYzkxMXgiLAorCS5pZCAgICAgPSAtMSwKKwkubnVtX3Jlc291cmNlcyAgPSBB
UlJBWV9TSVpFKG9tYXAyZXZtX3NtYzkxMXhfcmVzb3VyY2VzKSwKKwkucmVzb3VyY2UgICA9ICZv
bWFwMmV2bV9zbWM5MTF4X3Jlc291cmNlcyBbMF0sCit9OworCitzdGF0aWMgaW5saW5lIHZvaWQg
X19pbml0IG9tYXAyZXZtX2luaXRfc21jOTExeCh2b2lkKQoreworCWludCBncGlvID0gT01BUDJF
Vk1fRVRIUl9HUElPX0lSUTsKKwlpbnQgcmV0OworCisJcmV0ID0gZ3Bpb19yZXF1ZXN0KGdwaW8s
ICJzbWM5MTF4IElSUSIpOworCWlmIChyZXQgPCAwKSB7CisJCXByaW50ayhLRVJOX0VSUiAiRmFp
bGVkIHRvIHJlcXVlc3QgR1BJTyAlZCBmb3Igc21jOTExeCBJUlFcbiIsCisJCQkJZ3Bpbyk7CisJ
CXJldHVybjsKKwl9CisJZ3Bpb19kaXJlY3Rpb25faW5wdXQoZ3Bpbyk7CisKK30KKwogc3RhdGlj
IHZvaWQgX19pbml0IG9tYXAyX2V2bV9pbml0X2lycSh2b2lkKQogewogCW9tYXAyX2luaXRfY29t
bW9uX2h3KCk7CiAJb21hcF9pbml0X2lycSgpOwogCW9tYXBfZ3Bpb19pbml0KCk7CisJb21hcDJl
dm1faW5pdF9zbWM5MTF4KCk7CiB9CiAKIHN0YXRpYyBzdHJ1Y3Qgb21hcF91YXJ0X2NvbmZpZyBv
bWFwMl9ldm1fdWFydF9jb25maWcgX19pbml0ZGF0YSA9IHsKQEAgLTUzLDggKzg5LDEzIEBAIHN0
YXRpYyBpbnQgX19pbml0IG9tYXAyX2V2bV9pMmNfaW5pdCh2b2lkKQogCXJldHVybiAwOwogfQog
CitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb21hcDJfZXZtX2RldmljZXNbXSBfX2lu
aXRkYXRhID0geworICAgICZvbWFwMmV2bV9zbWM5MTF4X2RldmljZSwKK307CisKIHN0YXRpYyB2
b2lkIF9faW5pdCBvbWFwMl9ldm1faW5pdCh2b2lkKQogeworCXBsYXRmb3JtX2FkZF9kZXZpY2Vz
KG9tYXAyX2V2bV9kZXZpY2VzLCBBUlJBWV9TSVpFKG9tYXAyX2V2bV9kZXZpY2VzKSk7CiAJb21h
cF9ib2FyZF9jb25maWcgPSBvbWFwMl9ldm1fY29uZmlnOwogCW9tYXBfYm9hcmRfY29uZmlnX3Np
emUgPSBBUlJBWV9TSVpFKG9tYXAyX2V2bV9jb25maWcpOwogCW9tYXBfc2VyaWFsX2luaXQoKTsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaCBi
L2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaAppbmRleCA5ODI3M2E5
Li5kNzcwYzU4IDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLW9t
YXAyZXZtLmgKKysrIGIvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5o
CkBAIC0zMCw3ICszMCw4IEBACiAjZGVmaW5lIF9fQVNNX0FSQ0hfT01BUDJfRVZNX0gKIAogLyog
UGxhY2Vob2xkZXIgZm9yIE9NQVAyRVZNIHNwZWNpZmljIGRlZmluZXMgKi8KLSNkZWZpbmUgT01B
UDI0WFhfRVRIUl9TVEFSVAkJMHgwODAwMDMwMAotI2RlZmluZSBPTUFQMjRYWF9FVEhSX0dQSU9f
SVJRCQkxNDkKKyNkZWZpbmUgT01BUDJFVk1fRVRIUl9TVEFSVAkJCTB4MmMwMDAwMDAKKyNkZWZp
bmUgT01BUDJFVk1fRVRIUl9TSVpFCQkJMTAyNAorI2RlZmluZSBPTUFQMkVWTV9FVEhSX0dQSU9f
SVJRCQkxNDkKIAogI2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUDJfRVZNX0ggKi8KLS0gCjEuNS4z
LjQKCg==
------=_Part_13023_20252553.1214838565486--
