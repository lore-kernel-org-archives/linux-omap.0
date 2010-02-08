From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 11/17] OMAP: DSS2: move enable/get_te()
Date: Mon,  8 Feb 2010 17:57:35 +0200
Message-ID: <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45837 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab0BHPzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:22 -0500
In-Reply-To: <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move enable/get_te() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    5 +--
 drivers/video/omap2/displays/panel-taal.c |   18 ++++++++++
 drivers/video/omap2/dss/display.c         |    7 ++--
 drivers/video/omap2/dss/dsi.c             |   53 ++---------------------------
 drivers/video/omap2/dss/rfbi.c            |    7 ----
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    5 ++-
 drivers/video/omap2/omapfb/omapfb-main.c  |    4 +-
 7 files changed, 32 insertions(+), 67 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 950d781..d9829f1 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -486,9 +486,6 @@ struct omap_dss_device {
 	enum omap_dss_update_mode (*get_update_mode)
 		(struct omap_dss_device *dssdev);
 
-	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
-	int (*get_te)(struct omap_dss_device *dssdev);
-
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
@@ -516,6 +513,7 @@ struct omap_dss_driver {
 
 	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
 	int (*wait_for_te)(struct omap_dss_device *dssdev);
+	int (*get_te)(struct omap_dss_device *dssdev);
 
 	u8 (*get_rotate)(struct omap_dss_device *dssdev);
 	int (*set_rotate)(struct omap_dss_device *dssdev, u8 rotate);
@@ -570,5 +568,6 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
 void omapdss_dsi_vc_enable_hs(int channel, bool enable);
+int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 
 #endif
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e00502e..af4b0b0 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -736,6 +736,8 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
 	int r;
 
+	dsi_bus_lock();
+
 	td->te_enabled = enable;
 
 	if (enable)
@@ -743,9 +745,23 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	else
 		r = taal_dcs_write_0(DCS_TEAR_OFF);
 
+	omapdss_dsi_enable_te(dssdev, enable);
+
+	/* XXX for some reason, DSI TE breaks if we don't wait here.
+	 * Panel bug? Needs more studying */
+	msleep(100);
+
+	dsi_bus_unlock();
+
 	return r;
 }
 
+static int taal_get_te(struct omap_dss_device *dssdev)
+{
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	return td->te_enabled;
+}
+
 static int taal_wait_te(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
@@ -993,7 +1009,9 @@ static struct omap_dss_driver taal_driver = {
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
 	.enable_te	= taal_enable_te,
+	.get_te		= taal_get_te,
 	.wait_for_te	= taal_wait_te,
+
 	.set_rotate	= taal_rotate,
 	.get_rotate	= taal_get_rotate,
 	.set_mirror	= taal_mirror,
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index c5fecee..4c40300 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -106,7 +106,8 @@ static ssize_t display_tear_show(struct device *dev,
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	return snprintf(buf, PAGE_SIZE, "%d\n",
-			dssdev->get_te ? dssdev->get_te(dssdev) : 0);
+			dssdev->driver->get_te ?
+			dssdev->driver->get_te(dssdev) : 0);
 }
 
 static ssize_t display_tear_store(struct device *dev,
@@ -116,12 +117,12 @@ static ssize_t display_tear_store(struct device *dev,
 	unsigned long te;
 	int r;
 
-	if (!dssdev->enable_te || !dssdev->get_te)
+	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
 		return -ENOENT;
 
 	te = simple_strtoul(buf, NULL, 0);
 
-	r = dssdev->enable_te(dssdev, te);
+	r = dssdev->driver->enable_te(dssdev, te);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index eab45b8..4b885a4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2877,20 +2877,6 @@ static int dsi_set_update_mode(struct omap_dss_device *dssdev,
 	return r;
 }
 
-static int dsi_set_te(struct omap_dss_device *dssdev, bool enable)
-{
-	int r = 0;
-
-	if (dssdev->driver->enable_te) {
-		r = dssdev->driver->enable_te(dssdev, enable);
-		/* XXX for some reason, DSI TE breaks if we don't wait here.
-		 * Panel bug? Needs more studying */
-		msleep(100);
-	}
-
-	return r;
-}
-
 static void dsi_handle_framedone(void)
 {
 	int r;
@@ -3265,9 +3251,6 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	dsi.use_ext_te = dssdev->phy.dsi.ext_te;
-	r = dsi_set_te(dssdev, dsi.te_enabled);
-	if (r)
-		goto err4;
 
 	dsi_set_update_mode(dssdev, dsi.user_update_mode);
 
@@ -3276,9 +3259,6 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 
-err4:
-
-	dsi_display_uninit_dsi(dssdev);
 err3:
 	dsi_display_uninit_dispc(dssdev);
 err2:
@@ -3381,10 +3361,6 @@ static int dsi_display_resume(struct omap_dss_device *dssdev)
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	r = dsi_set_te(dssdev, dsi.te_enabled);
-	if (r)
-		goto err2;
-
 	dsi_set_update_mode(dssdev, dsi.user_update_mode);
 
 	dsi_bus_unlock();
@@ -3502,33 +3478,12 @@ static enum omap_dss_update_mode dsi_display_get_update_mode(
 }
 
 
-static int dsi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
+int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	int r = 0;
-
-	DSSDBGF("%d", enable);
-
-	if (!dssdev->driver->enable_te)
-		return -ENOENT;
-
-	dsi_bus_lock();
-
 	dsi.te_enabled = enable;
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		goto end;
-
-	r = dsi_set_te(dssdev, enable);
-end:
-	dsi_bus_unlock();
-
-	return r;
-}
-
-static int dsi_display_get_te(struct omap_dss_device *dssdev)
-{
-	return dsi.te_enabled;
+	return 0;
 }
+EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
@@ -3555,8 +3510,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->sync = dsi_display_sync;
 	dssdev->set_update_mode = dsi_display_set_update_mode;
 	dssdev->get_update_mode = dsi_display_get_update_mode;
-	dssdev->enable_te = dsi_display_enable_te;
-	dssdev->get_te = dsi_display_get_te;
 
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 6b9cd76..7129387 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1232,12 +1232,6 @@ static int rfbi_display_sync(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int rfbi_display_enable_te(struct omap_dss_device *dssdev, bool enable)
-{
-	dssdev->driver->enable_te(dssdev, enable);
-	return 0;
-}
-
 static int rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -1299,7 +1293,6 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 	dssdev->disable = rfbi_display_disable;
 	dssdev->update = rfbi_display_update;
 	dssdev->sync = rfbi_display_sync;
-	dssdev->enable_te = rfbi_display_enable_te;
 
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
 
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index e18a723..86467f8 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -783,12 +783,13 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		if (!display->enable_te) {
+		if (!display->driver->enable_te) {
 			r = -ENODEV;
 			break;
 		}
 
-		r = display->enable_te(display, !!p.tearsync_info.enabled);
+		r = display->driver->enable_te(display,
+				!!p.tearsync_info.enabled);
 
 		break;
 	}
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index f77256f..fff687b 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2205,8 +2205,8 @@ static int omapfb_probe(struct platform_device *pdev)
 				def_display->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_AUTO);
 #else /* MANUAL_UPDATE */
-			if (def_display->enable_te)
-				def_display->enable_te(def_display, 0);
+			if (def_display->driver->enable_te)
+				def_display->driver->enable_te(def_display, 0);
 			if (def_display->set_update_mode)
 				def_display->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_MANUAL);
-- 
1.6.5

