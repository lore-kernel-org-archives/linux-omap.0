From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/5] OMAPDSS: remove venc_panel.c
Date: Fri, 9 May 2014 15:32:04 +0300
Message-ID: <1399638727-23254-2-git-send-email-tomi.valkeinen@ti.com>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40524 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbaEIMc3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:32:29 -0400
In-Reply-To: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The use of venc_panel.c was removed in
09d2e7cdebd53b7572380a215008b334ff6321a5 (OMAPDSS: VENC: remove code
related to old panel model), but the file itself was left behind. Remove
the unused file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/venc_panel.c | 232 -----------------------------
 1 file changed, 232 deletions(-)
 delete mode 100644 drivers/video/fbdev/omap2/dss/venc_panel.c

diff --git a/drivers/video/fbdev/omap2/dss/venc_panel.c b/drivers/video/fbdev/omap2/dss/venc_panel.c
deleted file mode 100644
index af68cd444d7e..000000000000
--- a/drivers/video/fbdev/omap2/dss/venc_panel.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Copyright (C) 2009 Nokia Corporation
- * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
- *
- * VENC panel driver
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/mutex.h>
-#include <linux/module.h>
-
-#include <video/omapdss.h>
-
-#include "dss.h"
-
-static struct {
-	struct mutex lock;
-} venc_panel;
-
-static ssize_t display_output_type_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	const char *ret;
-
-	switch (dssdev->phy.venc.type) {
-	case OMAP_DSS_VENC_TYPE_COMPOSITE:
-		ret = "composite";
-		break;
-	case OMAP_DSS_VENC_TYPE_SVIDEO:
-		ret = "svideo";
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", ret);
-}
-
-static ssize_t display_output_type_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	enum omap_dss_venc_type new_type;
-
-	if (sysfs_streq("composite", buf))
-		new_type = OMAP_DSS_VENC_TYPE_COMPOSITE;
-	else if (sysfs_streq("svideo", buf))
-		new_type = OMAP_DSS_VENC_TYPE_SVIDEO;
-	else
-		return -EINVAL;
-
-	mutex_lock(&venc_panel.lock);
-
-	if (dssdev->phy.venc.type != new_type) {
-		dssdev->phy.venc.type = new_type;
-		omapdss_venc_set_type(dssdev, new_type);
-		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-			omapdss_venc_display_disable(dssdev);
-			omapdss_venc_display_enable(dssdev);
-		}
-	}
-
-	mutex_unlock(&venc_panel.lock);
-
-	return size;
-}
-
-static DEVICE_ATTR(output_type, S_IRUGO | S_IWUSR,
-		display_output_type_show, display_output_type_store);
-
-static int venc_panel_probe(struct omap_dss_device *dssdev)
-{
-	/* set default timings to PAL */
-	const struct omap_video_timings default_timings = {
-		.x_res		= 720,
-		.y_res		= 574,
-		.pixelclock	= 13500000,
-		.hsw		= 64,
-		.hfp		= 12,
-		.hbp		= 68,
-		.vsw		= 5,
-		.vfp		= 5,
-		.vbp		= 41,
-
-		.vsync_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-		.hsync_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-
-		.interlace	= true,
-	};
-
-	mutex_init(&venc_panel.lock);
-
-	dssdev->panel.timings = default_timings;
-
-	return device_create_file(dssdev->dev, &dev_attr_output_type);
-}
-
-static void venc_panel_remove(struct omap_dss_device *dssdev)
-{
-	device_remove_file(dssdev->dev, &dev_attr_output_type);
-}
-
-static int venc_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	dev_dbg(dssdev->dev, "venc_panel_enable\n");
-
-	mutex_lock(&venc_panel.lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	omapdss_venc_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_venc_set_type(dssdev, dssdev->phy.venc.type);
-	omapdss_venc_invert_vid_out_polarity(dssdev,
-		dssdev->phy.venc.invert_polarity);
-
-	r = omapdss_venc_display_enable(dssdev);
-	if (r)
-		goto err;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	mutex_unlock(&venc_panel.lock);
-
-	return 0;
-err:
-	mutex_unlock(&venc_panel.lock);
-
-	return r;
-}
-
-static void venc_panel_disable(struct omap_dss_device *dssdev)
-{
-	dev_dbg(dssdev->dev, "venc_panel_disable\n");
-
-	mutex_lock(&venc_panel.lock);
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_DISABLED)
-		goto end;
-
-	omapdss_venc_display_disable(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-end:
-	mutex_unlock(&venc_panel.lock);
-}
-
-static void venc_panel_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	dev_dbg(dssdev->dev, "venc_panel_set_timings\n");
-
-	mutex_lock(&venc_panel.lock);
-
-	omapdss_venc_set_timings(dssdev, timings);
-	dssdev->panel.timings = *timings;
-
-	mutex_unlock(&venc_panel.lock);
-}
-
-static int venc_panel_check_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings)
-{
-	dev_dbg(dssdev->dev, "venc_panel_check_timings\n");
-
-	return omapdss_venc_check_timings(dssdev, timings);
-}
-
-static u32 venc_panel_get_wss(struct omap_dss_device *dssdev)
-{
-	dev_dbg(dssdev->dev, "venc_panel_get_wss\n");
-
-	return omapdss_venc_get_wss(dssdev);
-}
-
-static int venc_panel_set_wss(struct omap_dss_device *dssdev, u32 wss)
-{
-	dev_dbg(dssdev->dev, "venc_panel_set_wss\n");
-
-	return omapdss_venc_set_wss(dssdev, wss);
-}
-
-static struct omap_dss_driver venc_driver = {
-	.probe		= venc_panel_probe,
-	.remove		= venc_panel_remove,
-
-	.enable		= venc_panel_enable,
-	.disable	= venc_panel_disable,
-
-	.get_resolution	= omapdss_default_get_resolution,
-	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
-
-	.set_timings	= venc_panel_set_timings,
-	.check_timings	= venc_panel_check_timings,
-
-	.get_wss	= venc_panel_get_wss,
-	.set_wss	= venc_panel_set_wss,
-
-	.driver         = {
-		.name   = "venc",
-		.owner  = THIS_MODULE,
-	},
-};
-
-int venc_panel_init(void)
-{
-	return omap_dss_register_driver(&venc_driver);
-}
-
-void venc_panel_exit(void)
-{
-	omap_dss_unregister_driver(&venc_driver);
-}
-- 
1.9.1

