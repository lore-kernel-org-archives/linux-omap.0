From: Archit Taneja <archit@ti.com>
Subject: [RFC 07/11] OMAPDSS: writeback: add mechanism to do mem to mem updates
Date: Wed, 7 Nov 2012 20:14:25 +0530
Message-ID: <1352299469-17609-8-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47567 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753794Ab2KGOpN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 09:45:13 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

writeback in mem to mem mode works like an overlay manager connected to a
display in stallmode. When we set ENABLE in DISPC_WB_ATTRIBUTES writeback, it
starts a mem to mem transfer. On completion, we get a FRAMEDONEWB interrupt and
the ENABLE bit is cleared by HW.

In APPLY, we add dss_wb_start_update, this function is similar to
dss_mgr_start_update, but is responsible for configuring both the manager(and
the overlays connected to it) and the writeback registers. We add an updating
field in the writeback private data which tells APPLY when we are busy and
when we are done with a mem to mem transfer. We register to the framedone isr
when needed and we update the updating field in dss_apply_irq_handler when we
are done with the transfer.

In the writeback output driver, we add a semaphore based way to lock the
writeback resource as we do in DSI command mode. The writeback user is expected
to lock the bus, call omapdss_writeback_update and mention a callback along with
it, and unlock the bus in the callback. omapdss_writeback_update registers to
the FRAMEDONE interrupt to trigger the callback and starts the update by calling
the corresponding APPLY function.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   83 +++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h       |    1 +
 drivers/video/omap2/dss/writeback.c |  106 +++++++++++++++++++++++++++++++++++
 include/video/omapdss.h             |    4 ++
 4 files changed, 194 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index a205ed4..2fd08d8 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -114,6 +114,9 @@ struct wb_priv_data {
 	bool info_dirty;
 	struct omap_dss_writeback_info info;
 
+	/* If true, writeback output is enabled */
+	bool updating;
+
 	/*
 	 * If true in memory to memory mode, a manager is connected to it.
 	 * However, it may not be active.
@@ -285,6 +288,7 @@ static int dss_check_settings_apply(struct omap_overlay_manager *mgr)
 static bool need_isr(void)
 {
 	const int num_mgrs = dss_feat_get_num_mgrs();
+	const int num_wbs = dss_feat_get_num_wbs();
 	int i;
 
 	for (i = 0; i < num_mgrs; ++i) {
@@ -362,6 +366,20 @@ static bool need_isr(void)
 		}
 	}
 
+	for (i = 0; i < num_wbs; i++) {
+		struct omap_dss_output *wb = omap_dss_get_writeback();
+		struct wb_priv_data *wp = get_wb_priv(wb);
+
+		if (!wp->enabled)
+			continue;
+
+		if (wb_manual_update(wb)) {
+			/* to catch FRAMEDONEWB */
+			if (wp->updating)
+				return true;
+		}
+	}
+
 	return false;
 }
 
@@ -841,6 +859,7 @@ static void dss_apply_irq_handler(void *data, u32 mask);
 static void dss_register_vsync_isr(void)
 {
 	const int num_mgrs = dss_feat_get_num_mgrs();
+	const int num_wbs = dss_feat_get_num_wbs();
 	u32 mask;
 	int r, i;
 
@@ -851,6 +870,9 @@ static void dss_register_vsync_isr(void)
 	for (i = 0; i < num_mgrs; ++i)
 		mask |= dispc_mgr_get_framedone_irq(i);
 
+	for (i = 0; i < num_wbs; i++)
+		mask |= dispc_wb_get_framedone_irq();
+
 	r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
@@ -860,6 +882,7 @@ static void dss_register_vsync_isr(void)
 static void dss_unregister_vsync_isr(void)
 {
 	const int num_mgrs = dss_feat_get_num_mgrs();
+	const int num_wbs = dss_feat_get_num_wbs();
 	u32 mask;
 	int r, i;
 
@@ -870,6 +893,9 @@ static void dss_unregister_vsync_isr(void)
 	for (i = 0; i < num_mgrs; ++i)
 		mask |= dispc_mgr_get_framedone_irq(i);
 
+	for (i = 0; i < num_wbs; i++)
+		mask |= dispc_wb_get_framedone_irq();
+
 	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
@@ -879,6 +905,7 @@ static void dss_unregister_vsync_isr(void)
 static void dss_apply_irq_handler(void *data, u32 mask)
 {
 	const int num_mgrs = dss_feat_get_num_mgrs();
+	const int num_wbs = dss_feat_get_num_wbs();
 	int i;
 	bool extra_updating;
 
@@ -906,6 +933,16 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 		}
 	}
 
+	for (i = 0; i < num_wbs; i++) {
+		struct omap_dss_output *wb = omap_dss_get_writeback();
+		struct wb_priv_data *wp = get_wb_priv(wb);
+
+		if (!wp->enabled)
+			continue;
+
+		wp->updating = dispc_wb_is_enabled();
+	}
+
 	dss_write_regs();
 	dss_set_go_bits();
 
@@ -1685,6 +1722,11 @@ void dss_wb_disable(struct omap_dss_output *wb)
 	if (!wp->enabled)
 		goto out;
 
+	if (wp->updating) {
+		DSSERR("can't disable writeback in the middle of an update\n");
+		goto out;
+	}
+
 	spin_lock_irqsave(&data_lock, flags);
 
 	wp->updating = false;
@@ -1694,3 +1736,44 @@ void dss_wb_disable(struct omap_dss_output *wb)
 out:
 	mutex_unlock(&apply_lock);
 }
+
+/*
+ * When doing a writeback mem to mem update, the updating field for writeback
+ * private data is true, but for manager private data the updating field is
+ * false. This is because a manager isn't really 'enabled' in HW, it's the
+ * writeback pipeline which initiates the transfer.
+ */
+void dss_wb_start_update(struct omap_dss_output *wb)
+{
+	struct omap_overlay_manager *mgr = wb->manager;
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+	int r;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	WARN_ON(wp->updating);
+
+	/* add some similar check for writeback later */
+
+	r = dss_check_settings(mgr);
+	if (r) {
+		DSSERR("cannot start manual update: illegal configuration\n");
+		spin_unlock_irqrestore(&data_lock, flags);
+		return;
+	}
+
+	dss_wb_write_regs(wb);
+
+	dss_mgr_write_regs(mgr);
+	dss_mgr_write_regs_extra(mgr);
+
+	wp->updating = true;
+
+	if (!dss_data.irq_enabled && need_isr())
+		dss_register_vsync_isr();
+
+	dispc_wb_enable(true);
+
+	spin_unlock_irqrestore(&data_lock, flags);
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f9e7074..8c70b08 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -217,6 +217,7 @@ void dss_wb_get_info(struct omap_dss_output *wb,
 int omap_dss_wb_apply(struct omap_dss_output *wb);
 int dss_wb_enable(struct omap_dss_output *wb);
 void dss_wb_disable(struct omap_dss_output *wb);
+void dss_wb_start_update(struct omap_dss_output *wb);
 
 /* output */
 void dss_register_output(struct omap_dss_output *out);
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 09394fb..7a25e99 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -20,6 +20,8 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/semaphore.h>
+#include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
 #include <video/omapdss.h>
@@ -27,7 +29,15 @@
 #include "dss.h"
 
 struct writeback_data {
+	struct platform_device *pdev;
+
 	struct mutex lock;
+	struct semaphore bus_lock;
+
+	void (*framedone_callback)(int, void *);
+	void *framedone_data;
+
+	struct delayed_work framedone_timeout_work;
 
 	struct omap_dss_output output;
 	/*
@@ -71,6 +81,32 @@ int dss_writeback_calc_channel_in(struct omap_overlay_manager *mgr,
 	return 0;
 }
 
+void omapdss_writeback_bus_lock(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	down(&wb_data->bus_lock);
+}
+EXPORT_SYMBOL(omapdss_writeback_bus_lock);
+
+void omapdss_writeback_bus_unlock(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	up(&wb_data->bus_lock);
+}
+EXPORT_SYMBOL(omapdss_writeback_bus_unlock);
+
+static bool writeback_bus_is_locked(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	return wb_data->bus_lock.count == 0;
+}
+
 void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h)
 {
 	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
@@ -88,11 +124,39 @@ void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h)
 }
 EXPORT_SYMBOL(omapdss_writeback_set_input_size);
 
+static void writeback_handle_framedone(struct platform_device *wbdev, int error)
+{
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	wb_data->framedone_callback(error, wb_data->framedone_data);
+}
+
+static void writeback_framedone_timeout_work_callback(struct work_struct *work)
+{
+	struct writeback_data *wb_data = container_of(work,
+			struct writeback_data, framedone_timeout_work.work);
+
+	DSSERR("FRAMEDONE WB not received for 100ms\n");
+
+	writeback_handle_framedone(wb_data->pdev, -ETIMEDOUT);
+}
+
+static void writeback_framedone_irq_callback(void *data, u32 mask)
+{
+	struct platform_device *wbdev = (struct platform_device *) data;
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	cancel_delayed_work(&wb_data->framedone_timeout_work);
+
+	writeback_handle_framedone(wb_data->pdev, 0);
+}
+
 static void writeback_config_manager(struct omap_dss_output *wb)
 {
 	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
 	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
 	struct dss_lcd_mgr_config lcd_config;
+	int r;
 
 	dss_mgr_set_timings(wb->manager, &wb_data->input_timings);
 
@@ -110,6 +174,11 @@ static void writeback_config_manager(struct omap_dss_output *wb)
 	 */
 	dss_mgr_set_lcd_config(wb->manager, &lcd_config);
 
+	r = omap_dispc_register_isr(writeback_framedone_irq_callback,
+		(void *) wbdev, DISPC_IRQ_FRAMEDONEWB);
+	if (r)
+		DSSERR("Failed to register for FRAMEDONEWB irq\n");
+
 	dss_mgr_enable(wb->manager);
 }
 
@@ -119,6 +188,8 @@ int omapdss_writeback_enable(struct omap_dss_output *wb)
 	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
 	int r;
 
+	WARN_ON(!writeback_bus_is_locked(wb));
+
 	mutex_lock(&wb_data->lock);
 
 	r = dispc_runtime_get();
@@ -139,18 +210,48 @@ void omapdss_writeback_disable(struct omap_dss_output *wb)
 {
 	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
 	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+	int r;
+
+	WARN_ON(!writeback_bus_is_locked(wb));
 
 	mutex_lock(&wb_data->lock);
 
 	dss_wb_disable(wb);
 	dss_mgr_disable(wb->manager);
 
+	r = omap_dispc_unregister_isr(writeback_framedone_irq_callback,
+		(void *) wbdev, DISPC_IRQ_FRAMEDONEWB);
+	if (r)
+		DSSERR("Failed to unregister FRAMEDONEWB irq\n");
+
 	dispc_runtime_put();
 
 	mutex_unlock(&wb_data->lock);
 }
 EXPORT_SYMBOL(omapdss_writeback_disable);
 
+int omapdss_writeback_update(struct omap_dss_output *wb,
+		void (*callback)(int, void *), void *data)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+	int r;
+
+	WARN_ON(!writeback_bus_is_locked(wb));
+
+	wb_data->framedone_callback = callback;
+	wb_data->framedone_data = data;
+
+	r = schedule_delayed_work(&wb_data->framedone_timeout_work,
+		msecs_to_jiffies(100));
+	BUG_ON(r == 0);
+
+	dss_wb_start_update(wb);
+
+	return 0;
+}
+EXPORT_SYMBOL(omapdss_writeback_update);
+
 int omapdss_writeback_apply(struct omap_dss_output *wb)
 {
 	return omap_dss_wb_apply(wb);
@@ -199,7 +300,12 @@ static int __init omap_writeback_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, wb_data);
 
+	wb_data->pdev = pdev;
 	mutex_init(&wb_data->lock);
+	sema_init(&wb_data->bus_lock, 1);
+
+	INIT_DEFERRABLE_WORK(&wb_data->framedone_timeout_work,
+			writeback_framedone_timeout_work_callback);
 
 	/* initialize with dummy timings */
 	wb_data->input_timings = (struct omap_video_timings)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f63c0cb..c7f3ac7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -837,9 +837,13 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+void omapdss_writeback_bus_lock(struct omap_dss_output *wb);
+void omapdss_writeback_bus_unlock(struct omap_dss_output *wb);
 int omapdss_writeback_enable(struct omap_dss_output *wb);
 void omapdss_writeback_disable(struct omap_dss_output *wb);
 void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h);
+int omapdss_writeback_update(struct omap_dss_output *wb,
+		void (*callback)(int, void *), void *data);
 int omapdss_writeback_apply(struct omap_dss_output *wb);
 int omapdss_writeback_set_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
-- 
1.7.9.5

