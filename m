From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: LEDs driver support
Date: Mon, 26 Jun 2006 12:01:53 +0900
Message-ID: <008701c698cc$e0f41240$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi

As there's no OMAP2 leds implementation, I implement LED device driver for
OMAP

Any comments are welcome.

Thank you
Kyungmin Park


ARM: OMAP: LEDs driver support

	OMAP GPIO LEDs support

	Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 6c6ba17..bf04f1b 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/onenand.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -31,6 +32,7 @@
 #include <asm/mach/flash.h>
 
 #include <asm/arch/gpio.h>
+#include <asm/arch/led.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/board.h>
@@ -125,10 +127,45 @@ static struct platform_device apollon_lc
 	.id		= -1,
 };
 
+static struct omap_led_config apollon_led_config[] = {
+	{
+		.cdev	= {
+			.name	= "apollon:led0",
+		},
+		.gpio	= LED0_GPIO13,
+	},
+	{
+		.cdev	= {
+			.name	= "apollon:led1",
+		},
+		.gpio	= LED1_GPIO14,
+	},
+	{
+		.cdev	= {
+			.name	= "apollon:led2",
+		},
+		.gpio	= LED2_GPIO15,
+	},
+};
+
+static struct omap_led_platform_data apollon_led_data = {
+	.nr_leds	= ARRAY_SIZE(apollon_led_config),
+	.leds		= apollon_led_config,
+};
+
+static struct platform_device apollon_led_device = {
+	.name		= "omap-led",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &apollon_led_data,
+	},
+};
+
 static struct platform_device *apollon_devices[] __initdata = {
 	&apollon_onenand_device,
 	&apollon_smc91x_device,
 	&apollon_lcd_device,
+	&apollon_led_device,
 };
 
 static inline void __init apollon_init_smc91x(void)
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6265062..da4086b 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -63,6 +63,12 @@ config LEDS_S3C24XX
 	  This option enables support for LEDs connected to GPIO lines
 	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
 
+config LEDS_OMAP
+	tristate "LED Support for OMAP GPIO LEDs"
+	depends LEDS_CLASS && ARCH_OMAP
+	help
+	  This option enables support for the LEDs on OMAP processors.
+
 comment "LED Triggers"
 
 config LEDS_TRIGGERS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 40f0426..6dbd3bc 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_LEDS_SPITZ)		+= leds-spitz.
 obj-$(CONFIG_LEDS_IXP4XX)		+= leds-ixp4xx-gpio.o
 obj-$(CONFIG_LEDS_TOSA)			+= leds-tosa.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
+obj-$(CONFIG_LEDS_OMAP)			+= leds-omap.o
 
 # LED Triggers
 obj-$(CONFIG_LEDS_TRIGGER_TIMER)	+= ledtrig-timer.o
diff --git a/drivers/leds/leds-omap.c b/drivers/leds/leds-omap.c
new file mode 100644
index 0000000..1cf5908
--- /dev/null
+++ b/drivers/leds/leds-omap.c
@@ -0,0 +1,136 @@
+/* drivers/leds/leds-omap.c
+ *
+ * (C) 2006 Samsung Electronics
+ * Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * OMAP - LEDs GPIO driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+
+#include <asm/arch/gpio.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/led.h>
+
+/* our context */
+
+static void omap_set_led_gpio(struct led_classdev *led_cdev,
+			    enum led_brightness value)
+{
+	struct omap_led_config *led_dev;
+
+	led_dev = container_of(led_cdev, struct omap_led_config, cdev);
+
+	if (value)
+		omap_set_gpio_dataout(led_dev->gpio, 1);
+	else
+		omap_set_gpio_dataout(led_dev->gpio, 0);
+}
+
+static void omap_configure_led_gpio(int gpio)
+{
+	if (omap_request_gpio(gpio) < 0) {
+		printk(KERN_ERR "Failed to request GPIO%d for LEDs\n",
gpio);
+		return;
+	}
+	omap_set_gpio_direction(gpio, 0);	/* OUT */
+}
+
+static int omap_led_probe(struct platform_device *dev)
+{
+	struct omap_led_platform_data *pdata = dev->dev.platform_data;
+	struct omap_led_config *leds = pdata->leds;
+	int i, ret = 0;
+
+	for (i = 0; ret >= 0 && i < pdata->nr_leds; i++) {
+		omap_configure_led_gpio(leds[i].gpio);
+		if (!leds[i].cdev.brightness_set)
+			leds[i].cdev.brightness_set = omap_set_led_gpio;
+		
+		ret = led_classdev_register(&dev->dev, &leds[i].cdev);
+	}
+
+	if (ret < 0 && i > 1) {
+		for (i = i - 2; i >= 0; i--)
+			led_classdev_unregister(&leds[i].cdev);
+	}
+
+	return ret;
+}
+
+static int omap_led_remove(struct platform_device *dev)
+{
+	struct omap_led_platform_data *pdata = dev->dev.platform_data;
+	struct omap_led_config *leds = pdata->leds;
+	int i;
+
+	for (i = 0; i < pdata->nr_leds; i++)
+		led_classdev_unregister(&leds[i].cdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int omap_led_suspend(struct platform_device *dev, pm_message_t
state)
+{
+	struct omap_led_platform_data *pdata = dev->dev.platform_data;
+	struct omap_led_config *leds = pdata->leds;
+	int i;
+
+	for (i = 0; i < pdata->nr_leds; i++)
+		led_classdev_suspend(&leds[i].cdev);
+
+	return 0;
+}
+
+static int omap_led_resume(struct platform_device *dev)
+{
+	struct omap_led_platform_data *pdata = dev->dev.platform_data;
+	struct omap_led_config *leds = pdata->leds;
+	int i;
+
+	for (i = 0; i < pdata->nr_leds; i++)
+		led_classdev_resume(&leds[i].cdev);
+
+	return 0;
+}
+#else
+#define omap_led_suspend	NULL
+#define omap_led_resume		NULL
+#endif
+
+static struct platform_driver omap_led_driver = {
+	.probe		= omap_led_probe,
+	.remove		= omap_led_remove,
+	.suspend	= omap_led_suspend,
+	.resume		= omap_led_resume,
+	.driver		= {
+		.name		= "omap-led",
+		.owner		= THIS_MODULE,
+	},
+};
+
+static int __init omap_led_init(void)
+{
+	return platform_driver_register(&omap_led_driver);
+}
+
+static void __exit omap_led_exit(void)
+{
+ 	platform_driver_unregister(&omap_led_driver);
+}
+
+module_init(omap_led_init);
+module_exit(omap_led_exit);
+
+MODULE_AUTHOR("Kyungmin Park<kyungmin.park@samsung.com>");
+MODULE_DESCRIPTION("OMAP LED driver");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/arch-omap/led.h b/include/asm-arm/arch-
omap/led.h
new file mode 100644
index 0000000..3343005
--- /dev/null
+++ b/include/asm-arm/arch-omap/led.h
@@ -0,0 +1,24 @@
+/*
+ *  linux/include/asm-arm/arch-omap/led.h
+ *
+ *  Copyright (C) 2006 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASMARM_ARCH_LED_H
+#define ASMARM_ARCH_LED_H
+
+struct omap_led_config {
+	struct led_classdev	cdev;
+	s16			gpio;
+};
+
+struct omap_led_platform_data {
+	s16			nr_leds;
+	struct omap_led_config	*leds;
+};
+
+#endif
