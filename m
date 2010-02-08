From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 12/17] OMAP: DSS2: move set/get_update_mode()
Date: Mon,  8 Feb 2010 17:57:36 +0200
Message-ID: <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26950 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab0BHPzp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:45 -0500
In-Reply-To: <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move set/get_update_mode() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    9 +-
 drivers/video/omap2/displays/panel-taal.c |   16 ++++
 drivers/video/omap2/dss/display.c         |    6 +-
 drivers/video/omap2/dss/dpi.c             |   27 -------
 drivers/video/omap2/dss/dsi.c             |  115 +++--------------------------
 drivers/video/omap2/dss/manager.c         |   17 +++--
 drivers/video/omap2/dss/sdi.c             |   26 -------
 drivers/video/omap2/dss/venc.c            |   27 ++++---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   13 ++-
 drivers/video/omap2/omapfb/omapfb-main.c  |   19 +++--
 10 files changed, 80 insertions(+), 195 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index d9829f1..7e46a5d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -481,11 +481,6 @@ struct omap_dss_device {
 			       u16 x, u16 y, u16 w, u16 h);
 	int (*sync)(struct omap_dss_device *dssdev);
 
-	int (*set_update_mode)(struct omap_dss_device *dssdev,
-			enum omap_dss_update_mode);
-	enum omap_dss_update_mode (*get_update_mode)
-		(struct omap_dss_device *dssdev);
-
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
@@ -510,6 +505,10 @@ struct omap_dss_driver {
 
 	void (*setup_update)(struct omap_dss_device *dssdev,
 			u16 x, u16 y, u16 w, u16 h);
+	int (*set_update_mode)(struct omap_dss_device *dssdev,
+			enum omap_dss_update_mode);
+	enum omap_dss_update_mode (*get_update_mode)(
+			struct omap_dss_device *dssdev);
 
 	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
 	int (*wait_for_te)(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index af4b0b0..4ccb583 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -995,6 +995,20 @@ err:
 	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
 }
 
+static int taal_set_update_mode(struct omap_dss_device *dssdev,
+		enum omap_dss_update_mode mode)
+{
+	if (mode != OMAP_DSS_UPDATE_MANUAL)
+		return -EINVAL;
+	return 0;
+}
+
+static enum omap_dss_update_mode taal_get_update_mode(
+		struct omap_dss_device *dssdev)
+{
+	return OMAP_DSS_UPDATE_MANUAL;
+}
+
 static struct omap_dss_driver taal_driver = {
 	.probe		= taal_probe,
 	.remove		= taal_remove,
@@ -1005,6 +1019,8 @@ static struct omap_dss_driver taal_driver = {
 	.resume		= taal_resume,
 
 	.setup_update	= taal_setup_update,
+	.set_update_mode = taal_set_update_mode,
+	.get_update_mode = taal_get_update_mode,
 	.get_resolution	= taal_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 4c40300..dba33cd 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -69,8 +69,8 @@ static ssize_t display_upd_mode_show(struct device *dev,
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	enum omap_dss_update_mode mode = OMAP_DSS_UPDATE_AUTO;
-	if (dssdev->get_update_mode)
-		mode = dssdev->get_update_mode(dssdev);
+	if (dssdev->driver->get_update_mode)
+		mode = dssdev->driver->get_update_mode(dssdev);
 	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
 }
 
@@ -94,7 +94,7 @@ static ssize_t display_upd_mode_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	r = dssdev->set_update_mode(dssdev, mode);
+	r = dssdev->driver->set_update_mode(dssdev, mode);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 77b9557..48ff7ea 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -36,7 +36,6 @@
 #include "dss.h"
 
 static struct {
-	int update_enabled;
 	struct regulator *vdds_dsi_reg;
 } dpi;
 
@@ -376,30 +375,6 @@ static void dpi_get_timings(struct omap_dss_device *dssdev,
 	*timings = dssdev->panel.timings;
 }
 
-static int dpi_display_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	if (mode == OMAP_DSS_UPDATE_MANUAL)
-		return -EINVAL;
-
-	if (mode == OMAP_DSS_UPDATE_DISABLED) {
-		dssdev->manager->disable(dssdev->manager);
-		dpi.update_enabled = 0;
-	} else {
-		dssdev->manager->enable(dssdev->manager);
-		dpi.update_enabled = 1;
-	}
-
-	return 0;
-}
-
-static enum omap_dss_update_mode dpi_display_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	return dpi.update_enabled ? OMAP_DSS_UPDATE_AUTO :
-		OMAP_DSS_UPDATE_DISABLED;
-}
-
 int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -411,8 +386,6 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 	dssdev->set_timings = dpi_set_timings;
 	dssdev->check_timings = dpi_check_timings;
 	dssdev->get_timings = dpi_get_timings;
-	dssdev->set_update_mode = dpi_display_set_update_mode;
-	dssdev->get_update_mode = dpi_display_get_update_mode;
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4b885a4..aa5d0fd 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -243,8 +243,6 @@ static struct
 	struct dsi_update_region active_update_region;
 	struct completion update_completion;
 
-	enum omap_dss_update_mode user_update_mode;
-	enum omap_dss_update_mode update_mode;
 	bool te_enabled;
 	bool use_ext_te;
 
@@ -345,9 +343,6 @@ static void dsi_perf_show(const char *name)
 	if (!dsi_perf)
 		return;
 
-	if (dsi.update_mode == OMAP_DSS_UPDATE_DISABLED)
-		return;
-
 	t = ktime_get();
 
 	setup_time = ktime_sub(dsi.perf_start_time, dsi.perf_setup_time);
@@ -1702,9 +1697,8 @@ static int dsi_force_tx_stop_mode_io(void)
 
 static int dsi_vc_enable(int channel, bool enable)
 {
-	if (dsi.update_mode != OMAP_DSS_UPDATE_AUTO)
-		DSSDBG("dsi_vc_enable channel %d, enable %d\n",
-				channel, enable);
+	DSSDBG("dsi_vc_enable channel %d, enable %d\n",
+			channel, enable);
 
 	enable = enable ? 1 : 0;
 
@@ -1884,8 +1878,7 @@ static u16 dsi_vc_flush_receive_data(int channel)
 
 static int dsi_vc_send_bta(int channel)
 {
-	if (dsi.update_mode != OMAP_DSS_UPDATE_AUTO &&
-			(dsi.debug_write || dsi.debug_read))
+	if (dsi.debug_write || dsi.debug_read)
 		DSSDBG("dsi_vc_send_bta %d\n", channel);
 
 	WARN_ON(!dsi_bus_is_locked());
@@ -2738,9 +2731,8 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 
 	use_te_trigger = dsi.te_enabled && !dsi.use_ext_te;
 
-	if (dsi.update_mode != OMAP_DSS_UPDATE_AUTO)
-		DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
-				x, y, w, h);
+	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
+			x, y, w, h);
 
 	bytespp	= dssdev->ctrl.pixel_size / 8;
 	bytespl = w * bytespp;
@@ -2838,45 +2830,6 @@ static void dsi_set_update_region(struct omap_dss_device *dssdev,
 
 }
 
-static int dsi_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	int r = 0;
-	int i;
-
-	WARN_ON(!dsi_bus_is_locked());
-
-	if (dsi.update_mode != mode) {
-		dsi.update_mode = mode;
-
-		/* Mark the overlays dirty, and do apply(), so that we get the
-		 * overlays configured properly after update mode change. */
-		for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-			struct omap_overlay *ovl;
-			ovl = omap_dss_get_overlay(i);
-			if (ovl->manager == dssdev->manager)
-				ovl->info_dirty = true;
-		}
-
-		r = dssdev->manager->apply(dssdev->manager);
-
-		if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE &&
-				mode == OMAP_DSS_UPDATE_AUTO) {
-			u16 w, h;
-
-			DSSDBG("starting auto update\n");
-
-			dssdev->driver->get_resolution(dssdev, &w, &h);
-
-			dsi_set_update_region(dssdev, 0, 0, w, h);
-
-			wake_up(&dsi.waitqueue);
-		}
-	}
-
-	return r;
-}
-
 static void dsi_handle_framedone(void)
 {
 	int r;
@@ -2885,8 +2838,7 @@ static void dsi_handle_framedone(void)
 
 	use_te_trigger = dsi.te_enabled && !dsi.use_ext_te;
 
-	if (dsi.update_mode != OMAP_DSS_UPDATE_AUTO)
-		DSSDBG("FRAMEDONE\n");
+	DSSDBG("FRAMEDONE\n");
 
 	if (use_te_trigger) {
 		/* enable LP_RX_TO again after the TE */
@@ -2925,9 +2877,7 @@ static int dsi_update_thread(void *data)
 
 	while (1) {
 		wait_event_interruptible(dsi.waitqueue,
-				dsi.update_mode == OMAP_DSS_UPDATE_AUTO ||
-				(dsi.update_mode == OMAP_DSS_UPDATE_MANUAL &&
-				 dsi.update_region.dirty == true) ||
+				dsi.update_region.dirty == true ||
 				kthread_should_stop());
 
 		if (kthread_should_stop())
@@ -2935,8 +2885,7 @@ static int dsi_update_thread(void *data)
 
 		dsi_bus_lock();
 
-		if (dsi.update_mode == OMAP_DSS_UPDATE_DISABLED ||
-				kthread_should_stop()) {
+		if (kthread_should_stop()) {
 			dsi_bus_unlock();
 			break;
 		}
@@ -2958,9 +2907,8 @@ static int dsi_update_thread(void *data)
 
 		if (device->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 
-			if (dsi.update_mode == OMAP_DSS_UPDATE_MANUAL)
-				dss_setup_partial_planes(device,
-						&x, &y, &w, &h);
+			dss_setup_partial_planes(device,
+					&x, &y, &w, &h);
 
 			dispc_set_lcd_size(w, h);
 		}
@@ -3252,8 +3200,6 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 
 	dsi.use_ext_te = dssdev->phy.dsi.ext_te;
 
-	dsi_set_update_mode(dssdev, dsi.user_update_mode);
-
 	dsi_bus_unlock();
 	mutex_unlock(&dsi.lock);
 
@@ -3284,7 +3230,6 @@ static void dsi_display_disable(struct omap_dss_device *dssdev)
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
 		goto end;
 
-	dsi.update_mode = OMAP_DSS_UPDATE_DISABLED;
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	dsi_display_uninit_dispc(dssdev);
@@ -3311,7 +3256,6 @@ static int dsi_display_suspend(struct omap_dss_device *dssdev)
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
 		goto end;
 
-	dsi.update_mode = OMAP_DSS_UPDATE_DISABLED;
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
 	dsi_display_uninit_dispc(dssdev);
@@ -3361,8 +3305,6 @@ static int dsi_display_resume(struct omap_dss_device *dssdev)
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	dsi_set_update_mode(dssdev, dsi.user_update_mode);
-
 	dsi_bus_unlock();
 	mutex_unlock(&dsi.lock);
 
@@ -3390,9 +3332,6 @@ static int dsi_display_update(struct omap_dss_device *dssdev,
 
 	mutex_lock(&dsi.lock);
 
-	if (dsi.update_mode != OMAP_DSS_UPDATE_MANUAL)
-		goto end;
-
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		goto end;
 
@@ -3434,8 +3373,7 @@ static int dsi_display_sync(struct omap_dss_device *dssdev)
 	mutex_lock(&dsi.lock);
 	dsi_bus_lock();
 
-	if (dsi.update_mode == OMAP_DSS_UPDATE_MANUAL &&
-			dsi.update_region.dirty) {
+	if (dsi.update_region.dirty) {
 		INIT_COMPLETION(dsi.update_completion);
 		wait = true;
 	} else {
@@ -3452,32 +3390,6 @@ static int dsi_display_sync(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	int r = 0;
-
-	DSSDBGF("%d", mode);
-
-	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
-
-	dsi.user_update_mode = mode;
-	r = dsi_set_update_mode(dssdev, mode);
-
-	dsi_bus_unlock();
-	mutex_unlock(&dsi.lock);
-
-	return r;
-}
-
-static enum omap_dss_update_mode dsi_display_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	return dsi.update_mode;
-}
-
-
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	dsi.te_enabled = enable;
@@ -3508,8 +3420,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->resume = dsi_display_resume;
 	dssdev->update = dsi_display_update;
 	dssdev->sync = dsi_display_sync;
-	dssdev->set_update_mode = dsi_display_set_update_mode;
-	dssdev->get_update_mode = dsi_display_get_update_mode;
 
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
@@ -3560,9 +3470,6 @@ int dsi_init(struct platform_device *pdev)
 	dsi.te_timer.data = 0;
 #endif
 
-	dsi.update_mode = OMAP_DSS_UPDATE_DISABLED;
-	dsi.user_update_mode = OMAP_DSS_UPDATE_DISABLED;
-
 	dsi.base = ioremap(DSI_BASE, DSI_SZ_REGS);
 	if (!dsi.base) {
 		DSSERR("can't ioremap DSI\n");
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 4ede519..913142d 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -522,17 +522,18 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	u32 irq;
 	int r;
 	int i;
+	struct omap_dss_device *dssdev = mgr->device;
 
-	if (!mgr->device)
+	if (!dssdev)
 		return 0;
 
-	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 		channel = OMAP_DSS_CHANNEL_DIGIT;
 	} else {
-		if (mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
+		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
-			mode = mgr->device->get_update_mode(mgr->device);
+			mode = dssdev->driver->get_update_mode(dssdev);
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
@@ -605,7 +606,7 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	} else {
 		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
 			enum omap_dss_update_mode mode;
-			mode = dssdev->get_update_mode(dssdev);
+			mode = dssdev->driver->get_update_mode(dssdev);
 			if (mode != OMAP_DSS_UPDATE_AUTO)
 				return 0;
 
@@ -1209,7 +1210,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		oc->manual_update =
 			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
-			dssdev->get_update_mode(dssdev) != OMAP_DSS_UPDATE_AUTO;
+			dssdev->driver->get_update_mode(dssdev) !=
+				OMAP_DSS_UPDATE_AUTO;
 
 		++num_planes_enabled;
 	}
@@ -1250,7 +1252,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		mc->manual_update =
 			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
-			dssdev->get_update_mode(dssdev) != OMAP_DSS_UPDATE_AUTO;
+			dssdev->driver->get_update_mode(dssdev) !=
+				OMAP_DSS_UPDATE_AUTO;
 	}
 
 	/* XXX TODO: Try to get fifomerge working. The problem is that it
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5f852ed..6bd9b0c 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -213,30 +213,6 @@ err:
 	return r;
 }
 
-static int sdi_display_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	if (mode == OMAP_DSS_UPDATE_MANUAL)
-		return -EINVAL;
-
-	if (mode == OMAP_DSS_UPDATE_DISABLED) {
-		dssdev->manager->disable(dssdev->manager);
-		sdi.update_enabled = 0;
-	} else {
-		dssdev->manager->enable(dssdev->manager);
-		sdi.update_enabled = 1;
-	}
-
-	return 0;
-}
-
-static enum omap_dss_update_mode sdi_display_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	return sdi.update_enabled ? OMAP_DSS_UPDATE_AUTO :
-		OMAP_DSS_UPDATE_DISABLED;
-}
-
 static void sdi_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -251,8 +227,6 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 	dssdev->disable = sdi_display_disable;
 	dssdev->suspend = sdi_display_suspend;
 	dssdev->resume = sdi_display_resume;
-	dssdev->set_update_mode = sdi_display_set_update_mode;
-	dssdev->get_update_mode = sdi_display_get_update_mode;
 	dssdev->get_timings = sdi_get_timings;
 
 	return 0;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index d13071d..0d0dc94 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -450,6 +450,20 @@ static int venc_panel_resume(struct omap_dss_device *dssdev)
 	return venc_panel_enable(dssdev);
 }
 
+static enum omap_dss_update_mode venc_get_update_mode(
+		struct omap_dss_device *dssdev)
+{
+	return OMAP_DSS_UPDATE_AUTO;
+}
+
+static int venc_set_update_mode(struct omap_dss_device *dssdev,
+		enum omap_dss_update_mode mode)
+{
+	if (mode != OMAP_DSS_UPDATE_AUTO)
+		return -EINVAL;
+	return 0;
+}
+
 static struct omap_dss_driver venc_driver = {
 	.probe		= venc_panel_probe,
 	.remove		= venc_panel_remove,
@@ -462,6 +476,9 @@ static struct omap_dss_driver venc_driver = {
 	.get_resolution	= omapdss_default_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
+	.set_update_mode = venc_set_update_mode,
+	.get_update_mode = venc_get_update_mode,
+
 	.driver         = {
 		.name   = "venc",
 		.owner  = THIS_MODULE,
@@ -717,15 +734,6 @@ static int venc_set_wss(struct omap_dss_device *dssdev,	u32 wss)
 	return 0;
 }
 
-static enum omap_dss_update_mode venc_display_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
-		return OMAP_DSS_UPDATE_AUTO;
-	else
-		return OMAP_DSS_UPDATE_DISABLED;
-}
-
 int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -739,7 +747,6 @@ int venc_init_display(struct omap_dss_device *dssdev)
 	dssdev->check_timings = venc_check_timings;
 	dssdev->get_wss = venc_get_wss;
 	dssdev->set_wss = venc_set_wss;
-	dssdev->get_update_mode = venc_display_get_update_mode;
 
 	return 0;
 }
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 86467f8..75fe1e7 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -243,7 +243,7 @@ static int omapfb_set_update_mode(struct fb_info *fbi,
 	enum omap_dss_update_mode um;
 	int r;
 
-	if (!display || !display->set_update_mode)
+	if (!display || !display->driver->set_update_mode)
 		return -EINVAL;
 
 	switch (mode) {
@@ -263,7 +263,7 @@ static int omapfb_set_update_mode(struct fb_info *fbi,
 		return -EINVAL;
 	}
 
-	r = display->set_update_mode(display, um);
+	r = display->driver->set_update_mode(display, um);
 
 	return r;
 }
@@ -274,10 +274,15 @@ static int omapfb_get_update_mode(struct fb_info *fbi,
 	struct omap_dss_device *display = fb2display(fbi);
 	enum omap_dss_update_mode m;
 
-	if (!display || !display->get_update_mode)
+	if (!display)
 		return -EINVAL;
 
-	m = display->get_update_mode(display);
+	if (!display->driver->get_update_mode) {
+		*mode = OMAPFB_AUTO_UPDATE;
+		return 0;
+	}
+
+	m = display->driver->get_update_mode(display);
 
 	switch (m) {
 	case OMAP_DSS_UPDATE_DISABLED:
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index fff687b..7686e86 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1226,8 +1226,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (display->resume)
 			r = display->resume(display);
 
-		if (r == 0 && display->get_update_mode &&
-				display->get_update_mode(display) ==
+		if (r == 0 && display->driver->get_update_mode &&
+				display->driver->get_update_mode(display) ==
 				OMAP_DSS_UPDATE_MANUAL)
 			do_update = 1;
 
@@ -2188,6 +2188,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	}
 
 	if (def_display) {
+		struct omap_dss_driver *dssdrv = def_display->driver;
 #ifndef CONFIG_FB_OMAP2_FORCE_AUTO_UPDATE
 		u16 w, h;
 #endif
@@ -2205,19 +2206,19 @@ static int omapfb_probe(struct platform_device *pdev)
 				def_display->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_AUTO);
 #else /* MANUAL_UPDATE */
-			if (def_display->driver->enable_te)
-				def_display->driver->enable_te(def_display, 0);
-			if (def_display->set_update_mode)
-				def_display->set_update_mode(def_display,
+			if (dssdrv->enable_te)
+				dssdrv->enable_te(def_display, 0);
+			if (dssdrv->set_update_mode)
+				dssdrv->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_MANUAL);
 
-			def_display->driver->get_resolution(def_display,
+			dssdrv->get_resolution(def_display,
 					&w, &h);
 			def_display->update(def_display, 0, 0, w, h);
 #endif
 		} else {
-			if (def_display->set_update_mode)
-				def_display->set_update_mode(def_display,
+			if (dssdrv->set_update_mode)
+				dssdrv->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_AUTO);
 		}
 	}
-- 
1.6.5

