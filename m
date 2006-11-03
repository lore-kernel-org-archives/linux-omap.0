From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc4-omap 1/2] h4 must have blinky leds!!
Date: Fri, 3 Nov 2006 11:35:35 -0800
Message-ID: <200611031135.35487.david-b@pacbell.net>
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

This adds generic support for the "debug board" LEDs used by most of
TI's OMAP reference boards, and board-specific support for the H4.

It's derived from the not-as-generic stuff used by OMAP1 H2/H3/P2.
Those should be able to switch easily to this version, and clean up
some of the omap1-specific code.

In addition to H4 support, one key improvement is supporting not just
the "old" ARM debug LED API (with timer and idle LEDs, plus four that
can be handy for kernel debugging), but it also supports the "new"
generic LED API (most useful for usermode stuff IMO).  Either or both
APIs can be enabled.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: h4/arch/arm/plat-omap/Kconfig
===================================================================
--- h4.orig/arch/arm/plat-omap/Kconfig	2006-11-03 11:28:19.000000000 -0800
+++ h4/arch/arm/plat-omap/Kconfig	2006-11-03 11:28:23.000000000 -0800
@@ -19,6 +19,11 @@ endchoice
 
 comment "OMAP Feature Selections"
 
+config OMAP_DEBUG_LEDS
+	bool
+	help
+	  For debug card leds on TI reference boards.
+
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
 	depends on ARCH_OMAP
Index: h4/drivers/leds/Kconfig
===================================================================
--- h4.orig/drivers/leds/Kconfig	2006-11-03 11:28:19.000000000 -0800
+++ h4/drivers/leds/Kconfig	2006-11-03 11:28:23.000000000 -0800
@@ -76,6 +76,14 @@ config LEDS_NET48XX
 	  This option enables support for the Soekris net4801 and net4826 error
 	  LED.
 
+config LEDS_OMAP_DEBUG
+	boolean "LED Support for OMAP debug board LEDs"
+	depends LEDS_CLASS=y && ARCH_OMAP
+	help
+	  Enables support for the LEDs on the debug board used with OMAP
+	  reference boards like H2/H3/H4 and Perseus2.  Up to six of these
+	  may be claimed by the original ARM debug LED API.
+
 config LEDS_OMAP
 	tristate "LED Support for OMAP GPIO LEDs"
 	depends LEDS_CLASS && ARCH_OMAP
Index: h4/arch/arm/mach-omap2/Kconfig
===================================================================
--- h4.orig/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:19.000000000 -0800
+++ h4/arch/arm/mach-omap2/Kconfig	2006-11-03 11:28:23.000000000 -0800
@@ -25,6 +25,7 @@ config MACH_OMAP2_TUSB6010
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
 	depends on ARCH_OMAP2 && ARCH_OMAP24XX
+	select OMAP_DEBUG_LEDS if LEDS || LEDS_OMAP_DEBUG
 	select GPIOEXPANDER_OMAP
 
 config MACH_OMAP_H4_TUSB
Index: h4/arch/arm/mach-omap2/board-h4.c
===================================================================
--- h4.orig/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:19.000000000 -0800
+++ h4/arch/arm/mach-omap2/board-h4.c	2006-11-03 11:28:23.000000000 -0800
@@ -271,12 +271,26 @@ static struct platform_device h4_lcd_dev
 	.id		= -1,
 };
 
+static struct resource h4_led_resources[] = {
+	[0] = {
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device h4_led_device = {
+	.name		= "omap_dbg_led",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(h4_led_resources),
+	.resource	= h4_led_resources,
+};
+
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_smc91x_device,
 	&h4_flash_device,
 	&h4_irda_device,
 	&h4_kp_device,
 	&h4_lcd_device,
+	&h4_led_device,
 };
 
 /* 2420 Sysboot setup (2430 is different) */
@@ -352,8 +366,13 @@ static inline void __init h4_init_smc91x
 		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
 		return;
 	}
+
+	h4_led_resources[0].start = cs_mem_base;
+	h4_led_resources[0].end   = cs_mem_base + SZ_4K - 1;
+
 	h4_smc91x_resources[0].start = cs_mem_base + 0x300;
 	h4_smc91x_resources[0].end   = cs_mem_base + 0x30f;
+
 	udelay(100);
 
 	omap_cfg_reg(M15_24XX_GPIO92);
Index: h4/arch/arm/plat-omap/Makefile
===================================================================
--- h4.orig/arch/arm/plat-omap/Makefile	2006-11-03 11:28:19.000000000 -0800
+++ h4/arch/arm/plat-omap/Makefile	2006-11-03 11:28:23.000000000 -0800
@@ -24,6 +24,7 @@ obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_BOOT_REASON) += bootreason.o
 obj-$(CONFIG_OMAP_COMPONENT_VERSION) += component-version.o
 obj-$(CONFIG_OMAP_GPIO_SWITCH) += gpio-switch.o
+obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 
 # DSP subsystem
 obj-y += dsp/
Index: h4/arch/arm/plat-omap/debug-leds.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ h4/arch/arm/plat-omap/debug-leds.c	2006-11-03 11:28:23.000000000 -0800
@@ -0,0 +1,319 @@
+/*
+ * linux/arch/arm/plat-omap/debug-leds.c
+ *
+ * Copyright 2003 by Texas Instruments Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+
+#include <asm/io.h>
+#include <asm/hardware.h>
+#include <asm/leds.h>
+#include <asm/system.h>
+#include <asm/mach-types.h>
+
+#include <asm/arch/fpga.h>
+#include <asm/arch/gpio.h>
+
+
+/* Many OMAP development platforms reuse the same "debug board"; these
+ * platforms include H2, H3, H4, and Perseus2.  There are 16 LEDs on the
+ * debug board (all green), accessed through FPGA registers.
+ *
+ * The "surfer" expansion board and H2 sample board also have two-color
+ * green+red LEDs (in parallel), used here for timer and idle indicators
+ * in preference to the ones on the debug board, for a "Disco LED" effect.
+ *
+ * This driver exports either the original ARM LED API, the new generic
+ * one, or both.
+ */
+
+static spinlock_t			lock;
+static struct h2p2_dbg_fpga __iomem	*fpga;
+static u16				led_state, hw_led_state;
+
+
+#ifdef	CONFIG_LEDS
+#define old_led_api()	1
+#else
+#define old_led_api()	0
+#endif
+
+#ifdef	CONFIG_LEDS_OMAP_DEBUG
+#define new_led_api()	1
+#else
+#define new_led_api()	0
+#endif
+
+
+/*-------------------------------------------------------------------------*/
+
+/* original ARM debug LED API:
+ *  - timer and idle leds (some boards use non-FPGA leds here);
+ *  - up to 4 generic leds, easily accessed in-kernel (any context)
+ */
+
+#define GPIO_LED_RED		3
+#define GPIO_LED_GREEN		OMAP_MPUIO(4)
+
+#define LED_STATE_ENABLED	0x01
+#define LED_STATE_CLAIMED	0x02
+#define LED_TIMER_ON		0x04
+
+#define GPIO_IDLE		GPIO_LED_GREEN
+#define GPIO_TIMER		GPIO_LED_RED
+
+static void h2p2_dbg_leds_event(led_event_t evt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+
+	if (!(led_state & LED_STATE_ENABLED) && evt != led_start)
+		goto done;
+
+	switch (evt) {
+	case led_start:
+		if (fpga)
+			led_state |= LED_STATE_ENABLED;
+		break;
+
+	case led_stop:
+	case led_halted:
+		/* all leds off during suspend or shutdown */
+
+		if (!(machine_is_omap_perseus2() || machine_is_omap_h4())) {
+			omap_set_gpio_dataout(GPIO_TIMER, 0);
+			omap_set_gpio_dataout(GPIO_IDLE, 0);
+		}
+
+		__raw_writew(~0, &fpga->leds);
+		led_state &= ~LED_STATE_ENABLED;
+		goto done;
+
+	case led_claim:
+		led_state |= LED_STATE_CLAIMED;
+		hw_led_state = 0;
+		break;
+
+	case led_release:
+		led_state &= ~LED_STATE_CLAIMED;
+		break;
+
+#ifdef CONFIG_LEDS_TIMER
+	case led_timer:
+		led_state ^= LED_TIMER_ON;
+
+		if (machine_is_omap_perseus2() || machine_is_omap_h4())
+			hw_led_state ^= H2P2_DBG_FPGA_P2_LED_TIMER;
+		else {
+			omap_set_gpio_dataout(GPIO_TIMER,
+					led_state & LED_TIMER_ON);
+			goto done;
+		}
+
+		break;
+#endif
+
+#ifdef CONFIG_LEDS_CPU
+	/* LED lit iff busy */
+	case led_idle_start:
+		if (machine_is_omap_perseus2() || machine_is_omap_h4())
+			hw_led_state &= ~H2P2_DBG_FPGA_P2_LED_IDLE;
+		else {
+			omap_set_gpio_dataout(GPIO_IDLE, 1);
+			goto done;
+		}
+
+		break;
+
+	case led_idle_end:
+		if (machine_is_omap_perseus2() || machine_is_omap_h4())
+			hw_led_state |= H2P2_DBG_FPGA_P2_LED_IDLE;
+		else {
+			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			goto done;
+		}
+
+		break;
+#endif
+
+	case led_green_on:
+		hw_led_state |= H2P2_DBG_FPGA_LED_GREEN;
+		break;
+	case led_green_off:
+		hw_led_state &= ~H2P2_DBG_FPGA_LED_GREEN;
+		break;
+
+	case led_amber_on:
+		hw_led_state |= H2P2_DBG_FPGA_LED_AMBER;
+		break;
+	case led_amber_off:
+		hw_led_state &= ~H2P2_DBG_FPGA_LED_AMBER;
+		break;
+
+	case led_red_on:
+		hw_led_state |= H2P2_DBG_FPGA_LED_RED;
+		break;
+	case led_red_off:
+		hw_led_state &= ~H2P2_DBG_FPGA_LED_RED;
+		break;
+
+	case led_blue_on:
+		hw_led_state |= H2P2_DBG_FPGA_LED_BLUE;
+		break;
+	case led_blue_off:
+		hw_led_state &= ~H2P2_DBG_FPGA_LED_BLUE;
+		break;
+
+	default:
+		break;
+	}
+
+
+	/*
+	 *  Actually burn the LEDs
+	 */
+	if (led_state & LED_STATE_ENABLED)
+		__raw_writew(~hw_led_state, &fpga->leds);
+
+done:
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+/*-------------------------------------------------------------------------*/
+
+/* "new" LED API
+ *  - with syfs access and generic triggering
+ *  - not readily accessible to in-kernel drivers
+ */
+
+struct dbg_led {
+	struct led_classdev	cdev;
+	u16			mask;
+};
+
+static struct dbg_led dbg_leds[] = {
+	/* REVISIT at least H2 uses different timer & cpu leds... */
+#ifndef CONFIG_LEDS_TIMER
+	{ .mask = 1 << 0,  .cdev.name =  "d4:green", },		/* timer */
+#endif
+#ifndef CONFIG_LEDS_CPU
+	{ .mask = 1 << 1,  .cdev.name =  "d5:green", },		/* !idle */
+#endif
+	{ .mask = 1 << 2,  .cdev.name =  "d6:green", },
+	{ .mask = 1 << 3,  .cdev.name =  "d7:green", },
+
+	{ .mask = 1 << 4,  .cdev.name =  "d8:green", },
+	{ .mask = 1 << 5,  .cdev.name =  "d9:green", },
+	{ .mask = 1 << 6,  .cdev.name = "d10:green", },
+	{ .mask = 1 << 7,  .cdev.name = "d11:green", },
+
+	{ .mask = 1 << 8,  .cdev.name = "d12:green", },
+	{ .mask = 1 << 9,  .cdev.name = "d13:green", },
+	{ .mask = 1 << 10, .cdev.name = "d14:green", },
+	{ .mask = 1 << 11, .cdev.name = "d15:green", },
+
+#ifndef	CONFIG_LEDS
+	{ .mask = 1 << 12, .cdev.name = "d16:green", },
+	{ .mask = 1 << 13, .cdev.name = "d17:green", },
+	{ .mask = 1 << 14, .cdev.name = "d18:green", },
+	{ .mask = 1 << 15, .cdev.name = "d19:green", },
+#endif
+};
+
+static void
+fpga_led_set(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct dbg_led	*led = container_of(cdev, struct dbg_led, cdev);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&lock, flags);
+	if (value == LED_OFF)
+		hw_led_state &= ~led->mask;
+	else
+		hw_led_state |= led->mask;
+	__raw_writew(~hw_led_state, &fpga->leds);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static void __init newled_init(struct device *dev)
+{
+	unsigned	i;
+	struct dbg_led	*led;
+	int		status;
+
+	for (i = 0, led = dbg_leds; i < ARRAY_SIZE(dbg_leds); i++, led++) {
+		led->cdev.brightness_set = fpga_led_set;
+		status = led_classdev_register(dev, &led->cdev);
+		if (status < 0)
+			break;
+	}
+	return;
+}
+
+
+/*-------------------------------------------------------------------------*/
+
+static int /* __init */ fpga_probe(struct platform_device *pdev)
+{
+	struct resource	*iomem;
+
+	spin_lock_init(&lock);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iomem)
+		return -ENODEV;
+
+	fpga = ioremap(iomem->start, H2P2_DBG_FPGA_SIZE);
+	__raw_writew(~0, &fpga->leds);
+
+	if (old_led_api()) {
+		leds_event = h2p2_dbg_leds_event;
+		leds_event(led_start);
+	}
+
+	if (new_led_api()) {
+		newled_init(&pdev->dev);
+	}
+
+	return 0;
+}
+
+static int fpga_suspend_late(struct platform_device *pdev, pm_message_t mesg)
+{
+	__raw_writew(~0, &fpga->leds);
+	return 0;
+}
+
+static int fpga_resume_early(struct platform_device *pdev)
+{
+	__raw_writew(~hw_led_state, &fpga->leds);
+	return 0;
+}
+
+
+static struct platform_driver led_driver = {
+	.driver.name	= "omap_dbg_led",
+	.probe		= fpga_probe,
+	.suspend_late	= fpga_suspend_late,
+	.resume_early	= fpga_resume_early,
+};
+
+static int __init fpga_init(void)
+{
+	if (machine_is_omap_h4()
+			|| machine_is_omap_h3()
+			|| machine_is_omap_h2()
+			|| machine_is_omap_perseus2()
+			)
+		return platform_driver_register(&led_driver);
+	return 0;
+}
+fs_initcall(fpga_init);
