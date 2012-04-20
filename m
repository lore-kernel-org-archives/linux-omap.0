From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V3 3/3] OMAPDSS: DISPC: Correct DISPC functional clock usage
Date: Fri, 20 Apr 2012 19:01:13 +0530
Message-ID: <1334928673-27943-1-git-send-email-cmahapatra@ti.com>
References: <1333379598-11544-4-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60975 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756208Ab2DTNb3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 09:31:29 -0400
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
 drivers/video/omap2/dss/dispc.c |   25 +++++++++++++++++++------
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 17ffa71..0417423 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1855,7 +1855,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 			fclk = calc_fclk(channel, in_width, in_height,
 					out_width, out_height);
 			error = (in_width > maxsinglelinewidth || !fclk ||
-				fclk > dispc_fclk_rate());
+				fclk > dispc_core_clk_rate());
 			if (error) {
 				if (decim_x == decim_y) {
 					decim_x = min_factor;
@@ -1893,7 +1893,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 					out_width, out_height);
 			error = (error || in_width > maxsinglelinewidth * 2 ||
 				(in_width > maxsinglelinewidth && *five_taps) ||
-				!fclk || fclk > dispc_fclk_rate());
+				!fclk || fclk > dispc_core_clk_rate());
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
@@ -1950,13 +1950,13 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	}
 
 	DSSDBG("required fclk rate = %lu Hz\n", fclk);
-	DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
+	DSSDBG("current fclk rate = %lu Hz\n", dispc_core_clk_rate());
 
-	if (!fclk || fclk > dispc_fclk_rate()) {
+	if (!fclk || fclk > dispc_core_clk_rate()) {
 		DSSERR("failed to set up scaling, "
 			"required fclk rate = %lu Hz, "
 			"current fclk rate = %lu Hz\n",
-			fclk, dispc_fclk_rate());
+			fclk, dispc_core_clk_rate());
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

