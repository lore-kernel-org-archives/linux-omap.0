From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 2/5] OMAPDSS: DPI: Remove omap_dss_device arguments in dpi_set_dsi_clk/dpi_set_dispc_clk
Date: Thu, 9 Aug 2012 14:37:07 +0530
Message-ID: <1344503230-18550-3-git-send-email-archit@ti.com>
References: <1344503230-18550-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51772 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2HIJIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 05:08:54 -0400
In-Reply-To: <1344503230-18550-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The clock related info for DSS modules is not tied anymore to a panel's
omap_dss_device struct. It's now passed via platform data. The functions
dpi_set_dsi_clk() and dpi_set_dispc_clk() do not need the omap_dss_device
argument to retieve these clocks. They use the api dss_get_platform_clock_config
to get the clocks. Remove the omap_dss_device arguments from these functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5fec180..c20fe23 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -80,9 +80,8 @@ static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 		lcd_src == OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
 }
 
-static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
-		unsigned long pck_req, unsigned long *fck, int *lck_div,
-		int *pck_div)
+static int dpi_set_dsi_clk(unsigned long pck_req, unsigned long *fck,
+		int *lck_div, int *pck_div)
 {
 	const struct omapdss_clock_config *clks;
 	struct dsi_clock_info dsi_cinfo;
@@ -111,9 +110,8 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
-		unsigned long pck_req, unsigned long *fck, int *lck_div,
-		int *pck_div)
+static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
+		int *lck_div, int *pck_div)
 {
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
@@ -145,10 +143,10 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	int r = 0;
 
 	if (dpi_use_dsi_pll(dssdev))
-		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
+		r = dpi_set_dsi_clk(t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	else
-		r = dpi_set_dispc_clk(dssdev, t->pixel_clock * 1000, &fck,
+		r = dpi_set_dispc_clk(t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	if (r)
 		return r;
-- 
1.7.9.5

