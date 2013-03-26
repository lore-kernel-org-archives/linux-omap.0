From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/26] OMAPDSS: HDMI: convert to platform device
Date: Tue, 26 Mar 2013 15:33:49 +0200
Message-ID: <1364304836-18134-20-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55881 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934269Ab3CZNe6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:58 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Convert HDMI driver from omap_dss_driver to a platform driver. The
driver uses the new panel support from omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi_panel.c |   48 +++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index dfb8eda..bc4dea3 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -26,10 +26,13 @@
 #include <linux/module.h>
 #include <video/omapdss.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
 
 #include "dss.h"
 
 static struct {
+	struct omap_dss_device dssdev;
+
 	/* This protects the panel ops, mainly when accessing the HDMI IP. */
 	struct mutex lock;
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
@@ -38,8 +41,9 @@ static struct {
 #endif
 } hdmi;
 
+static struct omap_dss_driver hdmi_driver;
 
-static int hdmi_panel_probe(struct omap_dss_device *dssdev)
+static int hdmi_panel_probe(struct platform_device *pdev)
 {
 	/* Initialize default timings to VGA in DVI mode */
 	const struct omap_video_timings default_timings = {
@@ -59,9 +63,22 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 		.interlace	= false,
 	};
 
+	struct omap_dss_hdmi_data *pdata = dev_get_platdata(&pdev->dev);
+	struct omap_dss_device *dssdev = &hdmi.dssdev;
+	int r;
+
 	DSSDBG("ENTER hdmi_panel_probe\n");
 
 	dssdev->panel.timings = default_timings;
+	dssdev->driver = &hdmi_driver;
+	dssdev->name = "hdmi";
+	dssdev->panel_dev = &pdev->dev;
+
+	/*
+	 * XXX for now, the hdmi panel's platform data contains the gpios for
+	 * the tpd level shifter chip, so we pass this data to the hdmi driver.
+	 */
+	dssdev->data = pdata;
 
 	DSSDBG("hdmi_panel_probe x_res= %d y_res = %d\n",
 		dssdev->panel.timings.x_res,
@@ -69,12 +86,19 @@ static int hdmi_panel_probe(struct omap_dss_device *dssdev)
 
 	omapdss_hdmi_display_set_timing(dssdev, &dssdev->panel.timings);
 
+	r = omap_hdmi_register_panel(dssdev);
+	if (r) {
+		DSSERR("Failed to register panel\n");
+		return r;
+	}
+
 	return 0;
 }
 
-static void hdmi_panel_remove(struct omap_dss_device *dssdev)
+static int hdmi_panel_remove(struct platform_device *pdev)
 {
-
+	omap_hdmi_free_panel(&hdmi.dssdev);
+	return 0;
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
@@ -375,8 +399,6 @@ err:
 }
 
 static struct omap_dss_driver hdmi_driver = {
-	.probe		= hdmi_panel_probe,
-	.remove		= hdmi_panel_remove,
 	.enable		= hdmi_panel_enable,
 	.disable	= hdmi_panel_disable,
 	.get_timings	= hdmi_get_timings,
@@ -384,15 +406,21 @@ static struct omap_dss_driver hdmi_driver = {
 	.check_timings	= hdmi_check_timings,
 	.read_edid	= hdmi_read_edid,
 	.detect		= hdmi_detect,
+	.get_resolution	= omapdss_default_get_resolution,
 	.audio_enable	= hdmi_panel_audio_enable,
 	.audio_disable	= hdmi_panel_audio_disable,
 	.audio_start	= hdmi_panel_audio_start,
 	.audio_stop	= hdmi_panel_audio_stop,
 	.audio_supported	= hdmi_panel_audio_supported,
 	.audio_config	= hdmi_panel_audio_config,
-	.driver			= {
-		.name   = "hdmi_panel",
-		.owner  = THIS_MODULE,
+};
+
+static struct platform_driver hdmi_panel_platform_driver = {
+	.probe	= hdmi_panel_probe,
+	.remove	= hdmi_panel_remove,
+	.driver	= {
+		.name	= "hdmi_panel",
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -404,11 +432,11 @@ int hdmi_panel_init(void)
 	spin_lock_init(&hdmi.audio_lock);
 #endif
 
-	return omap_dss_register_driver(&hdmi_driver);
+	return platform_driver_register(&hdmi_panel_platform_driver);
 }
 
 void hdmi_panel_exit(void)
 {
-	omap_dss_unregister_driver(&hdmi_driver);
+	platform_driver_unregister(&hdmi_panel_platform_driver);
 
 }
-- 
1.7.10.4

