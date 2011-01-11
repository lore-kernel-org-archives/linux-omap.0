From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v5 2/3] omap3: beaglexm: fix DVI reset GPIO
Date: Tue, 11 Jan 2011 11:13:36 -0600
Message-ID: <1294766017-12182-3-git-send-email-nm@ti.com>
References: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1AKRNr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 12:13:47 -0500
In-Reply-To: <[PATCH v4 0/3] OMAP3: beaglexm: GPIO fixes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: l-o <linux-omap@vger.kernel.org>
Cc: l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Tony <tony@atomide.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>, Nishanth Menon <nm@ti.com>

From: Koen Kooi <koen@beagleboard.org>

GPIO reset line for Beagle XM is different from vanilla beagle
so we populate it as part of gpio update routine.

This in part fixes the issue of display not functioning on beagle XM
platform.

[nm@ti.com: split up, added descriptive changelogs]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index af1166b..673deb9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -199,7 +199,7 @@ static struct omap_dss_device beagle_dvi_device = {
 	.name = "dvi",
 	.driver_name = "generic_panel",
 	.phy.dpi.data_lines = 24,
-	.reset_gpio = 170,
+	.reset_gpio = -EINVAL,
 	.platform_enable = beagle_enable_dvi,
 	.platform_disable = beagle_disable_dvi,
 };
@@ -307,6 +307,12 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	else
 		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
+	/* DVI reset GPIO is different between beagle revisions */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+		beagle_dvi_device.reset_gpio = 129;
+	else
+		beagle_dvi_device.reset_gpio = 170;
+
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
-- 
1.6.3.3

