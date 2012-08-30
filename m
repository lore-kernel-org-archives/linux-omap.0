From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 12/23] OMAPDSS: DSI: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:34 +0530
Message-ID: <1346326845-16583-13-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab2H3LnE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:04 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a DSI function, it passes the omap_dss_device
pointer, this pointer currently propagates within the DSI driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to DSI functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the DSI interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  219 ++++++++++++++++++++++++-----------------
 1 file changed, 131 insertions(+), 88 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 78212c4..228510f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -356,9 +356,9 @@ static inline struct dsi_data *dsi_get_dsidrv_data(struct platform_device *dside
 	return dev_get_drvdata(&dsidev->dev);
 }
 
-static inline struct platform_device *dsi_get_dsidev_from_dssdev(struct omap_dss_device *dssdev)
+static inline struct platform_device *dsi_get_dsidev_from_output(struct omap_dss_output *out)
 {
-	return dssdev->output->pdev;
+	return out->pdev;
 }
 
 struct platform_device *dsi_get_dsidev_from_id(int module)
@@ -391,7 +391,8 @@ static inline u32 dsi_read_reg(struct platform_device *dsidev,
 
 void dsi_bus_lock(struct omap_dss_device *dssdev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	down(&dsi->bus_lock);
@@ -400,7 +401,8 @@ EXPORT_SYMBOL(dsi_bus_lock);
 
 void dsi_bus_unlock(struct omap_dss_device *dssdev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	up(&dsi->bus_lock);
@@ -1205,15 +1207,15 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 	return r;
 }
 
-static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
+static int dsi_set_lp_clk_divisor(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
 
-	lp_clk_div = dssdev->clocks.dsi.lp_clk_div;
+	lp_clk_div = out->device->clocks.dsi.lp_clk_div;
 
 	if (lp_clk_div == 0 || lp_clk_div > dsi->lpdiv_max)
 		return -EINVAL;
@@ -2689,7 +2691,8 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
 void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
@@ -2817,7 +2820,8 @@ static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 
 int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r = 0;
 	u32 err;
@@ -2986,7 +2990,8 @@ static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
 
 int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_send_long(dsidev, channel, MIPI_DSI_NULL_PACKET, NULL,
 		0, 0);
@@ -3026,7 +3031,8 @@ static int dsi_vc_write_nosync_common(struct platform_device *dsidev,
 int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_DCS);
@@ -3036,24 +3042,25 @@ EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_GENERIC);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_nosync);
 
-static int dsi_vc_write_common(struct omap_dss_device *dssdev, int channel,
+static int dsi_vc_write_common(struct omap_dss_output *out, int channel,
 		u8 *data, int len, enum dss_dsi_content_type type)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_write_nosync_common(dsidev, channel, data, len, type);
 	if (r)
 		goto err;
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
+	r = dsi_vc_send_bta_sync(out->device, channel);
 	if (r)
 		goto err;
 
@@ -3075,7 +3082,9 @@ err:
 int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 		int len)
 {
-	return dsi_vc_write_common(dssdev, channel, data, len,
+	struct omap_dss_output *out = dssdev->output;
+
+	return dsi_vc_write_common(out, channel, data, len,
 			DSS_DSI_CONTENT_DCS);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write);
@@ -3083,7 +3092,9 @@ EXPORT_SYMBOL(dsi_vc_dcs_write);
 int dsi_vc_generic_write(struct omap_dss_device *dssdev, int channel, u8 *data,
 		int len)
 {
-	return dsi_vc_write_common(dssdev, channel, data, len,
+	struct omap_dss_output *out = dssdev->output;
+
+	return dsi_vc_write_common(out, channel, data, len,
 			DSS_DSI_CONTENT_GENERIC);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write);
@@ -3295,7 +3306,8 @@ err:
 int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_dcs_send_read_request(dsidev, channel, dcs_cmd);
@@ -3323,17 +3335,17 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
-static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
+static int dsi_vc_generic_read(struct omap_dss_output *out, int channel,
 		u8 *reqdata, int reqlen, u8 *buf, int buflen)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	int r;
 
 	r = dsi_vc_generic_send_read_request(dsidev, channel, reqdata, reqlen);
 	if (r)
 		return r;
 
-	r = dsi_vc_send_bta_sync(dssdev, channel);
+	r = dsi_vc_send_bta_sync(out->device, channel);
 	if (r)
 		return r;
 
@@ -3353,9 +3365,10 @@ static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
 int dsi_vc_generic_read_0(struct omap_dss_device *dssdev, int channel, u8 *buf,
 		int buflen)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
-	r = dsi_vc_generic_read(dssdev, channel, NULL, 0, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, NULL, 0, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_0(ch %d) failed\n", channel);
 		return r;
@@ -3368,9 +3381,10 @@ EXPORT_SYMBOL(dsi_vc_generic_read_0);
 int dsi_vc_generic_read_1(struct omap_dss_device *dssdev, int channel, u8 param,
 		u8 *buf, int buflen)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
-	r = dsi_vc_generic_read(dssdev, channel, &param, 1, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, &param, 1, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_1(ch %d) failed\n", channel);
 		return r;
@@ -3383,13 +3397,14 @@ EXPORT_SYMBOL(dsi_vc_generic_read_1);
 int dsi_vc_generic_read_2(struct omap_dss_device *dssdev, int channel,
 		u8 param1, u8 param2, u8 *buf, int buflen)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 	u8 reqdata[2];
 
 	reqdata[0] = param1;
 	reqdata[1] = param2;
 
-	r = dsi_vc_generic_read(dssdev, channel, reqdata, 2, buf, buflen);
+	r = dsi_vc_generic_read(out, channel, reqdata, 2, buf, buflen);
 	if (r) {
 		DSSERR("dsi_vc_generic_read_2(ch %d) failed\n", channel);
 		return r;
@@ -3402,7 +3417,8 @@ EXPORT_SYMBOL(dsi_vc_generic_read_2);
 int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 
 	return dsi_vc_send_short(dsidev, channel,
 			MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE, len, 0);
@@ -3738,10 +3754,11 @@ static int dsi_compute_interleave_lp(int blank, int enter_hs, int exit_hs,
 	return max(lp_inter, 0);
 }
 
-static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
+static void dsi_config_cmd_mode_interleaving(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = out->device;
 	int blanking_mode;
 	int hfp_blanking_mode, hbp_blanking_mode, hsa_blanking_mode;
 	int hsa, hfp, hbp, width_bytes, bllp, lp_clk_div;
@@ -3856,9 +3873,9 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_VM_TIMING6, r);
 }
 
-static int dsi_proto_config(struct omap_dss_device *dssdev)
+static int dsi_proto_config(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 	int buswidth = 0;
@@ -3916,7 +3933,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_config_vp_sync_events(dsidev);
 		dsi_config_blanking_modes(dsidev);
-		dsi_config_cmd_mode_interleaving(dssdev);
+		dsi_config_cmd_mode_interleaving(out);
 	}
 
 	dsi_vc_initial_config(dsidev, 0);
@@ -4042,7 +4059,8 @@ static void dsi_proto_timings(struct platform_device *dsidev)
 int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 		const struct omap_dsi_pin_config *pin_cfg)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int num_pins;
 	const int *pins;
@@ -4109,7 +4127,8 @@ EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	u8 data_type;
@@ -4150,7 +4169,7 @@ int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 		dsi_if_enable(dsidev, true);
 	}
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r) {
 		if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 			dsi_if_enable(dsidev, false);
@@ -4166,7 +4185,8 @@ EXPORT_SYMBOL(dsi_enable_video_output);
 
 void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
@@ -4180,13 +4200,13 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 		dsi_if_enable(dsidev, true);
 	}
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 }
 EXPORT_SYMBOL(dsi_disable_video_output);
 
-static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
+static void dsi_update_screen_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned bytespp;
 	unsigned bytespl;
@@ -4249,9 +4269,9 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
 		msecs_to_jiffies(250));
 	BUG_ON(r == 0);
 
-	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
+	dss_mgr_set_timings(out->manager, &dsi->timings);
 
-	dss_mgr_start_update(dssdev->manager);
+	dss_mgr_start_update(out->manager);
 
 	if (dsi->te_enabled) {
 		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
@@ -4325,7 +4345,8 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u16 dw, dh;
 
@@ -4343,7 +4364,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->update_bytes = dw * dh *
 		dsi_get_pixel_size(dsi->pix_fmt) / 8;
 #endif
-	dsi_update_screen_dispc(dssdev);
+	dsi_update_screen_dispc(out);
 
 	return 0;
 }
@@ -4351,10 +4372,11 @@ EXPORT_SYMBOL(omap_dsi_update);
 
 /* Display funcs */
 
-static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dispc_clocks(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_device *dssdev = out->device;
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 	unsigned long long fck;
@@ -4375,10 +4397,11 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
+static int dsi_display_init_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
 	int r;
 	u32 irq = 0;
 
@@ -4390,7 +4413,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		dsi->timings.vfp = 0;
 		dsi->timings.vbp = 0;
 
-		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
+		irq = dispc_mgr_get_framedone_irq(mgr->id);
 
 		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
 			(void *) dsidev, irq);
@@ -4417,9 +4440,9 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	dsi->timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	dsi->timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
-	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
+	dss_mgr_set_timings(mgr, &dsi->timings);
 
-	r = dsi_configure_dispc_clocks(dssdev);
+	r = dsi_configure_dispc_clocks(out);
 	if (r)
 		goto err1;
 
@@ -4428,7 +4451,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			dsi_get_pixel_size(dsi->pix_fmt);
 	dsi->mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &dsi->mgr_config);
+	dss_mgr_set_lcd_config(mgr, &dsi->mgr_config);
 
 	return 0;
 err1:
@@ -4439,24 +4462,25 @@ err:
 	return r;
 }
 
-static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
+static void dsi_display_uninit_dispc(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		u32 irq;
 
-		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
+		irq = dispc_mgr_get_framedone_irq(out->manager->id);
 
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
 			(void *) dsidev, irq);
 	}
 }
 
-static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
+static int dsi_configure_dsi_clocks(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
+	struct omap_dss_device *dssdev = out->device;
 	struct dsi_clock_info cinfo;
 	int r;
 
@@ -4479,23 +4503,25 @@ static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
+static int dsi_display_init_dsi(struct omap_dss_output *out)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
+	struct omap_dss_device *dssdev = out->device;
 	int r;
 
 	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
 
-	r = dsi_configure_dsi_clocks(dssdev);
+	r = dsi_configure_dsi_clocks(out);
 	if (r)
 		goto err1;
 
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 	dss_select_dsi_clk_source(dsi->module_id, dssdev->clocks.dsi.dsi_fclk_src);
-	dss_select_lcd_clk_source(dssdev->manager->id,
+	dss_select_lcd_clk_source(out->manager->id,
 			dssdev->clocks.dispc.channel.lcd_clk_src);
 
 	DSSDBG("PLL OK\n");
@@ -4507,12 +4533,12 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	_dsi_print_reset_status(dsidev);
 
 	dsi_proto_timings(dsidev);
-	dsi_set_lp_clk_divisor(dssdev);
+	dsi_set_lp_clk_divisor(out);
 
 	if (1)
 		_dsi_print_reset_status(dsidev);
 
-	r = dsi_proto_config(dssdev);
+	r = dsi_proto_config(out);
 	if (r)
 		goto err3;
 
@@ -4530,7 +4556,7 @@ err3:
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 
 err1:
 	dsi_pll_uninit(dsidev, true);
@@ -4538,11 +4564,12 @@ err0:
 	return r;
 }
 
-static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
+static void dsi_display_uninit_dsi(struct omap_dss_output *out,
 		bool disconnect_lanes, bool enter_ulps)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_overlay_manager *mgr = out->manager;
 
 	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
@@ -4556,29 +4583,33 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
-	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
+	dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev;
+	struct dsi_data *dsi;
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
 
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
+		r = -ENODEV;
+		goto err_no_out_mgr;
+	}
+
+	dsidev = dsi_get_dsidev_from_output(out);
+	dsi = dsi_get_dsidrv_data(dsidev);
+
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	mutex_lock(&dsi->lock);
 
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
-		r = -ENODEV;
-		goto err_start_dev;
-	}
-
 	r = omap_dss_start_device(dssdev);
 	if (r) {
 		DSSERR("failed to start device\n");
@@ -4593,11 +4624,11 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 
 	_dsi_initialize_irq(dsidev);
 
-	r = dsi_display_init_dispc(dssdev);
+	r = dsi_display_init_dispc(out);
 	if (r)
 		goto err_init_dispc;
 
-	r = dsi_display_init_dsi(dssdev);
+	r = dsi_display_init_dsi(out);
 	if (r)
 		goto err_init_dsi;
 
@@ -4606,7 +4637,7 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err_init_dsi:
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(out);
 err_init_dispc:
 	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
@@ -4614,6 +4645,7 @@ err_get_dsi:
 	omap_dss_stop_device(dssdev);
 err_start_dev:
 	mutex_unlock(&dsi->lock);
+err_no_out_mgr:
 	DSSDBG("dsi_display_enable FAILED\n");
 	return r;
 }
@@ -4622,7 +4654,8 @@ EXPORT_SYMBOL(omapdss_dsi_display_enable);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_display_disable\n");
@@ -4636,9 +4669,9 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_sync_vc(dsidev, 2);
 	dsi_sync_vc(dsidev, 3);
 
-	dsi_display_uninit_dispc(dssdev);
+	dsi_display_uninit_dispc(out);
 
-	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
+	dsi_display_uninit_dsi(out, disconnect_lanes, enter_ulps);
 
 	dsi_runtime_put(dsidev);
 	dsi_enable_pll_clock(dsidev, 0);
@@ -4651,7 +4684,8 @@ EXPORT_SYMBOL(omapdss_dsi_display_disable);
 
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	dsi->te_enabled = enable;
@@ -4662,7 +4696,8 @@ EXPORT_SYMBOL(omapdss_dsi_enable_te);
 void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4675,7 +4710,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_timings);
 
 void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4690,7 +4726,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_size);
 void omapdss_dsi_set_pixel_format(struct omap_dss_device *dssdev,
 		enum omap_dss_dsi_pixel_format fmt)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4704,7 +4741,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_pixel_format);
 void omapdss_dsi_set_operation_mode(struct omap_dss_device *dssdev,
 		enum omap_dss_dsi_mode mode)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4718,7 +4756,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_operation_mode);
 void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
 		struct omap_dss_dsi_videomode_timings *timings)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	mutex_lock(&dsi->lock);
@@ -4731,7 +4770,8 @@ EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
 
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev =
+			dsi_get_dsidev_from_id(dssdev->phy.dsi.module);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("DSI init\n");
@@ -4759,7 +4799,8 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 
@@ -4778,7 +4819,8 @@ EXPORT_SYMBOL(omap_dsi_request_vc);
 
 int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if (vc_id < 0 || vc_id > 3) {
@@ -4805,7 +4847,8 @@ EXPORT_SYMBOL(omap_dsi_set_vc_id);
 
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+	struct platform_device *dsidev = dsi_get_dsidev_from_output(out);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	if ((channel >= 0 && channel <= 3) &&
-- 
1.7.9.5

