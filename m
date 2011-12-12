From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAPDSS: Panel NEC: Set omap_dss_device states correctly
Date: Mon, 12 Dec 2011 11:47:42 +0530
Message-ID: <1323670663-17793-3-git-send-email-archit@ti.com>
References: <1323670663-17793-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab1LLGSc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 01:18:32 -0500
In-Reply-To: <1323670663-17793-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Erik Gilling <konkers@android.com>

The display state parameter of omap_dss_device struct is not being set correctly
in the panel driver NEC panel driver panel-nec-nl8048hl11-01b.c. Set the correct
states in the panel's enable/disable/suspend/resume functions.

CC: Erik Gilling <konkers@android.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   61 +++++++++++++++++---
 1 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 2ba9d0c..94e0f20 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -163,50 +163,93 @@ static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
 	kfree(necd);
 }
 
-static int nec_8048_panel_enable(struct omap_dss_device *dssdev)
+static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 {
-	int r = 0;
+	int r;
 	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
 	struct backlight_device *bl = necd->bl;
 
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
+		return 0;
+
+	r = omapdss_dpi_display_enable(dssdev);
+	if (r)
+		goto err0;
+
 	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
 		if (r)
-			return r;
+			goto err1;
 	}
 
 	r = nec_8048_bl_update_status(bl);
 	if (r < 0)
 		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
 
-	r = omapdss_dpi_display_enable(dssdev);
-
+	return 0;
+err1:
+	omapdss_dpi_display_disable(dssdev);
+err0:
 	return r;
 }
 
-static void nec_8048_panel_disable(struct omap_dss_device *dssdev)
+static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
 	struct backlight_device *bl = necd->bl;
 
-	omapdss_dpi_display_disable(dssdev);
+	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+		return;
 
 	bl->props.brightness = 0;
 	nec_8048_bl_update_status(bl);
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
+
+	omapdss_dpi_display_disable(dssdev);
+}
+
+static int nec_8048_panel_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	r = nec_8048_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
+}
+
+static void nec_8048_panel_disable(struct omap_dss_device *dssdev)
+{
+	nec_8048_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
 static int nec_8048_panel_suspend(struct omap_dss_device *dssdev)
 {
-	nec_8048_panel_disable(dssdev);
+	nec_8048_panel_power_off(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
 	return 0;
 }
 
 static int nec_8048_panel_resume(struct omap_dss_device *dssdev)
 {
-	return nec_8048_panel_enable(dssdev);
+	int r;
+
+	r = nec_8048_panel_power_on(dssdev);
+	if (r)
+		return r;
+
+	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+
+	return 0;
 }
 
 static int nec_8048_recommended_bpp(struct omap_dss_device *dssdev)
-- 
1.7.4.1

