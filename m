From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 12/23] move twl4030-gpio to drivers/gpio
Date: Tue, 30 Sep 2008 13:05:49 +0300
Message-ID: <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-6-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-7-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-8-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-9-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-10-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35010 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbYI3KHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:07:00 -0400
In-Reply-To: <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Move the twl4030 GPIO support from drivers/i2c/chips to drivers/gpio,
which is a more appropriate home for this code.

The Kconfig symbol name is changed to match the GPIO_* convention for
such symbols, so config files must change in the obvious ways (Kconfig
will prompt you).  There's now some helptext.

It can now be compiled as a module, should anyone really want to
do that; that'll be mostly useful for test builds.  Sanity check the
IRQ range we're given.

Initialization order needed a bit of work too:  core add_children()
called only after IRQs get set up, gpio uses subsys_initcall.  This
depends on a patch making i2c driver model init use postcore_initcall.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/mach/irqs.h     |    2 +-
 drivers/gpio/Kconfig                       |    7 +++++
 drivers/gpio/Makefile                      |    1 +
 drivers/{i2c/chips => gpio}/twl4030-gpio.c |   37 +++++++++++++++++++++++----
 drivers/i2c/chips/Kconfig                  |    4 ---
 drivers/i2c/chips/Makefile                 |    1 -
 drivers/i2c/chips/twl4030-core.c           |   12 +++------
 7 files changed, 44 insertions(+), 20 deletions(-)
 rename drivers/{i2c/chips => gpio}/twl4030-gpio.c (96%)

diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 29c92c9..8a4473e 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -369,7 +369,7 @@
 
 /* External TWL4030 gpio interrupts are optional */
 #define TWL4030_GPIO_IRQ_BASE	TWL4030_PWR_IRQ_END
-#ifdef	CONFIG_TWL4030_GPIO
+#ifdef	CONFIG_GPIO_TWL4030
 #define TWL4030_GPIO_NR_IRQS	18
 #else
 #define	TWL4030_GPIO_NR_IRQS	0
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index dbd42d6..293b4a7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -127,6 +127,13 @@ config GPIO_PCF857X
 	  This driver provides an in-kernel interface to those GPIOs using
 	  platform-neutral GPIO calls.
 
+config GPIO_TWL4030
+	tristate "TWL4030/TPS659x0 GPIO Driver"
+	depends on TWL4030_CORE && GPIOLIB
+	help
+	  Say yes here to access the GPIO signals of various multi-function
+	  power management chips from Texas Instruments.
+
 comment "PCI GPIO expanders:"
 
 config GPIO_BT8XX
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 01b4bbd..6aafdeb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_GPIO_MAX732X)	+= max732x.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
+obj-$(CONFIG_GPIO_TWL4030)	+= twl4030-gpio.o
 obj-$(CONFIG_GPIO_BT8XX)	+= bt8xxgpio.o
diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
similarity index 96%
rename from drivers/i2c/chips/twl4030-gpio.c
rename to drivers/gpio/twl4030-gpio.c
index 0d4dd28..2949da1 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/i2c/chips/twl4030_gpio.c
+ * twl4030_gpio.c -- access to GPIOs on TWL4030/TPS659x0 chips
  *
  * Copyright (C) 2006-2007 Texas Instruments, Inc.
  * Copyright (C) 2006 MontaVista Software, Inc.
@@ -23,7 +23,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
  */
 
 #include <linux/module.h>
@@ -48,14 +47,19 @@
 
 
 /* REVISIT when these symbols vanish elsewhere, remove them here too */
-#undef TWL4030_GPIO_IRQ_BASE
-#undef TWL4030_GPIO_IRQ_END
+/* #undef TWL4030_GPIO_IRQ_BASE */
+/* #undef TWL4030_GPIO_IRQ_END */
 #undef TWL4030_MODIRQ_GPIO
 
 static struct gpio_chip twl_gpiochip;
 static int twl4030_gpio_irq_base;
 static int twl4030_gpio_irq_end;
 
+#ifdef MODULE
+#define is_module()	true
+#else
+#define is_module()	false
+#endif
 
 /* BitField Definitions */
 
@@ -765,7 +769,24 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 	twl4030_gpio_irq_base = pdata->irq_base;
 	twl4030_gpio_irq_end = pdata->irq_end;
 
-	/* REVISIT skip most of this if the irq range is empty... */
+	if ((twl4030_gpio_irq_end - twl4030_gpio_irq_base) > 0) {
+		if (is_module()) {
+			dev_err(&pdev->dev,
+				"can't dispatch IRQs from modules\n");
+			goto no_irqs;
+		}
+		if (twl4030_gpio_irq_end > NR_IRQS) {
+			dev_err(&pdev->dev,
+				"last IRQ is too large: %d\n",
+				twl4030_gpio_irq_end);
+			return -EINVAL;
+		}
+	} else {
+		dev_notice(&pdev->dev,
+			"no IRQs being dispatched\n");
+		goto no_irqs;
+	}
+
 	if (!ret) {
 		/*
 		 * Create a kernel thread to handle deferred unmasking of gpio
@@ -805,6 +826,7 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 			twl4030_gpio_irq_base, twl4030_gpio_irq_end - 1);
 	}
 
+no_irqs:
 	if (!ret) {
 		twl_gpiochip.base = pdata->gpio_base;
 		twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
@@ -849,6 +871,9 @@ static int __devexit gpio_twl4030_remove(struct platform_device *pdev)
 	if (status < 0)
 		return status;
 
+	if (is_module() || (twl4030_gpio_irq_end - twl4030_gpio_irq_base) <= 0)
+		return 0;
+
 	/* uninstall the gpio demultiplexing interrupt handler */
 	irq = platform_get_irq(pdev, 0);
 	set_irq_handler(irq, NULL);
@@ -883,7 +908,7 @@ static int __init gpio_twl4030_init(void)
 {
 	return platform_driver_register(&gpio_twl4030_driver);
 }
-module_init(gpio_twl4030_init);
+subsys_initcall(gpio_twl4030_init);
 
 static void __exit gpio_twl4030_exit(void)
 {
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 1a21388..e6ac6a2 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -157,10 +157,6 @@ config TWL4030_CORE
 	help
 	  Say yes here if you have TWL4030 chip on your board
 
-config TWL4030_GPIO
-	bool "TWL4030 GPIO Driver"
-	depends on TWL4030_CORE && GPIOLIB
-
 config TWL4030_MADC
 	tristate "TWL4030 MADC Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index ad5f5db..75c531a 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-pwrirq.o twl4030-power.o
-obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 5dcc3b1..4ea6444 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -51,7 +51,7 @@
 #define twl_has_keypad()	false
 #endif
 
-#ifdef CONFIG_TWL4030_GPIO
+#if defined(CONFIG_GPIO_TWL4030) || defined(CONFIG_GPIO_TWL4030_MODULE)
 #define twl_has_gpio()	true
 #else
 #define twl_has_gpio()	false
@@ -1110,10 +1110,6 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		mutex_init(&twl->xfer_lock);
 	}
 
-	status = add_children(pdata);
-	if (status < 0)
-		goto fail;
-
 	/*
 	 * Check if the PIH module is initialized, if yes, then init
 	 * the T2 Interrupt subsystem
@@ -1128,10 +1124,10 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				client->irq, pdata->irq_base, pdata->irq_end - 1);
 	}
 
-	return 0;
-
+	status = add_children(pdata);
 fail:
-	twl4030_remove(client);
+	if (status < 0)
+		twl4030_remove(client);
 	return status;
 }
 
-- 
1.6.0.2.307.gc427

