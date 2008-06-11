From: "arun c" <arunedarath@mistralsolutions.com>
Subject: [PATCH 3/3] This patch completes the name change from 2430osk to OMAP2EVM
Date: Wed, 11 Jun 2008 16:06:24 +0530
Message-ID: <c656a4d20806110336h78105b9dq66889156c469721f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_20010_4591096.1213180584304"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.159]:32646 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbYFKKgZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jun 2008 06:36:25 -0400
Received: by po-out-1718.google.com with SMTP id c31so5987083poi.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Jun 2008 03:36:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

------=_Part_20010_4591096.1213180584304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From 11262ea96e0fa73dd3470362b571a33b792bfb09 Mon Sep 17 00:00:00 2001
From: arun <arunedarath@mistralsolutions.com>
Date: Wed, 11 Jun 2008 15:46:10 +0530
Subject: [PATCH] This patch completes the name change from 2430osk to OMAP2EVM

Also
	a) Changed old style i2c registration
	b) Changed the Maintainer

Signed-off-by: arun <arunedarath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap2evm.c       |  111 ++++++----------------------
 include/asm-arm/arch-omap/board-omap2evm.h |   14 ++--
 2 files changed, 31 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index 146dba3..d00e502 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-omap2/board-2430osk.c
+ * linux/arch/arm/mach-omap2/board-omap2evm.c
  *
- * Copyright (C) 2007 Mistral Software Pvt Ltd
+ * Copyright (C) 2008 Mistral Solutions Pvt Ltd
  *
  * Modified from mach-omap2/board-generic.c
  *
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/io.h>

 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -26,118 +27,54 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>

-#include <asm/io.h>
-
-static void __init omap_2430osk_init_irq(void)
+static void __init omap2_evm_init_irq(void)
 {
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
 }

-static struct omap_uart_config osk2430_uart_config __initdata = {
+static struct omap_uart_config omap2_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };

-static struct omap_board_config_kernel osk2430_config[] __initdata = {
-
-	{OMAP_TAG_UART, &osk2430_uart_config},
-};
-
-#if	defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
-
-#define OMAP2_I2C_BASE1		0x48070000
-#define OMAP2_I2C_BASE2		0x48072000
-#define OMAP2_I2C_INT1		56
-#define OMAP2_I2C_INT2		57
-
-static u32 omap2_i2c1_clkrate	= 400;
-static u32 omap2_i2c2_clkrate	= 2600;
-
-static struct resource i2c_resources1[] = {
-	{
-		.start	= OMAP2_I2C_BASE1,
-		.end	= OMAP2_I2C_BASE1 + 0x3f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP2_I2C_INT1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource i2c_resources2[] = {
-	{
-		.start	= OMAP2_I2C_BASE2,
-		.end	= OMAP2_I2C_BASE2 + 0x3f,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= OMAP2_I2C_INT2,
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
+	{OMAP_TAG_UART, &omap2_evm_uart_config},
 };

-static struct platform_device omap_i2c_device1 = {
-	.name		= "i2c_omap",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(i2c_resources1),
-	.resource	= i2c_resources1,
-	.dev		= {
-		.platform_data	= &omap2_i2c1_clkrate,
-	},
-};
-
-static struct platform_device omap_i2c_device2 = {
-	.name		= "i2c_omap",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(i2c_resources2),
-	.resource	= i2c_resources2,
-	.dev		= {
-		.platform_data	= &omap2_i2c2_clkrate,
-	},
-};
-
-static void omap_init_i2c(void)
-{
-	(void) platform_device_register(&omap_i2c_device2);
-	(void) platform_device_register(&omap_i2c_device1);
-}
-
-#else
-
-static void omap_init_i2c(void) {}
-
-#endif
-
-static int __init omap2430_i2c_init(void)
+static int __init omap2_evm_i2c_init(void)
 {
-	omap_init_i2c();
+	/*
+	 * Registering bus 2 first to avoid twl4030 misbehaving as OMAP2EVM
+	 * has twl4030 on bus 2
+	 */
+	omap_register_i2c_bus(2, 2600, NULL, 0);
+	omap_register_i2c_bus(1, 400, NULL, 0);
 	return 0;
 }

-static void __init omap_2430osk_init(void)
+static void __init omap2_evm_init(void)
 {
-	omap_board_config = osk2430_config;
-	omap_board_config_size = ARRAY_SIZE(osk2430_config);
+	omap_board_config = omap2_evm_config;
+	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
 	omap_serial_init();
 }

-static void __init omap_2430osk_map_io(void)
+static void __init omap2_evm_map_io(void)
 {
 	omap2_set_globals_243x();
 	omap2_map_common_io();
 }

-arch_initcall(omap2430_i2c_init);
+arch_initcall(omap2_evm_i2c_init);

-MACHINE_START(OMAP_2430OSK, "OMAP2430 2430OSK board")
-	/* Maintainer: Syed Khasim */
+MACHINE_START(OMAP2EVM, "OMAP2EVM Board")
+	/* Maintainer:  Arun KS <arunks@mistralsolutions.com> */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
-	.map_io		= omap_2430osk_map_io,
-	.init_irq	= omap_2430osk_init_irq,
-	.init_machine	= omap_2430osk_init,
+	.map_io		= omap2_evm_map_io,
+	.init_irq	= omap2_evm_init_irq,
+	.init_machine	= omap2_evm_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/include/asm-arm/arch-omap/board-omap2evm.h
b/include/asm-arm/arch-omap/board-omap2evm.h
index 3b61bc1..98273a9 100644
--- a/include/asm-arm/arch-omap/board-omap2evm.h
+++ b/include/asm-arm/arch-omap/board-omap2evm.h
@@ -1,9 +1,9 @@
 /*
- * linux/include/asm-arm/arch-omap/board-2430osk.h
+ * linux/include/asm-arm/arch-omap/board-omap2evm.h
  *
- * Hardware definitions for TI OMAP2430 OSK board.
+ * Hardware definitions for Mistral's OMAP2EVM board.
  *
- * Based on board-2330sdp.h
+ * Based on board-2430sdp.h
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -26,11 +26,11 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */

-#ifndef __ASM_ARCH_OMAP_2430OSK_H
-#define __ASM_ARCH_OMAP_2430OSK_H
+#ifndef __ASM_ARCH_OMAP2_EVM_H
+#define __ASM_ARCH_OMAP2_EVM_H

-/* Placeholder for 2430OSK specific defines */
+/* Placeholder for OMAP2EVM specific defines */
 #define OMAP24XX_ETHR_START		0x08000300
 #define OMAP24XX_ETHR_GPIO_IRQ		149

-#endif /* __ASM_ARCH_OMAP_2430OSK_H */
+#endif /* __ASM_ARCH_OMAP2_EVM_H */
-- 
1.5.3.4

------=_Part_20010_4591096.1213180584304
Content-Type: text/x-patch;
 name=0003-This-patch-completes-the-name-change-from-2430osk-to.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhbq40gt0
Content-Disposition: attachment;
 filename=0003-This-patch-completes-the-name-change-from-2430osk-to.patch

RnJvbSAxMTI2MmVhOTZlMGZhNzNkZDM0NzAzNjJiNTcxYTMzYjc5MmJmYjA5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhcnVuIDxhcnVuZWRhcmF0aEBtaXN0cmFsc29sdXRpb25zLmNv
bT4KRGF0ZTogV2VkLCAxMSBKdW4gMjAwOCAxNTo0NjoxMCArMDUzMApTdWJqZWN0OiBbUEFUQ0hd
IFRoaXMgcGF0Y2ggY29tcGxldGVzIHRoZSBuYW1lIGNoYW5nZSBmcm9tIDI0MzBvc2sgdG8gT01B
UDJFVk0KCkFsc28KCWEpIENoYW5nZWQgb2xkIHN0eWxlIGkyYyByZWdpc3RyYXRpb24KCWIpIENo
YW5nZWQgdGhlIE1haW50YWluZXIKClNpZ25lZC1vZmYtYnk6IGFydW4gPGFydW5lZGFyYXRoQG1p
c3RyYWxzb2x1dGlvbnMuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDJl
dm0uYyAgICAgICB8ICAxMTEgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogaW5jbHVkZS9h
c20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5oIHwgICAxNCArKy0tCiAyIGZpbGVzIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDk0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtb21hcDIvYm9hcmQtb21hcDJldm0uYyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
Ym9hcmQtb21hcDJldm0uYwppbmRleCAxNDZkYmEzLi5kMDBlNTAyIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW9tYXAyL2JvYXJkLW9tYXAyZXZtLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFw
Mi9ib2FyZC1vbWFwMmV2bS5jCkBAIC0xLDcgKzEsNyBAQAogLyoKLSAqIGxpbnV4L2FyY2gvYXJt
L21hY2gtb21hcDIvYm9hcmQtMjQzMG9zay5jCisgKiBsaW51eC9hcmNoL2FybS9tYWNoLW9tYXAy
L2JvYXJkLW9tYXAyZXZtLmMKICAqCi0gKiBDb3B5cmlnaHQgKEMpIDIwMDcgTWlzdHJhbCBTb2Z0
d2FyZSBQdnQgTHRkCisgKiBDb3B5cmlnaHQgKEMpIDIwMDggTWlzdHJhbCBTb2x1dGlvbnMgUHZ0
IEx0ZAogICoKICAqIE1vZGlmaWVkIGZyb20gbWFjaC1vbWFwMi9ib2FyZC1nZW5lcmljLmMKICAq
CkBAIC0xNiw2ICsxNiw3IEBACiAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KICNpbmNsdWRlIDxs
aW51eC9lcnIuaD4KICNpbmNsdWRlIDxsaW51eC9jbGsuaD4KKyNpbmNsdWRlIDxsaW51eC9pby5o
PgogCiAjaW5jbHVkZSA8YXNtL2hhcmR3YXJlLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gtdHlwZXMu
aD4KQEAgLTI2LDExOCArMjcsNTQgQEAKICNpbmNsdWRlIDxhc20vYXJjaC9ib2FyZC5oPgogI2lu
Y2x1ZGUgPGFzbS9hcmNoL2NvbW1vbi5oPgogCi0jaW5jbHVkZSA8YXNtL2lvLmg+Ci0KLXN0YXRp
YyB2b2lkIF9faW5pdCBvbWFwXzI0MzBvc2tfaW5pdF9pcnEodm9pZCkKK3N0YXRpYyB2b2lkIF9f
aW5pdCBvbWFwMl9ldm1faW5pdF9pcnEodm9pZCkKIHsKIAlvbWFwMl9pbml0X2NvbW1vbl9odygp
OwogCW9tYXBfaW5pdF9pcnEoKTsKIAlvbWFwX2dwaW9faW5pdCgpOwogfQogCi1zdGF0aWMgc3Ry
dWN0IG9tYXBfdWFydF9jb25maWcgb3NrMjQzMF91YXJ0X2NvbmZpZyBfX2luaXRkYXRhID0gewor
c3RhdGljIHN0cnVjdCBvbWFwX3VhcnRfY29uZmlnIG9tYXAyX2V2bV91YXJ0X2NvbmZpZyBfX2lu
aXRkYXRhID0gewogCS5lbmFibGVkX3VhcnRzCT0gKCgxIDw8IDApIHwgKDEgPDwgMSkgfCAoMSA8
PCAyKSksCiB9OwogCi1zdGF0aWMgc3RydWN0IG9tYXBfYm9hcmRfY29uZmlnX2tlcm5lbCBvc2sy
NDMwX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7Ci0KLQl7T01BUF9UQUdfVUFSVCwgJm9zazI0MzBf
dWFydF9jb25maWd9LAotfTsKLQotI2lmCWRlZmluZWQoQ09ORklHX0kyQ19PTUFQKSB8fCBkZWZp
bmVkKENPTkZJR19JMkNfT01BUF9NT0RVTEUpCi0KLSNkZWZpbmUgT01BUDJfSTJDX0JBU0UxCQkw
eDQ4MDcwMDAwCi0jZGVmaW5lIE9NQVAyX0kyQ19CQVNFMgkJMHg0ODA3MjAwMAotI2RlZmluZSBP
TUFQMl9JMkNfSU5UMQkJNTYKLSNkZWZpbmUgT01BUDJfSTJDX0lOVDIJCTU3Ci0KLXN0YXRpYyB1
MzIgb21hcDJfaTJjMV9jbGtyYXRlCT0gNDAwOwotc3RhdGljIHUzMiBvbWFwMl9pMmMyX2Nsa3Jh
dGUJPSAyNjAwOwotCi1zdGF0aWMgc3RydWN0IHJlc291cmNlIGkyY19yZXNvdXJjZXMxW10gPSB7
Ci0JewotCQkuc3RhcnQJPSBPTUFQMl9JMkNfQkFTRTEsCi0JCS5lbmQJPSBPTUFQMl9JMkNfQkFT
RTEgKyAweDNmLAotCQkuZmxhZ3MJPSBJT1JFU09VUkNFX01FTSwKLQl9LAotCXsKLQkJLnN0YXJ0
CT0gT01BUDJfSTJDX0lOVDEsCi0JCS5mbGFncwk9IElPUkVTT1VSQ0VfSVJRLAotCX0sCi19Owot
Ci1zdGF0aWMgc3RydWN0IHJlc291cmNlIGkyY19yZXNvdXJjZXMyW10gPSB7Ci0JewotCQkuc3Rh
cnQJPSBPTUFQMl9JMkNfQkFTRTIsCi0JCS5lbmQJPSBPTUFQMl9JMkNfQkFTRTIgKyAweDNmLAot
CQkuZmxhZ3MJPSBJT1JFU09VUkNFX01FTSwKLQl9LAotCXsKLQkJLnN0YXJ0CT0gT01BUDJfSTJD
X0lOVDIsCi0JCS5mbGFncwk9IElPUkVTT1VSQ0VfSVJRLAotCX0sCitzdGF0aWMgc3RydWN0IG9t
YXBfYm9hcmRfY29uZmlnX2tlcm5lbCBvbWFwMl9ldm1fY29uZmlnW10gX19pbml0ZGF0YSA9IHsK
Kwl7T01BUF9UQUdfVUFSVCwgJm9tYXAyX2V2bV91YXJ0X2NvbmZpZ30sCiB9OwogCi1zdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RldmljZSBvbWFwX2kyY19kZXZpY2UxID0gewotCS5uYW1lCQk9ICJp
MmNfb21hcCIsCi0JLmlkCQk9IDEsCi0JLm51bV9yZXNvdXJjZXMJPSBBUlJBWV9TSVpFKGkyY19y
ZXNvdXJjZXMxKSwKLQkucmVzb3VyY2UJPSBpMmNfcmVzb3VyY2VzMSwKLQkuZGV2CQk9IHsKLQkJ
LnBsYXRmb3JtX2RhdGEJPSAmb21hcDJfaTJjMV9jbGtyYXRlLAotCX0sCi19OwotCi1zdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RldmljZSBvbWFwX2kyY19kZXZpY2UyID0gewotCS5uYW1lCQk9ICJp
MmNfb21hcCIsCi0JLmlkCQk9IDIsCi0JLm51bV9yZXNvdXJjZXMJPSBBUlJBWV9TSVpFKGkyY19y
ZXNvdXJjZXMyKSwKLQkucmVzb3VyY2UJPSBpMmNfcmVzb3VyY2VzMiwKLQkuZGV2CQk9IHsKLQkJ
LnBsYXRmb3JtX2RhdGEJPSAmb21hcDJfaTJjMl9jbGtyYXRlLAotCX0sCi19OwotCi1zdGF0aWMg
dm9pZCBvbWFwX2luaXRfaTJjKHZvaWQpCi17Ci0JKHZvaWQpIHBsYXRmb3JtX2RldmljZV9yZWdp
c3Rlcigmb21hcF9pMmNfZGV2aWNlMik7Ci0JKHZvaWQpIHBsYXRmb3JtX2RldmljZV9yZWdpc3Rl
cigmb21hcF9pMmNfZGV2aWNlMSk7Ci19Ci0KLSNlbHNlCi0KLXN0YXRpYyB2b2lkIG9tYXBfaW5p
dF9pMmModm9pZCkge30KLQotI2VuZGlmCi0KLXN0YXRpYyBpbnQgX19pbml0IG9tYXAyNDMwX2ky
Y19pbml0KHZvaWQpCitzdGF0aWMgaW50IF9faW5pdCBvbWFwMl9ldm1faTJjX2luaXQodm9pZCkK
IHsKLQlvbWFwX2luaXRfaTJjKCk7CisJLyoKKwkgKiBSZWdpc3RlcmluZyBidXMgMiBmaXJzdCB0
byBhdm9pZCB0d2w0MDMwIG1pc2JlaGF2aW5nIGFzIE9NQVAyRVZNCisJICogaGFzIHR3bDQwMzAg
b24gYnVzIDIKKwkgKi8KKwlvbWFwX3JlZ2lzdGVyX2kyY19idXMoMiwgMjYwMCwgTlVMTCwgMCk7
CisJb21hcF9yZWdpc3Rlcl9pMmNfYnVzKDEsIDQwMCwgTlVMTCwgMCk7CiAJcmV0dXJuIDA7CiB9
CiAKLXN0YXRpYyB2b2lkIF9faW5pdCBvbWFwXzI0MzBvc2tfaW5pdCh2b2lkKQorc3RhdGljIHZv
aWQgX19pbml0IG9tYXAyX2V2bV9pbml0KHZvaWQpCiB7Ci0Jb21hcF9ib2FyZF9jb25maWcgPSBv
c2syNDMwX2NvbmZpZzsKLQlvbWFwX2JvYXJkX2NvbmZpZ19zaXplID0gQVJSQVlfU0laRShvc2sy
NDMwX2NvbmZpZyk7CisJb21hcF9ib2FyZF9jb25maWcgPSBvbWFwMl9ldm1fY29uZmlnOworCW9t
YXBfYm9hcmRfY29uZmlnX3NpemUgPSBBUlJBWV9TSVpFKG9tYXAyX2V2bV9jb25maWcpOwogCW9t
YXBfc2VyaWFsX2luaXQoKTsKIH0KIAotc3RhdGljIHZvaWQgX19pbml0IG9tYXBfMjQzMG9za19t
YXBfaW8odm9pZCkKK3N0YXRpYyB2b2lkIF9faW5pdCBvbWFwMl9ldm1fbWFwX2lvKHZvaWQpCiB7
CiAJb21hcDJfc2V0X2dsb2JhbHNfMjQzeCgpOwogCW9tYXAyX21hcF9jb21tb25faW8oKTsKIH0K
IAotYXJjaF9pbml0Y2FsbChvbWFwMjQzMF9pMmNfaW5pdCk7CithcmNoX2luaXRjYWxsKG9tYXAy
X2V2bV9pMmNfaW5pdCk7CiAKLU1BQ0hJTkVfU1RBUlQoT01BUF8yNDMwT1NLLCAiT01BUDI0MzAg
MjQzME9TSyBib2FyZCIpCi0JLyogTWFpbnRhaW5lcjogU3llZCBLaGFzaW0gKi8KK01BQ0hJTkVf
U1RBUlQoT01BUDJFVk0sICJPTUFQMkVWTSBCb2FyZCIpCisJLyogTWFpbnRhaW5lcjogIEFydW4g
S1MgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4gKi8KIAkucGh5c19pbwk9IDB4NDgwMDAw
MDAsCiAJLmlvX3BnX29mZnN0CT0gKCgweGQ4MDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLmJv
b3RfcGFyYW1zCT0gMHg4MDAwMDEwMCwKLQkubWFwX2lvCQk9IG9tYXBfMjQzMG9za19tYXBfaW8s
Ci0JLmluaXRfaXJxCT0gb21hcF8yNDMwb3NrX2luaXRfaXJxLAotCS5pbml0X21hY2hpbmUJPSBv
bWFwXzI0MzBvc2tfaW5pdCwKKwkubWFwX2lvCQk9IG9tYXAyX2V2bV9tYXBfaW8sCisJLmluaXRf
aXJxCT0gb21hcDJfZXZtX2luaXRfaXJxLAorCS5pbml0X21hY2hpbmUJPSBvbWFwMl9ldm1faW5p
dCwKIAkudGltZXIJCT0gJm9tYXBfdGltZXIsCiBNQUNISU5FX0VORApkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5oIGIvaW5jbHVkZS9hc20tYXJt
L2FyY2gtb21hcC9ib2FyZC1vbWFwMmV2bS5oCmluZGV4IDNiNjFiYzEuLjk4MjczYTkgMTAwNjQ0
Ci0tLSBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaAorKysgYi9p
bmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2JvYXJkLW9tYXAyZXZtLmgKQEAgLTEsOSArMSw5IEBA
CiAvKgotICogbGludXgvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ib2FyZC0yNDMwb3NrLmgK
KyAqIGxpbnV4L2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvYm9hcmQtb21hcDJldm0uaAogICoK
LSAqIEhhcmR3YXJlIGRlZmluaXRpb25zIGZvciBUSSBPTUFQMjQzMCBPU0sgYm9hcmQuCisgKiBI
YXJkd2FyZSBkZWZpbml0aW9ucyBmb3IgTWlzdHJhbCdzIE9NQVAyRVZNIGJvYXJkLgogICoKLSAq
IEJhc2VkIG9uIGJvYXJkLTIzMzBzZHAuaAorICogQmFzZWQgb24gYm9hcmQtMjQzMHNkcC5oCiAg
KgogICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRl
IGl0IGFuZC9vciBtb2RpZnkgaXQKICAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZQpAQCAtMjYsMTEgKzI2LDExIEBA
CiAgKiA2NzUgTWFzcyBBdmUsIENhbWJyaWRnZSwgTUEgMDIxMzksIFVTQS4KICAqLwogCi0jaWZu
ZGVmIF9fQVNNX0FSQ0hfT01BUF8yNDMwT1NLX0gKLSNkZWZpbmUgX19BU01fQVJDSF9PTUFQXzI0
MzBPU0tfSAorI2lmbmRlZiBfX0FTTV9BUkNIX09NQVAyX0VWTV9ICisjZGVmaW5lIF9fQVNNX0FS
Q0hfT01BUDJfRVZNX0gKIAotLyogUGxhY2Vob2xkZXIgZm9yIDI0MzBPU0sgc3BlY2lmaWMgZGVm
aW5lcyAqLworLyogUGxhY2Vob2xkZXIgZm9yIE9NQVAyRVZNIHNwZWNpZmljIGRlZmluZXMgKi8K
ICNkZWZpbmUgT01BUDI0WFhfRVRIUl9TVEFSVAkJMHgwODAwMDMwMAogI2RlZmluZSBPTUFQMjRY
WF9FVEhSX0dQSU9fSVJRCQkxNDkKIAotI2VuZGlmIC8qIF9fQVNNX0FSQ0hfT01BUF8yNDMwT1NL
X0ggKi8KKyNlbmRpZiAvKiBfX0FTTV9BUkNIX09NQVAyX0VWTV9IICovCi0tIAoxLjUuMy40Cgo=

------=_Part_20010_4591096.1213180584304--
