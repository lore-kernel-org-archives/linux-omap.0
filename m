From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 7/8] omap: 3630sdp: introduce 3630 sdp board support
Date: Tue,  3 Nov 2009 15:20:14 -0600
Message-ID: <1257283215-6448-8-git-send-email-vikram.pandita@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-2-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-4-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-5-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-6-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-7-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37878 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbZKCVVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Nov 2009 16:21:13 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3LLHZq028943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 15:21:18 -0600
In-Reply-To: <1257283215-6448-7-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Add 3630SDP board support

The board shares the same peripherals as a zoom2 main.
So reuse the peripheral file of zoom platform.

The RAM part is Hynix memory as as in zoom3.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/Kconfig         |    4 ++
 arch/arm/mach-omap2/Makefile        |    3 +
 arch/arm/mach-omap2/board-3630sdp.c |   96 +++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100755 arch/arm/mach-omap2/board-3630sdp.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 9824775..83551a8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,6 +105,10 @@ config MACH_OMAP_ZOOM3
 	bool "OMAP3630 Zoom3 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OMAP_3630SDP
+	bool "OMAP3630 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 712e7fc..90cf2cc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -79,6 +79,9 @@ obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
 					   mmc-twl4030.o \
 					   board-zoom-debugboard.o
+obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
+					   board-zoom-peripherals.o \
+					   mmc-twl4030.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
 					   mmc-twl4030.o
 
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
new file mode 100755
index 0000000..450fcdd
--- /dev/null
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2009 Texas Instruments Inc.
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
+#include <plat/gpmc-smc91x.h>
+#include <plat/mux.h>
+#include <plat/usb.h>
+
+#include "sdram-hynix-h8mbx00u0mer-0em.h"
+
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
+static struct omap_smc91x_platform_data board_smc91x_data = {
+	.cs             = 3,
+	.flags          = GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
+};
+
+static void __init board_smc91x_init(void)
+{
+	board_smc91x_data.gpio_irq = 158;
+	gpmc_smc91x_init(&board_smc91x_data);
+}
+#else
+static inline void board_smc91x_init(void)
+{
+}
+#endif
+
+static void enable_board_wakeup_source(void)
+{
+	omap_cfg_reg(AF26_34XX_SYS_NIRQ); /* T2 interrupt line (keypad) */
+}
+
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = 126,
+	.reset_gpio_port[1]  = 61,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static void __init omap_sdp_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+static struct omap_board_config_kernel sdp_config[] __initdata = {
+};
+static void __init omap_sdp_init_irq(void)
+{
+	omap_board_config = sdp_config;
+	omap_board_config_size = ARRAY_SIZE(sdp_config);
+	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
+			h8mbx00u0mer0em_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+extern void __init zoom_peripherals_init(void);
+
+static void __init omap_sdp_init(void)
+{
+        zoom_peripherals_init();
+	board_smc91x_init();
+	enable_board_wakeup_source();
+	usb_ehci_init(&ehci_pdata);
+}
+
+MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_sdp_map_io,
+	.init_irq	= omap_sdp_init_irq,
+	.init_machine	= omap_sdp_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.5.1.69.g36942

