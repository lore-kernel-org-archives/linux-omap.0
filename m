From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [patch 2.6.29-rc7-omap-git] Overo: MMC regulator configuration
	(V2)
Date: Sun, 15 Mar 2009 21:37:03 -0700
Message-ID: <5e088bd90903152137k53302823n53419f63c6aab892@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:24556 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbZCPEhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 00:37:05 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1699214wfa.4
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 21:37:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>

From: David Brownell <dbrownell@users.sourceforge.net>

This patch hooks up the twl4030 MMC1 regulator on Overo,
The WLAN chip connected to MMC2 on some board versions
has a dedicated regulator.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
Patches still needed for LDP/Zoom and Pandora...

--- a/arch/arm/mach-omap2/board-overo.c	2009-03-14 21:03:05.000000000 -0700
+++ b/arch/arm/mach-omap2/board-overo.c	2009-03-15 20:38:07.000000000 -0700
@@ -267,10 +267,43 @@ static struct omap_uart_config overo_uar
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };

+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+		.transceiver	= true,
+		.ocr_mask	= 0x00100000,	/* 3.3V */
+	},
+	{}	/* Terminator */
+};
+
+static struct regulator_consumer_supply overo_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+static int overo_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	twl4030_mmc_init(mmc);
+
+	overo_vmmc1_supply.dev = mmc[0].dev;
+
+	return 0;
+}
+
 static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.setup		= overo_twl_gpio_setup,
 };

 static struct twl4030_usb_data overo_usb_data = {
@@ -287,6 +320,8 @@ static struct regulator_init_data overo_
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &overo_vmmc1_supply,
 };

 /* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
@@ -343,23 +378,6 @@ static struct platform_device *overo_dev
 	&overo_lcd_device,
 };

-static struct twl4030_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{
-		.mmc		= 2,
-		.wires		= 4,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-		.transceiver	= true,
-	},
-	{}	/* Terminator */
-};
-
 static void __init overo_init(void)
 {
 	overo_i2c_init();
@@ -367,7 +385,6 @@ static void __init overo_init(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();
