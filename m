From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 6/7] OMAP4: board-dt: Add generic board with DT support
Date: Wed, 24 Aug 2011 12:17:19 +0200
Message-ID: <1314181040-22807-7-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab1HXKTT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 06:19:19 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

Create an OMAP4 generic board to start the DT migration.

This file is doing the minimal initialization needed to boot
properly on a RAMDISK filesystem.

As soon as the OMAP4 specifics will be removed, that board will
be converted to an even more generic board-dt.c that will support
every OMAP 2+ platform.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig          |    9 +++
 arch/arm/mach-omap2/Makefile         |    1 +
 arch/arm/mach-omap2/board-omap4-dt.c |  110 ++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4-dt.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..5d501d2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -326,6 +326,15 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_OMAP4_DT
+	bool "Generic OMAP4 board (FDT support)"
+	default y
+	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBL
+	select OMAP_PACKAGE_CBS
+	select REGULATOR_FIXED_VOLTAGE
+	select USE_OF
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b1501bd..79e42a1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -223,6 +223,7 @@ obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o \
 					   omap_phy_internal.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
 					   omap_phy_internal.o
+obj-$(CONFIG_MACH_OMAP4_DT)		+= board-omap4-dt.o
 
 obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
 					   omap_phy_internal.o
diff --git a/arch/arm/mach-omap2/board-omap4-dt.c b/arch/arm/mach-omap2/board-omap4-dt.c
new file mode 100644
index 0000000..9553cf1
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap4-dt.c
@@ -0,0 +1,110 @@
+/*
+ * OMAP4 Device tree boards support
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
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/i2c/twl.h>
+
+#include <asm/mach/arch.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+
+#include <mach/omap4-common.h>
+
+#include "mux.h"
+#include "common-board-devices.h"
+
+
+static void __init omap4_map_io(void)
+{
+	omap2_set_globals_443x();
+	omap44xx_map_common_io();
+}
+
+static void __init omap_init_early(void)
+{
+	omap2_init_common_infrastructure();
+	/*
+	 * XXX: That name is misleading because it does call only
+	 * omap2_sdrc_init in the case of OMAP 2&3 platform.
+	 * It is a no-op in the case of OMAP4, but keep it for the moment.
+	 * It should be replaced by a init_memory_controller kind of function
+	 * that will use DT to get the proper memory controller config.
+	 */
+	omap2_init_common_devices(NULL, NULL);
+}
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,omap-infra", },
+	{}
+};
+
+static struct of_device_id omap_dt_gic_match[] __initdata = {
+	{ .compatible = "ti,omap4-gic", },
+	{}
+};
+
+/*
+ * XXX: Still needed to boot until the i2c & twl driver is adapted to
+ * device-tree
+ */
+static struct twl4030_platform_data sdp4430_twldata = {
+	.irq_base	= TWL6030_IRQ_BASE,
+	.irq_end	= TWL6030_IRQ_END,
+};
+
+static void __init omap4_i2c_init(void)
+{
+	omap4_pmic_init("twl6030", &sdp4430_twldata);
+}
+
+static void __init omap4_init_machine(void)
+{
+	int package = OMAP_PACKAGE_CBS;
+	struct device_node *node;
+
+	node = of_find_matching_node(NULL, omap_dt_gic_match);
+	if (node)
+		irq_domain_add_simple(node, 0);
+
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		package = OMAP_PACKAGE_CBL;
+	omap4_mux_init(NULL, NULL, package);
+
+	omap4_i2c_init();
+	/*
+	 * XXX: Still needed to boot until the omap-serial driver is adapted
+	 * to device-tree
+	 */
+	omap_serial_init();
+
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+}
+
+static const char *omap4_boards_compat[] __initdata = {
+	"ti,omap4",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP4_DT, "OMAP4 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap4_map_io,
+	.init_early	= omap_init_early,
+	.init_irq	= gic_init_irq,
+	.init_machine	= omap4_init_machine,
+	.timer		= &omap4_timer,
+	.dt_compat	= omap4_boards_compat,
+MACHINE_END
-- 
1.7.0.4

