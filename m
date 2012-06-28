From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/12] MAPDSS: DISPC: Change return type of dispc_mgr_set_clock_div()
Date: Thu, 28 Jun 2012 20:00:30 +0530
Message-ID: <1340893842-10626-2-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41693 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2F1OcE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:04 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dipsc_mgr_set_clock div has an int return type to report errors or success.
The function doesn't really check for errors and always returns 0. Change
the return type to void.

Checking for the correct DISPC clock divider ranges will be done when a DSS2
user does a manager apply. This support will be added later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    4 +---
 drivers/video/omap2/dss/dpi.c   |   10 ++--------
 drivers/video/omap2/dss/dsi.c   |    6 +-----
 drivers/video/omap2/dss/dss.h   |    2 +-
 drivers/video/omap2/dss/sdi.c   |    5 +----
 5 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 864adcc..b047fe6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3184,15 +3184,13 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 	return 0;
 }
 
-int dispc_mgr_set_clock_div(enum omap_channel channel,
+void dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo)
 {
 	DSSDBG("lck = %lu (%u)\n", cinfo->lck, cinfo->lck_div);
 	DSSDBG("pck = %lu (%u)\n", cinfo->pck, cinfo->pck_div);
 
 	dispc_mgr_set_lcd_divisor(channel, cinfo->lck_div, cinfo->pck_div);
-
-	return 0;
 }
 
 int dispc_mgr_get_clock_div(enum omap_channel channel,
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 046a6fb..af01430 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -100,11 +100,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(clks->dispc.fclk_src);
 
-	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-	if (r) {
-		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-		return r;
-	}
+	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 
 	*fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	*lck_div = dispc_cinfo.lck_div;
@@ -129,9 +125,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-	if (r)
-		return r;
+	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 
 	*fck = dss_cinfo.fck;
 	*lck_div = dispc_cinfo.lck_div;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9f08787..94ff3aa 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4456,11 +4456,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev,
 		return r;
 	}
 
-	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-	if (r) {
-		DSSERR("Failed to set dispc clocks\n");
-		return r;
-	}
+	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 20151d5..f8289e9 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -416,7 +416,7 @@ void dispc_mgr_set_timings(enum omap_channel channel,
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 unsigned long dispc_core_clk_rate(void);
-int dispc_mgr_set_clock_div(enum omap_channel channel,
+void dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index b44ab72..0b2659f 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -106,9 +106,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_set_dss_clock_div;
 
-	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
-	if (r)
-		goto err_set_dispc_clock_div;
+	dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 
 	dss_sdi_init(dssdev->phy.sdi.datapairs);
 	r = dss_sdi_enable();
@@ -125,7 +123,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 err_mgr_enable:
 	dss_sdi_disable();
 err_sdi_enable:
-err_set_dispc_clock_div:
 err_set_dss_clock_div:
 err_calc_clock_div:
 	dispc_runtime_put();
-- 
1.7.9.5

