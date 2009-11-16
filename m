From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] omap3: zoom: Introduce zoom3 board support
Date: Mon, 16 Nov 2009 15:37:38 -0800
Message-ID: <20091116233738.GU3684@atomide.com>
References: <20091116232435.24892.81547.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64110 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbZKPXhh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 18:37:37 -0500
Content-Disposition: inline
In-Reply-To: <20091116232435.24892.81547.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: vikram pandita <vikram.pandita@ti.com>
Date: Fri, 13 Nov 2009 17:37:34 -0800
Subject: [PATCH 12/12] omap3: zoom: Introduce zoom3 board support

Zoom3 is the next version of Zoom2 board.
There has been a silicon update from zoom2 to zoom3.
        Zoom2 has OMAP34xx
        Zoom3 has OMAP3630 [1]
Zoom3 = OMAP3630 SOM board [2] + same zoom2 main board [3] + same debugboard

Zoom3 has a SDRAM part from Hynix
Zoom2 had SDRAM part from micron

Hynix memory timings are contributed by:
Chalhoub, Nicole and Bour, Vincent

Reuse the zoom2 files as much for zoom3, as at board level,
there is no change at all.

References: (courtesy Nishant Menon)
[1] OMAP3630
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12836&contentId=52606

[2] SOM boards
http://logicpd.com/products/system-modules/texas-instruments-omap35x-som-lv

[3] Zoom2 boards
http://logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp
OMAP3630:

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Cc: Nicole Chalhoub <n-chalhoub@ti.com>
Cc: Vincent Bour <v-bour@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index aad194f..0d14dde 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -97,6 +97,10 @@ config MACH_OMAP_ZOOM2
 	bool "OMAP3 Zoom2 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_ZOOM3
+	bool "OMAP3630 Zoom3 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8ac121e..f40619e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -78,6 +78,10 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+					   board-zoom-peripherals.o \
+					   mmc-twl4030.o \
+					   board-zoom-debugboard.o
 
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
new file mode 100644
index 0000000..8d965a6
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2009 Texas Instruments Inc.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/board-zoom.h>
+
+#include <plat/common.h>
+#include <plat/board.h>
+
+#include "sdram-hynix-h8mbx00u0mer-0em.h"
+
+static void __init omap_zoom_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+static struct omap_board_config_kernel zoom_config[] __initdata = {
+};
+
+static void __init omap_zoom_init_irq(void)
+{
+	omap_board_config = zoom_config;
+	omap_board_config_size = ARRAY_SIZE(zoom_config);
+	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
+			h8mbx00u0mer0em_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init omap_zoom_init(void)
+{
+	zoom_peripherals_init();
+	zoom_debugboard_init();
+}
+
+MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_zoom_map_io,
+	.init_irq	= omap_zoom_init_irq,
+	.init_machine	= omap_zoom_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
new file mode 100644
index 0000000..8bfaf34
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
@@ -0,0 +1,51 @@
+/*
+ * SDRC register values for the Hynix H8MBX00U0MER-0EM
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
+#define __ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
+
+#include <plat/sdrc.h>
+
+/* Hynix H8MBX00U0MER-0EM */
+static struct omap_sdrc_params h8mbx00u0mer0em_sdrc_params[] = {
+	[0] = {
+		.rate        = 200000000,
+		.actim_ctrla = 0xa2e1b4c6,
+		.actim_ctrlb = 0x0002131c,
+		.rfr_ctrl    = 0x0005e601,
+		.mr          = 0x00000032,
+	},
+	[1] = {
+		.rate        = 166000000,
+		.actim_ctrla = 0x629db4c6,
+		.actim_ctrlb = 0x00012214,
+		.rfr_ctrl    = 0x0004dc01,
+		.mr          = 0x00000032,
+	},
+	[2] = {
+		.rate        = 100000000,
+		.actim_ctrla = 0x51912284,
+		.actim_ctrlb = 0x0002120e,
+		.rfr_ctrl    = 0x0002d101,
+		.mr          = 0x00000022,
+	},
+	[3] = {
+		.rate        = 83000000,
+		.actim_ctrla = 0x31512283,
+		.actim_ctrlb = 0x0001220a,
+		.rfr_ctrl    = 0x00025501,
+		.mr          = 0x00000022,
+	},
+	[4] = {
+		.rate        = 0
+	},
+};
+
+#endif
