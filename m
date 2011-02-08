From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH v2 2/2] omap3: beaglexm: fix DVI initialization
Date: Tue,  8 Feb 2011 17:43:55 -0200
Message-ID: <1297194235-7376-3-git-send-email-ricardo.salveti@canonical.com>
References: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:60546 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1BHTop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 14:44:45 -0500
In-Reply-To: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Function beagle_twl_gpio_setup is called after beagle_display_init, what
lets reset_gpio with an invalid value at the time it request the gpio.
As a side effect the DVI reset GPIO is not properly set.

Also removing old code that powers down DVI in a hardcoded way, as it's
not necessary anymore.

Tested with Beagle-xM and C4.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 685ac06..1a21002 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -52,6 +52,9 @@
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
+#define BEAGLE_DVI_RESET_GPIO		170
+#define BEAGLE_XM_DVI_RESET_GPIO	129
+
 /*
  * OMAP3 Beagle revision
  * Run time detection of Beagle revision is done by reading GPIO.
@@ -248,6 +251,14 @@ static void __init beagle_display_init(void)
 {
 	int r;
 
+	/* DVI reset GPIO is different between beagle revisions */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		beagle_dvi_device.reset_gpio = BEAGLE_XM_DVI_RESET_GPIO;
+	else
+		beagle_dvi_device.reset_gpio = BEAGLE_DVI_RESET_GPIO;
+
+	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_OUTPUT);
+
 	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
 	if (r < 0) {
 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
@@ -324,12 +335,6 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	else
 		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
-	/* DVI reset GPIO is different between beagle revisions */
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
-		beagle_dvi_device.reset_gpio = 129;
-	else
-		beagle_dvi_device.reset_gpio = 170;
-
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
@@ -620,11 +625,6 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
-
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
-- 
1.7.2.3

