From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Date: Mon, 23 Apr 2012 12:16:50 +0530
Message-ID: <1335163610-19737-1-git-send-email-cmahapatra@ti.com>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38065 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab2DWGrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 02:47:06 -0400
In-Reply-To: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

DISPC_FCLK is incorrectly used as functional clock of DISPC in scaling
calculations. So, DISPC_CORE_CLK replaces as functional clock of DISPC.
DISPC_CORE_CLK is derived from DISPC_FCLK divided by an independent DISPC
divisor LCD.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   67 +++++++++++++++++++++++---------------
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 17ffa71..f1be23f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1721,11 +1721,11 @@ static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
 	return 0;
 }
 
-static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
-		u16 height, u16 out_width, u16 out_height,
+static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
+		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
 {
-	u32 fclk = 0;
+	u32 core_clk = 0;
 	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
 
 	if (height <= out_height && width <= out_width)
@@ -1737,7 +1737,7 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 
 		tmp = pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
-		fclk = tmp;
+		core_clk = tmp;
 
 		if (height > 2 * out_height) {
 			if (ppl == out_width)
@@ -1745,23 +1745,23 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 
 			tmp = pclk * (height - 2 * out_height) * out_width;
 			do_div(tmp, 2 * out_height * (ppl - out_width));
-			fclk = max(fclk, (u32) tmp);
+			core_clk = max_t(u32, core_clk, tmp);
 		}
 	}
 
 	if (width > out_width) {
 		tmp = pclk * width;
 		do_div(tmp, out_width);
-		fclk = max(fclk, (u32) tmp);
+		core_clk = max_t(u32, core_clk, tmp);
 
 		if (color_mode == OMAP_DSS_COLOR_RGB24U)
-			fclk <<= 1;
+			core_clk <<= 1;
 	}
 
-	return fclk;
+	return core_clk;
 }
 
-static unsigned long calc_fclk(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
@@ -1812,7 +1812,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	const int max_decim_limit = 16;
-	unsigned long fclk = 0;
+	unsigned long core_clk = 0;
 	int decim_x, decim_y, error, min_factor;
 	u16 in_width, in_height, in_width_max = 0;
 
@@ -1852,10 +1852,10 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		do {
 			in_height = DIV_ROUND_UP(height, decim_y);
 			in_width = DIV_ROUND_UP(width, decim_x);
-			fclk = calc_fclk(channel, in_width, in_height,
+			core_clk = calc_core_clk(channel, in_width, in_height,
 					out_width, out_height);
-			error = (in_width > maxsinglelinewidth || !fclk ||
-				fclk > dispc_fclk_rate());
+			error = (in_width > maxsinglelinewidth || !core_clk ||
+				core_clk > dispc_core_clk_rate());
 			if (error) {
 				if (decim_x == decim_y) {
 					decim_x = min_factor;
@@ -1878,8 +1878,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		do {
 			in_height = DIV_ROUND_UP(height, decim_y);
 			in_width = DIV_ROUND_UP(width, decim_x);
-			fclk = calc_fclk_five_taps(channel, in_width, in_height,
-				out_width, out_height, color_mode);
+			core_clk = calc_core_clk_five_taps(channel, in_width,
+				in_height, out_width, out_height, color_mode);
 
 			error = check_horiz_timing_omap3(channel, pos_x,
 				in_width, in_height, out_width, out_height);
@@ -1889,11 +1889,11 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 					in_height < out_height * 2)
 					*five_taps = false;
 			if (!*five_taps)
-				fclk = calc_fclk(channel, in_width, in_height,
-					out_width, out_height);
+				core_clk = calc_core_clk(channel, in_width,
+					in_height, out_width, out_height);
 			error = (error || in_width > maxsinglelinewidth * 2 ||
 				(in_width > maxsinglelinewidth && *five_taps) ||
-				!fclk || fclk > dispc_fclk_rate());
+				!core_clk || core_clk > dispc_core_clk_rate());
 			if (error) {
 				if (decim_x == decim_y) {
 					decim_x = min_factor;
@@ -1926,7 +1926,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	} else {
 		int decim_x_min = decim_x;
 		in_height = DIV_ROUND_UP(height, decim_y);
-		in_width_max = dispc_fclk_rate() /
+		in_width_max = dispc_core_clk_rate() /
 				DIV_ROUND_UP(dispc_mgr_pclk_rate(channel),
 						out_width);
 		decim_x = DIV_ROUND_UP(width, in_width_max);
@@ -1945,18 +1945,18 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 			return -EINVAL;
 		}
 
-		fclk = calc_fclk(channel, in_width, in_height, out_width,
-				out_height);
+		core_clk = calc_core_clk(channel, in_width, in_height,
+				out_width, out_height);
 	}
 
-	DSSDBG("required fclk rate = %lu Hz\n", fclk);
-	DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+	DSSDBG("required core clk rate = %lu Hz\n", core_clk);
+	DSSDBG("current core clk rate = %lu Hz\n", dispc_core_clk_rate());
 
-	if (!fclk || fclk > dispc_fclk_rate()) {
+	if (!core_clk || core_clk > dispc_core_clk_rate()) {
 		DSSERR("failed to set up scaling, "
-			"required fclk rate = %lu Hz, "
-			"current fclk rate = %lu Hz\n",
-			fclk, dispc_fclk_rate());
+			"required core clk rate = %lu Hz, "
+			"current core clk rate = %lu Hz\n",
+			core_clk, dispc_core_clk_rate());
 		return -EINVAL;
 	}
 
@@ -2646,6 +2646,19 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 	}
 }
 
+unsigned long dispc_core_clk_rate(void)
+{
+	int lcd;
+	unsigned long fclk = dispc_fclk_rate();
+
+	if (dss_has_feature(FEAT_CORE_CLK_DIV))
+		lcd = REG_GET(DISPC_DIVISOR, 23, 16);
+	else
+		lcd = REG_GET(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD), 23, 16);
+
+	return fclk / lcd;
+}
+
 void dispc_dump_clocks(struct seq_file *s)
 {
 	int lcd, pcd;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d4b3dff..1bde34c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -451,6 +451,7 @@ void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
+unsigned long dispc_core_clk_rate(void);
 int dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
-- 
1.7.1

