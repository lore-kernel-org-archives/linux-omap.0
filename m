From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/4] OMAP2PLUS: DSS2: Add clock sources to dss device clock configuration
Date: Tue, 12 Apr 2011 13:52:24 +0530
Message-ID: <1302596546-14888-3-git-send-email-archit@ti.com>
References: <1302596546-14888-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab1DLIRm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 04:17:42 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3C8Hf0h011651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 03:17:41 -0500
In-Reply-To: <1302596546-14888-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add enum dss_clock_source in dssdev.clocks struct so that the clock sources can
be specified in the board file.
Replace hard coded clock sources in dsi.c, dpi.c and replace them with the new
clock source members in dssdev.clocks. Modify the sdp4430_lcd_device struct in
board-4430sdp.c to specify clock sources for DISPC_FCLK, LCD1_CLK and DSI1_FCLK.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c       |    9 +++++++--
 arch/arm/plat-omap/include/plat/display.h |   10 ++++++++--
 drivers/video/omap2/dss/dpi.c             |    2 +-
 drivers/video/omap2/dss/dsi.c             |   10 +++++-----
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 626b16b..5639af8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -770,8 +770,12 @@ static struct omap_dss_device sdp4430_lcd_device = {
 
 	.clocks = {
 		.dispc = {
-			.lck_div	= 1,	/* Logic Clock = 172.8 MHz */
-			.pck_div	= 5,	/* Pixel Clock = 34.56 MHz */
+			.channel = {
+				.lck_div	= 1,	/* Logic Clock = 172.8 MHz */
+				.pck_div	= 5,	/* Pixel Clock = 34.56 MHz */
+				.lcd_clk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,
+			},
+			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
 		},
 
 		.dsi = {
@@ -781,6 +785,7 @@ static struct omap_dss_device sdp4430_lcd_device = {
 			.regm_dsi	= 5,	/* PLL1_CLK2 = 172.8 MHz */
 
 			.lp_clk_div	= 10,	/* LP Clock = 8.64 MHz */
+			.dsi_fclk_src	= OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,
 		},
 	},
 	.channel		= OMAP_DSS_CHANNEL_LCD,
diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index f28b446..91495b0 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -422,8 +422,13 @@ struct omap_dss_device {
 
 	struct {
 		struct {
-			u16 lck_div;
-			u16 pck_div;
+			struct {
+				u16 lck_div;
+				u16 pck_div;
+				enum omap_dss_clk_source lcd_clk_src;
+			} channel;
+
+			enum omap_dss_clk_source dispc_fclk_src;
 		} dispc;
 
 		struct {
@@ -433,6 +438,7 @@ struct omap_dss_device {
 			u16 regm_dsi;
 
 			u16 lp_clk_div;
+			enum omap_dss_clk_source dsi_fclk_src;
 		} dsi;
 	} clocks;
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 9e8b061..55d9157 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -57,7 +57,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	if (r)
 		return r;
 
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
+	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 
 	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 546792b..6a51c07 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3411,8 +3411,8 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 
 	fck = dsi_get_pll_hsdiv_dispc_rate();
 
-	dispc_cinfo.lck_div = dssdev->clocks.dispc.lck_div;
-	dispc_cinfo.pck_div = dssdev->clocks.dispc.pck_div;
+	dispc_cinfo.lck_div = dssdev->clocks.dispc.channel.lck_div;
+	dispc_cinfo.pck_div = dssdev->clocks.dispc.channel.pck_div;
 
 	r = dispc_calc_clock_rates(fck, &dispc_cinfo);
 	if (r) {
@@ -3447,10 +3447,10 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
-	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI);
+	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+	dss_select_dsi_clk_source(dssdev->clocks.dsi.dsi_fclk_src);
 	dss_select_lcd_clk_source(dssdev->manager->id,
-		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
+			dssdev->clocks.dispc.channel.lcd_clk_src);
 
 	DSSDBG("PLL OK\n");
 
-- 
1.7.1

