From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH v2] OMAP2: add board file for Nokia N800 and N810
Date: Sat, 15 Aug 2009 10:44:18 +0300
Message-ID: <20090815074418.18931.45131.stgit@tikku>
References: <87ocqhzfux.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:59349 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZHOHoX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 03:44:23 -0400
In-Reply-To: <87ocqhzfux.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Add board file for Nokia N800 and N810 devices. Currently only serial ports,
onenand, spi and usb are configured, more to come later.

Tested on Nokia N800.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
---

 arch/arm/mach-omap2/Kconfig      |    4 +
 arch/arm/mach-omap2/Makefile     |    2 
 arch/arm/mach-omap2/board-n8x0.c |  155 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bf54686..75b1c7e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,10 @@ config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_NOKIA_N8X0
+	bool "Nokia N800/N810"
+	depends on ARCH_OMAP2420
+
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 757c84b..8850a24 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
new file mode 100644
index 0000000..813b57d
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -0,0 +1,155 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n8x0.c
+ *
+ * Copyright (C) 2005-2009 Nokia Corporation
+ * Author: Juha Yrjola <juha.yrjola@nokia.com>
+ *
+ * Modified from mach-omap2/board-generic.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/stddef.h>
+#include <linux/spi/spi.h>
+#include <linux/usb/musb.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/mcspi.h>
+#include <mach/onenand.h>
+#include <mach/serial.h>
+
+static struct omap2_mcspi_device_config p54spi_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel = 1,
+};
+
+static struct spi_board_info n800_spi_board_info[] __initdata = {
+	{
+		.modalias	= "p54spi",
+		.bus_num	= 2,
+		.chip_select	= 0,
+		.max_speed_hz   = 48000000,
+		.controller_data = &p54spi_mcspi_config,
+	},
+};
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name           = "bootloader",
+		.offset         = 0,
+		.size           = 0x20000,
+		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
+	},
+	{
+		.name           = "config",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x60000,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "initfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x400000,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 0,
+	.gpio_irq	= 26,
+	.parts		= onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READ,
+};
+
+static void __init n8x0_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static void __init n8x0_onenand_init(void) {}
+
+#endif
+
+/* FIXME: n810 needs UART1 */
+static struct omap_uart_platform_data n8x0_uart_config __initdata = {
+	.enabled_uarts = (1 << 2),
+};
+
+static void __init n8x0_map_io(void)
+{
+	omap2_set_globals_242x();
+	omap2_map_common_io();
+}
+
+static void __init n8x0_init_irq(void)
+{
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init n8x0_init_machine(void)
+{
+	/* FIXME: add n810 spi devices */
+	spi_register_board_info(n800_spi_board_info,
+				ARRAY_SIZE(n800_spi_board_info));
+
+	omap_serial_init(&n8x0_uart_config);
+	n8x0_onenand_init();
+}
+
+MACHINE_START(NOKIA_N800, "Nokia N800")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END
+
+MACHINE_START(NOKIA_N810, "Nokia N810")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END
+
+MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END

