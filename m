From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc7-omap-git] Overo: MMC regulator configuration
Date: Wed, 11 Mar 2009 10:58:29 -0800
Message-ID: <200903111158.29860.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n15b.bullet.mail.mud.yahoo.com ([68.142.207.236]:38108 "HELO
	n15b.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752574AbZCKS6e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 14:58:34 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>
Cc: Steve Sakoman <steve@sakoman.com>

From: David Brownell <dbrownell@users.sourceforge.net>

This patch hooks up the twl4030 MMC1 regulator on Overo,
as well as the MMC1 card detect signal.  The WLAN chip
connected to MMC2 on some board versions has a dedicated
regulator.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Patches still needed for LDP/Zoom and Pandora...

 arch/arm/mach-omap2/board-overo.c |   55 ++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -267,10 +267,45 @@ static struct omap_uart_config overo_uar
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
+	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
+	mmc[0].gpio_cd = gpio + 0;
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
@@ -287,6 +322,8 @@ static struct regulator_init_data overo_
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &overo_vmmc1_supply,
 };
 
 /* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
@@ -343,23 +380,6 @@ static struct platform_device *overo_dev
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
@@ -367,7 +387,6 @@ static void __init overo_init(void)
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
 	usb_musb_init();
 	usb_ehci_init();
 	overo_flash_init();

