From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/32] OMAPDSS: manage framedone irq with mgr ops
Date: Thu, 15 Nov 2012 17:58:29 +0200
Message-ID: <1352995120-3288-22-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768296Ab2KOP7p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:45 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Some of the output drivers need to handle FRAMEDONE interrupt from
DISPC. This creates a direct dependency to dispc code, and we need to
avoid this to make the compat code to work.

Instead of the output drivers registering for dispc interrupts, we
create new mgr-ops that are used to register a framedone handler. The
code implementing the mgr-ops is responsible for calling the handler
when DISPC FRAMEDONE interrupt happens. The compat layer is improved
accordingly to do the call to the framedone handler.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c  |   46 ++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dsi.c    |   26 ++++++++-------------
 drivers/video/omap2/dss/dss.h    |    8 +++++++
 drivers/video/omap2/dss/output.c |   12 ++++++++++
 drivers/video/omap2/dss/rfbi.c   |   12 +++++-----
 5 files changed, 82 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ca85eaf..f10e0b4 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -105,6 +105,9 @@ struct mgr_priv_data {
 
 	struct omap_video_timings timings;
 	struct dss_lcd_mgr_config lcd_config;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
 
 static struct {
@@ -888,6 +891,21 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	if (!extra_updating)
 		complete_all(&extra_updated_completion);
 
+	/* call framedone handlers for manual update displays */
+	for (i = 0; i < num_mgrs; i++) {
+		struct omap_overlay_manager *mgr;
+		struct mgr_priv_data *mp;
+
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		if (!mgr_manual_update(mgr) || !mp->framedone_handler)
+			continue;
+
+		if (mask & dispc_mgr_get_framedone_irq(i))
+			mp->framedone_handler(mp->framedone_handler_data);
+	}
+
 	if (!need_isr())
 		dss_unregister_vsync_isr();
 
@@ -1501,12 +1519,40 @@ err:
 	return r;
 }
 
+static int dss_mgr_register_framedone_handler_compat(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	if (mp->framedone_handler)
+		return -EBUSY;
+
+	mp->framedone_handler = handler;
+	mp->framedone_handler_data = data;
+
+	return 0;
+}
+
+static void dss_mgr_unregister_framedone_handler_compat(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	WARN_ON(mp->framedone_handler != handler ||
+			mp->framedone_handler_data != data);
+
+	mp->framedone_handler = NULL;
+	mp->framedone_handler_data = NULL;
+}
+
 static const struct dss_mgr_ops apply_mgr_ops = {
 	.start_update = dss_mgr_start_update_compat,
 	.enable = dss_mgr_enable_compat,
 	.disable = dss_mgr_disable_compat,
 	.set_timings = dss_mgr_set_timings_compat,
 	.set_lcd_config = dss_mgr_set_lcd_config_compat,
+	.register_framedone_handler = dss_mgr_register_framedone_handler_compat,
+	.unregister_framedone_handler = dss_mgr_unregister_framedone_handler_compat,
 };
 
 static int compat_refcnt;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cf32dc7..6f9b62e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4535,7 +4535,7 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 	dsi_handle_framedone(dsi->pdev, -ETIMEDOUT);
 }
 
-static void dsi_framedone_irq_callback(void *data, u32 mask)
+static void dsi_framedone_irq_callback(void *data)
 {
 	struct platform_device *dsidev = (struct platform_device *) data;
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -4609,7 +4609,6 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_overlay_manager *mgr = dssdev->output->manager;
 	int r;
-	u32 irq = 0;
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		dsi->timings.hsw = 1;
@@ -4619,12 +4618,10 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dsi->timings.vfp = 0;
 		dsi->timings.vbp = 0;
 
-		irq = dispc_mgr_get_framedone_irq(mgr->id);
-
-		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
-			(void *) dsidev, irq);
+		r = dss_mgr_register_framedone_handler(mgr,
+				dsi_framedone_irq_callback, dsidev);
 		if (r) {
-			DSSERR("can't get FRAMEDONE irq\n");
+			DSSERR("can't register FRAMEDONE handler\n");
 			goto err;
 		}
 
@@ -4662,8 +4659,8 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	return 0;
 err1:
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
-		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
-			(void *) dsidev, irq);
+		dss_mgr_unregister_framedone_handler(mgr,
+				dsi_framedone_irq_callback, dsidev);
 err:
 	return r;
 }
@@ -4674,14 +4671,9 @@ static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_overlay_manager *mgr = dssdev->output->manager;
 
-	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
-		u32 irq;
-
-		irq = dispc_mgr_get_framedone_irq(mgr->id);
-
-		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
-			(void *) dsidev, irq);
-	}
+	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
+		dss_mgr_unregister_framedone_handler(mgr,
+				dsi_framedone_irq_callback, dsidev);
 }
 
 static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index dbe54c0..8ec411d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -186,6 +186,10 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings);
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config);
+int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data);
+void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data);
 
 /* output */
 void dss_register_output(struct omap_dss_output *out);
@@ -531,6 +535,10 @@ struct dss_mgr_ops {
 			const struct omap_video_timings *timings);
 	void (*set_lcd_config)(struct omap_overlay_manager *mgr,
 			const struct dss_lcd_mgr_config *config);
+	int (*register_framedone_handler)(struct omap_overlay_manager *mgr,
+			void (*handler)(void *), void *data);
+	void (*unregister_framedone_handler)(struct omap_overlay_manager *mgr,
+			void (*handler)(void *), void *data);
 };
 
 int dss_install_mgr_ops(const struct dss_mgr_ops *mgr_ops);
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index c8972bf..accb865 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -190,3 +190,15 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 {
 	dss_mgr_ops->start_update(mgr);
 }
+
+int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data)
+{
+	return dss_mgr_ops->register_framedone_handler(mgr, handler, data);
+}
+
+void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
+		void (*handler)(void *), void *data)
+{
+	dss_mgr_ops->unregister_framedone_handler(mgr, handler, data);
+}
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 7bfeb13..328170f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -342,7 +342,7 @@ static int rfbi_transfer_area(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static void framedone_callback(void *data, u32 mask)
+static void framedone_callback(void *data)
 {
 	void (*callback)(void *data);
 
@@ -908,8 +908,8 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	r = omap_dispc_register_isr(framedone_callback, NULL,
-			DISPC_IRQ_FRAMEDONE);
+	r = dss_mgr_register_framedone_handler(out->manager,
+			framedone_callback, NULL);
 	if (r) {
 		DSSERR("can't get FRAMEDONE irq\n");
 		goto err1;
@@ -933,8 +933,10 @@ EXPORT_SYMBOL(omapdss_rfbi_display_enable);
 
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 {
-	omap_dispc_unregister_isr(framedone_callback, NULL,
-			DISPC_IRQ_FRAMEDONE);
+	struct omap_dss_output *out = dssdev->output;
+
+	dss_mgr_unregister_framedone_handler(out->manager,
+			framedone_callback, NULL);
 	omap_dss_stop_device(dssdev);
 
 	rfbi_runtime_put();
-- 
1.7.10.4

