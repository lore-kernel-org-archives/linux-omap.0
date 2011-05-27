From: Koen Kooi <koen@dominion.thruhere.net>
Subject: [PATCH v2] OMAP3: beagle: add support for beagleboard xM revision C
Date: Fri, 27 May 2011 14:40:18 +0200
Message-ID: <1306500018-19685-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37399 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996Ab1E0MkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 08:40:23 -0400
Received: by wya21 with SMTP id 21so1216142wya.19
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 05:40:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jkridner@beagleboard.org, Koen Kooi <koen@dominion.thruhere.net>

The USB enable GPIO has been inverted again and the USER button moved.

Future revisions will now fall back to xM rev C instead of unknown.

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---

Changes since v1:
	* updated against mainline to take Igors gpio cleanup into account
	* removed xM rev B checks, no boards with that ID were ever produced, rev B boards show up as rev A
	* double checked whitespace:

		total: 0 errors, 0 warnings, 89 lines checked
		patches/0001-OMAP3-beagle-add-support-for-beagleboard-xM-revision.patch has no obvious style problems and is ready for submission.

 arch/arm/mach-omap2/board-omap3beagle.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index be71426..177769b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -63,7 +63,9 @@
  *	AXBX	= GPIO173, GPIO172, GPIO171: 1 1 1
  *	C1_3	= GPIO173, GPIO172, GPIO171: 1 1 0
  *	C4	= GPIO173, GPIO172, GPIO171: 1 0 1
- *	XM	= GPIO173, GPIO172, GPIO171: 0 0 0
+ *	XMA	= GPIO173, GPIO172, GPIO171: 0 0 0
+ *	XMB	= GPIO173, GPIO172, GPIO171: 0 0 1 - unused
+ *	XMC = GPIO173, GPIO172, GPIO171: 0 1 0
  */
 enum {
 	OMAP3BEAGLE_BOARD_UNKN = 0,
@@ -71,6 +73,7 @@ enum {
 	OMAP3BEAGLE_BOARD_C1_3,
 	OMAP3BEAGLE_BOARD_C4,
 	OMAP3BEAGLE_BOARD_XM,
+	OMAP3BEAGLE_BOARD_XMC,
 };
 
 static u8 omap3_beagle_version;
@@ -123,9 +126,13 @@ static void __init omap3_beagle_init_rev(void)
 		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
 		omap3_beagle_version = OMAP3BEAGLE_BOARD_XM;
 		break;
+	case 2:
+		printk(KERN_INFO "OMAP3 Beagle Rev: xM\n");
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
+		break;
 	default:
 		printk(KERN_INFO "OMAP3 Beagle Rev: unknown %hd\n", beagle_rev);
-		omap3_beagle_version = OMAP3BEAGLE_BOARD_UNKN;
+		omap3_beagle_version = OMAP3BEAGLE_BOARD_XMC;
 	}
 }
 
@@ -253,7 +260,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 {
 	int r, usb_pwr_level;
 
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+	if (cpu_is_omap3630()) {
 		mmc[0].gpio_wp = -EINVAL;
 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
 		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
@@ -275,11 +282,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	 * high / others active low)
 	 * DVI reset GPIO is different between beagle revisions
 	 */
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
-		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
+	if (cpu_is_omap3630()) {
 		beagle_dvi_device.reset_gpio = 129;
 		/*
-		 * gpio + 1 on Xm controls the TFP410's enable line (active low)
+		 * gpio + 1 on xM controls the TFP410's enable line (active low)
 		 * gpio + 2 control varies depending on the board rev as below:
 		 * P7/P8 revisions(prototype): Camera EN
 		 * A2+ revisions (production): LDO (DVI, serial, led blocks)
@@ -295,7 +301,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 			pr_err("%s: unable to configure DVI_LDO_EN\n",
 				__func__);
 	} else {
-		usb_pwr_level = GPIOF_OUT_INIT_LOW;
 		beagle_dvi_device.reset_gpio = 170;
 		/*
 		 * REVISIT: need ehci-omap hooks for external VBUS
@@ -305,6 +310,12 @@ static int beagle_twl_gpio_setup(struct device *dev,
 			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
 
+	/* Only xM rev A and xM rev B use active high */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		usb_pwr_level = GPIOF_OUT_INIT_HIGH;
+	else
+		usb_pwr_level = GPIOF_OUT_INIT_LOW;
+
 	gpio_request_one(gpio + TWL4030_GPIO_MAX, usb_pwr_level, "nEN_USB_PWR");
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
@@ -525,7 +536,7 @@ static void __init beagle_opp_init(void)
 	}
 
 	/* Custom OPP enabled for XM */
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+	if (cpu_is_omap3630()) {
 		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
 		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
 		struct device *dev;
@@ -565,6 +576,10 @@ static void __init omap3_beagle_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap3_beagle_init_rev();
 	omap3_beagle_i2c_init();
+
+	if (cpu_is_omap3630())
+			gpio_buttons[0].gpio = 4;
+
 	platform_add_devices(omap3_beagle_devices,
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_display_init(&beagle_dss_data);
-- 
1.6.6.1

