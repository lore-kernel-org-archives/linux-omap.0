From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [Patch 2/2] OMAP2PLUS: DSS2: Use opt-clocks from hwmod
Date: Fri, 25 Feb 2011 13:57:50 +0530
Message-ID: <1298622470-10558-3-git-send-email-sumit.semwal@ti.com>
References: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50477 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771Ab1BYI2L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 03:28:11 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P8SAI5000631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 02:28:10 -0600
In-Reply-To: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

hwmod databases provide information on which optional clocks are available for
a given platform. Use this information during get/enable/disable/put of clocks.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/dss.c |   54 ++++++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 921ff91..9a85f9d 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -706,6 +706,18 @@ static int dss_get_clock(struct clk **clock, const char *clk_name)
 	return 0;
 }
 
+static inline bool opt_clock_available(const char *clk_role)
+{
+	int i;
+	struct omap_display_platform_data *pdata = dss.pdev->dev.platform_data;
+
+	for (i = 0; i < pdata->dss_opt_clks_count; i++) {
+		if (strcmp(pdata->dss_opt_clk_roles[i], clk_role) == 0)
+			return true;
+	}
+	return false;
+}
+
 static int dss_get_clocks(void)
 {
 	int r;
@@ -724,17 +736,23 @@ static int dss_get_clocks(void)
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
-	if (r)
-		goto err;
+	if (opt_clock_available("sys_clk")) {
+		r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
+		if (r)
+			goto err;
+	}
 
-	r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
-	if (r)
-		goto err;
+	if (opt_clock_available("tv_clk")) {
+		r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
+		if (r)
+			goto err;
+	}
 
-	r = dss_get_clock(&dss.dss_video_fck, "video_clk");
-	if (r)
-		goto err;
+	if (opt_clock_available("video_clk")) {
+		r = dss_get_clock(&dss.dss_video_fck, "video_clk");
+		if (r)
+			goto err;
+	}
 
 	return 0;
 
@@ -757,9 +775,11 @@ static void dss_put_clocks(void)
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
 
@@ -808,11 +828,11 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
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
@@ -836,11 +856,11 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
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

