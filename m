From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] OMAP: DSS2: OMAPFB: Implement auto-update mode
Date: Mon, 13 Jun 2011 12:12:53 +0300
Message-ID: <1307956374-1107-3-git-send-email-tomi.valkeinen@ti.com>
References: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46740 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755217Ab1FMJNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 05:13:09 -0400
In-Reply-To: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement auto-update mode for manual-update displays. omapfb driver
uses a delayed work to update the display with a constant rate.

The update mode can be changed via OMAPFB_SET_UPDATE_MODE ioctl, which
previously called omapdss but is now handled inside omapfb, and a new
sysfs file, "update_mode".

The update interval is by default 20 times per second, but can be
changed via "auto_update_freq" module parameter. There is also a new
module parameter "auto_update", which will make omapfb start manual
update displays in auto-update mode.

This auto-update mode can be used for testing if the userspace does not
support manual update displays properly. However, it is a very
inefficient solution, and should be considered more as a hack for
testing than something that could be used as a long term solution.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   72 ++++++++--------
 drivers/video/omap2/omapfb/omapfb-main.c  |  130 ++++++++++++++++++++++++----
 drivers/video/omap2/omapfb/omapfb-sysfs.c |   34 ++++++++
 drivers/video/omap2/omapfb/omapfb.h       |   13 +++
 4 files changed, 194 insertions(+), 55 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index cff4503..6b1ac23 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -316,67 +316,67 @@ int omapfb_update_window(struct fb_info *fbi,
 }
 EXPORT_SYMBOL(omapfb_update_window);
 
-static int omapfb_set_update_mode(struct fb_info *fbi,
+int omapfb_set_update_mode(struct fb_info *fbi,
 				   enum omapfb_update_mode mode)
 {
 	struct omap_dss_device *display = fb2display(fbi);
-	enum omap_dss_update_mode um;
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	struct omapfb_display_data *d;
 	int r;
 
-	if (!display || !display->driver->set_update_mode)
+	if (!display)
 		return -EINVAL;
 
-	switch (mode) {
-	case OMAPFB_UPDATE_DISABLED:
-		um = OMAP_DSS_UPDATE_DISABLED;
-		break;
+	if (mode != OMAPFB_AUTO_UPDATE && mode != OMAPFB_MANUAL_UPDATE)
+		return -EINVAL;
 
-	case OMAPFB_AUTO_UPDATE:
-		um = OMAP_DSS_UPDATE_AUTO;
-		break;
+	omapfb_lock(fbdev);
 
-	case OMAPFB_MANUAL_UPDATE:
-		um = OMAP_DSS_UPDATE_MANUAL;
-		break;
+	d = get_display_data(fbdev, display);
 
-	default:
-		return -EINVAL;
+	if (d->update_mode == mode) {
+		omapfb_unlock(fbdev);
+		return 0;
 	}
 
-	r = display->driver->set_update_mode(display, um);
+	r = 0;
+
+	if (display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
+		if (mode == OMAPFB_AUTO_UPDATE)
+			omapfb_start_auto_update(fbdev, display);
+		else /* MANUAL_UPDATE */
+			omapfb_stop_auto_update(fbdev, display);
+
+		d->update_mode = mode;
+	} else { /* AUTO_UPDATE */
+		if (mode == OMAPFB_MANUAL_UPDATE)
+			r = -EINVAL;
+	}
+
+	omapfb_unlock(fbdev);
 
 	return r;
 }
 
-static int omapfb_get_update_mode(struct fb_info *fbi,
+int omapfb_get_update_mode(struct fb_info *fbi,
 		enum omapfb_update_mode *mode)
 {
 	struct omap_dss_device *display = fb2display(fbi);
-	enum omap_dss_update_mode m;
+	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
+	struct omapfb_display_data *d;
 
 	if (!display)
 		return -EINVAL;
 
-	if (!display->driver->get_update_mode) {
-		*mode = OMAPFB_AUTO_UPDATE;
-		return 0;
-	}
+	omapfb_lock(fbdev);
 
-	m = display->driver->get_update_mode(display);
+	d = get_display_data(fbdev, display);
 
-	switch (m) {
-	case OMAP_DSS_UPDATE_DISABLED:
-		*mode = OMAPFB_UPDATE_DISABLED;
-		break;
-	case OMAP_DSS_UPDATE_AUTO:
-		*mode = OMAPFB_AUTO_UPDATE;
-		break;
-	case OMAP_DSS_UPDATE_MANUAL:
-		*mode = OMAPFB_MANUAL_UPDATE;
-		break;
-	default:
-		BUG();
-	}
+	*mode = d->update_mode;
+
+	omapfb_unlock(fbdev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 44eb666..c2514a2 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -46,6 +46,10 @@ static char *def_vram;
 static int def_vrfb;
 static int def_rotate;
 static int def_mirror;
+static bool auto_update;
+static unsigned int auto_update_freq;
+module_param(auto_update, bool, 0);
+module_param(auto_update_freq, uint, 0644);
 
 #ifdef DEBUG
 unsigned int omapfb_debug;
@@ -1242,6 +1246,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 	struct omapfb_info *ofbi = FB2OFB(fbi);
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omap_dss_device *display = fb2display(fbi);
+	struct omapfb_display_data *d;
 	int r = 0;
 
 	if (!display)
@@ -1249,6 +1254,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 
 	omapfb_lock(fbdev);
 
+	d = get_display_data(fbdev, display);
+
 	switch (blank) {
 	case FB_BLANK_UNBLANK:
 		if (display->state != OMAP_DSS_DISPLAY_SUSPENDED)
@@ -1257,6 +1264,11 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->driver->resume)
 			r = display->driver->resume(display);
 
+		if ((display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) &&
+				d->update_mode == OMAPFB_AUTO_UPDATE &&
+				!d->auto_update_work_enabled)
+			omapfb_start_auto_update(fbdev, display);
+
 		break;
 
 	case FB_BLANK_NORMAL:
@@ -1268,6 +1280,9 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->state != OMAP_DSS_DISPLAY_ACTIVE)
 			goto exit;
 
+		if (d->auto_update_work_enabled)
+			omapfb_stop_auto_update(fbdev, display);
+
 		if (display->driver->suspend)
 			r = display->driver->suspend(display);
 
@@ -1724,6 +1739,78 @@ err:
 	return r;
 }
 
+static void omapfb_auto_update_work(struct work_struct *work)
+{
+	struct omap_dss_device *dssdev;
+	struct omap_dss_driver *dssdrv;
+	struct omapfb_display_data *d;
+	u16 w, h;
+	unsigned int freq;
+	struct omapfb2_device *fbdev;
+
+	d = container_of(work, struct omapfb_display_data,
+			auto_update_work.work);
+
+	dssdev = d->dssdev;
+	dssdrv = dssdev->driver;
+	fbdev = d->fbdev;
+
+	if (!dssdrv || !dssdrv->update)
+		return;
+
+	if (dssdrv->sync)
+		dssdrv->sync(dssdev);
+
+	dssdrv->get_resolution(dssdev, &w, &h);
+	dssdrv->update(dssdev, 0, 0, w, h);
+
+	freq = auto_update_freq;
+	if (freq == 0)
+		freq = 20;
+	queue_delayed_work(fbdev->auto_update_wq,
+			&d->auto_update_work, HZ / freq);
+}
+
+void omapfb_start_auto_update(struct omapfb2_device *fbdev,
+		struct omap_dss_device *display)
+{
+	struct omapfb_display_data *d;
+
+	if (fbdev->auto_update_wq == NULL) {
+		struct workqueue_struct *wq;
+
+		wq = create_singlethread_workqueue("omapfb_auto_update");
+
+		if (wq == NULL) {
+			dev_err(fbdev->dev, "Failed to create workqueue for "
+					"auto-update\n");
+			return;
+		}
+
+		fbdev->auto_update_wq = wq;
+	}
+
+	d = get_display_data(fbdev, display);
+
+	INIT_DELAYED_WORK(&d->auto_update_work, omapfb_auto_update_work);
+
+	d->auto_update_work_enabled = true;
+
+	omapfb_auto_update_work(&d->auto_update_work.work);
+}
+
+void omapfb_stop_auto_update(struct omapfb2_device *fbdev,
+		struct omap_dss_device *display)
+{
+	struct omapfb_display_data *d;
+
+	d = get_display_data(fbdev, display);
+
+	cancel_delayed_work_sync(&d->auto_update_work);
+
+	d->auto_update_work_enabled = false;
+}
+
 /* initialize fb_info, var, fix to something sane based on the display */
 static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi)
 {
@@ -1859,12 +1946,22 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 
 	for (i = 0; i < fbdev->num_displays; i++) {
 		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
+
+		if (fbdev->displays[i].auto_update_work_enabled)
+			omapfb_stop_auto_update(fbdev, dssdev);
+
 		if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
 			dssdev->driver->disable(dssdev);
 
 		omap_dss_put_device(dssdev);
 	}
 
+	if (fbdev->auto_update_wq != NULL) {
+		flush_workqueue(fbdev->auto_update_wq);
+		destroy_workqueue(fbdev->auto_update_wq);
+		fbdev->auto_update_wq = NULL;
+	}
+
 	dev_set_drvdata(fbdev->dev, NULL);
 	kfree(fbdev);
 }
@@ -2183,6 +2280,7 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 		struct omap_dss_device *dssdev)
 {
 	struct omap_dss_driver *dssdrv = dssdev->driver;
+	struct omapfb_display_data *d;
 	int r;
 
 	r = dssdrv->enable(dssdev);
@@ -2192,8 +2290,20 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 		return r;
 	}
 
+	d = get_display_data(fbdev, dssdev);
+
+	d->fbdev = fbdev;
+
 	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 		u16 w, h;
+
+		if (auto_update) {
+			omapfb_start_auto_update(fbdev, dssdev);
+			d->update_mode = OMAPFB_AUTO_UPDATE;
+		} else {
+			d->update_mode = OMAPFB_MANUAL_UPDATE;
+		}
+
 		if (dssdrv->enable_te) {
 			r = dssdrv->enable_te(dssdev, 1);
 			if (r) {
@@ -2202,16 +2312,6 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 			}
 		}
 
-		if (dssdrv->set_update_mode) {
-			r = dssdrv->set_update_mode(dssdev,
-					OMAP_DSS_UPDATE_MANUAL);
-			if (r) {
-				dev_err(fbdev->dev,
-						"Failed to set update mode\n");
-				return r;
-			}
-		}
-
 		dssdrv->get_resolution(dssdev, &w, &h);
 		r = dssdrv->update(dssdev, 0, 0, w, h);
 		if (r) {
@@ -2220,15 +2320,7 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 			return r;
 		}
 	} else {
-		if (dssdrv->set_update_mode) {
-			r = dssdrv->set_update_mode(dssdev,
-					OMAP_DSS_UPDATE_AUTO);
-			if (r) {
-				dev_err(fbdev->dev,
-						"Failed to set update mode\n");
-				return r;
-			}
-		}
+		d->update_mode = OMAPFB_AUTO_UPDATE;
 	}
 
 	return 0;
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 2f5e817..153bf1a 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -518,6 +518,39 @@ static ssize_t show_virt(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%p\n", ofbi->region->vaddr);
 }
 
+static ssize_t show_upd_mode(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct fb_info *fbi = dev_get_drvdata(dev);
+	enum omapfb_update_mode mode;
+	int r;
+
+	r = omapfb_get_update_mode(fbi, &mode);
+
+	if (r)
+		return r;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", (unsigned)mode);
+}
+
+static ssize_t store_upd_mode(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct fb_info *fbi = dev_get_drvdata(dev);
+	unsigned mode;
+	int r;
+
+	r = kstrtouint(buf, 0, &mode);
+	if (r)
+		return r;
+
+	r = omapfb_set_update_mode(fbi, mode);
+	if (r)
+		return r;
+
+	return count;
+}
+
 static struct device_attribute omapfb_attrs[] = {
 	__ATTR(rotate_type, S_IRUGO | S_IWUSR, show_rotate_type,
 			store_rotate_type),
@@ -528,6 +561,7 @@ static struct device_attribute omapfb_attrs[] = {
 			store_overlays_rotate),
 	__ATTR(phys_addr, S_IRUGO, show_phys, NULL),
 	__ATTR(virt_addr, S_IRUGO, show_virt, NULL),
+	__ATTR(update_mode, S_IRUGO | S_IWUSR, show_upd_mode, store_upd_mode),
 };
 
 int omapfb_create_sysfs(struct omapfb2_device *fbdev)
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index f07dbbb..fdf0ede 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -74,8 +74,12 @@ struct omapfb_info {
 };
 
 struct omapfb_display_data {
+	struct omapfb2_device *fbdev;
 	struct omap_dss_device *dssdev;
 	u8 bpp_override;
+	enum omapfb_update_mode update_mode;
+	bool auto_update_work_enabled;
+	struct delayed_work auto_update_work;
 };
 
 struct omapfb2_device {
@@ -96,6 +100,8 @@ struct omapfb2_device {
 	struct omap_overlay *overlays[10];
 	unsigned num_managers;
 	struct omap_overlay_manager *managers[10];
+
+	struct workqueue_struct *auto_update_wq;
 };
 
 struct omapfb_colormode {
@@ -127,6 +133,13 @@ int dss_mode_to_fb_mode(enum omap_color_mode dssmode,
 int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl,
 		u16 posx, u16 posy, u16 outw, u16 outh);
 
+void omapfb_start_auto_update(struct omapfb2_device *fbdev,
+		struct omap_dss_device *display);
+void omapfb_stop_auto_update(struct omapfb2_device *fbdev,
+		struct omap_dss_device *display);
+int omapfb_get_update_mode(struct fb_info *fbi, enum omapfb_update_mode *mode);
+int omapfb_set_update_mode(struct fb_info *fbi, enum omapfb_update_mode mode);
+
 /* find the display connected to this fb, if any */
 static inline struct omap_dss_device *fb2display(struct fb_info *fbi)
 {
-- 
1.7.4.1

