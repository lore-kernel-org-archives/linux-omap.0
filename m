From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/5] Regulator: Creating regulator hookup file for OMAP3 platforms
Date: Thu,  5 Nov 2009 22:09:24 +0530
Message-ID: <1257439164-28467-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757055AbZKEQj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Nov 2009 11:39:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, Anuj Aggarwal <anuj.aggarwal@ti.com>

This newly created board-omap35x-pmic.c will be used to provide
the board specific regulator hookup code for various TI PMICs (like
TWL4030/TPS65950, TPS65023) on different EVMs like OMAP3, AM3517.

PMIC initialization routine is called from the board-evm file
which will initialize the configured PMIC appropriately.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-omap35x-pmic.c |   71 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c     |    8 +++
 2 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.c

diff --git a/arch/arm/mach-omap2/board-omap35x-pmic.c b/arch/arm/mach-omap2/board-omap35x-pmic.c
new file mode 100644
index 0000000..aae07ab
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap35x-pmic.c
@@ -0,0 +1,71 @@
+/*
+ * board-omap35x-pmic.c
+ *
+ * Board specific information for different regulators and platforms.
+ *
+ * Copyright (C) 2009 Texas Instrument Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/platform_device.h>
+#include <plat/common.h>
+
+/*
+ * Definitions specific to TWL4030/TPS65950
+ */
+#if defined(CONFIG_PMIC_TWL4030)
+static inline void pmic_twl4030_init(void)
+{
+	/* TWL4030 specific init code */
+}
+#else
+static inline void pmic_twl4030_init(void)
+{
+}
+#endif	/* CONFIG_PMIC_TWL4030 */
+
+/*
+ * Definitions specific to TPS65023
+ */
+#if defined(CONFIG_PMIC_TPS65023)
+static inline void pmic_tps65023_init(void)
+{
+	/* TPS65023 specific init code */
+}
+#else
+static inline void pmic_tps65023_init(void)
+{
+}
+#endif	/* CONFIG_PMIC_TPS65023 */
+
+/*
+ * Definitions specific to TPS65073
+ */
+#if defined(CONFIG_PMIC_TPS65073)
+static inline void pmic_tps65073_init(void)
+{
+	/* TPS65073 specific init code */
+}
+#else
+static inline void pmic_tps65073_init(void)
+{
+}
+#endif	/* CONFIG_PMIC_TPS65073 */
+
+/* Detects the PMIC and initializes it accordingly */
+void omap35x_pmic_init(void)
+{
+	pmic_twl4030_init();
+	pmic_tps65023_init();
+	pmic_tps65073_init();
+}
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d526fa5..dbdf062 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -51,6 +51,8 @@
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
 #define OMAP3EVM_SMC911X_CS	5
 
+extern void omap35x_pmic_init(void);
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start	= OMAP3EVM_ETHR_START,
@@ -204,6 +206,10 @@ static struct twl4030_platform_data omap3evm_twldata = {
 	.madc		= &omap3evm_madc_data,
 	.usb		= &omap3evm_usb_data,
 	.gpio		= &omap3evm_gpio_data,
+	/*
+	 * Regulator specific hooks are getting populated
+	 * in the omap35x_pmic_init().
+	 */
 };
 
 static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
@@ -312,6 +318,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap3_evm_init(void)
 {
+	omap35x_pmic_init();
+
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
-- 
1.6.2.4

