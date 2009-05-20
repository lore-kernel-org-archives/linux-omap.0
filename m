From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/4] ARM: OMAP4: Add support for 4430 SDP
Date: Wed, 20 May 2009 18:29:02 +0530
Message-ID: <1242824343-5956-3-git-send-email-santosh.shilimkar@ti.com>
References: <1242824343-5956-1-git-send-email-santosh.shilimkar@ti.com>
 <1242824343-5956-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33811 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZETM70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 08:59:26 -0400
In-Reply-To: <1242824343-5956-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the Makefile and Kconfig entries for OMAP4. The OMAP4430 SDP
board file supports only minimal set of drivers.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Makefile                   |    1 +
 arch/arm/mach-omap2/Kconfig         |    6 ++-
 arch/arm/mach-omap2/Makefile        |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c |   94 +++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig          |   11 +++-
 5 files changed, 109 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-4430sdp.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e84729b..676d10d 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -127,6 +127,7 @@ endif
  machine-$(CONFIG_ARCH_OMAP1)	   := omap1
  machine-$(CONFIG_ARCH_OMAP2)	   := omap2
  machine-$(CONFIG_ARCH_OMAP3)	   := omap2
+ machine-$(CONFIG_ARCH_OMAP4)	   := omap2
     plat-$(CONFIG_ARCH_OMAP)	   := omap
  machine-$(CONFIG_ARCH_S3C2410)	   := s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c2443
  machine-$(CONFIG_ARCH_S3C24A0)	   := s3c24a0
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 64ab386..81bbc1e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -25,7 +25,7 @@ config ARCH_OMAP3430
 	select ARCH_OMAP_OTG
 
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
 
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
@@ -67,3 +67,7 @@ config MACH_OMAP_3430SDP
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
+config MACH_OMAP_4430SDP
+	bool "OMAP 4430 SDP board"
+	depends on ARCH_OMAP4
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bf3827a..a51d811 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -53,7 +53,7 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
 # Platform specific device init code
 ifeq ($(CONFIG_USB_MUSB_SOC),y)
 obj-y					+= usb-musb.o
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
new file mode 100644
index 0000000..57e477b
--- /dev/null
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -0,0 +1,94 @@
+/*
+ * Board support file for OMAP4430 SDP.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ *
+ * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Based on mach-omap2/board-3430sdp.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/control.h>
+#include <mach/timer-gp.h>
+#include <asm/hardware/gic.h>
+
+static struct platform_device sdp4430_lcd_device = {
+	.name		= "sdp4430_lcd",
+	.id		= -1,
+};
+
+static struct platform_device *sdp4430_devices[] __initdata = {
+	&sdp4430_lcd_device,
+};
+
+static struct omap_uart_config sdp4430_uart_config __initdata = {
+	.enabled_uarts	= (1 << 0) | (1 << 1) | (1 << 2),
+};
+
+static struct omap_lcd_config sdp4430_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel sdp4430_config[] __initdata = {
+	{ OMAP_TAG_UART,	&sdp4430_uart_config },
+	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
+};
+
+static void __init gic_init_irq(void)
+{
+	gic_dist_init(0, IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+}
+
+static void __init omap_4430sdp_init_irq(void)
+{
+	omap2_init_common_hw(NULL);
+#ifdef CONFIG_OMAP_32K_TIMER
+	omap2_gp_clockevent_set_gptimer(1);
+#endif
+	gic_init_irq();
+	omap_gpio_init();
+}
+
+
+static void __init omap_4430sdp_init(void)
+{
+	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
+	omap_board_config = sdp4430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
+	omap_serial_init();
+}
+
+static void __init omap_4430sdp_map_io(void)
+{
+	omap2_set_globals_443x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP_4430SDP, "OMAP4430 4430SDP board")
+	/* Maintainer: Santosh Shilimkar - Texas Instruments Inc */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap_4430sdp_map_io,
+	.init_irq	= omap_4430sdp_init_irq,
+	.init_machine	= omap_4430sdp_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 9dd68fa..89499e6 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -23,6 +23,11 @@ config ARCH_OMAP3
 	select CPU_V7
 	select COMMON_CLKDEV
 
+config ARCH_OMAP4
+	bool "TI OMAP4"
+	select CPU_V7
+	select ARM_GIC
+
 endchoice
 
 comment "OMAP Feature Selections"
@@ -128,13 +133,13 @@ config OMAP_MPU_TIMER
 
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX, 24XX and 34XX.
+	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4.
 
 endchoice
 
@@ -149,7 +154,7 @@ config OMAP_32K_TIMER_HZ
 
 config OMAP_DM_TIMER
 	bool "Use dual-mode timer"
-	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX
+	depends on ARCH_OMAP16XX || ARCH_OMAP24XX || ARCH_OMAP34XX || ARCH_OMAP4
 	help
 	 Select this option if you want to use OMAP Dual-Mode timers.
 
-- 
1.5.4.7

