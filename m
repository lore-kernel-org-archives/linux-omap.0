From: "Arun KS" <getarunks@gmail.com>
Subject: [Resend] [PATCH 1/3] OMAP2EVM: add ethernet support (smc911x)
Date: Tue, 24 Jun 2008 21:11:35 +0530
Message-ID: <dfeb90390806240841k25f8951ajc6bd7b84d5a8da3d@mail.gmail.com>
References: <dfeb90390806240504t3a900901t8879c3fc07aebb0f@mail.gmail.com>
	 <0d8b982e9147570fe343aff404e7a1c6@felipebalbi.com>
	 <dfeb90390806240554v549cf987h20c68685d3082f2b@mail.gmail.com>
	 <4c2f926971f553819251f824d239ca85@felipebalbi.com>
	 <dfeb90390806240625y7c1309fal44dce5ce3f7f62c1@mail.gmail.com>
	 <48e8658f507de35e2fab060ca2a9db43@felipebalbi.com>
	 <dfeb90390806240806t59a4feb2vbaafc75961bc9827@mail.gmail.com>
	 <5ba86bb09a1376c0040f6fa6cb1cc204@felipebalbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6660_21655599.1214322095329"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:37293 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYFXPlh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 11:41:37 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1369676tic.23
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 08:41:35 -0700 (PDT)
In-Reply-To: <5ba86bb09a1376c0040f6fa6cb1cc204@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

------=_Part_6660_21655599.1214322095329
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
index d00e502..0048775 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -27,11 +27,47 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>

+static struct resource omap2evm_smc911x_resources[] = {
+       [0] =   {
+               .start  = OMAP2EVM_ETHR_START,
+               .end    = (OMAP2EVM_ETHR_START + OMAP2EVM_ETHR_SIZE - 1),
+               .flags  = IORESOURCE_MEM,
+       },
+       [1] =   {
+               .start  = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+               .end    = OMAP_GPIO_IRQ(OMAP2EVM_ETHR_GPIO_IRQ),
+               .flags  = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device omap2evm_smc911x_device = {
+       .name       = "smc911x",
+       .id     = -1,
+       .num_resources  = ARRAY_SIZE(omap2evm_smc911x_resources),
+       .resource   = &omap2evm_smc911x_resources [0],
+};
+
+static inline void __init omap2evm_init_smc911x(void)
+{
+       int gpio = OMAP2EVM_ETHR_GPIO_IRQ;
+       int ret;
+
+       ret = gpio_request(gpio, "smc911x IRQ");
+       if (ret < 0) {
+               printk(KERN_ERR "Failed to request GPIO %d for smc911x IRQ\n",
+               gpio);
+               return;
+       }
+       gpio_direction_input(gpio);
+
+}
+
 static void __init omap2_evm_init_irq(void)
 {
        omap2_init_common_hw();
        omap_init_irq();
        omap_gpio_init();
+       omap2evm_init_smc911x();
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
+       platform_add_devices(omap2_evm_devices, ARRAY_SIZE(omap2_evm_devices));
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
-#define OMAP24XX_ETHR_START            0x08000300
-#define OMAP24XX_ETHR_GPIO_IRQ         149
+#define OMAP2EVM_ETHR_START                    0x2c000000
+#define OMAP2EVM_ETHR_SIZE                     1024
+#define OMAP2EVM_ETHR_GPIO_IRQ         149

 #endif /* __ASM_ARCH_OMAP2_EVM_H */
--
1.5.3.4

------=_Part_6660_21655599.1214322095329
Content-Type: text/x-patch;
 name=0001-OMAP2EVM-Adding-ethernet-support.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhuo9acg0
Content-Disposition: attachment;
 filename=0001-OMAP2EVM-Adding-ethernet-support.patch

RnJvbSAxYjBlMzU1MWEwYTM1MmZjMDZjYWRlYzljMjY3ZTc2YTM4ODRmM2ZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFR1ZSwgMjQgSnVuIDIwMDggMjA6NTE6NDYgKzA1MzAKU3ViamVjdDogW1BBVENIXSBP
TUFQMkVWTTogQWRkaW5nIGV0aGVybmV0IHN1cHBvcnQKCk9NQVAyRVZNOiBBZGQgZXRoZXJuZXQg
c3VwcG9ydCAoc21jOTExeCkKClNpZ25lZC1vZmYtYnk6IEFydW4gS1MgPGFydW5rc0BtaXN0cmFs
c29sdXRpb25zLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMg
ICAgICAgfCAgIDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUvYXNtLWFy
bS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaCB8ICAgIDUgKystCiAyIGZpbGVzIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9ib2FyZC1vbWFwMmV2bS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1v
bWFwMmV2bS5jCmluZGV4IGQwMGU1MDIuLjAwNDg3NzUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
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
bGVkIHRvIHJlcXVlc3QgR1BJTyAlZCBmb3Igc21jOTExeCBJUlFcbiIsCisJCWdwaW8pOworCQly
ZXR1cm47CisJfQorCWdwaW9fZGlyZWN0aW9uX2lucHV0KGdwaW8pOworCit9CisKIHN0YXRpYyB2
b2lkIF9faW5pdCBvbWFwMl9ldm1faW5pdF9pcnEodm9pZCkKIHsKIAlvbWFwMl9pbml0X2NvbW1v
bl9odygpOwogCW9tYXBfaW5pdF9pcnEoKTsKIAlvbWFwX2dwaW9faW5pdCgpOworCW9tYXAyZXZt
X2luaXRfc21jOTExeCgpOwogfQogCiBzdGF0aWMgc3RydWN0IG9tYXBfdWFydF9jb25maWcgb21h
cDJfZXZtX3VhcnRfY29uZmlnIF9faW5pdGRhdGEgPSB7CkBAIC01Myw4ICs4OSwxMyBAQCBzdGF0
aWMgaW50IF9faW5pdCBvbWFwMl9ldm1faTJjX2luaXQodm9pZCkKIAlyZXR1cm4gMDsKIH0KIAor
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9tYXAyX2V2bV9kZXZpY2VzW10gX19pbml0
ZGF0YSA9IHsKKyAgICAmb21hcDJldm1fc21jOTExeF9kZXZpY2UsCit9OworCiBzdGF0aWMgdm9p
ZCBfX2luaXQgb21hcDJfZXZtX2luaXQodm9pZCkKIHsKKwlwbGF0Zm9ybV9hZGRfZGV2aWNlcyhv
bWFwMl9ldm1fZGV2aWNlcywgQVJSQVlfU0laRShvbWFwMl9ldm1fZGV2aWNlcykpOwogCW9tYXBf
Ym9hcmRfY29uZmlnID0gb21hcDJfZXZtX2NvbmZpZzsKIAlvbWFwX2JvYXJkX2NvbmZpZ19zaXpl
ID0gQVJSQVlfU0laRShvbWFwMl9ldm1fY29uZmlnKTsKIAlvbWFwX3NlcmlhbF9pbml0KCk7CmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLW9tYXAyZXZtLmggYi9p
bmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLW9tYXAyZXZtLmgKaW5kZXggOTgyNzNhOS4u
ZDc3MGM1OCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFw
MmV2bS5oCisrKyBiL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaApA
QCAtMzAsNyArMzAsOCBAQAogI2RlZmluZSBfX0FTTV9BUkNIX09NQVAyX0VWTV9ICiAKIC8qIFBs
YWNlaG9sZGVyIGZvciBPTUFQMkVWTSBzcGVjaWZpYyBkZWZpbmVzICovCi0jZGVmaW5lIE9NQVAy
NFhYX0VUSFJfU1RBUlQJCTB4MDgwMDAzMDAKLSNkZWZpbmUgT01BUDI0WFhfRVRIUl9HUElPX0lS
UQkJMTQ5CisjZGVmaW5lIE9NQVAyRVZNX0VUSFJfU1RBUlQJCQkweDJjMDAwMDAwCisjZGVmaW5l
IE9NQVAyRVZNX0VUSFJfU0laRQkJCTEwMjQKKyNkZWZpbmUgT01BUDJFVk1fRVRIUl9HUElPX0lS
UQkJMTQ5CiAKICNlbmRpZiAvKiBfX0FTTV9BUkNIX09NQVAyX0VWTV9IICovCi0tIAoxLjUuMy40
Cgo=
------=_Part_6660_21655599.1214322095329--
