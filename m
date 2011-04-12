From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: HDMI: Use dss_device clock configuration for HDMI PLL parameters
Date: Tue, 12 Apr 2011 13:52:25 +0530
Message-ID: <1302596546-14888-4-git-send-email-archit@ti.com>
References: <1302596546-14888-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab1DLIRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2011 04:17:46 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3C8Hkq5003216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 03:17:46 -0500
In-Reply-To: <1302596546-14888-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Move some of the configurable HDMI PLL parameters to dssdev.clock struct.
Cleanup the function hdmi_compute_pll() by using the parameters defined in the
board file and do some cosmetic modifications.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c       |    9 +++++++++
 arch/arm/plat-omap/include/plat/display.h |    5 +++++
 drivers/video/omap2/dss/hdmi.c            |   27 +++++++++++++--------------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5639af8..cadea7e 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -795,6 +795,15 @@ static struct omap_dss_device sdp4430_hdmi_device = {
 	.name = "hdmi",
 	.driver_name = "hdmi_panel",
 	.type = OMAP_DISPLAY_TYPE_HDMI,
+	.clocks	= {
+		.dispc	= {
+			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
+		},
+		.hdmi	= {
+			.regn	= 15,
+			.regm2	= 1,
+		},
+	},
 	.platform_enable = sdp4430_panel_enable_hdmi,
 	.platform_disable = sdp4430_panel_disable_hdmi,
 	.channel = OMAP_DSS_CHANNEL_DIGIT,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 91495b0..7613637 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -440,6 +440,11 @@ struct omap_dss_device {
 			u16 lp_clk_div;
 			enum omap_dss_clk_source dsi_fclk_src;
 		} dsi;
+
+		struct {
+			u16 regn;
+			u16 regm2;
+		} hdmi;
 	} clocks;
 
 	struct {
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index aad7354..4b8a93b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1052,25 +1052,26 @@ static void update_hdmi_timings(struct hdmi_config *cfg,
 	cfg->timings.hsync_pol = cea_vesa_timings[code].hsync_pol;
 }
 
-static void hdmi_compute_pll(unsigned long clkin, int phy,
-	int n, struct hdmi_pll_info *pi)
+static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
+		struct hdmi_pll_info *pi)
 {
-	unsigned long refclk;
+	unsigned long clkin, refclk;
 	u32 mf;
 
+	clkin = dss_clk_get_rate(DSS_CLK_SYSCK) / 10000;
 	/*
 	 * Input clock is predivided by N + 1
 	 * out put of which is reference clk
 	 */
-	refclk = clkin / (n + 1);
-	pi->regn = n;
+	pi->regn = dssdev->clocks.hdmi.regn;
+	refclk = clkin / (pi->regn + 1);
 
 	/*
 	 * multiplier is pixel_clk/ref_clk
 	 * Multiplying by 100 to avoid fractional part removal
 	 */
-	pi->regm = (phy * 100/(refclk))/100;
-	pi->regm2 = 1;
+	pi->regm = (phy * 100 / (refclk)) / 100;
+	pi->regm2 = dssdev->clocks.hdmi.regm2;
 
 	/*
 	 * fractional multiplier is remainder of the difference between
@@ -1078,14 +1079,14 @@ static void hdmi_compute_pll(unsigned long clkin, int phy,
 	 * multiplied by 2^18(262144) divided by the reference clock
 	 */
 	mf = (phy - pi->regm * refclk) * 262144;
-	pi->regmf = mf/(refclk);
+	pi->regmf = mf / (refclk);
 
 	/*
 	 * Dcofreq should be set to 1 if required pixel clock
 	 * is greater than 1000MHz
 	 */
 	pi->dcofreq = phy > 1000 * 100;
-	pi->regsd = ((pi->regm * clkin / 10) / ((n + 1) * 250) + 5) / 10;
+	pi->regsd = ((pi->regm * clkin / 10) / ((pi->regn + 1) * 250) + 5) / 10;
 
 	DSSDBG("M = %d Mf = %d\n", pi->regm, pi->regmf);
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
@@ -1106,7 +1107,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	int r, code = 0;
 	struct hdmi_pll_info pll_data;
 	struct omap_video_timings *p;
-	int clkin, n, phy;
+	unsigned long phy;
 
 	hdmi_enable_clocks(1);
 
@@ -1126,11 +1127,9 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dssdev->panel.timings = cea_vesa_timings[code].timings;
 	update_hdmi_timings(&hdmi.cfg, p, code);
 
-	clkin = 3840; /* 38.4 MHz */
-	n = 15; /* this is a constant for our math */
 	phy = p->pixel_clock;
 
-	hdmi_compute_pll(clkin, phy, n, &pll_data);
+	hdmi_compute_pll(dssdev, phy, &pll_data);
 
 	hdmi_wp_video_start(0);
 
@@ -1160,7 +1159,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	 * dynamically by user. This can be moved to single location , say
 	 * Boardfile.
 	 */
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
-- 
1.7.1

