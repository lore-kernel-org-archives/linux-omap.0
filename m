From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH 3/3] OMAP2PLUS: DSS2: Generalize external clock names in struct dss of dss.c
Date: Wed,  5 Jan 2011 23:07:44 +0530
Message-ID: <1294249064-11491-4-git-send-email-sumit.semwal@ti.com>
References: <1294249064-11491-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37419 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1AERiQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 12:38:16 -0500
In-Reply-To: <1294249064-11491-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

The dss struct in dss.c has omap2/3 specific clock names. Making them generic,
to increase readability and extendability.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.c |  108 ++++++++++++++++++++--------------------
 1 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 72c13dc..91f2fb1 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -66,10 +66,10 @@ static struct {
 	struct clk	*dpll4_m4_ck;
 
 	struct clk      *dss_ick;
-	struct clk	*dss1_fck;
-	struct clk	*dss2_fck;
-	struct clk      *dss_54m_fck;
-	struct clk	*dss_96m_fck;
+	struct clk	*dss_fck;
+	struct clk	*dss_sys_clk;
+	struct clk      *dss_tv_fck;
+	struct clk	*dss_video_fck;
 	unsigned	num_clks_enabled;
 
 	unsigned long	cache_req_pck;
@@ -747,28 +747,28 @@ static int dss_get_clocks(void)
 	int r;
 
 	dss.dss_ick = NULL;
-	dss.dss1_fck = NULL;
-	dss.dss2_fck = NULL;
-	dss.dss_54m_fck = NULL;
-	dss.dss_96m_fck = NULL;
+	dss.dss_fck = NULL;
+	dss.dss_sys_clk = NULL;
+	dss.dss_tv_fck = NULL;
+	dss.dss_video_fck = NULL;
 
 	r = dss_get_clock(&dss.dss_ick, "ick");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss1_fck, "dss1_fck");
+	r = dss_get_clock(&dss.dss_fck, "fck");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss2_fck, "dss2_fck");
+	r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_54m_fck, "tv_fck");
+	r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_96m_fck, "video_fck");
+	r = dss_get_clock(&dss.dss_video_fck, "video_clk");
 	if (r)
 		goto err;
 
@@ -777,25 +777,25 @@ static int dss_get_clocks(void)
 err:
 	if (dss.dss_ick)
 		clk_put(dss.dss_ick);
-	if (dss.dss1_fck)
-		clk_put(dss.dss1_fck);
-	if (dss.dss2_fck)
-		clk_put(dss.dss2_fck);
-	if (dss.dss_54m_fck)
-		clk_put(dss.dss_54m_fck);
-	if (dss.dss_96m_fck)
-		clk_put(dss.dss_96m_fck);
+	if (dss.dss_fck)
+		clk_put(dss.dss_fck);
+	if (dss.dss_sys_clk)
+		clk_put(dss.dss_sys_clk);
+	if (dss.dss_tv_fck)
+		clk_put(dss.dss_tv_fck);
+	if (dss.dss_video_fck)
+		clk_put(dss.dss_video_fck);
 
 	return r;
 }
 
 static void dss_put_clocks(void)
 {
-	if (dss.dss_96m_fck)
-		clk_put(dss.dss_96m_fck);
-	clk_put(dss.dss_54m_fck);
-	clk_put(dss.dss1_fck);
-	clk_put(dss.dss2_fck);
+	if (dss.dss_video_fck)
+		clk_put(dss.dss_video_fck);
+	clk_put(dss.dss_tv_fck);
+	clk_put(dss.dss_fck);
+	clk_put(dss.dss_sys_clk);
 	clk_put(dss.dss_ick);
 }
 
@@ -805,13 +805,13 @@ unsigned long dss_clk_get_rate(enum dss_clock clk)
 	case DSS_CLK_ICK:
 		return clk_get_rate(dss.dss_ick);
 	case DSS_CLK_FCK:
-		return clk_get_rate(dss.dss1_fck);
+		return clk_get_rate(dss.dss_fck);
 	case DSS_CLK_SYSCK:
-		return clk_get_rate(dss.dss2_fck);
+		return clk_get_rate(dss.dss_sys_clk);
 	case DSS_CLK_TVFCK:
-		return clk_get_rate(dss.dss_54m_fck);
+		return clk_get_rate(dss.dss_tv_fck);
 	case DSS_CLK_VIDFCK:
-		return clk_get_rate(dss.dss_96m_fck);
+		return clk_get_rate(dss.dss_video_fck);
 	}
 
 	BUG();
@@ -843,13 +843,13 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
 	if (clks & DSS_CLK_ICK)
 		clk_enable(dss.dss_ick);
 	if (clks & DSS_CLK_FCK)
-		clk_enable(dss.dss1_fck);
+		clk_enable(dss.dss_fck);
 	if (clks & DSS_CLK_SYSCK)
-		clk_enable(dss.dss2_fck);
+		clk_enable(dss.dss_sys_clk);
 	if (clks & DSS_CLK_TVFCK)
-		clk_enable(dss.dss_54m_fck);
+		clk_enable(dss.dss_tv_fck);
 	if (clks & DSS_CLK_VIDFCK)
-		clk_enable(dss.dss_96m_fck);
+		clk_enable(dss.dss_video_fck);
 
 	dss.num_clks_enabled += num_clks;
 }
@@ -871,13 +871,13 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
 	if (clks & DSS_CLK_ICK)
 		clk_disable(dss.dss_ick);
 	if (clks & DSS_CLK_FCK)
-		clk_disable(dss.dss1_fck);
+		clk_disable(dss.dss_fck);
 	if (clks & DSS_CLK_SYSCK)
-		clk_disable(dss.dss2_fck);
+		clk_disable(dss.dss_sys_clk);
 	if (clks & DSS_CLK_TVFCK)
-		clk_disable(dss.dss_54m_fck);
+		clk_disable(dss.dss_tv_fck);
 	if (clks & DSS_CLK_VIDFCK)
-		clk_disable(dss.dss_96m_fck);
+		clk_disable(dss.dss_video_fck);
 
 	dss.num_clks_enabled -= num_clks;
 }
@@ -923,10 +923,10 @@ static void core_dump_clocks(struct seq_file *s)
 	int i;
 	struct clk *clocks[5] = {
 		dss.dss_ick,
-		dss.dss1_fck,
-		dss.dss2_fck,
-		dss.dss_54m_fck,
-		dss.dss_96m_fck
+		dss.dss_fck,
+		dss.dss_sys_clk,
+		dss.dss_tv_fck,
+		dss.dss_video_fck
 	};
 
 	seq_printf(s, "- CORE -\n");
@@ -1010,34 +1010,34 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 			clk_disable(dss.dss_ick);
 	}
 
-	c = dss.dss1_fck->usecount;
+	c = dss.dss_fck->usecount;
 	if (c > 0) {
-		DSSERR("warning: dss1_fck usecount %d, disabling\n", c);
+		DSSERR("warning: dss_fck usecount %d, disabling\n", c);
 		while (c-- > 0)
-			clk_disable(dss.dss1_fck);
+			clk_disable(dss.dss_fck);
 	}
 
-	c = dss.dss2_fck->usecount;
+	c = dss.dss_sys_clk->usecount;
 	if (c > 0) {
-		DSSERR("warning: dss2_fck usecount %d, disabling\n", c);
+		DSSERR("warning: dss_sys_clk usecount %d, disabling\n", c);
 		while (c-- > 0)
-			clk_disable(dss.dss2_fck);
+			clk_disable(dss.dss_sys_clk);
 	}
 
-	c = dss.dss_54m_fck->usecount;
+	c = dss.dss_tv_fck->usecount;
 	if (c > 0) {
-		DSSERR("warning: dss_54m_fck usecount %d, disabling\n", c);
+		DSSERR("warning: dss_tv_fck usecount %d, disabling\n", c);
 		while (c-- > 0)
-			clk_disable(dss.dss_54m_fck);
+			clk_disable(dss.dss_tv_fck);
 	}
 
-	if (dss.dss_96m_fck) {
-		c = dss.dss_96m_fck->usecount;
+	if (dss.dss_video_fck) {
+		c = dss.dss_video_fck->usecount;
 		if (c > 0) {
-			DSSERR("warning: dss_96m_fck usecount %d, disabling\n",
+			DSSERR("warning: dss_video_fck usecount %d, disabling\n",
 					c);
 			while (c-- > 0)
-				clk_disable(dss.dss_96m_fck);
+				clk_disable(dss.dss_video_fck);
 		}
 	}
 
-- 
1.7.0.4

