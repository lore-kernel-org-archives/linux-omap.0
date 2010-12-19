From: Koen Kooi <koen.kooi@gmail.com>
Subject: [PATCH v2] ARM: OMAP: Power on EHCI, serial, camera and DVI on beagleboard-xM
Date: Sun, 19 Dec 2010 15:42:15 +0100
Message-ID: <1292769735-54159-1-git-send-email-koen@dominion.thruhere.net>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60016 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab0LSOm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Dec 2010 09:42:29 -0500
Received: by wyb28 with SMTP id 28so2115532wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 06:42:28 -0800 (PST)
In-Reply-To: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@dominion.thruhere.net>, Koen Kooi <koen@beagleboard.org>

Signed-off-by: Koen Kooi <koen@beagleboard.org>

---

Changes since v1:
	* Reenable the PMU stat LED

 arch/arm/mach-omap2/board-omap3beagle.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index f1a8ede..4756ac7 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -297,13 +297,35 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	gpio_request(gpio + 1, "EHCI_nOC");
 	gpio_direction_input(gpio + 1);
 
-	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
+	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
+	 * high / others active low) */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	else
+		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+
+	/* DVI reset GPIO is different between revisions */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		beagle_dvi_device.reset_gpio = 129;
+	else
+		beagle_dvi_device.reset_gpio = 170;
+
+	 /* Power on DVI, Serial and PWR led */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		gpio_request(gpio + 1, "nDVI_PWR_EN");
+		gpio_direction_output(gpio + 1, 0);
+	}
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+	/* Power on camera interface on P7/P8 or DVI on A2 and beyond */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		gpio_request(gpio + 2, "CAM_EN");
+		gpio_direction_output(gpio + 2, 1);
+	}
+
 	return 0;
 }
 
-- 
1.6.6.1

