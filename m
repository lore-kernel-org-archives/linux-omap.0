From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 05/13] dt: omap3: add generic board file for dt support
Date: Tue, 23 Aug 2011 10:03:33 +0500
Message-ID: <1314074021-25186-6-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:39844 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750827Ab1HWEqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:46:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


The generic board file is created and derived from beagle board file.
The beagle board file is migrated to boot from flattened device tree and
the cleanup of board specific file will happen in different stages.

The changes here focus on minimal configuration to boot beagle board with
dt enabled which provides basic platform for converting device drivers for
using dt.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/Kconfig             |   11 ++++
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-omap3-dt.c    |   84 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c |   13 -----
 4 files changed, 96 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..4fbb54d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -305,6 +305,17 @@ config MACH_OMAP_3630SDP
 	default y
 	select OMAP_PACKAGE_CBP
 
+config MACH_OMAP3_DT
+	bool "Generic OMAP3 board(FDT support)"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CBB
+	select USE_OF
+
+	help
+	  Support for generic TI OMAP3 boards using Flattened Device Tree.
+	  Say Y here to enable OMAP3 device tree support
+	  More information at Documentation/devicetree
+
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
 	depends on SOC_OMAPTI816X
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b1501bd..e702e47 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -197,6 +197,7 @@ obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
+obj-$(CONFIG_MACH_OMAP3_DT)		+= board-omap3-dt.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
 					   sdram-nokia.o
diff --git a/arch/arm/mach-omap2/board-omap3-dt.c b/arch/arm/mach-omap2/board-omap3-dt.c
new file mode 100644
index 0000000..72c59a4
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap3-dt.c
@@ -0,0 +1,84 @@
+/*
+ * TI OMAP3 device tree board support
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+
+#include <linux/regulator/machine.h>
+#include <linux/i2c/twl.h>
+
+#include <asm/mach/arch.h>
+
+#include <plat/common.h>
+#include <plat/omap_device.h>
+
+#include "mux.h"
+#include "common-board-devices.h"
+#include "hsmmc.h"
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+static struct twl4030_platform_data beagle_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+};
+
+static int __init omap3_beagle_i2c_init(void)
+{
+	omap3_pmic_init("twl4030", &beagle_twldata);
+	return 0;
+}
+
+static void __init omap3_init_early(void)
+{
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
+				  mt46h32m32lf6_sdrc_params);
+}
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "ti,omap3-l4-core", },
+	{}
+};
+
+static void __init omap3_init(void)
+{
+	omap3_beagle_i2c_init();
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap_serial_init();
+
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+}
+
+static const char *omap3_dt_match[] __initdata = {
+	"ti,omap3",
+	NULL
+};
+
+DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3_init_early,
+	.init_irq	= omap3_init_irq,
+	.init_machine	= omap3_init,
+	.timer		= &omap3_timer,
+	.dt_compat	= omap3_dt_match,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 268c826..a845e9e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/of_platform.h>
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
@@ -388,9 +387,7 @@ static int __init omap3_beagle_i2c_init(void)
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
-#ifdef CONFIG_OF
 	omap_register_i2c_bus(2, 100, NULL, 0);
-#endif /* CONFIG_OF */
 	return 0;
 }
 
@@ -528,10 +525,6 @@ static void __init beagle_opp_init(void)
 
 static void __init omap3_beagle_init(void)
 {
-#ifdef CONFIG_OF
-	of_platform_prepare(NULL, NULL);
-#endif /* CONFIG_OF */
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
@@ -563,11 +556,6 @@ static void __init omap3_beagle_init(void)
 	beagle_opp_init();
 }
 
-static const char *omap3_beagle_dt_match[] __initdata = {
-	"ti,omap3-beagle",
-	NULL
-};
-
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.boot_params	= 0x80000100,
@@ -577,5 +565,4 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
 	.timer		= &omap3_secure_timer,
-	.dt_compat	= omap3_beagle_dt_match,
 MACHINE_END
-- 
1.7.4.1

