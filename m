From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 3/3] omap3: beaglexm: fix power on of DVI
Date: Fri,  7 Jan 2011 17:01:22 -0600
Message-ID: <1294441282-17986-4-git-send-email-nm@ti.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58645 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755854Ab1AGXBf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 18:01:35 -0500
In-Reply-To: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>, Nishanth Menon <nm@ti.com>

From: Koen Kooi <koen@beagleboard.org>

TFP410 DVI chip is used to provide display out.
This chip is controlled by 2 lines:
LDO which supplies the power is controlled over gpio + 2
and the enable of the chip itself is done over gpio + 1
NOTE: the LDO is necessary for LED, serial blocks as well.

gpio + 1 was used to sense USB overcurrent in vanilla beagle.

Without this fix, the display would not function as the LDO
remains shut down.

[nm@ti.com: split up, added descriptive changelogs]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index d628f5e..7c82730 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -293,9 +293,10 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
+	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
+		gpio_request(gpio + 1, "EHCI_nOC");
+		gpio_direction_input(gpio + 1);
+	}
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
@@ -317,6 +318,19 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+	/*
+	 * gpio + 1 on Xm controls the TFP410's enable line (active low)
+	 * gpio + 2 control varies depending on the board rev as follows:
+	 * P7/P8 revisions(prototype): Camera EN
+	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
+	 */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		gpio_request(gpio + 1, "nDVI_PWR_EN");
+		gpio_direction_output(gpio + 1, 0);
+		gpio_request(gpio + 2, "DVI_LDO_EN");
+		gpio_direction_output(gpio + 2, 1);
+	}
+
 	return 0;
 }
 
-- 
1.6.3.3

