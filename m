From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/3] OMAPDSS: DSI: Pass dsi platform device wherever possible
Date: Fri, 17 Aug 2012 16:19:09 +0530
Message-ID: <1345200551-28712-2-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345200551-28712-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46712 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757815Ab2HQKut (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 06:50:49 -0400
In-Reply-To: <1345200551-28712-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Many of the DSI functions receive the connected panel's omap_dss_device pointer
as an argument. The platform device pointer is then derived via omap_dss_device
pointers.

Most of these functions don't really require omap_dss_device pointer anymore
since we now keep copies of parameters in the driver data which were previously
available only via omap_dss_device. Replace the arguments with platform device
pointers for such functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   89 ++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 96d0024..659b6cd 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2014,9 +2014,8 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 	}
 }
 
-static int dsi_set_lane_config(struct omap_dss_device *dssdev)
+static int dsi_set_lane_config(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	static const u8 offsets[] = { 0, 4, 8, 12, 16 };
 	static const enum dsi_lane_function functions[] = {
@@ -2151,10 +2150,9 @@ static void dsi_cio_timings(struct platform_device *dsidev)
 }
 
 /* lane masks have lane 0 at lsb. mask_p for positive lines, n for negative */
-static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
+static void dsi_cio_enable_lane_override(struct platform_device *dsidev,
 		unsigned mask_p, unsigned mask_n)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 	u32 l;
@@ -2201,9 +2199,8 @@ static void dsi_cio_disable_lane_override(struct platform_device *dsidev)
 	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, 0, 22, 17);
 }
 
-static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
+static int dsi_cio_wait_tx_clk_esc_reset(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int t, i;
 	bool in_use[DSI_MAX_NR_LANES];
@@ -2251,9 +2248,8 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 }
 
 /* return bitmask of enabled lanes, lane0 being the lsb */
-static unsigned dsi_get_lane_mask(struct omap_dss_device *dssdev)
+static unsigned dsi_get_lane_mask(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned mask = 0;
 	int i;
@@ -2266,16 +2262,15 @@ static unsigned dsi_get_lane_mask(struct omap_dss_device *dssdev)
 	return mask;
 }
 
-static int dsi_cio_init(struct omap_dss_device *dssdev)
+static int dsi_cio_init(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 	u32 l;
 
 	DSSDBGF();
 
-	r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
+	r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dsidev));
 	if (r)
 		return r;
 
@@ -2292,7 +2287,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 		goto err_scp_clk_dom;
 	}
 
-	r = dsi_set_lane_config(dssdev);
+	r = dsi_set_lane_config(dsidev);
 	if (r)
 		goto err_scp_clk_dom;
 
@@ -2327,7 +2322,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 			mask_p |= 1 << i;
 		}
 
-		dsi_cio_enable_lane_override(dssdev, mask_p, 0);
+		dsi_cio_enable_lane_override(dsidev, mask_p, 0);
 	}
 
 	r = dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ON);
@@ -2344,7 +2339,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_if_enable(dsidev, false);
 	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
 
-	r = dsi_cio_wait_tx_clk_esc_reset(dssdev);
+	r = dsi_cio_wait_tx_clk_esc_reset(dsidev);
 	if (r)
 		goto err_tx_clk_esc_rst;
 
@@ -2385,13 +2380,12 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
+	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dsidev));
 	return r;
 }
 
-static void dsi_cio_uninit(struct omap_dss_device *dssdev)
+static void dsi_cio_uninit(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	/* DDR_CLK_ALWAYS_ON */
@@ -2399,7 +2393,7 @@ static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
+	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dsidev));
 }
 
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
@@ -2992,10 +2986,9 @@ int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
 
-static int dsi_vc_write_nosync_common(struct omap_dss_device *dssdev,
+static int dsi_vc_write_nosync_common(struct platform_device *dsidev,
 		int channel, u8 *data, int len, enum dss_dsi_content_type type)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
 	if (len == 0) {
@@ -3026,7 +3019,9 @@ static int dsi_vc_write_nosync_common(struct omap_dss_device *dssdev,
 int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len)
 {
-	return dsi_vc_write_nosync_common(dssdev, channel, data, len,
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+
+	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_DCS);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
@@ -3034,7 +3029,9 @@ EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 int dsi_vc_generic_write_nosync(struct omap_dss_device *dssdev, int channel,
 		u8 *data, int len)
 {
-	return dsi_vc_write_nosync_common(dssdev, channel, data, len,
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+
+	return dsi_vc_write_nosync_common(dsidev, channel, data, len,
 			DSS_DSI_CONTENT_GENERIC);
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_nosync);
@@ -3045,7 +3042,7 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int channel,
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
-	r = dsi_vc_write_nosync_common(dssdev, channel, data, len, type);
+	r = dsi_vc_write_nosync_common(dsidev, channel, data, len, type);
 	if (r)
 		goto err;
 
@@ -3123,10 +3120,9 @@ int dsi_vc_generic_write_2(struct omap_dss_device *dssdev, int channel,
 }
 EXPORT_SYMBOL(dsi_vc_generic_write_2);
 
-static int dsi_vc_dcs_send_read_request(struct omap_dss_device *dssdev,
+static int dsi_vc_dcs_send_read_request(struct platform_device *dsidev,
 		int channel, u8 dcs_cmd)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 
@@ -3144,10 +3140,9 @@ static int dsi_vc_dcs_send_read_request(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dsi_vc_generic_send_read_request(struct omap_dss_device *dssdev,
+static int dsi_vc_generic_send_read_request(struct platform_device *dsidev,
 		int channel, u8 *reqdata, int reqlen)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u16 data;
 	u8 data_type;
@@ -3296,7 +3291,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
-	r = dsi_vc_dcs_send_read_request(dssdev, channel, dcs_cmd);
+	r = dsi_vc_dcs_send_read_request(dsidev, channel, dcs_cmd);
 	if (r)
 		goto err;
 
@@ -3327,7 +3322,7 @@ static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int channel,
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	int r;
 
-	r = dsi_vc_generic_send_read_request(dssdev, channel, reqdata, reqlen);
+	r = dsi_vc_generic_send_read_request(dsidev, channel, reqdata, reqlen);
 	if (r)
 		return r;
 
@@ -3609,14 +3604,12 @@ static void dsi_set_hs_tx_timeout(struct platform_device *dsidev,
 			(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
-static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
+static void dsi_config_vp_num_line_buffers(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int num_line_buffers;
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
-		struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 		int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
 		struct omap_video_timings *timings = &dsi->timings;
@@ -3637,9 +3630,8 @@ static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
 	REG_FLD_MOD(dsidev, DSI_CTRL, num_line_buffers, 13, 12);
 }
 
-static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
+static void dsi_config_vp_sync_events(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	bool vsync_end = dsi->vm_timings.vp_vsync_end;
 	bool hsync_end = dsi->vm_timings.vp_hsync_end;
@@ -3656,9 +3648,8 @@ static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_CTRL, r);
 }
 
-static void dsi_config_blanking_modes(struct omap_dss_device *dssdev)
+static void dsi_config_blanking_modes(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int blanking_mode = dsi->vm_timings.blanking_mode;
 	int hfp_blanking_mode = dsi->vm_timings.hfp_blanking_mode;
@@ -3913,11 +3904,11 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 
 	dsi_write_reg(dsidev, DSI_CTRL, r);
 
-	dsi_config_vp_num_line_buffers(dssdev);
+	dsi_config_vp_num_line_buffers(dsidev);
 
 	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
-		dsi_config_vp_sync_events(dssdev);
-		dsi_config_blanking_modes(dssdev);
+		dsi_config_vp_sync_events(dsidev);
+		dsi_config_blanking_modes(dsidev);
 		dsi_config_cmd_mode_interleaving(dssdev);
 	}
 
@@ -3929,9 +3920,8 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void dsi_proto_timings(struct omap_dss_device *dssdev)
+static void dsi_proto_timings(struct platform_device *dsidev)
 {
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned tlpx, tclk_zero, tclk_prepare, tclk_trail;
 	unsigned tclk_pre, tclk_post;
@@ -4312,8 +4302,7 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 
 static void dsi_framedone_irq_callback(void *data, u32 mask)
 {
-	struct omap_dss_device *dssdev = (struct omap_dss_device *) data;
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct platform_device *dsidev = (struct platform_device *) data;
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
@@ -4397,7 +4386,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
 		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
-			(void *) dssdev, irq);
+			(void *) dsidev, irq);
 		if (r) {
 			DSSERR("can't get FRAMEDONE irq\n");
 			goto err;
@@ -4438,7 +4427,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 err1:
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE)
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
-			(void *) dssdev, irq);
+			(void *) dsidev, irq);
 err:
 	return r;
 }
@@ -4454,7 +4443,7 @@ static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
 		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
-			(void *) dssdev, irq);
+			(void *) dsidev, irq);
 	}
 }
 
@@ -4504,13 +4493,13 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	DSSDBG("PLL OK\n");
 
-	r = dsi_cio_init(dssdev);
+	r = dsi_cio_init(dsidev);
 	if (r)
 		goto err2;
 
 	_dsi_print_reset_status(dsidev);
 
-	dsi_proto_timings(dssdev);
+	dsi_proto_timings(dsidev);
 	dsi_set_lp_clk_divisor(dssdev);
 
 	if (1)
@@ -4530,7 +4519,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	return 0;
 err3:
-	dsi_cio_uninit(dssdev);
+	dsi_cio_uninit(dsidev);
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
@@ -4561,7 +4550,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
 	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
-	dsi_cio_uninit(dssdev);
+	dsi_cio_uninit(dsidev);
 	dsi_pll_uninit(dsidev, disconnect_lanes);
 }
 
-- 
1.7.9.5

