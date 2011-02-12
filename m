From: Daniel Morsing <daniel.morsing@gmail.com>
Subject: [PATCH 1/2] omap: dss2: Add recommended bpp option for generic dpi panels
Date: Sat, 12 Feb 2011 18:02:09 +0100
Message-ID: <1297530130-10355-2-git-send-email-daniel.morsing@gmail.com>
References: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54555 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1BLRCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 12:02:06 -0500
In-Reply-To: <1297530130-10355-1-git-send-email-daniel.morsing@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomba@iki.fi>
Cc: Bryan Wu <bryan.wu@canonical.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>

Currently, there is no way to specify a recommended bpp for a generic
dpi display. This patch adds a mechanism for doing so.

If no recommended bpp is specified by the driver, we fall back to the
default recommended bpp function

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 07eb30e..b52a28f 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -43,6 +43,8 @@ struct panel_config {
 	/* Unit: line clocks */
 	int acb;	/* ac-bias pin frequency */
 
+	int recommended_bpp; /* overrides the default bpp */
+
 	enum omap_panel_config config;
 
 	int power_on_delay;
@@ -331,6 +333,17 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 	return dpi_check_timings(dssdev, timings);
 }
 
+static int generic_dpi_panel_get_bpp(struct omap_dss_device *dssdev)
+{
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_config *panel_config = drv_data->panel_config;
+
+	if (panel_config->recommended_bpp != 0)
+		return panel_config->recommended_bpp;
+
+	return omapdss_default_get_recommended_bpp(dssdev);
+}
+
 static struct omap_dss_driver dpi_driver = {
 	.probe		= generic_dpi_panel_probe,
 	.remove		= generic_dpi_panel_remove,
@@ -344,6 +357,8 @@ static struct omap_dss_driver dpi_driver = {
 	.get_timings	= generic_dpi_panel_get_timings,
 	.check_timings	= generic_dpi_panel_check_timings,
 
+	.get_recommended_bpp = generic_dpi_panel_get_bpp,
+
 	.driver         = {
 		.name   = "generic_dpi_panel",
 		.owner  = THIS_MODULE,
-- 
1.7.4

