From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 23/23] twl4030-bci: move to new style registration method
Date: Tue, 30 Sep 2008 13:06:00 +0300
Message-ID: <1222769160-31615-24-git-send-email-felipe.balbi@nokia.com>
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
 <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-14-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-18-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-19-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-20-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-21-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-22-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-23-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58464 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYI3KHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:07:06 -0400
In-Reply-To: <1222769160-31615-23-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

twl4030_bci_battery.c is now moved to new style
registration of twl4030 children.

During the process a few bugfixes came but the main one
is that twl4030-bci was releasing the wrong irq if
battery registration had failed.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/Makefile          |    4 +--
 arch/arm/mach-omap2/bci.c             |   57 ---------------------------------
 arch/arm/mach-omap2/board-3430sdp.c   |   18 ++++++++++-
 arch/arm/mach-omap2/board-ldp.c       |   18 ++++++++++-
 arch/arm/plat-omap/include/mach/bci.h |   17 ----------
 drivers/i2c/chips/twl4030-core.c      |   50 +++++++++++++++++++++++++++++
 drivers/power/twl4030_bci_battery.c   |   25 +++++++++------
 include/linux/i2c/twl4030.h           |    5 +++
 8 files changed, 105 insertions(+), 89 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/bci.c
 delete mode 100644 arch/arm/plat-omap/include/mach/bci.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e18da0c..33de217 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -54,8 +54,7 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
 					   usb-musb.o \
 					   usb-ehci.o \
-					   board-3430sdp-flash.o \
-					   bci.o
+					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
 					   hsmmc.o \
 					   usb-musb.o usb-ehci.o \
@@ -65,7 +64,6 @@ obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o \
 					   hsmmc.o \
-					   bci.o \
 					   usb-musb.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
diff --git a/arch/arm/mach-omap2/bci.c b/arch/arm/mach-omap2/bci.c
deleted file mode 100644
index 9b9f9d2..0000000
--- a/arch/arm/mach-omap2/bci.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/bci.c
- *
- * TWL4030 BCI platform device setup/initialization
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <mach/bci.h>
-
-#if defined(CONFIG_TWL4030_BCI_BATTERY) || \
-	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
-/*
- * Thermistor Calibration for Current Source and MADC
- * Tolerance (for THS05-3H103F)
- */
-static int sdp3430_batt_table[] = {
-/* 0 C*/
-30800, 29500, 28300, 27100,
-26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
-17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
-11600, 11200, 10800, 10400, 10000, 9630,   9280,   8950,   8620,   8310,
-8020,   7730,   7460,   7200,   6950,   6710,   6470,   6250,   6040,   5830,
-5640,   5450,   5260,   5090,   4920,   4760,   4600,   4450,   4310,   4170,
-4040,   3910,   3790,   3670,   3550
-};
-
-static struct twl4030_bci_platform_data sdp3430_bci_data = {
-      .battery_tmp_tbl = sdp3430_batt_table,
-      .tblsize = ARRAY_SIZE(sdp3430_batt_table),
-};
-
-static struct platform_device twl4030_bci_battery_device = {
-	.name           = "twl4030-bci-battery",
-	.id             = -1,
-	.dev            = {
-		.platform_data  = &sdp3430_bci_data,
-	},
-	.num_resources  = 0,
-};
-
-void __init twl4030_bci_battery_init(void)
-{
-	(void) platform_device_register(&twl4030_bci_battery_device);
-}
-#else
-void __init twl4030_bci_battery_init(void)
-{
-}
-#endif
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 661d5d0..4264b68 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -300,6 +300,22 @@ static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&sdp3430_lcd_config },
 };
 
+static int sdp3430_batt_table[] = {
+/* 0 C*/
+30800, 29500, 28300, 27100,
+26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
+17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
+11600, 11200, 10800, 10400, 10000, 9630,   9280,   8950,   8620,   8310,
+8020,   7730,   7460,   7200,   6950,   6710,   6470,   6250,   6040,   5830,
+5640,   5450,   5260,   5090,   4920,   4760,   4600,   4450,   4310,   4170,
+4040,   3910,   3790,   3670,   3550
+};
+
+static struct twl4030_bci_platform_data sdp3430_bci_data = {
+      .battery_tmp_tbl	= sdp3430_batt_table,
+      .tblsize		= ARRAY_SIZE(sdp3430_batt_table),
+};
+
 static struct twl4030_gpio_platform_data sdp3430_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
@@ -319,6 +335,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.bci		= &sdp3430_bci_data,
 	.gpio		= &sdp3430_gpio_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
@@ -361,7 +378,6 @@ static void __init omap_3430sdp_init(void)
 	ads7846_dev_init();
 	sdp3430_flash_init();
 	msecure_init();
-	twl4030_bci_battery_init();
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index a0e2c7a..35c03b7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -183,6 +183,22 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_UART,	&ldp_uart_config },
 };
 
+static int ldp_batt_table[] = {
+/* 0 C*/
+30800, 29500, 28300, 27100,
+26000, 24900, 23900, 22900, 22000, 21100, 20300, 19400, 18700, 17900,
+17200, 16500, 15900, 15300, 14700, 14100, 13600, 13100, 12600, 12100,
+11600, 11200, 10800, 10400, 10000, 9630,   9280,   8950,   8620,   8310,
+8020,   7730,   7460,   7200,   6950,   6710,   6470,   6250,   6040,   5830,
+5640,   5450,   5260,   5090,   4920,   4760,   4600,   4450,   4310,   4170,
+4040,   3910,   3790,   3670,   3550
+};
+
+static struct twl4030_bci_platform_data ldp_bci_data = {
+      .battery_tmp_tbl	= ldp_batt_table,
+      .tblsize		= ARRAY_SIZE(ldp_batt_table),
+};
+
 static struct twl4030_usb_data ldp_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -202,6 +218,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.bci		= &ldp_bci_data,
 	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
 	.gpio		= &ldp_gpio_data,
@@ -237,7 +254,6 @@ static void __init omap_ldp_init(void)
 				ARRAY_SIZE(ldp_spi_board_info));
 	msecure_init();
 	ads7846_dev_init();
-	twl4030_bci_battery_init();
 	omap_serial_init();
 	usb_musb_init();
 	hsmmc_init();
diff --git a/arch/arm/plat-omap/include/mach/bci.h b/arch/arm/plat-omap/include/mach/bci.h
deleted file mode 100644
index 9baf59e..0000000
--- a/arch/arm/plat-omap/include/mach/bci.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/bci.h
- *
- *  Copyright (C) 2008 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef ASMARM_ARCH_BCI_H
-#define ASMARM_ARCH_BCI_H
-struct twl4030_bci_platform_data {
-	int *battery_tmp_tbl;
-	unsigned int tblsize;
-};
-#endif
-
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index efba776..9debab4 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -45,6 +45,13 @@
 
 #define DRIVER_NAME			"twl4030"
 
+#if defined(CONFIG_TWL4030_BCI_BATTERY) || \
+	defined(CONFIG_TWL4030_BCI_BATTERY_MODUEL)
+#define twl_has_bci()		true
+#else
+#define twl_has_bci()		false
+#endif
+
 #if defined(CONFIG_KEYBOARD_TWL4030) || defined(CONFIG_KEYBOARD_TWL4030_MODULE)
 #define twl_has_keypad()	true
 #else
@@ -681,6 +688,49 @@ static int add_children(struct twl4030_platform_data *pdata)
 	struct twl4030_client	*twl = NULL;
 	int			status = 0;
 
+	if (twl_has_bci() && pdata->bci) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+
+		pdev = platform_device_alloc("twl4030_bci", -1);
+		if (!pdev) {
+			pr_debug("%s: can't alloc bci dev\n", DRIVER_NAME);
+			status = -ENOMEM;
+			goto err;
+		}
+
+		if (status == 0) {
+			pdev->dev.parent = &twl->client->dev;
+			status = platform_device_add_data(pdev, pdata->bci,
+					sizeof(*pdata->bci));
+			if (status < 0) {
+				dev_dbg(&twl->client->dev,
+					"can't add bci data, %d\n",
+					status);
+				goto err;
+			}
+		}
+
+		if (status == 0) {
+			struct resource r = {
+				.start = TWL4030_PWRIRQ_CHG_PRES,
+				.flags = IORESOURCE_IRQ,
+			};
+
+			status = platform_device_add_resources(pdev, &r, 1);
+		}
+
+		if (status == 0)
+			status = platform_device_add(pdev);
+
+		if (status < 0) {
+			platform_device_put(pdev);
+			dev_dbg(&twl->client->dev,
+					"can't create bci dev, %d\n",
+					status);
+			goto err;
+		}
+	}
+
 	if (twl_has_gpio() && pdata->gpio) {
 		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
 
diff --git a/drivers/power/twl4030_bci_battery.c b/drivers/power/twl4030_bci_battery.c
index 9ab6127..72a018b 100644
--- a/drivers/power/twl4030_bci_battery.c
+++ b/drivers/power/twl4030_bci_battery.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/power_supply.h>
-#include <mach/bci.h>
 #include <linux/i2c/twl4030-madc.h>
 
 #define T2_BATTERY_VOLT		0x04
@@ -583,9 +582,8 @@ static int twl4030battery_current(void)
  */
 static int twl4030backupbatt_voltage(void)
 {
-	int ret, temp;
-	u8 volt;
 	struct twl4030_madc_request req;
+	int temp;
 
 	req.channels = (1 << 9);
 	req.do_avg = 0;
@@ -826,9 +824,11 @@ static int twl4030_bci_battery_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
 {
-	struct twl4030_bci_device_info *di = to_twl4030_bci_device_info(psy);
+	struct twl4030_bci_device_info *di;
 	int status = 0;
 
+	di = to_twl4030_bci_device_info(psy);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = di->charge_status;
@@ -893,6 +893,7 @@ static int __init twl4030_bci_battery_probe(struct platform_device *pdev)
 {
 	struct twl4030_bci_platform_data *pdata = pdev->dev.platform_data;
 	struct twl4030_bci_device_info *di;
+	int irq;
 	int ret;
 
 	therm_tbl = pdata->battery_tmp_tbl;
@@ -938,6 +939,8 @@ static int __init twl4030_bci_battery_probe(struct platform_device *pdev)
 	if (ret)
 		goto voltage_setup_fail;
 
+	/* REVISIT do we need to request both IRQs ?? */
+
 	/* request BCI interruption */
 	ret = request_irq(TWL4030_MODIRQ_BCI, twl4030battery_interrupt,
 		IRQF_DISABLED, pdev->name, NULL);
@@ -947,17 +950,19 @@ static int __init twl4030_bci_battery_probe(struct platform_device *pdev)
 		goto batt_irq_fail;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+
 	/* request Power interruption */
-	ret = request_irq(TWL4030_PWRIRQ_CHG_PRES, twl4030charger_interrupt,
+	ret = request_irq(irq, twl4030charger_interrupt,
 		0, pdev->name, di);
 
 	if (ret) {
 		dev_dbg(&pdev->dev, "could not request irq %d, status %d\n",
-			TWL4030_PWRIRQ_CHG_PRES, ret);
+			irq, ret);
 		goto chg_irq_fail;
 	}
 
-	ret = power_supply_register(&dev->dev, &di->bat);
+	ret = power_supply_register(&pdev->dev, &di->bat);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to register main battery\n");
 		goto batt_failed;
@@ -982,9 +987,8 @@ static int __init twl4030_bci_battery_probe(struct platform_device *pdev)
 bk_batt_failed:
 	power_supply_unregister(&di->bat);
 batt_failed:
-	free_irq(TWL4030_MODIRQ_PWR, di);
+	free_irq(irq, di);
 chg_irq_fail:
-prev_setup_err:
 	free_irq(TWL4030_MODIRQ_BCI, NULL);
 batt_irq_fail:
 voltage_setup_fail:
@@ -1001,6 +1005,7 @@ temp_setup_fail:
 static int __exit twl4030_bci_battery_remove(struct platform_device *pdev)
 {
 	struct twl4030_bci_device_info *di = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
 
 	twl4030charger_ac_en(DISABLE);
 	twl4030charger_usb_en(DISABLE);
@@ -1008,7 +1013,7 @@ static int __exit twl4030_bci_battery_remove(struct platform_device *pdev)
 	twl4030battery_hw_presence_en(DISABLE);
 
 	free_irq(TWL4030_MODIRQ_BCI, NULL);
-	free_irq(TWL4030_MODIRQ_PWR, di);
+	free_irq(irq, di);
 
 	flush_scheduled_work();
 	power_supply_unregister(&di->bat);
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 56a9415..1746733 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -52,6 +52,10 @@
 #define TWL4030_MODULE_RTC		0x14
 #define TWL4030_MODULE_SECURED_REG	0x15
 
+struct twl4030_bci_platform_data {
+	int *battery_tmp_tbl;
+	unsigned int tblsize;
+};
 
 /* TWL4030_GPIO_MAX (18) GPIOs, with interrupts */
 struct twl4030_gpio_platform_data {
@@ -91,6 +95,7 @@ struct twl4030_usb_data {
 
 struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
+	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
-- 
1.6.0.2.307.gc427

