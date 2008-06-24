From: "Arun KS" <getarunks@gmail.com>
Subject: [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 17:34:59 +0530
Message-ID: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4732_13223486.1214309099879"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:13928 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbYFXMFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 08:05:01 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1309496tic.23
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 05:04:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_4732_13223486.1214309099879
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From 58efa8d0019a7f777aaad2d43afb05170df25fae Mon Sep 17 00:00:00 2001
From: Arun KS <arunks@mistralsolutions.com>
Date: Tue, 24 Jun 2008 16:01:32 +0530
Subject: [PATCH] OMAP2EVM:  Adding ethernet support

OMAP2EVM: add ethernet support (smc911x)

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c       |   37 ++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/board-omap2evm.h |    5 ++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index d00e502..e9a2cef 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -27,11 +27,43 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>

+static struct resource omap2evm_smc911x_resources[] = {
+   [0] =   {
+       .start  = OMAP2EVM_ETHR_START,
+       .end    = (OMAP2EVM_ETHR_START + OMAP2EVM_ETHR_SIZE - 1),
+       .flags  = IORESOURCE_MEM,
+   },
+   [1] =   {
+       .start  = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+       .end    = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+       .flags  = IORESOURCE_IRQ,
+   },
+};
+
+static struct platform_device omap2evm_smc911x_device = {
+   .name       = "smc911x",
+   .id     = -1,
+   .num_resources  = ARRAY_SIZE(omap2evm_smc911x_resources),
+   .resource   = &omap2evm_smc911x_resources [0],
+};
+
+static inline void __init omap2evm_init_smc911x(void)
+{
+    if (omap_request_gpio(OMAP2EVM_ETHR_GPIO_IRQ) < 0) {
+       printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
+       OMAP2EVM_ETHR_GPIO_IRQ);
+       return;
+    }
+
+    omap_set_gpio_direction(OMAP2EVM_ETHR_GPIO_IRQ, 1);
+}
+
 static void __init omap2_evm_init_irq(void)
 {
    omap2_init_common_hw();
    omap_init_irq();
    omap_gpio_init();
+   omap2evm_init_smc911x();
 }

 static struct omap_uart_config omap2_evm_uart_config __initdata = {
@@ -53,8 +85,13 @@ static int __init omap2_evm_i2c_init(void)
    return 0;
 }

+static struct platform_device *omap2_evm_devices[] __initdata = {
+    &omap2evm_smc911x_device,
+};
+
 static void __init omap2_evm_init(void)
 {
+   platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
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
-#define OMAP24XX_ETHR_START        0x08000300
-#define OMAP24XX_ETHR_GPIO_IRQ     149
+#define OMAP2EVM_ETHR_START            0x2c000000
+#define OMAP2EVM_ETHR_SIZE         1024
+#define OMAP2EVM_ETHR_GPIO_IRQ     149

 #endif /* __ASM_ARCH_OMAP2_EVM_H */
--
1.5.3.4

------=_Part_4732_13223486.1214309099879
Content-Type: text/x-patch;
 name=0001-OMAP2EVM-Adding-ethernet-support.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhugjoct0
Content-Disposition: attachment;
 filename=0001-OMAP2EVM-Adding-ethernet-support.patch

RnJvbSA1OGVmYThkMDAxOWE3Zjc3N2FhYWQyZDQzYWZiMDUxNzBkZjI1ZmFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMjQgSnVuIDIwMDggMTY6MDE6MzIgKzA1MzAKU3ViamVjdDogW1BBVENIXSBP
TUFQMkVWTToJQWRkaW5nIGV0aGVybmV0IHN1cHBvcnQKCk9NQVAyRVZNOiBhZGQgZXRoZXJuZXQg
c3VwcG9ydCAoc21jOTExeCkKClNpZ25lZC1vZmYtYnk6IEFydW4gS1MgPGFydW5rc0BtaXN0cmFs
c29sdXRpb25zLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMg
ICAgICAgfCAgIDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvYXNtLWFy
bS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaCB8ICAgIDUgKystCiAyIGZpbGVzIGNoYW5nZWQs
IDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1vbWFwMmV2bS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1v
bWFwMmV2bS5jCmluZGV4IGQwMGU1MDIuLmU5YTJjZWYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvYm9hcmQtb21hcDJldm0uYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJk
LW9tYXAyZXZtLmMKQEAgLTI3LDExICsyNyw0MyBAQAogI2luY2x1ZGUgPGFzbS9hcmNoL2JvYXJk
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
X19pbml0IG9tYXAyZXZtX2luaXRfc21jOTExeCh2b2lkKQoreworICAgIGlmIChvbWFwX3JlcXVl
c3RfZ3BpbyhPTUFQMkVWTV9FVEhSX0dQSU9fSVJRKSA8IDApIHsKKwkJcHJpbnRrKEtFUk5fRVJS
ICJGYWlsZWQgdG8gcmVxdWVzdCBHUElPJWQgZm9yIHNtYzkxMXggSVJRXG4iLAorCQlPTUFQMkVW
TV9FVEhSX0dQSU9fSVJRKTsKKwkJcmV0dXJuOworICAgIH0KKworICAgIG9tYXBfc2V0X2dwaW9f
ZGlyZWN0aW9uKE9NQVAyRVZNX0VUSFJfR1BJT19JUlEsIDEpOworfQorCiBzdGF0aWMgdm9pZCBf
X2luaXQgb21hcDJfZXZtX2luaXRfaXJxKHZvaWQpCiB7CiAJb21hcDJfaW5pdF9jb21tb25faHco
KTsKIAlvbWFwX2luaXRfaXJxKCk7CiAJb21hcF9ncGlvX2luaXQoKTsKKwlvbWFwMmV2bV9pbml0
X3NtYzkxMXgoKTsKIH0KIAogc3RhdGljIHN0cnVjdCBvbWFwX3VhcnRfY29uZmlnIG9tYXAyX2V2
bV91YXJ0X2NvbmZpZyBfX2luaXRkYXRhID0gewpAQCAtNTMsOCArODUsMTMgQEAgc3RhdGljIGlu
dCBfX2luaXQgb21hcDJfZXZtX2kyY19pbml0KHZvaWQpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpvbWFwMl9ldm1fZGV2aWNlc1tdIF9faW5pdGRhdGEg
PSB7CisgICAgJm9tYXAyZXZtX3NtYzkxMXhfZGV2aWNlLAorfTsKKwogc3RhdGljIHZvaWQgX19p
bml0IG9tYXAyX2V2bV9pbml0KHZvaWQpCiB7CisJcGxhdGZvcm1fYWRkX2RldmljZXMob21hcDJf
ZXZtX2RldmljZXMsIEFSUkFZX1NJWkUob21hcDJfZXZtX2RldmljZXMpKTsKIAlvbWFwX2JvYXJk
X2NvbmZpZyA9IG9tYXAyX2V2bV9jb25maWc7CiAJb21hcF9ib2FyZF9jb25maWdfc2l6ZSA9IEFS
UkFZX1NJWkUob21hcDJfZXZtX2NvbmZpZyk7CiAJb21hcF9zZXJpYWxfaW5pdCgpOwpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5oIGIvaW5jbHVk
ZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5oCmluZGV4IDk4MjczYTkuLmQ3NzBj
NTggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0u
aAorKysgYi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLW9tYXAyZXZtLmgKQEAgLTMw
LDcgKzMwLDggQEAKICNkZWZpbmUgX19BU01fQVJDSF9PTUFQMl9FVk1fSAogCiAvKiBQbGFjZWhv
bGRlciBmb3IgT01BUDJFVk0gc3BlY2lmaWMgZGVmaW5lcyAqLwotI2RlZmluZSBPTUFQMjRYWF9F
VEhSX1NUQVJUCQkweDA4MDAwMzAwCi0jZGVmaW5lIE9NQVAyNFhYX0VUSFJfR1BJT19JUlEJCTE0
OQorI2RlZmluZSBPTUFQMkVWTV9FVEhSX1NUQVJUCQkJMHgyYzAwMDAwMAorI2RlZmluZSBPTUFQ
MkVWTV9FVEhSX1NJWkUJCQkxMDI0CisjZGVmaW5lIE9NQVAyRVZNX0VUSFJfR1BJT19JUlEJCTE0
OQogCiAjZW5kaWYgLyogX19BU01fQVJDSF9PTUFQMl9FVk1fSCAqLwotLSAKMS41LjMuNAoK
------=_Part_4732_13223486.1214309099879--
