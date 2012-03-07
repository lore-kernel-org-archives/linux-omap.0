From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/21] OMAPDSS: Taal: move reset gpio handling to taal driver
Date: Wed,  7 Mar 2012 14:44:36 +0200
Message-ID: <1331124290-6285-8-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:34210 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758441Ab2CGMp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:27 -0500
Received: by lagz14 with SMTP id z14so9201098lag.0
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:24 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The reset GPIO for Taal panel driver is currently requested in the
4430sdp board file. This patch moves the gpio request/free into the Taal
driver, where it should be.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c       |   16 ----------------
 drivers/video/omap2/displays/panel-taal.c |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 4e90715..3a05173 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -724,21 +724,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
 };
 
-static void sdp4430_lcd_init(void)
-{
-	int r;
-
-	r = gpio_request_one(dsi1_panel.reset_gpio, GPIOF_DIR_OUT,
-		"lcd1_reset_gpio");
-	if (r)
-		pr_err("%s: Could not get lcd1_reset_gpio\n", __func__);
-
-	r = gpio_request_one(dsi2_panel.reset_gpio, GPIOF_DIR_OUT,
-		"lcd2_reset_gpio");
-	if (r)
-		pr_err("%s: Could not get lcd2_reset_gpio\n", __func__);
-}
-
 static struct omap_dss_hdmi_data sdp4430_hdmi_data = {
 	.hpd_gpio = HDMI_GPIO_HPD,
 };
@@ -824,7 +809,6 @@ static void __init omap_4430sdp_display_init(void)
 	if (r)
 		pr_err("%s: Could not get display_sel GPIO\n", __func__);
 
-	sdp4430_lcd_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	/*
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 00c5c61..6e240fe 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -993,6 +993,15 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dev_set_drvdata(&dssdev->dev, td);
 
+	if (gpio_is_valid(panel_data->reset_gpio)) {
+		r = gpio_request_one(panel_data->reset_gpio, GPIOF_OUT_INIT_LOW,
+				"taal rst");
+		if (r) {
+			dev_err(&dssdev->dev, "failed to request reset gpio\n");
+			goto err_rst_gpio;
+		}
+	}
+
 	taal_hw_reset(dssdev);
 
 	if (panel_data->use_dsi_backlight) {
@@ -1075,6 +1084,9 @@ err_gpio:
 	if (bldev != NULL)
 		backlight_device_unregister(bldev);
 err_bl:
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_free(panel_data->reset_gpio);
+err_rst_gpio:
 	destroy_workqueue(td->workqueue);
 err_wq:
 	free_regulators(panel_config->regulators, panel_config->num_regulators);
@@ -1115,6 +1127,9 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
 
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_free(panel_data->reset_gpio);
+
 	free_regulators(td->panel_config->regulators,
 			td->panel_config->num_regulators);
 
-- 
1.7.4.1

