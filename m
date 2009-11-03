From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 5/8] omap: zoom3: introduce zoom3 board support
Date: Tue,  3 Nov 2009 15:20:12 -0600
Message-ID: <1257283215-6448-6-git-send-email-vikram.pandita@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-2-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-4-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-5-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51584 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbZKCVVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 16:21:12 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3LLHh9005202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 15:21:17 -0600
In-Reply-To: <1257283215-6448-5-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Vikram Pandita <vikram.pandtia@ti.com>

Zoom3 is the next versoin of Zoom2 board.
There has been a silicon update from zoom2 to zoom3.
	Zoom2 has OMAP34xx
	Zoom3 has OMAP3630
Zoom3 = OMAP3630 SOM board + same zoom2 main board + same debugboard

Zoom3 has a different SDRAM part from Hynix
Zoom2 had SDRAM part from micron

Reuse the zoom2 files as much for zoom3, as at board level,
there is no change at all.

Signed-off-by: Vikram Pandita <vikram.pandtia@ti.com>
---
 arch/arm/mach-omap2/Kconfig                        |    4 +
 arch/arm/mach-omap2/Makefile                       |    4 +
 arch/arm/mach-omap2/board-zoom3.c                  |   59 ++++++++++++++++++++
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   54 ++++++++++++++++++
 4 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 arch/arm/mach-omap2/board-zoom3.c
 create mode 100644 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8685df5..9824775 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -101,6 +101,10 @@ config MACH_CM_T35
 	bool "CompuLab CM-T35 module"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_ZOOM3
+	bool "OMAP3630 Zoom3 board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4d66b42..712e7fc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -75,6 +75,10 @@ obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+					   board-zoom-peripherals.o \
+					   mmc-twl4030.o \
+					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   mmc-twl4030.o
 
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
new file mode 100755
index 0000000..aebe7b8
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
+extern int __init omap_zoom2_debugboard_init(void);
+extern void __init zoom_peripherals_init(void);
+
+static void __init omap_zoom_init(void)
+{
+        zoom_peripherals_init();
+	omap_zoom2_debugboard_init();
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
index 0000000..c469c48
--- /dev/null
+++ b/arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h
@@ -0,0 +1,54 @@
+/*
+ * SDRC register values for the Hynix H8MBX00U0MER-0EM
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ * Copyright (C) 2008-2009 Nokia Corporation
+ *
+ * Nicole Chalhoub / Vincent Bour
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
+#define ARCH_ARM_MACH_OMAP2_SDRAM_HYNIX_H8MBX00U0MER0EM
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
-- 
1.6.5.1.69.g36942

