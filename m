From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
Date: Wed,  9 May 2012 15:15:03 -0700
Message-ID: <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
References: <20120509163649.GN5088@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39342 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487Ab2EIWPI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 18:15:08 -0400
Received: by obbtb18 with SMTP id tb18so875290obb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 15:15:08 -0700 (PDT)
In-Reply-To: <20120509163649.GN5088@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: chase.maupin@ti.com, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, Russ Dill <Russ.Dill@ti.com>

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

v4
 - Rebase onto git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5
 - Use dvi_pd_gpio instead of reset_gpio to match with new naming

v3
 - Change patch title to include 'ARM: OMAP:'
 - Actually rename reset_gpio to dvi_reset_gpio

v2
 - Rename reset_gpio to dvi_reset_gpio to self document
 - Use gpio_set_value_cansleep since TWL gpio can sleep
 - Use gpio_is_valid instead of -EINVAL check

Tested on Beagleboard-xM Rev C1 and Beagleboard Rev B4.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 5a66e7e..2f4906e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -81,13 +81,13 @@ static u8 omap3_beagle_version;
 static struct {
 	int mmc1_gpio_wp;
 	int usb_pwr_level;
-	int reset_gpio;
+	int dvi_pd_gpio;
 	int usr_button_gpio;
 	int mmc_caps;
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
 	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
-	.reset_gpio = 129,
+	.dvi_pd_gpio = -EINVAL,
 	.usr_button_gpio = 4,
 	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
@@ -126,21 +126,21 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
 		beagle_config.mmc1_gpio_wp = 29;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 6:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 5:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.dvi_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 0:
@@ -273,11 +273,9 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (r)
 			pr_err("%s: unable to configure nDVI_PWR_EN\n",
 				__func__);
-		r = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
-				     "DVI_LDO_EN");
-		if (r)
-			pr_err("%s: unable to configure DVI_LDO_EN\n",
-				__func__);
+
+		beagle_config.dvi_pd_gpio = gpio + 2;
+
 	} else {
 		/*
 		 * REVISIT: need ehci-omap hooks for external VBUS
@@ -286,7 +284,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	dvi_panel.power_down_gpio = beagle_config.reset_gpio;
+	dvi_panel.power_down_gpio = beagle_config.dvi_pd_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -498,7 +496,7 @@ static void __init omap3_beagle_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 
-	if (beagle_config.mmc1_gpio_wp != -EINVAL)
+	if (gpio_is_valid(beagle_config.mmc1_gpio_wp))
 		omap_mux_init_gpio(beagle_config.mmc1_gpio_wp, OMAP_PIN_INPUT);
 	mmc[0].caps = beagle_config.mmc_caps;
 	omap_hsmmc_init(mmc);
@@ -509,15 +507,13 @@ static void __init omap3_beagle_init(void)
 
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
+	if (gpio_is_valid(beagle_config.dvi_pd_gpio))
+		omap_mux_init_gpio(beagle_config.dvi_pd_gpio, OMAP_PIN_OUTPUT);
 	omap_display_init(&beagle_dss_data);
 	omap_serial_init();
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
1.7.10

