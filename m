From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Tue, 30 Aug 2011 16:21:35 +0530
Message-ID: <1314701495-11247-11-git-send-email-archit@ti.com>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1H3Kxo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Aug 2011 06:53:44 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7UArhXV009722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:43 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArhM8009453
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:43 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7UArh1k025555
	for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 05:53:43 -0500 (CDT)
In-Reply-To: <1314701495-11247-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add initial support for DSI video mode panels:
- Add a new structure omap_dss_dsi_videomode_data in the member "panel" in
  omap_dss_device struct. This allows panel driver to configure dsi video_mode
  specific parameters.
- Configure basic DSI video mode timing parameters: HBP, HFP, HSA, VBP, VFP, VSA,
  TL and VACT.
- Configure DSI protocol engine registers for video_mode support.
- Introduce functions dsi_video_mode_enable() and dsi_video_mode_disable() which
  enable/disable video mode for a given virtual channel and a given pixel format
  type.

Things left for later
- Add functions to check for errors in video mode timings provided by panel.
- Configure timing registers required  for command mode interleaving.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  256 ++++++++++++++++++++++++++++++++++++-----
 include/video/omapdss.h       |   32 +++++
 2 files changed, 259 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 582ae7b..e3d5c38 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -132,7 +132,7 @@ struct dsi_reg { u16 idx; };
 #define DSI_IRQ_TA_TIMEOUT	(1 << 20)
 #define DSI_IRQ_ERROR_MASK \
 	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
-	DSI_IRQ_TA_TIMEOUT)
+	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
 #define DSI_IRQ_CHANNEL_MASK	0xf
 
 /* Virtual channel interrupts */
@@ -2472,6 +2472,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	dsi_cio_timings(dsidev);
 
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		/* DDR_CLK_ALWAYS_ON */
+		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
+			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
+	}
+
 	dsi->ulps_enabled = false;
 
 	DSSDBG("CIO init done\n");
@@ -2496,6 +2502,9 @@ static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
+	/* DDR_CLK_ALWAYS_ON */
+	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 13, 13);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
 	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
@@ -3683,6 +3692,75 @@ static void dsi_set_hs_tx_timeout(struct platform_device *dsidev,
 			ticks, x4 ? " x4" : "", x16 ? " x16" : "",
 			(total_ticks * 1000) / (fck / 1000 / 1000));
 }
+
+static void dsi_config_vp_num_line_buffers(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int num_line_buffers;
+
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+		unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
+		struct omap_video_timings *timings = &dssdev->panel.timings;
+		/*
+		 * Don't use line buffers if width is greater than the video
+		 * port's line buffer size
+		 */
+		if (line_buf_size <= timings->x_res * bpp / 8)
+			num_line_buffers = 0;
+		else
+			num_line_buffers = 2;
+	} else {
+		/* Use maximum number of line buffers in command mode */
+		num_line_buffers = 2;
+	}
+
+	/* LINE_BUFFER */
+	REG_FLD_MOD(dsidev, DSI_CTRL, num_line_buffers, 13, 12);
+}
+
+static void dsi_config_vp_sync_events(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int de_pol = dssdev->panel.dsi_vm_data.vp_de_pol;
+	int hsync_pol = dssdev->panel.dsi_vm_data.vp_hsync_pol;
+	int vsync_pol = dssdev->panel.dsi_vm_data.vp_vsync_pol;
+	bool vsync_end = dssdev->panel.dsi_vm_data.vp_vsync_end;
+	bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
+	u32 r;
+
+	r = dsi_read_reg(dsidev, DSI_CTRL);
+	r = FLD_MOD(r, de_pol, 9, 9);		/* VP_DE_POL */
+	r = FLD_MOD(r, hsync_pol, 10, 10);	/* VP_HSYNC_POL */
+	r = FLD_MOD(r, vsync_pol, 11, 11);	/* VP_VSYNC_POL */
+	r = FLD_MOD(r, 1, 15, 15);		/* VP_VSYNC_START */
+	r = FLD_MOD(r, vsync_end, 16, 16);	/* VP_VSYNC_END */
+	r = FLD_MOD(r, 1, 17, 17);		/* VP_HSYNC_START */
+	r = FLD_MOD(r, hsync_end, 18, 18);	/* VP_HSYNC_END */
+	dsi_write_reg(dsidev, DSI_CTRL, r);
+}
+
+static void dsi_config_blanking_modes(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int blanking_mode = dssdev->panel.dsi_vm_data.blanking_mode;
+	int hfp_blanking_mode = dssdev->panel.dsi_vm_data.hfp_blanking_mode;
+	int hbp_blanking_mode = dssdev->panel.dsi_vm_data.hbp_blanking_mode;
+	int hsa_blanking_mode = dssdev->panel.dsi_vm_data.hsa_blanking_mode;
+	u32 r;
+
+	/*
+	 * 0 = TX FIFO packets sent or LPS in corresponding blanking periods
+	 * 1 = Long blanking packets are sent in corresponding blanking periods
+	 */
+	r = dsi_read_reg(dsidev, DSI_CTRL);
+	r = FLD_MOD(r, blanking_mode, 20, 20);		/* BLANKING_MODE */
+	r = FLD_MOD(r, hfp_blanking_mode, 21, 21);	/* HFP_BLANKING */
+	r = FLD_MOD(r, hbp_blanking_mode, 22, 22);	/* HBP_BLANKING */
+	r = FLD_MOD(r, hsa_blanking_mode, 23, 23);	/* HSA_BLANKING */
+	dsi_write_reg(dsidev, DSI_CTRL, r);
+}
+
 static int dsi_proto_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -3726,7 +3804,6 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	r = FLD_MOD(r, 1, 4, 4);	/* VP_CLK_RATIO, always 1, see errata*/
 	r = FLD_MOD(r, buswidth, 7, 6); /* VP_DATA_BUS_WIDTH */
 	r = FLD_MOD(r, 0, 8, 8);	/* VP_CLK_POL */
-	r = FLD_MOD(r, 2, 13, 12);	/* LINE_BUFFER, 2 lines */
 	r = FLD_MOD(r, 1, 14, 14);	/* TRIGGER_RESET_MODE */
 	r = FLD_MOD(r, 1, 19, 19);	/* EOT_ENABLE */
 	if (!dss_has_feature(FEAT_DSI_DCS_CMD_CONFIG_VC)) {
@@ -3737,6 +3814,13 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 
 	dsi_write_reg(dsidev, DSI_CTRL, r);
 
+	dsi_config_vp_num_line_buffers(dssdev);
+
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		dsi_config_vp_sync_events(dssdev);
+		dsi_config_blanking_modes(dssdev);
+	}
+
 	dsi_vc_initial_config(dsidev, 0);
 	dsi_vc_initial_config(dsidev, 1);
 	dsi_vc_initial_config(dsidev, 2);
@@ -3755,6 +3839,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	unsigned ddr_clk_pre, ddr_clk_post;
 	unsigned enter_hs_mode_lat, exit_hs_mode_lat;
 	unsigned ths_eot;
+	int ndl = dsi_get_num_data_lanes_dssdev(dssdev);
 	u32 r;
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
@@ -3777,7 +3862,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	/* min 60ns + 52*UI */
 	tclk_post = ns2ddr(dsidev, 60) + 26;
 
-	ths_eot = DIV_ROUND_UP(4, dsi_get_num_data_lanes_dssdev(dssdev));
+	ths_eot = DIV_ROUND_UP(4, ndl);
 
 	ddr_clk_pre = DIV_ROUND_UP(tclk_pre + tlpx + tclk_zero + tclk_prepare,
 			4);
@@ -3807,8 +3892,115 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 
 	DSSDBG("enter_hs_mode_lat %u, exit_hs_mode_lat %u\n",
 			enter_hs_mode_lat, exit_hs_mode_lat);
+
+	 if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
+		/* TODO: Implement a video mode check_timings function */
+		int hsa = dssdev->panel.dsi_vm_data.hsa;
+		int hfp = dssdev->panel.dsi_vm_data.hfp;
+		int hbp = dssdev->panel.dsi_vm_data.hbp;
+		int vsa = dssdev->panel.dsi_vm_data.vsa;
+		int vfp = dssdev->panel.dsi_vm_data.vfp;
+		int vbp = dssdev->panel.dsi_vm_data.vbp;
+		int window_sync = dssdev->panel.dsi_vm_data.window_sync;
+		bool hsync_end = dssdev->panel.dsi_vm_data.vp_hsync_end;
+		struct omap_video_timings *timings = &dssdev->panel.timings;
+		int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+		int tl, t_he, width_bytes;
+
+		t_he = hsync_end ?
+			((hsa == 0 && ndl == 3) ? 1 : DIV_ROUND_UP(4, ndl)) : 0;
+
+		width_bytes = DIV_ROUND_UP(timings->x_res * bpp, 8);
+
+		/* TL = t_HS + HSA + t_HE + HFP + ceil((WC + 6) / NDL) + HBP */
+		tl = DIV_ROUND_UP(4, ndl) + (hsync_end ? hsa : 0) + t_he + hfp +
+			DIV_ROUND_UP(width_bytes + 6, ndl) + hbp;
+
+		DSSDBG("HBP: %d, HFP: %d, HSA: %d, TL: %d TXBYTECLKHS\n", hbp,
+			hfp, hsync_end ? hsa : 0, tl);
+		DSSDBG("VBP: %d, VFP: %d, VSA: %d, VACT: %d lines\n", vbp, vfp,
+			vsa, timings->y_res);
+
+		r = dsi_read_reg(dsidev, DSI_VM_TIMING1);
+		r = FLD_MOD(r, hbp, 11, 0);	/* HBP */
+		r = FLD_MOD(r, hfp, 23, 12);	/* HFP */
+		r = FLD_MOD(r, hsync_end ? hsa : 0, 31, 24);	/* HSA */
+		dsi_write_reg(dsidev, DSI_VM_TIMING1, r);
+
+		r = dsi_read_reg(dsidev, DSI_VM_TIMING2);
+		r = FLD_MOD(r, vbp, 7, 0);	/* VBP */
+		r = FLD_MOD(r, vfp, 15, 8);	/* VFP */
+		r = FLD_MOD(r, vsa, 23, 16);	/* VSA */
+		r = FLD_MOD(r, window_sync, 27, 24);	/* WINDOW_SYNC */
+		dsi_write_reg(dsidev, DSI_VM_TIMING2, r);
+
+		r = dsi_read_reg(dsidev, DSI_VM_TIMING3);
+		r = FLD_MOD(r, timings->y_res, 14, 0);	/* VACT */
+		r = FLD_MOD(r, tl, 31, 16);		/* TL */
+		dsi_write_reg(dsidev, DSI_VM_TIMING3, r);
+	}
 }
 
+int dsi_video_mode_enable(struct omap_dss_device *dssdev, int channel)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	u8 data_type;
+	u16 word_count;
+
+	switch (dssdev->panel.dsi_pix_fmt) {
+	case OMAP_DSS_DSI_FMT_RGB888:
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
+		break;
+	case OMAP_DSS_DSI_FMT_RGB666:
+		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
+		break;
+	case OMAP_DSS_DSI_FMT_RGB666_PACKED:
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
+		break;
+	case OMAP_DSS_DSI_FMT_RGB565:
+		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
+		break;
+	default:
+		BUG();
+	};
+
+	dsi_if_enable(dsidev, false);
+	dsi_vc_enable(dsidev, channel, false);
+
+	/* MODE, 1 = video mode */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 4, 4);
+
+	word_count = DIV_ROUND_UP(dssdev->panel.timings.x_res * bpp, 8);
+
+	dsi_vc_write_long_header(dsidev, channel, data_type, word_count, 0);
+
+	dsi_vc_enable(dsidev, channel, true);
+	dsi_if_enable(dsidev, true);
+
+	dssdev->manager->enable(dssdev->manager);
+
+	return 0;
+}
+EXPORT_SYMBOL(dsi_video_mode_enable);
+
+void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+
+	dsi_if_enable(dsidev, false);
+	dsi_vc_enable(dsidev, channel, false);
+
+	/* MODE, 0 = command mode */
+	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 4, 4);
+
+	dsi_vc_enable(dsidev, channel, true);
+	dsi_if_enable(dsidev, true);
+
+	dssdev->manager->disable(dssdev->manager);
+}
+EXPORT_SYMBOL(dsi_video_mode_disable);
+
 static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h)
 {
@@ -4020,28 +4212,9 @@ EXPORT_SYMBOL(omap_dsi_update);
 static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 {
 	int r;
-	u32 irq;
-
-	irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
-		DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
-
-	r = omap_dispc_register_isr(dsi_framedone_irq_callback, (void *) dssdev,
-			irq);
-	if (r) {
-		DSSERR("can't get FRAMEDONE irq\n");
-		return r;
-	}
-
-	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
-			OMAP_DSS_LCD_DISPLAY_TFT);
-
-	dispc_mgr_enable_stallmode(dssdev->manager->id, true);
-	dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
-			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
 
-	{
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+		u32 irq;
 		struct omap_video_timings timings = {
 			.hsw		= 1,
 			.hfp		= 1,
@@ -4051,21 +4224,46 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			.vbp		= 0,
 		};
 
+		irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
+			DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
+
+		r = omap_dispc_register_isr(dsi_framedone_irq_callback,
+			(void *) dssdev, irq);
+		if (r) {
+			DSSERR("can't get FRAMEDONE irq\n");
+			return r;
+		}
+
+		dispc_mgr_enable_stallmode(dssdev->manager->id, true);
+		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
+
 		dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
+	} else {
+		dispc_mgr_enable_stallmode(dssdev->manager->id, false);
+		dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 0);
+
+		dispc_mgr_set_lcd_timings(dssdev->manager->id,
+			&dssdev->panel.timings);
 	}
 
+		dispc_mgr_set_lcd_display_type(dssdev->manager->id,
+			OMAP_DSS_LCD_DISPLAY_TFT);
+		dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+			dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt));
 	return 0;
 }
 
 static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 {
-	u32 irq;
+	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+		u32 irq;
 
-	irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
-		DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
+		irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
+			DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
 
-	omap_dispc_unregister_isr(dsi_framedone_irq_callback, (void *) dssdev,
-			irq);
+		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
+			(void *) dssdev, irq);
+	}
 }
 
 static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1e9a35c..c462ed0 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -228,6 +228,35 @@ void rfbi_bus_lock(void);
 void rfbi_bus_unlock(void);
 
 /* DSI */
+
+struct omap_dss_dsi_videomode_data {
+	/* DSI video mode blanking data */
+	/* Unit: byte clock cycles */
+	u16 hsa;
+	u16 hfp;
+	u16 hbp;
+	/* Unit: line clocks */
+	u16 vsa;
+	u16 vfp;
+	u16 vbp;
+
+	/* DSI blanking modes */
+	int blanking_mode;
+	int hsa_blanking_mode;
+	int hbp_blanking_mode;
+	int hfp_blanking_mode;
+
+	/* Video port sync events */
+	int vp_de_pol;
+	int vp_hsync_pol;
+	int vp_vsync_pol;
+	bool vp_vsync_end;
+	bool vp_hsync_end;
+
+	bool ddr_clk_always_on;
+	int window_sync;
+};
+
 void dsi_bus_lock(struct omap_dss_device *dssdev);
 void dsi_bus_unlock(struct omap_dss_device *dssdev);
 int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
@@ -258,6 +287,8 @@ int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
 		u16 len);
 int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
 int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
+int dsi_video_mode_enable(struct omap_dss_device *dssdev, int channel);
+void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel);
 
 /* Board specific data */
 struct omap_dss_board_info {
@@ -498,6 +529,7 @@ struct omap_dss_device {
 
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
+		struct omap_dss_dsi_videomode_data dsi_vm_data;
 	} panel;
 
 	struct {
-- 
1.7.1

