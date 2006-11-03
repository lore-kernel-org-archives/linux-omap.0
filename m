From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc4-omap 2/2] abstract debug card setup (smc, leds)
Date: Fri, 3 Nov 2006 11:47:08 -0800
Message-ID: <200611031147.08596.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Additional cleanup for debug boards on H2/P2/H3/H4:  move the init
code that's not board-specific into a new file where it can be easily
shared between all the different boards (avoiding code duplication,
and making it easier to support more devices).  Make H4 use that.

This should be easy to drop in to the OMAP1 boards using these debug
cards; the only difference seems to be that the p2 does an extra reset
of the smc using the fpga (probably all boards could do that, if it's
necessary) and doesn't use the gpio mux or request APIs.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/arch/arm/plat-omap/Kconfig
===================================================================
--- h4.orig/arch/arm/plat-omap/Kconfig	2006-11-03 11:28:23.000000000 -0800
+++ h4/arch/arm/plat-omap/Kconfig	2006-11-03 11:28:25.000000000 -0800
@@ -19,10 +19,15 @@ endchoice
 
 comment "OMAP Feature Selections"
 
-config OMAP_DEBUG_LEDS
+config OMAP_DEBUG_DEVICES
 	bool
 	help
-	  For debug card leds on TI reference boards.
+	  For debug cards on TI reference boards.
+
+config OMAP_DEBUG_LEDS
+	bool
+	depends on OMAP_DEBUG_DEVICES
+	default y if LEDS || LEDS_OMAP_DEBUG
 
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
Index: h4/arch/arm/mach-omap2/Kconfig
===================================================================
--- h4.orig/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:23.000000000 -0800
+++ h4/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:25.000000000 -0800
@@ -25,7 +25,7 @@ config MACH_OMAP2_TUSB6010
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
-	select OMAP_DEBUG_LEDS if LEDS || LEDS_OMAP_DEBUG
+	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
 
 config MACH_OMAP_H4_TUSB
Index: h4/include/asm-arm/arch-omap/board.h
===================================================================
--- h4.orig/include/asm-arm/arch-omap/board.h	2006-11-03 11:28:14.000000000 -0800
+++ h4/include/asm-arm/arch-omap/board.h	2006-11-03 11:28:25.000000000 -0800
@@ -179,4 +179,8 @@ extern const void *omap_get_var_config(u
 extern struct omap_board_config_kernel *omap_board_config;
 extern int omap_board_config_size;
 
+
+/* for TI reference platforms sharing the same debug card */
+extern int debug_card_init(u32 addr, unsigned gpio);
+
 #endif
Index: h4/arch/arm/plat-omap/Makefile
===================================================================
--- h4.orig/arch/arm/plat-omap/Makefile	2006-11-03 11:28:23.000000000 -0800
+++ h4/arch/arm/plat-omap/Makefile	2006-11-03 11:28:25.000000000 -0800
@@ -24,6 +24,7 @@ obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_BOOT_REASON) += bootreason.o
 obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
+obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 
 # DSP subsystem
Index: h4/arch/arm/plat-omap/debug-devices.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ h4/arch/arm/plat-omap/debug-devices.c	2006-11-03 11:28:25.000000000 -0800
@@ -0,0 +1,86 @@
+/*
+ * linux/arch/arm/plat-omap/debug-devices.c
+ *
+ * Copyright (C) 2005 Nokia Corporation
+ * Modified from mach-omap2/board-h4.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+
+#include <asm/arch/board.h>
+#include <asm/arch/gpio.h>
+
+
+/* Many OMAP development platforms reuse the same "debug board"; these
+ * platforms include H2, H3, H4, and Perseus2.
+ */
+
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct resource led_resources[] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device led_device = {
+	.name		= "omap_dbg_led",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(led_resources),
+	.resource	= led_resources,
+};
+
+static struct platform_device *debug_devices[] __initdata = {
+	&smc91x_device,
+	&led_device,
+	/* ps2 kbd + mouse ports */
+	/* 4 extra uarts */
+	/* 6 input dip switches */
+	/* 8 output pins */
+};
+
+int __init debug_card_init(u32 addr, unsigned gpio)
+{
+	int	status;
+
+	smc91x_resources[0].start = addr + 0x300;
+	smc91x_resources[0].end   = addr + 0x30f;
+
+	smc91x_resources[1].start = OMAP_GPIO_IRQ(gpio);
+	smc91x_resources[1].end   = OMAP_GPIO_IRQ(gpio);
+
+	status = omap_request_gpio(gpio);
+	if (status < 0) {
+		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
+		return status;
+	}
+	omap_set_gpio_direction(gpio, 1);
+
+	led_resources[0].start = addr;
+	led_resources[0].end   = addr + SZ_4K - 1;
+
+	return platform_add_devices(debug_devices, ARRAY_SIZE(debug_devices));
+}
Index: h4/arch/arm/mach-omap2/board-h4.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:23.000000000 -0800
+++ h4/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:25.000000000 -0800
@@ -136,24 +136,6 @@ static struct platform_device h4_flash_d
 	.resource	= &h4_flash_resource,
 };
 
-static struct resource h4_smc91x_resources[] = {
-	[0] = {
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
-		.end    = OMAP_GPIO_IRQ(OMAP24XX_ETHR_GPIO_IRQ),
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device h4_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(h4_smc91x_resources),
-	.resource	= h4_smc91x_resources,
-};
-
 /* Select between the IrDA and aGPS module
  */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
@@ -271,26 +253,11 @@ static struct platform_device h4_lcd_dev
 	.id		= -1,
 };
 
-static struct resource h4_led_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device h4_led_device = {
-	.name		= "omap_dbg_led",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(h4_led_resources),
-	.resource	= h4_led_resources,
-};
-
 static struct platform_device *h4_devices[] __initdata = {
-	&h4_smc91x_device,
 	&h4_flash_device,
 	&h4_irda_device,
 	&h4_kp_device,
 	&h4_lcd_device,
-	&h4_led_device,
 };
 
 /* 2420 Sysboot setup (2430 is different) */
@@ -318,7 +285,7 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
 
-static inline void __init h4_init_smc91x(void)
+static inline void __init h4_init_debug(void)
 {
 	int eth_cs;
 	unsigned long cs_mem_base;
@@ -367,23 +334,11 @@ static inline void __init h4_init_smc91x
 		return;
 	}
 
-	h4_led_resources[0].start = cs_mem_base;
-	h4_led_resources[0].end   = cs_mem_base + SZ_4K - 1;
-
-	h4_smc91x_resources[0].start = cs_mem_base + 0x300;
-	h4_smc91x_resources[0].end   = cs_mem_base + 0x30f;
-
 	udelay(100);
 
 	omap_cfg_reg(M15_24XX_GPIO92);
-	if (omap_request_gpio(OMAP24XX_ETHR_GPIO_IRQ) < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			OMAP24XX_ETHR_GPIO_IRQ);
+	if (debug_card_init(cs_mem_base, OMAP24XX_ETHR_GPIO_IRQ) < 0)
 		gpmc_cs_free(eth_cs);
-		return;
-	}
-	omap_set_gpio_direction(OMAP24XX_ETHR_GPIO_IRQ, 1);
-
 }
 
 static void __init h4_init_flash(void)
@@ -403,7 +358,6 @@ static void __init omap_h4_init_irq(void
 	omap2_init_common_hw();
 	omap_init_irq();
 	omap_gpio_init();
-	h4_init_smc91x();
 	h4_init_flash();
 }
 
@@ -522,6 +476,9 @@ static void __init omap_h4_init(void)
 	omap_board_config_size = ARRAY_SIZE(h4_config);
 	omap_serial_init();
 
+	/* smc91x, debug leds, ps/2, extra uarts */
+	h4_init_debug();
+
 #ifdef	CONFIG_MACH_OMAP_H4_TUSB
 	tusb_evm_setup();
 #endif
