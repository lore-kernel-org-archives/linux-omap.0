From: Archit Taneja <archit@ti.com>
Subject: [RFC 05/11] OMAPDSS: APPLY: Add writeback enable/disable funcs
Date: Wed, 7 Nov 2012 20:14:23 +0530
Message-ID: <1352299469-17609-6-git-send-email-archit@ti.com>
References: <n>
 <1352299469-17609-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab2KGOpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 09:45:07 -0500
In-Reply-To: <1352299469-17609-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add dss_wb_enable/dss_wb_disable funcs in APPLY similar to that of manager's
enable/disable functions. Since, these functions support only writeback in
memory to memory mode, their job is reduced to just setting the private enable
parameter correctly.

Writeback can't be enabled if the manager it is connected to is not enabled
first. dss_wb_enable makes sure that the connected manager is enabled,
dss_wb_disable doesn't have much dependency on whether the connected manager
is disabled before or after.

Add corresponding enable/disable functions in the output driver which the
writeback user will use. The output driver enable function also takes the
responsibility of configuring and enabling the connected manager. The function
writeback_configure_manager configures the manager in stall mode and sets
the dimensions to the desired writeback input size. The output driver disable
functions disables both manager and writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   70 +++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h       |    2 +
 drivers/video/omap2/dss/writeback.c |   63 +++++++++++++++++++++++++++++++
 include/video/omapdss.h             |    2 +
 4 files changed, 137 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 8fe7fce..1ab1755 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1593,3 +1593,73 @@ end:
 
 	return 0;
 }
+
+int dss_wb_enable(struct omap_dss_output *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	struct mgr_priv_data *mp;
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&apply_lock);
+
+	if (wp->enabled) {
+		r = 0;
+		goto out;
+	}
+
+	if (wb->manager == NULL) {
+		DSSERR("can't enable writeback without a manager\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	mp = get_mgr_priv(wb->manager);
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (!mp->enabled) {
+		DSSERR("can't enable writeback with a disabled manager\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	wp->enabled = true;
+
+	/*
+	 * TODO: check settings here, if we fail, set wp->enabled back to
+	 * false
+	 */
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	mutex_unlock(&apply_lock);
+
+	return 0;
+err:
+	spin_unlock_irqrestore(&data_lock, flags);
+out:
+	mutex_unlock(&apply_lock);
+
+	return r;
+}
+
+void dss_wb_disable(struct omap_dss_output *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	mutex_lock(&apply_lock);
+
+	if (!wp->enabled)
+		goto out;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	wp->updating = false;
+	wp->enabled = false;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+out:
+	mutex_unlock(&apply_lock);
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 1b9c936..6238895 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -215,6 +215,8 @@ int dss_wb_set_info(struct omap_dss_output *wb,
 void dss_wb_get_info(struct omap_dss_output *wb,
 		struct omap_dss_writeback_info *info);
 int omap_dss_wb_apply(struct omap_dss_output *wb);
+int dss_wb_enable(struct omap_dss_output *wb);
+void dss_wb_disable(struct omap_dss_output *wb);
 
 /* output */
 void dss_register_output(struct omap_dss_output *out);
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 9a80f72..598defd 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -65,6 +65,69 @@ void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h)
 }
 EXPORT_SYMBOL(omapdss_writeback_set_input_size);
 
+static void writeback_config_manager(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+	struct dss_lcd_mgr_config lcd_config;
+
+	dss_mgr_set_timings(wb->manager, &wb_data->input_timings);
+
+	lcd_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
+	lcd_config.stallmode = true;
+	lcd_config.fifohandcheck = false;
+	lcd_config.clock_info.lck_div = 1;
+	lcd_config.clock_info.pck_div = 1;
+	lcd_config.video_port_width = 24;
+	lcd_config.lcden_sig_polarity = false;
+
+	/*
+	 * apply lcd_config such that manager appears to be in stallmode, this
+	 * makes the manager operate in manual update mode
+	 */
+	dss_mgr_set_lcd_config(wb->manager, &lcd_config);
+
+	dss_mgr_enable(wb->manager);
+}
+
+int omapdss_writeback_enable(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+	int r;
+
+	mutex_lock(&wb_data->lock);
+
+	r = dispc_runtime_get();
+	if (r)
+		goto err;
+
+	writeback_config_manager(wb);
+
+	r = dss_wb_enable(wb);
+err:
+	mutex_unlock(&wb_data->lock);
+
+	return r;
+}
+EXPORT_SYMBOL(omapdss_writeback_enable);
+
+void omapdss_writeback_disable(struct omap_dss_output *wb)
+{
+	struct platform_device *wbdev = writeback_get_wbdev_from_output(wb);
+	struct writeback_data *wb_data = writeback_get_drv_data(wbdev);
+
+	mutex_lock(&wb_data->lock);
+
+	dss_wb_disable(wb);
+	dss_mgr_disable(wb->manager);
+
+	dispc_runtime_put();
+
+	mutex_unlock(&wb_data->lock);
+}
+EXPORT_SYMBOL(omapdss_writeback_disable);
+
 int omapdss_writeback_apply(struct omap_dss_output *wb)
 {
 	return omap_dss_wb_apply(wb);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d8064ed..f63c0cb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -837,6 +837,8 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+int omapdss_writeback_enable(struct omap_dss_output *wb);
+void omapdss_writeback_disable(struct omap_dss_output *wb);
 void omapdss_writeback_set_input_size(struct omap_dss_output *wb, u16 w, u16 h);
 int omapdss_writeback_apply(struct omap_dss_output *wb);
 int omapdss_writeback_set_info(struct omap_dss_output *wb,
-- 
1.7.9.5

