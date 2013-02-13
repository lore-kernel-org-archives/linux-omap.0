From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/11] OMAPDSS: acx565akm: remove platform backlight calls
Date: Wed, 13 Feb 2013 19:37:04 +0530
Message-ID: <1360764434-18788-2-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55792 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646Ab3BMOH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:07:57 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

acx565akm has support to call set_backlight/get_backlight in platform
code. They are not used by any board, and thus can be removed from the
driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index 72699f8..a980a11 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -336,8 +336,6 @@ static int acx565akm_bl_update_status(struct backlight_device *dev)
 	r = 0;
 	if (md->has_bc)
 		acx565akm_set_brightness(md, level);
-	else if (md->dssdev->set_backlight)
-		r = md->dssdev->set_backlight(md->dssdev, level);
 	else
 		r = -ENODEV;
 
@@ -352,7 +350,7 @@ static int acx565akm_bl_get_intensity(struct backlight_device *dev)
 
 	dev_dbg(&dev->dev, "%s\n", __func__);
 
-	if (!md->has_bc && md->dssdev->set_backlight == NULL)
+	if (!md->has_bc)
 		return -ENODEV;
 
 	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
@@ -564,8 +562,6 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 
 	if (md->has_bc)
 		brightness = acx565akm_get_actual_brightness(md);
-	else if (dssdev->get_backlight)
-		brightness = dssdev->get_backlight(dssdev);
 	else
 		brightness = 0;
 
-- 
1.7.9.5

