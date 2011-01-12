From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v6.1 3/3] omap3: beaglexm: fix power on of DVI
Date: Tue, 11 Jan 2011 18:23:29 -0600
Message-ID: <1294791809-28069-1-git-send-email-nm@ti.com>
References: <[PATCH v5 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932575Ab1ALAXo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 19:23:44 -0500
In-Reply-To: <[PATCH v5 0/3] OMAP3: beaglexm: GPIO fixes>
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
Posting the last of the patches of this series
v6.1: formal submission:
	added gpio error checks

v5: http://marc.info/?t=129476616900006&r=1&w=2
	

 arch/arm/mach-omap2/board-omap3beagle.c |   42 ++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 673deb9..2ed8040 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -273,6 +273,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
 		mmc[0].gpio_wp = -EINVAL;
 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
@@ -293,9 +295,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
+	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
+		r = gpio_request(gpio + 1, "EHCI_nOC");
+		if (!r) {
+			r = gpio_direction_input(gpio + 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
+	}
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
@@ -316,6 +325,33 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+	/*
+	 * gpio + 1 on Xm controls the TFP410's enable line (active low)
+	 * gpio + 2 control varies depending on the board rev as follows:
+	 * P7/P8 revisions(prototype): Camera EN
+	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
+	 */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 1, 0);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure nDVI_PWR_EN\n",
+				__func__);
+		r = gpio_request(gpio + 2, "DVI_LDO_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 2, 1);
+			if (r)
+				gpio_free(gpio + 2);
+		}
+		if (r)
+			pr_err("%s: unable to configure DVI_LDO_EN\n",
+				__func__);
+	}
+
 	return 0;
 }
 
-- 
1.6.3.3

