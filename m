From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 16/17] OMAP: DSS2: move timing functions
Date: Mon,  8 Feb 2010 17:57:40 +0200
Message-ID: <1265644661-3694-17-git-send-email-tomi.valkeinen@nokia.com>
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
 <1265644661-3694-16-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26959 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713Ab0BHPzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:48 -0500
In-Reply-To: <1265644661-3694-16-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move check/set/get_timings() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |   18 ++++---
 drivers/video/omap2/displays/panel-taal.c |    4 +-
 drivers/video/omap2/dss/display.c         |   10 ++--
 drivers/video/omap2/dss/dpi.c             |   16 ++----
 drivers/video/omap2/dss/sdi.c             |    8 ---
 drivers/video/omap2/dss/venc.c            |   82 ++++++++++++++--------------
 drivers/video/omap2/omapfb/omapfb-main.c  |   10 ++--
 7 files changed, 68 insertions(+), 80 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index e2d785c..ccf35a8 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -465,13 +465,6 @@ struct omap_dss_device {
 
 	enum omap_dss_display_state state;
 
-	int (*check_timings)(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
-	void (*set_timings)(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
-	void (*get_timings)(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
-
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
@@ -517,6 +510,13 @@ struct omap_dss_driver {
 			u16 *xres, u16 *yres);
 	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
 
+	int (*check_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*set_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*get_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 };
@@ -572,6 +572,10 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
+void dpi_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+int dpi_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index cdb7617..e0f1c9e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -516,8 +516,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dev_set_drvdata(&dssdev->dev, td);
 
-	dssdev->get_timings = taal_get_timings;
-
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
 	if (!dssdev->set_backlight)
@@ -1108,6 +1106,8 @@ static struct omap_dss_driver taal_driver = {
 	.run_test	= taal_run_test,
 	.memory_read	= taal_memory_read,
 
+	.get_timings	= taal_get_timings,
+
 	.driver         = {
 		.name   = "taal",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 3194f21..74b923a 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -135,10 +135,10 @@ static ssize_t display_timings_show(struct device *dev,
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	struct omap_video_timings t;
 
-	if (!dssdev->get_timings)
+	if (!dssdev->driver->get_timings)
 		return -ENOENT;
 
-	dssdev->get_timings(dssdev, &t);
+	dssdev->driver->get_timings(dssdev, &t);
 
 	return snprintf(buf, PAGE_SIZE, "%u,%u/%u/%u/%u,%u/%u/%u/%u\n",
 			t.pixel_clock,
@@ -153,7 +153,7 @@ static ssize_t display_timings_store(struct device *dev,
 	struct omap_video_timings t;
 	int r, found;
 
-	if (!dssdev->set_timings || !dssdev->check_timings)
+	if (!dssdev->driver->set_timings || !dssdev->driver->check_timings)
 		return -ENOENT;
 
 	found = 0;
@@ -172,11 +172,11 @@ static ssize_t display_timings_store(struct device *dev,
 				&t.y_res, &t.vfp, &t.vbp, &t.vsw) != 9)
 		return -EINVAL;
 
-	r = dssdev->check_timings(dssdev, &t);
+	r = dssdev->driver->check_timings(dssdev, &t);
 	if (r)
 		return r;
 
-	dssdev->set_timings(dssdev, &t);
+	dssdev->driver->set_timings(dssdev, &t);
 
 	return size;
 }
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 1eef8b7..960e977 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -227,7 +227,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
-static void dpi_set_timings(struct omap_dss_device *dssdev,
+void dpi_set_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
 	DSSDBG("dpi_set_timings\n");
@@ -237,8 +237,9 @@ static void dpi_set_timings(struct omap_dss_device *dssdev,
 		dispc_go(OMAP_DSS_CHANNEL_LCD);
 	}
 }
+EXPORT_SYMBOL(dpi_set_timings);
 
-static int dpi_check_timings(struct omap_dss_device *dssdev,
+int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
 	bool is_tft;
@@ -292,21 +293,12 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 
 	return 0;
 }
-
-static void dpi_get_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
+EXPORT_SYMBOL(dpi_check_timings);
 
 int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	dssdev->set_timings = dpi_set_timings;
-	dssdev->check_timings = dpi_check_timings;
-	dssdev->get_timings = dpi_get_timings;
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 929ceb3..12eb404 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -150,18 +150,10 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
-static void sdi_get_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
 int sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
-	dssdev->get_timings = sdi_get_timings;
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 5c6e98b..f0ba573 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -557,6 +557,43 @@ static int venc_set_update_mode(struct omap_dss_device *dssdev,
 	return 0;
 }
 
+static void venc_get_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	*timings = dssdev->panel.timings;
+}
+
+static void venc_set_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	DSSDBG("venc_set_timings\n");
+
+	/* Reset WSS data when the TV standard changes. */
+	if (memcmp(&dssdev->panel.timings, timings, sizeof(*timings)))
+		venc.wss_data = 0;
+
+	dssdev->panel.timings = *timings;
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		/* turn the venc off and on to get new timings to use */
+		venc_panel_disable(dssdev);
+		venc_panel_enable(dssdev);
+	}
+}
+
+static int venc_check_timings(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings)
+{
+	DSSDBG("venc_check_timings\n");
+
+	if (memcmp(&omap_dss_pal_timings, timings, sizeof(*timings)) == 0)
+		return 0;
+
+	if (memcmp(&omap_dss_ntsc_timings, timings, sizeof(*timings)) == 0)
+		return 0;
+
+	return -EINVAL;
+}
+
 static u32 venc_get_wss(struct omap_dss_device *dssdev)
 {
 	/* Invert due to VENC_L21_WC_CTL:INV=1 */
@@ -603,6 +640,10 @@ static struct omap_dss_driver venc_driver = {
 	.set_update_mode = venc_set_update_mode,
 	.get_update_mode = venc_get_update_mode,
 
+	.get_timings	= venc_get_timings,
+	.set_timings	= venc_set_timings,
+	.check_timings	= venc_check_timings,
+
 	.get_wss	= venc_get_wss,
 	.set_wss	= venc_set_wss,
 
@@ -653,51 +694,10 @@ void venc_exit(void)
 	iounmap(venc.base);
 }
 
-static void venc_get_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	*timings = dssdev->panel.timings;
-}
-
-static void venc_set_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	DSSDBG("venc_set_timings\n");
-
-	/* Reset WSS data when the TV standard changes. */
-	if (memcmp(&dssdev->panel.timings, timings, sizeof(*timings)))
-		venc.wss_data = 0;
-
-	dssdev->panel.timings = *timings;
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-		/* turn the venc off and on to get new timings to use */
-		venc_panel_disable(dssdev);
-		venc_panel_enable(dssdev);
-	}
-}
-
-static int venc_check_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings)
-{
-	DSSDBG("venc_check_timings\n");
-
-	if (memcmp(&omap_dss_pal_timings, timings, sizeof(*timings)) == 0)
-		return 0;
-
-	if (memcmp(&omap_dss_ntsc_timings, timings, sizeof(*timings)) == 0)
-		return 0;
-
-	return -EINVAL;
-}
-
 int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	dssdev->get_timings = venc_get_timings;
-	dssdev->set_timings = venc_set_timings;
-	dssdev->check_timings = venc_check_timings;
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index f0b304d..5b2e269 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -705,9 +705,9 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 	var->width              = -1;
 	var->grayscale          = 0;
 
-	if (display && display->get_timings) {
+	if (display && display->driver->get_timings) {
 		struct omap_video_timings timings;
-		display->get_timings(display, &timings);
+		display->driver->get_timings(display, &timings);
 
 		/* pixclock in ps, the rest in pixclock */
 		var->pixclock = timings.pixel_clock != 0 ?
@@ -2029,14 +2029,14 @@ static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
 	fbdev->bpp_overrides[fbdev->num_bpp_overrides].bpp = bpp;
 	++fbdev->num_bpp_overrides;
 
-	if (!display->check_timings || !display->set_timings)
+	if (!display->driver->check_timings || !display->driver->set_timings)
 		return -EINVAL;
 
-	r = display->check_timings(display, &timings);
+	r = display->driver->check_timings(display, &timings);
 	if (r)
 		return r;
 
-	display->set_timings(display, &timings);
+	display->driver->set_timings(display, &timings);
 
 	return 0;
 }
-- 
1.6.5

