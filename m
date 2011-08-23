From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 11/13] dt: omap4: add generic board file for dt support
Date: Tue, 23 Aug 2011 10:03:39 +0500
Message-ID: <1314074021-25186-12-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:2423 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502Ab1HWErc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:47:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


The generic board file is created and derived from omap4 panda board file.

The changes here focus on minimal configuration to boot panda board with
dt enabled which provides basic platform for converting device drivers for
using dt.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts      |    2 +-
 arch/arm/mach-omap2/Kconfig            |   11 +++++
 arch/arm/mach-omap2/Makefile           |    1 +
 arch/arm/mach-omap2/board-omap4-dt.c   |   66 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap4panda.c |    6 ---
 5 files changed, 79 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4-dt.c

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 6b831ca..9d1b17c 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -2,7 +2,7 @@
 
 / {
 	model = "TI OMAP4 PandaBoard";
-	compatible = "ti,omap4-panda", "ti,omap4430";
+	compatible = "ti,omap4-panda", "ti,omap4";
 
 	i2c1 {
 		clock-frequency = <400000>;
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4fbb54d..853b14c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -337,6 +337,17 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_OMAP4_DT
+	bool "Generic OMAP4 board(FDT support)"
+	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBB
+	select USE_OF
+
+	help
+	  Support for generic TI OMAP4 boards using Flattened Device Tree.
+	  Say Y here to enable OMAP3 device tree support
+	  More information at Documentation/devicetree
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e702e47..8b8c29c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -198,6 +198,7 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP3_DT)		+= board-omap3-dt.o
+obj-$(CONFIG_MACH_OMAP4_DT)		+= board-omap4-dt.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
 					   sdram-nokia.o
diff --git a/arch/arm/mach-omap2/board-omap4-dt.c b/arch/arm/mach-omap2/board-omap4-dt.c
new file mode 100644
index 0000000..a4d296c
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap4-dt.c
@@ -0,0 +1,66 @@
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c/twl.h>
+
+#include <mach/omap4-common.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <plat/common.h>
+
+#include "common-board-devices.h"
+
+static void __init omap4_init_early(void)
+{
+	omap2_init_common_infrastructure();
+	omap2_init_common_devices(NULL, NULL);
+}
+
+static struct twl4030_platform_data omap4_twldata = {
+	.irq_base	= TWL6030_IRQ_BASE,
+	.irq_end	= TWL6030_IRQ_END,
+};
+
+static int __init omap4_i2c_init(void)
+{
+	omap4_pmic_init("twl6030", &omap4_twldata);
+	return 0;
+}
+
+static void __init omap4_init(void)
+{
+	omap4_i2c_init();
+	omap_serial_init();
+}
+
+static void __init omap4_map_io(void)
+{
+	omap2_set_globals_443x();
+	omap44xx_map_common_io();
+}
+
+static const char *omap4_match[] __initdata = {
+	"ti,omap4",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP4_DT, "TI OMAP4 (Flattened Device Tree)")
+	.boot_params	= 0x80000100,
+	.reserve	= omap_reserve,
+	.map_io		= omap4_map_io,
+	.init_early	= omap4_init_early,
+	.init_irq	= gic_init_irq,
+	.init_machine	= omap4_init,
+	.timer		= &omap4_timer,
+	.dt_compat	= omap4_match,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1c583c7..9aaa960 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -581,11 +581,6 @@ static void __init omap4_panda_map_io(void)
 	omap44xx_map_common_io();
 }
 
-static const char *omap4_panda_match[] __initdata = {
-	"ti,omap4-panda",
-	NULL,
-};
-
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
@@ -595,5 +590,4 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
-	.dt_compat	= omap4_panda_match,
 MACHINE_END
-- 
1.7.4.1

