From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch v3 2/2] OMAP2PLUS:DSS2: Use opt_clock_available from pdata
Date: Tue,  1 Mar 2011 14:12:14 +0530
Message-ID: <1298968934-22697-3-git-send-email-sumit.semwal@ti.com>
References: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab1CAIme (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 03:42:34 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p218gYVG027769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 02:42:34 -0600
In-Reply-To: <1298968934-22697-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

hwmod databases provide information about which optional clocks are available
for a given platform. This is available via a function pointer opt_clock_enable
in pdata.

Use this information during get/enable/disable/put of clocks.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/dss.c |   46 ++++++++++++++++++++++++++--------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 5a93e66..3d0277d 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -699,6 +699,7 @@ static int dss_get_clock(struct clk **clock, const char *clk_name)
 static int dss_get_clocks(void)
 {
 	int r;
+	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
 
 	dss.dss_ick = NULL;
 	dss.dss_fck = NULL;
@@ -714,17 +715,28 @@ static int dss_get_clocks(void)
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
-	if (r)
+	if (!pdata->opt_clock_available) {
+		r = -ENODEV;
 		goto err;
+	}
 
-	r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
-	if (r)
-		goto err;
+	if (pdata->opt_clock_available("sys_clk")) {
+		r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
+		if (r)
+			goto err;
+	}
 
-	r = dss_get_clock(&dss.dss_video_fck, "video_clk");
-	if (r)
-		goto err;
+	if (pdata->opt_clock_available("tv_clk")) {
+		r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
+		if (r)
+			goto err;
+	}
+
+	if (pdata->opt_clock_available("video_clk")) {
+		r = dss_get_clock(&dss.dss_video_fck, "video_clk");
+		if (r)
+			goto err;
+	}
 
 	return 0;
 
@@ -747,9 +759,11 @@ static void dss_put_clocks(void)
 {
 	if (dss.dss_video_fck)
 		clk_put(dss.dss_video_fck);
-	clk_put(dss.dss_tv_fck);
+	if (dss.dss_tv_fck)
+		clk_put(dss.dss_tv_fck);
+	if (dss.dss_sys_clk)
+		clk_put(dss.dss_sys_clk);
 	clk_put(dss.dss_fck);
-	clk_put(dss.dss_sys_clk);
 	clk_put(dss.dss_ick);
 }
 
@@ -798,11 +812,11 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
 		clk_enable(dss.dss_ick);
 	if (clks & DSS_CLK_FCK)
 		clk_enable(dss.dss_fck);
-	if (clks & DSS_CLK_SYSCK)
+	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
 		clk_enable(dss.dss_sys_clk);
-	if (clks & DSS_CLK_TVFCK)
+	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
 		clk_enable(dss.dss_tv_fck);
-	if (clks & DSS_CLK_VIDFCK)
+	if ((clks & DSS_CLK_VIDFCK) && dss.dss_video_fck)
 		clk_enable(dss.dss_video_fck);
 
 	dss.num_clks_enabled += num_clks;
@@ -826,11 +840,11 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
 		clk_disable(dss.dss_ick);
 	if (clks & DSS_CLK_FCK)
 		clk_disable(dss.dss_fck);
-	if (clks & DSS_CLK_SYSCK)
+	if ((clks & DSS_CLK_SYSCK) && dss.dss_sys_clk)
 		clk_disable(dss.dss_sys_clk);
-	if (clks & DSS_CLK_TVFCK)
+	if ((clks & DSS_CLK_TVFCK) && dss.dss_tv_fck)
 		clk_disable(dss.dss_tv_fck);
-	if (clks & DSS_CLK_VIDFCK)
+	if ((clks & DSS_CLK_VIDFCK) && dss.dss_video_fck)
 		clk_disable(dss.dss_video_fck);
 
 	dss.num_clks_enabled -= num_clks;
-- 
1.7.1

