From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 15/17] OMAP: DSS2: move set/get_wss()
Date: Mon,  8 Feb 2010 17:57:39 +0200
Message-ID: <1265644661-3694-16-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45844 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab0BHPza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:30 -0500
In-Reply-To: <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move set/get_wss() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    6 +-
 drivers/video/omap2/dss/display.c         |    8 ++--
 drivers/video/omap2/dss/venc.c            |   67 +++++++++++++++--------------
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index cc2b4e3..e2d785c 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -472,9 +472,6 @@ struct omap_dss_device {
 	void (*get_timings)(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
 
-	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
-	u32 (*get_wss)(struct omap_dss_device *dssdev);
-
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
@@ -519,6 +516,9 @@ struct omap_dss_driver {
 	void (*get_resolution)(struct omap_dss_device *dssdev,
 			u16 *xres, u16 *yres);
 	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
+
+	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
+	u32 (*get_wss)(struct omap_dss_device *dssdev);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index bc8ae35..3194f21 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -247,10 +247,10 @@ static ssize_t display_wss_show(struct device *dev,
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	unsigned int wss;
 
-	if (!dssdev->get_wss)
+	if (!dssdev->driver->get_wss)
 		return -ENOENT;
 
-	wss = dssdev->get_wss(dssdev);
+	wss = dssdev->driver->get_wss(dssdev);
 
 	return snprintf(buf, PAGE_SIZE, "0x%05x\n", wss);
 }
@@ -262,7 +262,7 @@ static ssize_t display_wss_store(struct device *dev,
 	unsigned long wss;
 	int r;
 
-	if (!dssdev->get_wss || !dssdev->set_wss)
+	if (!dssdev->driver->get_wss || !dssdev->driver->set_wss)
 		return -ENOENT;
 
 	if (strict_strtoul(buf, 0, &wss))
@@ -271,7 +271,7 @@ static ssize_t display_wss_store(struct device *dev,
 	if (wss > 0xfffff)
 		return -EINVAL;
 
-	r = dssdev->set_wss(dssdev, wss);
+	r = dssdev->driver->set_wss(dssdev, wss);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index a0ab52c..5c6e98b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -557,6 +557,37 @@ static int venc_set_update_mode(struct omap_dss_device *dssdev,
 	return 0;
 }
 
+static u32 venc_get_wss(struct omap_dss_device *dssdev)
+{
+	/* Invert due to VENC_L21_WC_CTL:INV=1 */
+	return (venc.wss_data >> 8) ^ 0xfffff;
+}
+
+static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
+{
+	const struct venc_config *config;
+
+	DSSDBG("venc_set_wss\n");
+
+	mutex_lock(&venc.venc_lock);
+
+	config = venc_timings_to_config(&dssdev->panel.timings);
+
+	/* Invert due to VENC_L21_WC_CTL:INV=1 */
+	venc.wss_data = (wss ^ 0xfffff) << 8;
+
+	venc_enable_clocks(1);
+
+	venc_write_reg(VENC_BSTAMP_WSS_DATA, config->bstamp_wss_data |
+			venc.wss_data);
+
+	venc_enable_clocks(0);
+
+	mutex_unlock(&venc.venc_lock);
+
+	return 0;
+}
+
 static struct omap_dss_driver venc_driver = {
 	.probe		= venc_panel_probe,
 	.remove		= venc_panel_remove,
@@ -572,6 +603,9 @@ static struct omap_dss_driver venc_driver = {
 	.set_update_mode = venc_set_update_mode,
 	.get_update_mode = venc_get_update_mode,
 
+	.get_wss	= venc_get_wss,
+	.set_wss	= venc_set_wss,
+
 	.driver         = {
 		.name   = "venc",
 		.owner  = THIS_MODULE,
@@ -656,37 +690,6 @@ static int venc_check_timings(struct omap_dss_device *dssdev,
 	return -EINVAL;
 }
 
-static u32 venc_get_wss(struct omap_dss_device *dssdev)
-{
-	/* Invert due to VENC_L21_WC_CTL:INV=1 */
-	return (venc.wss_data >> 8) ^ 0xfffff;
-}
-
-static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
-{
-	const struct venc_config *config;
-
-	DSSDBG("venc_set_wss\n");
-
-	mutex_lock(&venc.venc_lock);
-
-	config = venc_timings_to_config(&dssdev->panel.timings);
-
-	/* Invert due to VENC_L21_WC_CTL:INV=1 */
-	venc.wss_data = (wss ^ 0xfffff) << 8;
-
-	venc_enable_clocks(1);
-
-	venc_write_reg(VENC_BSTAMP_WSS_DATA, config->bstamp_wss_data |
-			venc.wss_data);
-
-	venc_enable_clocks(0);
-
-	mutex_unlock(&venc.venc_lock);
-
-	return 0;
-}
-
 int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -694,8 +697,6 @@ int venc_init_display(struct omap_dss_device *dssdev)
 	dssdev->get_timings = venc_get_timings;
 	dssdev->set_timings = venc_set_timings;
 	dssdev->check_timings = venc_check_timings;
-	dssdev->get_wss = venc_get_wss;
-	dssdev->set_wss = venc_set_wss;
 
 	return 0;
 }
-- 
1.6.5

