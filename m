From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAP: Beagle: fix TFP410 powerdown GPIO init
Date: Wed, 13 Jun 2012 12:20:15 +0300
Message-ID: <1339579215-24098-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:33474 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731Ab2FMJUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 05:20:48 -0400
Received: by lbbgj10 with SMTP id gj10so1380684lbb.23
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 02:20:43 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit e813a55eb9c9bc6c8039fb16332cf43402125b30 ("OMAP: board-files:
remove custom PD GPIO handling for DVI output") moved TFP410 chip's
powerdown-gpio handling from the board files to the tfp410 driver. One
gpio_request_one(powerdown-gpio, ...) was mistakenly left unremoved in
the Beagle board file. This causes the tfp410 driver to fail to request
the gpio on Beagle, causing the driver to fail and thus the DVI output
doesn't work.

Looking more closely to beagle board file, there seems to be other
problems also:

- The powerdown-gpio is initialized as OMAP_PIN_INPUT, whereas it's an
  output.
- The GPIO number 170 was used directly in the pin muxing above, even
  though the gpio number is different on some versions of beagle.
- The field for the gpio is named "reset_gpio" in the beagle_config
  struct, which is a bit confusing name for the gpio.

This patch does the following:

- Remove the gpio_request_one() for the gpio from the board file
- Use the gpio value from beagle_config for the pin muxing.
- Changes the pin to OMAP_PIN_OUTPUT
- Rename "reset_gpio" to "tfp410_pd_gpio"

Tested on BeagleBoard C3.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 79c6909..1bc8cea 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -81,13 +81,13 @@ static u8 omap3_beagle_version;
 static struct {
 	int mmc1_gpio_wp;
 	int usb_pwr_level;
-	int reset_gpio;
+	int tfp410_pd_gpio;
 	int usr_button_gpio;
 	int mmc_caps;
 } beagle_config = {
 	.mmc1_gpio_wp = -EINVAL,
 	.usb_pwr_level = GPIOF_OUT_INIT_LOW,
-	.reset_gpio = 129,
+	.tfp410_pd_gpio = 129,
 	.usr_button_gpio = 4,
 	.mmc_caps = MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 };
@@ -126,21 +126,21 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: Ax/Bx\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_AXBX;
 		beagle_config.mmc1_gpio_wp = 29;
-		beagle_config.reset_gpio = 170;
+		beagle_config.tfp410_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 6:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C1/C2/C3\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C1_3;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.tfp410_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 5:
 		printk(KERN_INFO "OMAP3 Beagle Rev: C4\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_C4;
 		beagle_config.mmc1_gpio_wp = 23;
-		beagle_config.reset_gpio = 170;
+		beagle_config.tfp410_pd_gpio = 170;
 		beagle_config.usr_button_gpio = 7;
 		break;
 	case 0:
@@ -287,7 +287,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 		if (gpio_request_one(gpio + 1, GPIOF_IN, "EHCI_nOC"))
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
-	dvi_panel.power_down_gpio = beagle_config.reset_gpio;
 
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, beagle_config.usb_pwr_level,
 			"nEN_USB_PWR");
@@ -515,9 +514,8 @@ static void __init omap3_beagle_init(void)
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
+	dvi_panel.power_down_gpio = beagle_config.tfp410_pd_gpio;
+	omap_mux_init_gpio(dvi_panel.power_down_gpio, OMAP_PIN_OUTPUT);
 
 	usb_musb_init(NULL);
 	usbhs_init(&usbhs_bdata);
-- 
1.7.9.5

