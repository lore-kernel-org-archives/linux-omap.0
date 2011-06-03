From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/27] OMAP: DSS2: DPI: remove unneeded SYSCK enable/disable
Date: Fri,  3 Jun 2011 13:00:20 +0300
Message-ID: <1307095237-14805-11-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35621 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab1FCKBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:21 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSI PLL requires sys_clk to function, and DPI enables sys_clk when it
wants to use DSI PLL. However, DSI PLL code already handles enabling
sys_clk, so DPI's sys_clk code is extra.

Remove the unneeded sys_clk handling from dpi.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index ff6bd30..bab55cd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -202,15 +202,14 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err2;
 
 	if (dpi_use_dsi_pll(dssdev)) {
-		dss_clk_enable(DSS_CLK_SYSCK);
 		r = dsi_pll_init(dpi.dsidev, 0, 1);
 		if (r)
-			goto err3;
+			goto err2;
 	}
 
 	r = dpi_set_mode(dssdev);
 	if (r)
-		goto err4;
+		goto err3;
 
 	mdelay(2);
 
@@ -218,12 +217,9 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 
-err4:
-	if (dpi_use_dsi_pll(dssdev))
-		dsi_pll_uninit(dpi.dsidev, true);
 err3:
 	if (dpi_use_dsi_pll(dssdev))
-		dss_clk_disable(DSS_CLK_SYSCK);
+		dsi_pll_uninit(dpi.dsidev, true);
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 	if (cpu_is_omap34xx())
@@ -242,7 +238,6 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi.dsidev, true);
-		dss_clk_disable(DSS_CLK_SYSCK);
 	}
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
-- 
1.7.4.1

