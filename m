From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v2] [OMAP] Cleanup Beagleboard DVI reset gpio
Date: Tue,  8 May 2012 11:43:13 -0700
Message-ID: <1336502593-32226-1-git-send-email-Russ.Dill@ti.com>
References: <4FA8DC48.5020901@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48458 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab2EHSnT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 14:43:19 -0400
Received: by obbtb18 with SMTP id tb18so10123467obb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 11:43:18 -0700 (PDT)
In-Reply-To: <4FA8DC48.5020901@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: chase.maupin@ti.com, Igor Grinberg <grinberg@compulab.co.il>, Russ Dill <Russ.Dill@ti.com>

This removes several boot warnings from board-omap3beagle.c:

 - gpio_request: gpio--22 (DVI reset) status -22
 - Unable to get DVI reset GPIO

There is a combination of leftover code and revision confusion.
Additionally, xM support is currently a hack.

For original Beagleboard this removes the double initialization of GPIO
170, properly configures it as an output, and wraps the initialization
in an if block so that xM does not attempt to request it.

For Beagleboard xM it removes reference to GPIO 129 which was part
of rev A1 and A2 designs, but never functioned. It then properly assigns
beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
hack of initializing it high. Additionally, it uses
gpio_set_value_cansleep since this GPIO is connected through i2c.

Unfortunately, there is no way to tell the difference between xM A2 and
A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
problems created by this fix.

v2
  - Rename reset_gpio to dvi_reset_gpio to self document
  - Use gpio_set_value_cansleep since TWL gpio can sleep
  - Use gpio_is_valid instead of -EINVAL check

Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   41 +++++++++++++++++--------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 495b810..4942be8 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -87,7 +87,7 @@ static struct {
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
 	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
-	.reset_gpio = 129,
+	.reset_gpio = -EINVAL,
 	.usr_button_gpio = 4,
 	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
@@ -196,7 +196,7 @@ static struct mtd_partition omap3beagle_nand_partitions[] = {
 static int beagle_enable_dvi(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 1);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
 
 	return 0;
 }
@@ -204,7 +204,7 @@ static int beagle_enable_dvi(struct omap_dss_device *dssdev)
 static void beagle_disable_dvi(struct omap_dss_device *dssdev)
 {
 	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value(dssdev->reset_gpio, 0);
+		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
 }
 
 static struct panel_dvi_platform_data dvi_panel = {
@@ -242,12 +242,17 @@ static struct omap_dss_board_info beagle_dss_data = {
 
 static void __init beagle_display_init(void)
 {
-	int r;
-
-	r = gpio_request_one(beagle_dvi_device.reset_gpio, GPIOF_OUT_INIT_LOW,
-			     "DVI reset");
-	if (r < 0)
-		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
+	if (gpio_is_valid(beagle_config.reset_gpio)) {
+		int r;
+
+		omap_mux_init_gpio(beagle_config.reset_gpio, OMAP_PIN_OUTPUT);
+		r = gpio_request_one(beagle_config.reset_gpio,
+				     GPIOF_OUT_INIT_LOW, "DVI reset");
+		if (r < 0)
+			printk(KERN_ERR "Unable to get DVI reset GPIO\n");
+		else
+			beagle_dvi_device.reset_gpio = beagle_config.reset_gpio;
+	}
 }
 
 #include "sdram-micron-mt46h32m32lf-6.h"
@@ -299,11 +304,14 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (r)
 			pr_err("%s: unable to configure nDVI_PWR_EN\n",
 				__func__);
-		r = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
-				     "DVI_LDO_EN");
+
+		r = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW,
+				     "DVI_PU");
 		if (r)
-			pr_err("%s: unable to configure DVI_LDO_EN\n",
-				__func__);
+			pr_err("%s: unable to get DVI_PU GPIO\n", __func__);
+		else
+			beagle_dvi_device.reset_gpio = gpio + 2;
+
 	} else {
 		/*
 		 * REVISIT: need ehci-omap hooks for external VBUS
@@ -312,7 +320,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	beagle_dvi_device.reset_gpio = beagle_config.reset_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -524,7 +531,7 @@ static void __init omap3_beagle_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 
-	if (beagle_config.mmc1_gpio_wp != -EINVAL)
+	if (gpio_is_valid(beagle_config.mmc1_gpio_wp))
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	mmc[0].caps = beagle_config.mmc_caps;
 	omap_hsmmc_init(mmc);
@@ -540,10 +547,6 @@ static void __init omap3_beagle_init(void)
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
-
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
 	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
-- 
1.7.9.5

