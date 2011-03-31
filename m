From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/9] OMAP: DSS2: OMAPFB: Handle errors when initializing panel
Date: Thu, 31 Mar 2011 13:11:04 +0300
Message-ID: <1301566266-11187-8-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:51197 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933501Ab1CaKLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:35 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Errors from the panel driver were ignored during panel initialization.
Handle the errors and fail accordingly.

Also move the display initialization to a separate function to make it
cleaner.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   80 ++++++++++++++++++++++--------
 1 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 163fb8b..1b89e28 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2193,6 +2193,61 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	return r;
 }
 
+static int omapfb_init_display(struct omapfb2_device *fbdev,
+		struct omap_dss_device *dssdev)
+{
+	struct omap_dss_driver *dssdrv = dssdev->driver;
+	int r;
+
+	r = dssdrv->enable(dssdev);
+	if (r) {
+		dev_warn(fbdev->dev, "Failed to enable display '%s'\n",
+				dssdev->name);
+		return r;
+	}
+
+	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
+		u16 w, h;
+		if (dssdrv->enable_te) {
+			r = dssdrv->enable_te(dssdev, 1);
+			if (r) {
+				dev_err(fbdev->dev, "Failed to set TE\n");
+				return r;
+			}
+		}
+
+		if (dssdrv->set_update_mode) {
+			r = dssdrv->set_update_mode(dssdev,
+					OMAP_DSS_UPDATE_MANUAL);
+			if (r) {
+				dev_err(fbdev->dev,
+						"Failed to set update mode\n");
+				return r;
+			}
+		}
+
+		dssdrv->get_resolution(dssdev, &w, &h);
+		r = dssdrv->update(dssdev, 0, 0, w, h);
+		if (r) {
+			dev_err(fbdev->dev,
+					"Failed to update display\n");
+			return r;
+		}
+	} else {
+		if (dssdrv->set_update_mode) {
+			r = dssdrv->set_update_mode(dssdev,
+					OMAP_DSS_UPDATE_AUTO);
+			if (r) {
+				dev_err(fbdev->dev,
+						"Failed to set update mode\n");
+				return r;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
@@ -2292,30 +2347,13 @@ static int omapfb_probe(struct platform_device *pdev)
 	}
 
 	if (def_display) {
-		struct omap_dss_driver *dssdrv = def_display->driver;
-
-		r = def_display->driver->enable(def_display);
+		r = omapfb_init_display(fbdev, def_display);
 		if (r) {
-			dev_warn(fbdev->dev, "Failed to enable display '%s'\n",
-					def_display->name);
+			dev_err(fbdev->dev,
+					"failed to initialize default "
+					"display\n");
 			goto cleanup;
 		}
-
-		if (def_display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
-			u16 w, h;
-			if (dssdrv->enable_te)
-				dssdrv->enable_te(def_display, 1);
-			if (dssdrv->set_update_mode)
-				dssdrv->set_update_mode(def_display,
-						OMAP_DSS_UPDATE_MANUAL);
-
-			dssdrv->get_resolution(def_display, &w, &h);
-			def_display->driver->update(def_display, 0, 0, w, h);
-		} else {
-			if (dssdrv->set_update_mode)
-				dssdrv->set_update_mode(def_display,
-						OMAP_DSS_UPDATE_AUTO);
-		}
 	}
 
 	DBG("create sysfs for fbs\n");
-- 
1.7.1

