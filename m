From: Thomas Weber <weber@corscience.de>
Subject: [PATCH 03/14] OMAP2: Devkit8000: Enable DVI-D output
Date: Tue, 18 May 2010 14:05:24 +0200
Message-ID: <1274184335-29322-4-git-send-email-weber@corscience.de>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61528 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab0ERMGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:06:07 -0400
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>, Kan-Ru Chen <kanru@0xlab.org>

This patch corrects the DVI-D output setup of Devkit8000.
Devkit8000 has different DVI reset pin with the BeagleBoard. On
Devkit8000 the TWL4030 GPIO_7 is assigned to do the job.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
Signed-off-by: Thomas Weber <weber@corscience.de>
---
 arch/arm/mach-omap2/board-devkit8000.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index e989136..c6b9ed4 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -140,13 +140,18 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 }
+
 static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
 {
+	if (dssdev->reset_gpio != -EINVAL)
+		gpio_set_value(dssdev->reset_gpio, 0);
 }
 
 static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
@@ -186,6 +191,7 @@ static struct omap_dss_device devkit8000_dvi_device = {
 	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines     = 24,
+	.reset_gpio             = -EINVAL, /* will be replaced */
 	.platform_enable        = devkit8000_panel_enable_dvi,
 	.platform_disable       = devkit8000_panel_disable_dvi,
 };
@@ -272,6 +278,15 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	devkit8000_vmmc1_supply.dev = mmc[0].dev;
 	devkit8000_vsim_supply.dev = mmc[0].dev;
 
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	/* gpio + 7 is "DVI_PD" (out, active low) */
+	devkit8000_dvi_device.reset_gpio = gpio + 7;
+	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
+	/* Disable until needed */
+	gpio_direction_output(devkit8000_dvi_device.reset_gpio, 0);
+
 	return 0;
 }
 
-- 
1.6.4.4

