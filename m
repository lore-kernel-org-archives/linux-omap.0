From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 13/17] OMAP: DSS2: move update() and sync()
Date: Mon,  8 Feb 2010 17:57:37 +0200
Message-ID: <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45843 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab0BHPz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:29 -0500
In-Reply-To: <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move update() and sync() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |   23 ++-
 drivers/video/omap2/displays/panel-taal.c |   69 +++++--
 drivers/video/omap2/dss/dsi.c             |  315 ++++++++++-------------------
 drivers/video/omap2/dss/rfbi.c            |  290 +++------------------------
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   10 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |   10 +-
 6 files changed, 212 insertions(+), 505 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 7e46a5d..46b3ff0 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -477,9 +477,6 @@ struct omap_dss_device {
 			struct omap_video_timings *timings);
 	void (*get_timings)(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
-	int (*update)(struct omap_dss_device *dssdev,
-			       u16 x, u16 y, u16 w, u16 h);
-	int (*sync)(struct omap_dss_device *dssdev);
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
@@ -503,15 +500,16 @@ struct omap_dss_driver {
 	int (*resume)(struct omap_dss_device *display);
 	int (*run_test)(struct omap_dss_device *display, int test);
 
-	void (*setup_update)(struct omap_dss_device *dssdev,
-			u16 x, u16 y, u16 w, u16 h);
 	int (*set_update_mode)(struct omap_dss_device *dssdev,
 			enum omap_dss_update_mode);
 	enum omap_dss_update_mode (*get_update_mode)(
 			struct omap_dss_device *dssdev);
 
+	int (*update)(struct omap_dss_device *dssdev,
+			       u16 x, u16 y, u16 w, u16 h);
+	int (*sync)(struct omap_dss_device *dssdev);
+
 	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
-	int (*wait_for_te)(struct omap_dss_device *dssdev);
 	int (*get_te)(struct omap_dss_device *dssdev);
 
 	u8 (*get_rotate)(struct omap_dss_device *dssdev);
@@ -569,4 +567,17 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 void omapdss_dsi_vc_enable_hs(int channel, bool enable);
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 
+int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
+				    u16 *x, u16 *y, u16 *w, u16 *h);
+int omap_dsi_update(struct omap_dss_device *dssdev,
+		u16 x, u16 y, u16 w, u16 h,
+		void (*callback)(int, void *), void *data);
+
+int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
+		u16 *x, u16 *y, u16 *w, u16 *h);
+int omap_rfbi_update(struct omap_dss_device *dssdev,
+		u16 x, u16 y, u16 w, u16 h,
+		void (*callback)(void *), void *data);
+
+
 #endif
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4ccb583..cb94596 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -725,10 +725,51 @@ static int taal_resume(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void taal_setup_update(struct omap_dss_device *dssdev,
+static void taal_framedone_cb(int err, void *data)
+{
+	struct omap_dss_device *dssdev = data;
+	dev_dbg(&dssdev->dev, "framedone, err %d\n", err);
+	dsi_bus_unlock();
+}
+
+static int taal_update(struct omap_dss_device *dssdev,
 				    u16 x, u16 y, u16 w, u16 h)
 {
-	taal_set_update_window(x, y, w, h);
+	int r;
+
+	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
+
+	dsi_bus_lock();
+
+	r = omap_dsi_prepare_update(dssdev, &x, &y, &w, &h);
+	if (r)
+		goto err;
+
+	r = taal_set_update_window(x, y, w, h);
+	if (r)
+		goto err;
+
+	r = omap_dsi_update(dssdev, x, y, w, h, taal_framedone_cb, dssdev);
+	if (r)
+		goto err;
+
+	/* note: no bus_unlock here. unlock is in framedone_cb */
+	return 0;
+err:
+	dsi_bus_unlock();
+	return r;
+}
+
+static int taal_sync(struct omap_dss_device *dssdev)
+{
+	dev_dbg(&dssdev->dev, "sync\n");
+
+	dsi_bus_lock();
+	dsi_bus_unlock();
+
+	dev_dbg(&dssdev->dev, "sync done\n");
+
+	return 0;
 }
 
 static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
@@ -762,24 +803,6 @@ static int taal_get_te(struct omap_dss_device *dssdev)
 	return td->te_enabled;
 }
 
-static int taal_wait_te(struct omap_dss_device *dssdev)
-{
-	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	long wait = msecs_to_jiffies(500);
-
-	if (!td->use_ext_te || !td->te_enabled)
-		return 0;
-
-	INIT_COMPLETION(td->te_completion);
-	wait = wait_for_completion_timeout(&td->te_completion, wait);
-	if (wait == 0) {
-		dev_err(&dssdev->dev, "timeout waiting TE\n");
-		return -ETIME;
-	}
-
-	return 0;
-}
-
 static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
@@ -1018,15 +1041,17 @@ static struct omap_dss_driver taal_driver = {
 	.suspend	= taal_suspend,
 	.resume		= taal_resume,
 
-	.setup_update	= taal_setup_update,
 	.set_update_mode = taal_set_update_mode,
 	.get_update_mode = taal_get_update_mode,
+
+	.update		= taal_update,
+	.sync		= taal_sync,
+
 	.get_resolution	= taal_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
 	.enable_te	= taal_enable_te,
 	.get_te		= taal_get_te,
-	.wait_for_te	= taal_wait_te,
 
 	.set_rotate	= taal_rotate,
 	.get_rotate	= taal_get_rotate,
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index aa5d0fd..a29ca43 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -31,8 +31,8 @@
 #include <linux/seq_file.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/kthread.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <plat/display.h>
 #include <plat/clock.h>
@@ -200,7 +200,6 @@ enum dsi_vc_mode {
 };
 
 struct dsi_update_region {
-	bool dirty;
 	u16 x, y, w, h;
 	struct omap_dss_device *device;
 };
@@ -234,18 +233,17 @@ static struct
 
 	struct completion bta_completion;
 
-	struct task_struct *thread;
-	wait_queue_head_t waitqueue;
-
-	spinlock_t update_lock;
-	bool framedone_received;
 	struct dsi_update_region update_region;
-	struct dsi_update_region active_update_region;
-	struct completion update_completion;
 
 	bool te_enabled;
 	bool use_ext_te;
 
+	struct work_struct framedone_work;
+	void (*framedone_callback)(int, void *);
+	void *framedone_data;
+
+	struct delayed_work framedone_timeout_work;
+
 #ifdef DSI_CATCH_MISSING_TE
 	struct timer_list te_timer;
 #endif
@@ -357,9 +355,9 @@ static void dsi_perf_show(const char *name)
 
 	total_us = setup_us + trans_us;
 
-	total_bytes = dsi.active_update_region.w *
-		dsi.active_update_region.h *
-		dsi.active_update_region.device->ctrl.pixel_size / 8;
+	total_bytes = dsi.update_region.w *
+		dsi.update_region.h *
+		dsi.update_region.device->ctrl.pixel_size / 8;
 
 	printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
 			"%u bytes, %u kbytes/sec\n",
@@ -2771,6 +2769,11 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	 */
 	dispc_disable_sidle();
 
+	dsi_perf_mark_start();
+
+	schedule_delayed_work(&dsi.framedone_timeout_work,
+			msecs_to_jiffies(250));
+
 	dss_start_update(dssdev);
 
 	if (use_te_trigger) {
@@ -2793,41 +2796,57 @@ static void dsi_te_timeout(unsigned long arg)
 }
 #endif
 
-static void dsi_framedone_irq_callback(void *data, u32 mask)
+static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 {
-	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
-	 * turns itself off. However, DSI still has the pixels in its buffers,
-	 * and is sending the data.
-	 */
+	int r;
+	const int channel = 0;
+	bool use_te_trigger;
+
+	DSSERR("Framedone not received for 250ms!\n");
 
 	/* SIDLEMODE back to smart-idle */
 	dispc_enable_sidle();
 
-	dsi.framedone_received = true;
-	wake_up(&dsi.waitqueue);
-}
+	use_te_trigger = dsi.te_enabled && !dsi.use_ext_te;
 
-static void dsi_set_update_region(struct omap_dss_device *dssdev,
-		u16 x, u16 y, u16 w, u16 h)
-{
-	spin_lock(&dsi.update_lock);
-	if (dsi.update_region.dirty) {
-		dsi.update_region.x = min(x, dsi.update_region.x);
-		dsi.update_region.y = min(y, dsi.update_region.y);
-		dsi.update_region.w = max(w, dsi.update_region.w);
-		dsi.update_region.h = max(h, dsi.update_region.h);
-	} else {
-		dsi.update_region.x = x;
-		dsi.update_region.y = y;
-		dsi.update_region.w = w;
-		dsi.update_region.h = h;
+	if (use_te_trigger) {
+		/* enable LP_RX_TO again after the TE */
+		REG_FLD_MOD(DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
+	}
+
+	/* Send BTA after the frame. We need this for the TE to work, as TE
+	 * trigger is only sent for BTAs without preceding packet. Thus we need
+	 * to BTA after the pixel packets so that next BTA will cause TE
+	 * trigger.
+	 *
+	 * This is not needed when TE is not in use, but we do it anyway to
+	 * make sure that the transfer has been completed. It would be more
+	 * optimal, but more complex, to wait only just before starting next
+	 * transfer. */
+	r = dsi_vc_send_bta_sync(channel);
+	if (r)
+		DSSERR("BTA after framedone failed\n");
+
+	/* RX_FIFO_NOT_EMPTY */
+	if (REG_GET(DSI_VC_CTRL(channel), 20, 20)) {
+		DSSERR("Received error during frame transfer:\n");
+		dsi_vc_flush_receive_data(channel);
 	}
 
-	dsi.update_region.device = dssdev;
-	dsi.update_region.dirty = true;
+	dsi.framedone_callback(-ETIMEDOUT, dsi.framedone_data);
+}
 
-	spin_unlock(&dsi.update_lock);
+static void dsi_framedone_irq_callback(void *data, u32 mask)
+{
+	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
+	 * turns itself off. However, DSI still has the pixels in its buffers,
+	 * and is sending the data.
+	 */
 
+	/* SIDLEMODE back to smart-idle */
+	dispc_enable_sidle();
+
+	schedule_work(&dsi.framedone_work);
 }
 
 static void dsi_handle_framedone(void)
@@ -2869,105 +2888,77 @@ static void dsi_handle_framedone(void)
 #endif
 }
 
-static int dsi_update_thread(void *data)
+static void dsi_framedone_work_callback(struct work_struct *work)
 {
-	unsigned long timeout;
-	struct omap_dss_device *device;
-	u16 x, y, w, h;
-
-	while (1) {
-		wait_event_interruptible(dsi.waitqueue,
-				dsi.update_region.dirty == true ||
-				kthread_should_stop());
-
-		if (kthread_should_stop())
-			break;
-
-		dsi_bus_lock();
-
-		if (kthread_should_stop()) {
-			dsi_bus_unlock();
-			break;
-		}
-
-		dsi_perf_mark_setup();
+	DSSDBGF();
 
-		if (dsi.update_region.dirty) {
-			spin_lock(&dsi.update_lock);
-			dsi.active_update_region = dsi.update_region;
-			dsi.update_region.dirty = false;
-			spin_unlock(&dsi.update_lock);
-		}
+	cancel_delayed_work_sync(&dsi.framedone_timeout_work);
 
-		device = dsi.active_update_region.device;
-		x = dsi.active_update_region.x;
-		y = dsi.active_update_region.y;
-		w = dsi.active_update_region.w;
-		h = dsi.active_update_region.h;
+	dsi_handle_framedone();
 
-		if (device->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
+	dsi_perf_show("DISPC");
 
-			dss_setup_partial_planes(device,
-					&x, &y, &w, &h);
+	dsi.framedone_callback(0, dsi.framedone_data);
+}
 
-			dispc_set_lcd_size(w, h);
-		}
+int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
+				    u16 *x, u16 *y, u16 *w, u16 *h)
+{
+	u16 dw, dh;
 
-		if (dsi.active_update_region.dirty) {
-			dsi.active_update_region.dirty = false;
-			/* XXX TODO we don't need to send the coords, if they
-			 * are the same that are already programmed to the
-			 * panel. That should speed up manual update a bit */
-			device->driver->setup_update(device, x, y, w, h);
-		}
+	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
-		dsi_perf_mark_start();
+	if  (*x > dw || *y > dh)
+		return -EINVAL;
 
-		if (device->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-			dsi_vc_config_vp(0);
+	if (*x + *w > dw)
+		return -EINVAL;
 
-			if (dsi.te_enabled && dsi.use_ext_te)
-				device->driver->wait_for_te(device);
+	if (*y + *h > dh)
+		return -EINVAL;
 
-			dsi.framedone_received = false;
+	if (*w == 1)
+		return -EINVAL;
 
-			dsi_update_screen_dispc(device, x, y, w, h);
+	if (*w == 0 || *h == 0)
+		return -EINVAL;
 
-			/* wait for framedone */
-			timeout = msecs_to_jiffies(1000);
-			wait_event_timeout(dsi.waitqueue,
-					dsi.framedone_received == true,
-					timeout);
+	dsi_perf_mark_setup();
 
-			if (!dsi.framedone_received) {
-				DSSERR("framedone timeout\n");
-				DSSERR("failed update %d,%d %dx%d\n",
-						x, y, w, h);
+	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
+		dss_setup_partial_planes(dssdev, x, y, w, h);
+		dispc_set_lcd_size(*w, *h);
+	}
 
-				dispc_enable_sidle();
-				device->manager->disable(device->manager);
+	return 0;
+}
+EXPORT_SYMBOL(omap_dsi_prepare_update);
 
-				dsi_reset_tx_fifo(0);
-			} else {
-				dsi_handle_framedone();
-				dsi_perf_show("DISPC");
-			}
-		} else {
-			dsi_update_screen_l4(device, x, y, w, h);
-			dsi_perf_show("L4");
-		}
+int omap_dsi_update(struct omap_dss_device *dssdev,
+		u16 x, u16 y, u16 w, u16 h,
+		void (*callback)(int, void *), void *data)
+{
+	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
+		dsi.framedone_callback = callback;
+		dsi.framedone_data = data;
+		dsi_vc_config_vp(0);
 
-		complete_all(&dsi.update_completion);
+		dsi.update_region.x = x;
+		dsi.update_region.y = y;
+		dsi.update_region.w = w;
+		dsi.update_region.h = h;
+		dsi.update_region.device = dssdev;
 
-		dsi_bus_unlock();
+		dsi_update_screen_dispc(dssdev, x, y, w, h);
+	} else {
+		dsi_update_screen_l4(dssdev, x, y, w, h);
+		dsi_perf_show("L4");
+		callback(0, data);
 	}
 
-	DSSDBG("update thread exiting\n");
-
 	return 0;
 }
-
-
+EXPORT_SYMBOL(omap_dsi_update);
 
 /* Display funcs */
 
@@ -3322,74 +3313,6 @@ err0:
 	return r;
 }
 
-static int dsi_display_update(struct omap_dss_device *dssdev,
-			u16 x, u16 y, u16 w, u16 h)
-{
-	int r = 0;
-	u16 dw, dh;
-
-	DSSDBG("dsi_display_update(%d,%d %dx%d)\n", x, y, w, h);
-
-	mutex_lock(&dsi.lock);
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		goto end;
-
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
-
-	if  (x > dw || y > dh)
-		goto end;
-
-	if (x + w > dw)
-		w = dw - x;
-
-	if (y + h > dh)
-		h = dh - y;
-
-	if (w == 0 || h == 0)
-		goto end;
-
-	if (w == 1) {
-		r = -EINVAL;
-		goto end;
-	}
-
-	dsi_set_update_region(dssdev, x, y, w, h);
-
-	wake_up(&dsi.waitqueue);
-
-end:
-	mutex_unlock(&dsi.lock);
-
-	return r;
-}
-
-static int dsi_display_sync(struct omap_dss_device *dssdev)
-{
-	bool wait;
-
-	DSSDBG("dsi_display_sync()\n");
-
-	mutex_lock(&dsi.lock);
-	dsi_bus_lock();
-
-	if (dsi.update_region.dirty) {
-		INIT_COMPLETION(dsi.update_completion);
-		wait = true;
-	} else {
-		wait = false;
-	}
-
-	dsi_bus_unlock();
-	mutex_unlock(&dsi.lock);
-
-	if (wait)
-		wait_for_completion_interruptible(&dsi.update_completion);
-
-	DSSDBG("dsi_display_sync() done\n");
-	return 0;
-}
-
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
 	dsi.te_enabled = enable;
@@ -3418,8 +3341,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->disable = dsi_display_disable;
 	dssdev->suspend = dsi_display_suspend;
 	dssdev->resume = dsi_display_resume;
-	dssdev->update = dsi_display_update;
-	dssdev->sync = dsi_display_sync;
 
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
@@ -3435,9 +3356,6 @@ int dsi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	int r;
-	struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO-1
-	};
 
 	spin_lock_init(&dsi.errors_lock);
 	dsi.errors = 0;
@@ -3448,28 +3366,19 @@ int dsi_init(struct platform_device *pdev)
 #endif
 
 	init_completion(&dsi.bta_completion);
-	init_completion(&dsi.update_completion);
-
-	dsi.thread = kthread_create(dsi_update_thread, NULL, "dsi");
-	if (IS_ERR(dsi.thread)) {
-		DSSERR("cannot create kthread\n");
-		r = PTR_ERR(dsi.thread);
-		goto err0;
-	}
-	sched_setscheduler(dsi.thread, SCHED_FIFO, &param);
-
-	init_waitqueue_head(&dsi.waitqueue);
-	spin_lock_init(&dsi.update_lock);
 
 	mutex_init(&dsi.lock);
 	sema_init(&dsi.bus_lock, 1);
 
+	INIT_WORK(&dsi.framedone_work, dsi_framedone_work_callback);
+	INIT_DELAYED_WORK_DEFERRABLE(&dsi.framedone_timeout_work,
+			dsi_framedone_timeout_work_callback);
+
 #ifdef DSI_CATCH_MISSING_TE
 	init_timer(&dsi.te_timer);
 	dsi.te_timer.function = dsi_te_timeout;
 	dsi.te_timer.data = 0;
 #endif
-
 	dsi.base = ioremap(DSI_BASE, DSI_SZ_REGS);
 	if (!dsi.base) {
 		DSSERR("can't ioremap DSI\n");
@@ -3493,21 +3402,15 @@ int dsi_init(struct platform_device *pdev)
 
 	enable_clocks(0);
 
-	wake_up_process(dsi.thread);
-
 	return 0;
 err2:
 	iounmap(dsi.base);
 err1:
-	kthread_stop(dsi.thread);
-err0:
 	return r;
 }
 
 void dsi_exit(void)
 {
-	kthread_stop(dsi.thread);
-
 	iounmap(dsi.base);
 
 	DSSDBG("omap_dsi_exit\n");
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 7129387..a6b3316 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -36,8 +36,6 @@
 #include <plat/display.h>
 #include "dss.h"
 
-/*#define MEASURE_PERF*/
-
 #define RFBI_BASE               0x48050800
 
 struct rfbi_reg { u16 idx; };
@@ -66,8 +64,6 @@ struct rfbi_reg { u16 idx; };
 #define RFBI_VSYNC_WIDTH	RFBI_REG(0x0090)
 #define RFBI_HSYNC_WIDTH	RFBI_REG(0x0094)
 
-#define RFBI_CMD_FIFO_LEN_BYTES (16 * sizeof(struct update_param))
-
 #define REG_FLD_MOD(idx, val, start, end) \
 	rfbi_write_reg(idx, FLD_MOD(rfbi_read_reg(idx), val, start, end))
 
@@ -102,7 +98,6 @@ enum update_cmd {
 
 static int rfbi_convert_timings(struct rfbi_timings *t);
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
-static void process_cmd_fifo(void);
 
 static struct {
 	void __iomem	*base;
@@ -125,11 +120,6 @@ static struct {
 	struct completion cmd_done;
 	atomic_t          cmd_fifo_full;
 	atomic_t          cmd_pending;
-#ifdef MEASURE_PERF
-	unsigned perf_bytes;
-	ktime_t perf_setup_time;
-	ktime_t perf_start_time;
-#endif
 } rfbi;
 
 struct update_region {
@@ -139,16 +129,6 @@ struct update_region {
 	u16     h;
 };
 
-struct update_param {
-	u8 rfbi_module;
-	u8 cmd;
-
-	union {
-		struct update_region r;
-		struct completion *sync;
-	} par;
-};
-
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
 {
 	__raw_writel(val, rfbi.base + idx.idx);
@@ -321,55 +301,6 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-#ifdef MEASURE_PERF
-static void perf_mark_setup(void)
-{
-	rfbi.perf_setup_time = ktime_get();
-}
-
-static void perf_mark_start(void)
-{
-	rfbi.perf_start_time = ktime_get();
-}
-
-static void perf_show(const char *name)
-{
-	ktime_t t, setup_time, trans_time;
-	u32 total_bytes;
-	u32 setup_us, trans_us, total_us;
-
-	t = ktime_get();
-
-	setup_time = ktime_sub(rfbi.perf_start_time, rfbi.perf_setup_time);
-	setup_us = (u32)ktime_to_us(setup_time);
-	if (setup_us == 0)
-		setup_us = 1;
-
-	trans_time = ktime_sub(t, rfbi.perf_start_time);
-	trans_us = (u32)ktime_to_us(trans_time);
-	if (trans_us == 0)
-		trans_us = 1;
-
-	total_us = setup_us + trans_us;
-
-	total_bytes = rfbi.perf_bytes;
-
-	DSSINFO("%s update %u us + %u us = %u us (%uHz), %u bytes, "
-			"%u kbytes/sec\n",
-			name,
-			setup_us,
-			trans_us,
-			total_us,
-			1000*1000 / total_us,
-			total_bytes,
-			total_bytes * 1000 / total_us);
-}
-#else
-#define perf_mark_setup()
-#define perf_mark_start()
-#define perf_show(x)
-#endif
-
 void rfbi_transfer_area(u16 width, u16 height,
 			     void (callback)(void *data), void *data)
 {
@@ -396,8 +327,6 @@ void rfbi_transfer_area(u16 width, u16 height,
 	if (!rfbi.te_enabled)
 		l = FLD_MOD(l, 1, 4, 4); /* ITE */
 
-	perf_mark_start();
-
 	rfbi_write_reg(RFBI_CONTROL, l);
 }
 
@@ -407,8 +336,6 @@ static void framedone_callback(void *data, u32 mask)
 
 	DSSDBG("FRAMEDONE\n");
 
-	perf_show("DISPC");
-
 	REG_FLD_MOD(RFBI_CONTROL, 0, 0, 0);
 
 	rfbi_enable_clocks(0);
@@ -416,11 +343,10 @@ static void framedone_callback(void *data, u32 mask)
 	callback = rfbi.framedone_callback;
 	rfbi.framedone_callback = NULL;
 
-	/*callback(rfbi.framedone_callback_data);*/
+	if (callback != NULL)
+		callback(rfbi.framedone_callback_data);
 
 	atomic_set(&rfbi.cmd_pending, 0);
-
-	process_cmd_fifo();
 }
 
 #if 1 /* VERBOSE */
@@ -937,52 +863,43 @@ int rfbi_configure(int rfbi_module, int bpp, int lines)
 }
 EXPORT_SYMBOL(rfbi_configure);
 
-static int rfbi_find_display(struct omap_dss_device *dssdev)
+int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
+		u16 *x, u16 *y, u16 *w, u16 *h)
 {
-	if (dssdev == rfbi.dssdev[0])
-		return 0;
+	u16 dw, dh;
 
-	if (dssdev == rfbi.dssdev[1])
-		return 1;
+	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
-	BUG();
-	return -1;
-}
+	if  (*x > dw || *y > dh)
+		return -EINVAL;
 
+	if (*x + *w > dw)
+		return -EINVAL;
 
-static void signal_fifo_waiters(void)
-{
-	if (atomic_read(&rfbi.cmd_fifo_full) > 0) {
-		/* DSSDBG("SIGNALING: Fifo not full for waiter!\n"); */
-		complete(&rfbi.cmd_done);
-		atomic_dec(&rfbi.cmd_fifo_full);
-	}
-}
+	if (*y + *h > dh)
+		return -EINVAL;
 
-/* returns 1 for async op, and 0 for sync op */
-static int do_update(struct omap_dss_device *dssdev, struct update_region *upd)
-{
-	u16 x = upd->x;
-	u16 y = upd->y;
-	u16 w = upd->w;
-	u16 h = upd->h;
+	if (*w == 1)
+		return -EINVAL;
 
-	perf_mark_setup();
+	if (*w == 0 || *h == 0)
+		return -EINVAL;
 
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		/*dssdev->driver->enable_te(dssdev, 1); */
-		dss_setup_partial_planes(dssdev, &x, &y, &w, &h);
+		dss_setup_partial_planes(dssdev, x, y, w, h);
+		dispc_set_lcd_size(*w, *h);
 	}
 
-#ifdef MEASURE_PERF
-	rfbi.perf_bytes = w * h * 2; /* XXX always 16bit */
-#endif
-
-	dssdev->driver->setup_update(dssdev, x, y, w, h);
+	return 0;
+}
+EXPORT_SYMBOL(omap_rfbi_prepare_update);
 
+int omap_rfbi_update(struct omap_dss_device *dssdev,
+		u16 x, u16 y, u16 w, u16 h,
+		void (*callback)(void *), void *data)
+{
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		rfbi_transfer_area(w, h, NULL, NULL);
-		return 1;
+		rfbi_transfer_area(w, h, callback, data);
 	} else {
 		struct omap_overlay *ovl;
 		void __iomem *addr;
@@ -994,123 +911,12 @@ static int do_update(struct omap_dss_device *dssdev, struct update_region *upd)
 
 		omap_rfbi_write_pixels(addr, scr_width, x, y, w, h);
 
-		perf_show("L4");
-
-		return 0;
-	}
-}
-
-static void process_cmd_fifo(void)
-{
-	int len;
-	struct update_param p;
-	struct omap_dss_device *dssdev;
-	unsigned long flags;
-
-	if (atomic_inc_return(&rfbi.cmd_pending) != 1)
-		return;
-
-	while (true) {
-		spin_lock_irqsave(&rfbi.cmd_lock, flags);
-
-		len = kfifo_out(&rfbi.cmd_fifo, (unsigned char *)&p,
-				  sizeof(struct update_param));
-		if (len == 0) {
-			DSSDBG("nothing more in fifo\n");
-			atomic_set(&rfbi.cmd_pending, 0);
-			spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
-			break;
-		}
-
-		/* DSSDBG("fifo full %d\n", rfbi.cmd_fifo_full.counter);*/
-
-		spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
-
-		BUG_ON(len != sizeof(struct update_param));
-		BUG_ON(p.rfbi_module > 1);
-
-		dssdev = rfbi.dssdev[p.rfbi_module];
-
-		if (p.cmd == RFBI_CMD_UPDATE) {
-			if (do_update(dssdev, &p.par.r))
-				break; /* async op */
-		} else if (p.cmd == RFBI_CMD_SYNC) {
-			DSSDBG("Signaling SYNC done!\n");
-			complete(p.par.sync);
-		} else
-			BUG();
+		callback(data);
 	}
 
-	signal_fifo_waiters();
-}
-
-static void rfbi_push_cmd(struct update_param *p)
-{
-	int ret;
-
-	while (1) {
-		unsigned long flags;
-		int available;
-
-		spin_lock_irqsave(&rfbi.cmd_lock, flags);
-		available = RFBI_CMD_FIFO_LEN_BYTES -
-			kfifo_len(&rfbi.cmd_fifo);
-
-/*		DSSDBG("%d bytes left in fifo\n", available); */
-		if (available < sizeof(struct update_param)) {
-			DSSDBG("Going to wait because FIFO FULL..\n");
-			spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
-			atomic_inc(&rfbi.cmd_fifo_full);
-			wait_for_completion(&rfbi.cmd_done);
-			/*DSSDBG("Woke up because fifo not full anymore\n");*/
-			continue;
-		}
-
-		ret = kfifo_in(&rfbi.cmd_fifo, (unsigned char *)p,
-				  sizeof(struct update_param));
-/*		DSSDBG("pushed %d bytes\n", ret);*/
-
-		spin_unlock_irqrestore(&rfbi.cmd_lock, flags);
-
-		BUG_ON(ret != sizeof(struct update_param));
-
-		break;
-	}
-}
-
-static void rfbi_push_update(int rfbi_module, int x, int y, int w, int h)
-{
-	struct update_param p;
-
-	p.rfbi_module = rfbi_module;
-	p.cmd = RFBI_CMD_UPDATE;
-
-	p.par.r.x = x;
-	p.par.r.y = y;
-	p.par.r.w = w;
-	p.par.r.h = h;
-
-	DSSDBG("RFBI pushed %d,%d %dx%d\n", x, y, w, h);
-
-	rfbi_push_cmd(&p);
-
-	process_cmd_fifo();
-}
-
-static void rfbi_push_sync(int rfbi_module, struct completion *sync_comp)
-{
-	struct update_param p;
-
-	p.rfbi_module = rfbi_module;
-	p.cmd = RFBI_CMD_SYNC;
-	p.par.sync = sync_comp;
-
-	rfbi_push_cmd(&p);
-
-	DSSDBG("RFBI sync pushed to cmd fifo\n");
-
-	process_cmd_fifo();
+	return 0;
 }
+EXPORT_SYMBOL(omap_rfbi_update);
 
 void rfbi_dump_regs(struct seq_file *s)
 {
@@ -1155,12 +961,8 @@ int rfbi_init(void)
 {
 	u32 rev;
 	u32 l;
-	int r;
 
 	spin_lock_init(&rfbi.cmd_lock);
-	r = kfifo_alloc(&rfbi.cmd_fifo, RFBI_CMD_FIFO_LEN_BYTES, GFP_KERNEL);
-	if (r)
-		return r;
 
 	init_completion(&rfbi.cmd_done);
 	atomic_set(&rfbi.cmd_fifo_full, 0);
@@ -1196,42 +998,10 @@ void rfbi_exit(void)
 {
 	DSSDBG("rfbi_exit\n");
 
-	kfifo_free(&rfbi.cmd_fifo);
-
 	iounmap(rfbi.base);
 }
 
 /* struct omap_display support */
-static int rfbi_display_update(struct omap_dss_device *dssdev,
-			u16 x, u16 y, u16 w, u16 h)
-{
-	int rfbi_module;
-
-	if (w == 0 || h == 0)
-		return 0;
-
-	rfbi_module = rfbi_find_display(dssdev);
-
-	rfbi_push_update(rfbi_module, x, y, w, h);
-
-	return 0;
-}
-
-static int rfbi_display_sync(struct omap_dss_device *dssdev)
-{
-	struct completion sync_comp;
-	int rfbi_module;
-
-	rfbi_module = rfbi_find_display(dssdev);
-
-	init_completion(&sync_comp);
-	rfbi_push_sync(rfbi_module, &sync_comp);
-	DSSDBG("Waiting for SYNC to happen...\n");
-	wait_for_completion(&sync_comp);
-	DSSDBG("Released from SYNC\n");
-	return 0;
-}
-
 static int rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -1291,8 +1061,6 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 {
 	dssdev->enable = rfbi_display_enable;
 	dssdev->disable = rfbi_display_disable;
-	dssdev->update = rfbi_display_update;
-	dssdev->sync = rfbi_display_sync;
 
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
 
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 75fe1e7..b145cae 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -213,7 +213,7 @@ static int omapfb_update_window_nolock(struct fb_info *fbi,
 	if (x + w > dw || y + h > dh)
 		return -EINVAL;
 
-	return display->update(display, x, y, w, h);
+	return display->driver->update(display, x, y, w, h);
 }
 
 /* This function is exported for SGX driver use */
@@ -538,18 +538,18 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");
-		if (!display || !display->sync) {
+		if (!display || !display->driver->sync) {
 			/* DSS1 never returns an error here, so we neither */
 			/*r = -EINVAL;*/
 			break;
 		}
 
-		r = display->sync(display);
+		r = display->driver->sync(display);
 		break;
 
 	case OMAPFB_UPDATE_WINDOW_OLD:
 		DBG("ioctl UPDATE_WINDOW_OLD\n");
-		if (!display || !display->update) {
+		if (!display || !display->driver->update) {
 			r = -EINVAL;
 			break;
 		}
@@ -567,7 +567,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	case OMAPFB_UPDATE_WINDOW:
 		DBG("ioctl UPDATE_WINDOW\n");
-		if (!display || !display->update) {
+		if (!display || !display->driver->update) {
 			r = -EINVAL;
 			break;
 		}
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 7686e86..310d573 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1254,11 +1254,11 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 exit:
 	omapfb_unlock(fbdev);
 
-	if (r == 0 && do_update && display->update) {
+	if (r == 0 && do_update && display->driver->update) {
 		u16 w, h;
 		display->driver->get_resolution(display, &w, &h);
 
-		r = display->update(display, 0, 0, w, h);
+		r = display->driver->update(display, 0, 0, w, h);
 	}
 
 	return r;
@@ -1639,8 +1639,8 @@ int omapfb_realloc_fbmem(struct fb_info *fbi, unsigned long size, int type)
 	if (old_size == size && old_type == type)
 		return 0;
 
-	if (display && display->sync)
-			display->sync(display);
+	if (display && display->driver->sync)
+			display->driver->sync(display);
 
 	omapfb_free_fbmem(fbi);
 
@@ -2214,7 +2214,7 @@ static int omapfb_probe(struct platform_device *pdev)
 
 			dssdrv->get_resolution(def_display,
 					&w, &h);
-			def_display->update(def_display, 0, 0, w, h);
+			def_display->driver->update(def_display, 0, 0, w, h);
 #endif
 		} else {
 			if (dssdrv->set_update_mode)
-- 
1.6.5

