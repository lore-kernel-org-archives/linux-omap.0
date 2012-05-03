From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/25] OMAPDSS: Taal: move reset gpio handling to taal driver
Date: Thu,  3 May 2012 16:57:43 +0300
Message-ID: <1336053481-25433-8-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34426 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756108Ab2ECN63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:29 -0400
Received: by lahj13 with SMTP id j13so1764667lah.33
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:26 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
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
index 130ab00..6cbb16f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -758,21 +758,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
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
@@ -858,7 +843,6 @@ static void __init omap_4430sdp_display_init(void)
 	if (r)
 		pr_err("%s: Could not get display_sel GPIO\n", __func__);
 
-	sdp4430_lcd_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
 	/*
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3053399..be9992f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -912,6 +912,15 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
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
@@ -992,6 +1001,9 @@ err_gpio:
 	if (bldev != NULL)
 		backlight_device_unregister(bldev);
 err_bl:
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_free(panel_data->reset_gpio);
+err_rst_gpio:
 	destroy_workqueue(td->workqueue);
 err_wq:
 	kfree(td);
@@ -1030,6 +1042,9 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	/* reset, to be sure that the panel is in a valid state */
 	taal_hw_reset(dssdev);
 
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_free(panel_data->reset_gpio);
+
 	kfree(td);
 }
 
-- 
1.7.9.5

