From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 6/6] OMAP3: Add board specific file for OMAP3517EVM
Date: Thu,  6 Aug 2009 16:06:34 +0530
Message-ID: <1249554994-20499-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47027 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbZHFKgk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:40 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AaZla027088
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Created a minimal board file with placeholders for
the OMAP3517 EVM. It will help in getting a minimal
kernel image running on the EVM.

More board specific updates will follow in subsequent
patches.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-omap3517evm.c |  127 +++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3517evm.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8d0c9ba..18e15fc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-omap3517evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
diff --git a/arch/arm/mach-omap2/board-omap3517evm.c b/arch/arm/mach-omap2/board-omap3517evm.c
new file mode 100644
index 0000000..c64255e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap3517evm.c
@@ -0,0 +1,127 @@
+/*
+ * linux/arch/arm/mach-omap2/board-omap3517evm.c
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated
+ *
+ * Based on mach-omap2/board-omap3evm.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as  published by the
+ * Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/input.h>
+#include <linux/leds.h>
+
+#include <linux/spi/spi.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/gpio.h>
+#include <mach/board.h>
+#include <mach/mux.h>
+#include <mach/usb.h>
+#include <mach/common.h>
+#include <mach/mcspi.h>
+
+
+/*
+ * UART
+ */
+static struct omap_uart_config omap3517_evm_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+/*
+ * Ethernet
+ */
+static int __init omap3517_evm_ethernet_init (void)
+{
+
+	return 0 ;
+}
+
+/*
+ * I2C
+ */
+static int __init omap3517_evm_i2c_init(void)
+{
+	return 0;
+}
+
+/*
+ * Power Management IC
+ */
+
+/*
+ * MTD
+ */
+
+/*
+ * SPI
+ */
+
+/*
+ * MTD
+ */
+
+/*
+ * Board initialization
+ */
+static struct omap_board_config_kernel omap3517_evm_config[] __initdata = {
+	{ OMAP_TAG_UART,	&omap3517_evm_uart_config },
+};
+
+static struct platform_device *omap3517_evm_devices[] __initdata = {
+};
+
+static void __init omap3517_evm_init_irq(void)
+{
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init omap3517_evm_init(void)
+{
+	omap3517_evm_i2c_init();
+
+	platform_add_devices(omap3517_evm_devices,
+				ARRAY_SIZE(omap3517_evm_devices));
+
+	omap_board_config = omap3517_evm_config;
+	omap_board_config_size = ARRAY_SIZE(omap3517_evm_config);
+
+	omap_serial_init();
+	omap3517_evm_ethernet_init();
+}
+
+static void __init omap3517_evm_map_io(void)
+{
+	omap2_set_globals_35xx();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP3517EVM, "OMAP3517 EVM")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3517_evm_map_io,
+	.init_irq	= omap3517_evm_init_irq,
+	.init_machine	= omap3517_evm_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.6.2.2

