From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAPDSS: DSI: Support command mode interleaving during video mode blanking periods
Date: Tue, 15 May 2012 11:32:18 +0530
Message-ID: <1337061738-32488-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49699 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab2EOGDH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 02:03:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DSI supports interleaving of command mode packets during the HSA, HFP, HBP and
BLLP blanking intervals in a video mode stream. This is useful as a user may
want to read or change the configuration of a panel without stopping the video
stream.

On OMAP DSI, we can queue HS or LP command mode packets in the TX FIFO, and
the DSI HW takes care of interleaving this data during the one of the blanking
intervals. The DSI HW needs to be programmed with the maximum amount of data
that can be interleaved in a particular blanking period. A blanking period
cannot be used to send command mode data for it's complete duration, there is
some amount of time required for the DSI data and clock lanes to transition
to the desired LP or HS state.

Based on the state of the lanes at the beginning and end of the blanking period,
we have different scenarios, with each scenario having a different value of time
required to transition to HS or LP. Refer to the section 'Interleaving Mode' in
OMAP TRM for more info on the scenarios and the equations to calculate the time
required for HS or LP transitions.

We use the scenarios which takes the maximum time for HS or LP transition, this
gives us the minimum amount of time that can be used to interleave command mode
data. The amount of data that can be sent during this minimum time is calculated
for command mode packets both in LP and HS. These are written to the registers
DSI_VM_TIMING4 to DSI_VM_TIMING6.

The calculations don't take into account the time required of transmitting BTA
when doing a DSI read, or verifying if a DSI write went through correctly. Until
these latencies aren't considered, the behaviour of DSI is unpredictable when
a BTA is interleaved during a blanking period. Enhancement of these calculations
is a TODO item.

The calculations are derived from DSI parameter calculation tools written by
Sebastien Fagard <s-fagard@ti.com>

Signed-off-by: Archit Taneja <archit@ti.com>
---
Note:
- Tested on Blaze tablet and OMAP5 SEVM
- Reference tree with testing intelrevaing of commands on blaze tablet:
  git@gitorious.org:~boddob/linux-omap-dss2/archit-dss2-clone.git dsi_interleave

 drivers/video/omap2/dss/dsi.c |  181 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 181 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 95bc996..53228c9 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3763,6 +3763,186 @@ static void dsi_config_blanking_modes(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_CTRL, r);
 }
 
+/*
+ * According to section 'HS Command Mode Interleaving' in OMAP TRM, Scenario 3
+ * results in maximum transition time for data and clock lanes to enter and
+ * exit HS mode. Hence, this is the scenario where the least amount of command
+ * mode data can be interleaved. We program the minimum amount of TXBYTECLKHS
+ * clock cycles that can be used to interleave command mode data in HS so that
+ * all scenarios are satisfied.
+ */
+static int dsi_compute_interleave_hs(int blank, bool ddr_alwon, int enter_hs,
+		int exit_hs, int exiths_clk, int ddr_pre, int ddr_post)
+{
+	int transition;
+
+	/*
+	 * If DDR_CLK_ALWAYS_ON is set, we need to consider HS mode transition
+	 * time of data lanes only, if it isn't set, we need to consider HS
+	 * transition time of both data and clock lanes. HS transition time
+	 * of Scenario 3 is considered.
+	 */
+	if (ddr_alwon) {
+		transition = enter_hs + exit_hs + max(enter_hs, 2) + 1;
+	} else {
+		int trans1, trans2;
+		trans1 = ddr_pre + enter_hs + exit_hs + max(enter_hs, 2) + 1;
+		trans2 = ddr_pre + enter_hs + exiths_clk + ddr_post + ddr_pre +
+				enter_hs + 1;
+		transition = max(trans1, trans2);
+	}
+
+	return blank > transition ? blank - transition : 0;
+}
+
+/*
+ * According to section 'LP Command Mode Interleaving' in OMAP TRM, Scenario 1
+ * results in maximum transition time for data lanes to enter and exit LP mode.
+ * Hence, this is the scenario where the least amount of command mode data can
+ * be interleaved. We program the minimum amount of bytes that can be
+ * interleaved in LP so that all scenarios are satisfied.
+ */
+static int dsi_compute_interleave_lp(int blank, int enter_hs, int exit_hs,
+		int lp_clk_div, int tdsi_fclk)
+{
+	int trans_lp;	/* time required for a LP transition, in TXBYTECLKHS */
+	int tlp_avail;	/* time left for interleaving commands, in CLKIN4DDR */
+	int ttxclkesc;	/* period of LP transmit escape clock, in CLKIN4DDR */
+	int thsbyte_clk = 16;	/* Period of TXBYTECLKHS clock, in CLKIN4DDR */
+	int lp_inter;	/* cmd mode data that can be interleaved, in bytes */
+
+	/* maximum LP transition time according to Scenario 1 */
+	trans_lp = exit_hs + max(enter_hs, 2) + 1;
+
+	/* CLKIN4DDR = 16 * TXBYTECLKHS */
+	tlp_avail = thsbyte_clk * (blank - trans_lp);
+
+	ttxclkesc = tdsi_fclk / lp_clk_div;
+
+	lp_inter = ((tlp_avail - 8 * thsbyte_clk - 5 * tdsi_fclk) / ttxclkesc -
+			26) / 16;
+
+	return max(lp_inter, 0);
+}
+
+static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int blanking_mode;
+	int hfp_blanking_mode, hbp_blanking_mode, hsa_blanking_mode;
+	int hsa, hfp, hbp, width_bytes, bllp, lp_clk_div;
+	int ddr_clk_pre, ddr_clk_post, enter_hs_mode_lat, exit_hs_mode_lat;
+	int tclk_trail, ths_exit, exiths_clk;
+	bool ddr_alwon;
+	struct omap_video_timings *timings = &dssdev->panel.timings;
+	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
+	int ndl = dsi->num_lanes_used - 1;
+	int dsi_fclk_hsdiv = dssdev->clocks.dsi.regm_dsi + 1;
+	int hsa_interleave_hs = 0, hsa_interleave_lp = 0;
+	int hfp_interleave_hs = 0, hfp_interleave_lp = 0;
+	int hbp_interleave_hs = 0, hbp_interleave_lp = 0;
+	int bl_interleave_hs = 0, bl_interleave_lp = 0;
+	u32 r;
+
+	r = dsi_read_reg(dsidev, DSI_CTRL);
+	blanking_mode = FLD_GET(r, 20, 20);
+	hfp_blanking_mode = FLD_GET(r, 21, 21);
+	hbp_blanking_mode = FLD_GET(r, 22, 22);
+	hsa_blanking_mode = FLD_GET(r, 23, 23);
+
+	r = dsi_read_reg(dsidev, DSI_VM_TIMING1);
+	hbp = FLD_GET(r, 11, 0);
+	hfp = FLD_GET(r, 23, 12);
+	hsa = FLD_GET(r, 31, 24);
+
+	r = dsi_read_reg(dsidev, DSI_CLK_TIMING);
+	ddr_clk_post = FLD_GET(r, 7, 0);
+	ddr_clk_pre = FLD_GET(r, 15, 8);
+
+	r = dsi_read_reg(dsidev, DSI_VM_TIMING7);
+	exit_hs_mode_lat = FLD_GET(r, 15, 0);
+	enter_hs_mode_lat = FLD_GET(r, 31, 16);
+
+	r = dsi_read_reg(dsidev, DSI_CLK_CTRL);
+	lp_clk_div = FLD_GET(r, 12, 0);
+	ddr_alwon = FLD_GET(r, 13, 13);
+
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
+	ths_exit = FLD_GET(r, 7, 0);
+
+	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG1);
+	tclk_trail = FLD_GET(r, 15, 8);
+
+	exiths_clk = ths_exit + tclk_trail;
+
+	width_bytes = DIV_ROUND_UP(timings->x_res * bpp, 8);
+	bllp = hbp + hfp + hsa + DIV_ROUND_UP(width_bytes + 6, ndl);
+
+	if (!hsa_blanking_mode) {
+		hsa_interleave_hs = dsi_compute_interleave_hs(hsa, ddr_alwon,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					exiths_clk, ddr_clk_pre, ddr_clk_post);
+		hsa_interleave_lp = dsi_compute_interleave_lp(hsa,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					lp_clk_div, dsi_fclk_hsdiv);
+	}
+
+	if (!hfp_blanking_mode) {
+		hfp_interleave_hs = dsi_compute_interleave_hs(hfp, ddr_alwon,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					exiths_clk, ddr_clk_pre, ddr_clk_post);
+		hfp_interleave_lp = dsi_compute_interleave_lp(hfp,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					lp_clk_div, dsi_fclk_hsdiv);
+	}
+
+	if (!hbp_blanking_mode) {
+		hbp_interleave_hs = dsi_compute_interleave_hs(hbp, ddr_alwon,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					exiths_clk, ddr_clk_pre, ddr_clk_post);
+
+		hbp_interleave_lp = dsi_compute_interleave_lp(hbp,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					lp_clk_div, dsi_fclk_hsdiv);
+	}
+
+	if (!blanking_mode) {
+		bl_interleave_hs = dsi_compute_interleave_hs(bllp, ddr_alwon,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					exiths_clk, ddr_clk_pre, ddr_clk_post);
+
+		bl_interleave_lp = dsi_compute_interleave_lp(bllp,
+					enter_hs_mode_lat, exit_hs_mode_lat,
+					lp_clk_div, dsi_fclk_hsdiv);
+	}
+
+	DSSDBG("DSI HS interleaving(TXBYTECLKHS) HSA %d, HFP %d, HBP %d, BLLP %d\n",
+		hsa_interleave_hs, hfp_interleave_hs, hbp_interleave_hs,
+		bl_interleave_hs);
+
+	DSSDBG("DSI LP interleaving(bytes) HSA %d, HFP %d, HBP %d, BLLP %d\n",
+		hsa_interleave_lp, hfp_interleave_lp, hbp_interleave_lp,
+		bl_interleave_lp);
+
+	r = dsi_read_reg(dsidev, DSI_VM_TIMING4);
+	r = FLD_MOD(r, hsa_interleave_hs, 23, 16);
+	r = FLD_MOD(r, hfp_interleave_hs, 15, 8);
+	r = FLD_MOD(r, hbp_interleave_hs, 7, 0);
+	dsi_write_reg(dsidev, DSI_VM_TIMING4, r);
+
+	r = dsi_read_reg(dsidev, DSI_VM_TIMING5);
+	r = FLD_MOD(r, hsa_interleave_lp, 23, 16);
+	r = FLD_MOD(r, hfp_interleave_lp, 15, 8);
+	r = FLD_MOD(r, hbp_interleave_lp, 7, 0);
+	dsi_write_reg(dsidev, DSI_VM_TIMING5, r);
+
+	r = dsi_read_reg(dsidev, DSI_VM_TIMING6);
+	r = FLD_MOD(r, bl_interleave_hs, 31, 15);
+	r = FLD_MOD(r, bl_interleave_lp, 16, 0);
+	dsi_write_reg(dsidev, DSI_VM_TIMING6, r);
+}
+
 static int dsi_proto_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -3821,6 +4001,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		dsi_config_vp_sync_events(dssdev);
 		dsi_config_blanking_modes(dssdev);
+		dsi_config_cmd_mode_interleaving(dssdev);
 	}
 
 	dsi_vc_initial_config(dsidev, 0);
-- 
1.7.5.4

