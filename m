From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/12] OMAPDSS: DPI: use dpi.dsidev to see whether to use dsi pll
Date: Tue, 30 Oct 2012 18:10:07 +0200
Message-ID: <1351613409-21186-11-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933958Ab2J3QKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 12:10:37 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using dpi_use_dsi_pll() to check if dsi pll is to be used, we
can just check if dpi.dsidev != NULL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 9df62cf..fc1ec7d 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -137,7 +137,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r = 0;
 
-	if (dpi_use_dsi_pll(dssdev))
+	if (dpi.dsidev)
 		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	else
@@ -216,7 +216,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_src_sel;
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi.dsidev) {
 		r = dsi_runtime_get(dpi.dsidev);
 		if (r)
 			goto err_get_dsi;
@@ -244,10 +244,10 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 err_mgr_enable:
 err_set_mode:
-	if (dpi_use_dsi_pll(dssdev))
+	if (dpi.dsidev)
 		dsi_pll_uninit(dpi.dsidev, true);
 err_dsi_pll_init:
-	if (dpi_use_dsi_pll(dssdev))
+	if (dpi.dsidev)
 		dsi_runtime_put(dpi.dsidev);
 err_get_dsi:
 err_src_sel:
@@ -273,7 +273,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(mgr);
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi.dsidev) {
 		dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi.dsidev, true);
 		dsi_runtime_put(dpi.dsidev);
@@ -319,7 +319,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	if (timings->pixel_clock == 0)
 		return -EINVAL;
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi.dsidev) {
 		struct dsi_clock_info dsi_cinfo;
 		r = dsi_pll_calc_clock_div_pck(dpi.dsidev,
 				timings->pixel_clock * 1000,
-- 
1.7.10.4

