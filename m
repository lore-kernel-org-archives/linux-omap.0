From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAP: DSS2: Change DSI device naming
Date: Mon, 22 Aug 2011 11:26:36 +0300
Message-ID: <1314001599-17951-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:58552 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754735Ab1HVI06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:58 -0400
In-Reply-To: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently, there are 2 differently named platform devices generated for
the 2 DSS DSI modules. In order to use the same driver, the dsi devices
should be 2 instances of the same platform device.

Change the platform device names from "omapdss_dsi1" and "omapdss_dsi2"
to omapdss_dsi", and set the device indices to 0 and 1.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c   |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 arch/arm/mach-omap2/display.c            |    6 +++---
 arch/arm/mach-omap2/twl-common.c         |    2 +-
 drivers/video/omap2/dss/dsi.c            |   25 ++++++++++---------------
 5 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index b6002ec..d3941e6 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -267,7 +267,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 
 static struct regulator_consumer_supply devkit8000_vpll1_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 080d7bd..3f10001 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -335,7 +335,7 @@ static struct regulator_consumer_supply pandora_vmmc3_supply[] = {
 static struct regulator_consumer_supply pandora_vdds_supplies[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_consumer_supply pandora_vcc_lcd_supply[] = {
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index cdb675a..0339605 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -62,7 +62,7 @@ static const struct omap_dss_hwmod_data omap3_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
 };
 
 static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
@@ -70,8 +70,8 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_dispc", "omapdss_dispc", -1 },
 	{ "dss_rfbi", "omapdss_rfbi", -1 },
 	{ "dss_venc", "omapdss_venc", -1 },
-	{ "dss_dsi1", "omapdss_dsi1", -1 },
-	{ "dss_dsi2", "omapdss_dsi2", -1 },
+	{ "dss_dsi1", "omapdss_dsi", 0 },
+	{ "dss_dsi2", "omapdss_dsi", 1 },
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index daa056e..4f6d216 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -99,7 +99,7 @@ static struct regulator_init_data omap3_vdac_idata = {
 
 static struct regulator_consumer_supply omap3_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
-	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
 };
 
 static struct regulator_init_data omap3_vpll2_idata = {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d167a54..713e1d9 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -368,14 +368,9 @@ struct platform_device *dsi_get_dsidev_from_id(int module)
 	return dsi_pdev_map[module];
 }
 
-static int dsi_get_dsidev_id(struct platform_device *dsidev)
+static inline int dsi_get_dsidev_id(struct platform_device *dsidev)
 {
-	/* TEMP: Pass 0 as the dsi module index till the time the dsi platform
-	 * device names aren't changed to the form "omapdss_dsi.0",
-	 * "omapdss_dsi.1" and so on */
-	BUG_ON(dsidev->id != -1);
-
-	return 0;
+	return dsidev->id;
 }
 
 static inline void dsi_write_reg(struct platform_device *dsidev,
@@ -4465,7 +4460,7 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 }
 
 /* DSI1 HW IP initialisation */
-static int omap_dsi1hw_probe(struct platform_device *dsidev)
+static int omap_dsihw_probe(struct platform_device *dsidev)
 {
 	struct omap_display_platform_data *dss_plat_data;
 	struct omap_dss_board_info *board_info;
@@ -4575,7 +4570,7 @@ err_alloc:
 	return r;
 }
 
-static int omap_dsi1hw_remove(struct platform_device *dsidev)
+static int omap_dsihw_remove(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
@@ -4636,11 +4631,11 @@ static const struct dev_pm_ops dsi_pm_ops = {
 	.runtime_resume = dsi_runtime_resume,
 };
 
-static struct platform_driver omap_dsi1hw_driver = {
-	.probe          = omap_dsi1hw_probe,
-	.remove         = omap_dsi1hw_remove,
+static struct platform_driver omap_dsihw_driver = {
+	.probe          = omap_dsihw_probe,
+	.remove         = omap_dsihw_remove,
 	.driver         = {
-		.name   = "omapdss_dsi1",
+		.name   = "omapdss_dsi",
 		.owner  = THIS_MODULE,
 		.pm	= &dsi_pm_ops,
 	},
@@ -4648,10 +4643,10 @@ static struct platform_driver omap_dsi1hw_driver = {
 
 int dsi_init_platform_driver(void)
 {
-	return platform_driver_register(&omap_dsi1hw_driver);
+	return platform_driver_register(&omap_dsihw_driver);
 }
 
 void dsi_uninit_platform_driver(void)
 {
-	return platform_driver_unregister(&omap_dsi1hw_driver);
+	return platform_driver_unregister(&omap_dsihw_driver);
 }
-- 
1.7.4.1

