From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v3 3/4] OMAP2PLUS: DSS2: Generalize external clock names in struct dss of dss.c
Date: Mon, 31 Jan 2011 21:57:45 +0530
Message-ID: <1296491266-6949-4-git-send-email-sumit.semwal@ti.com>
References: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44965 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab1AaQae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 11:30:34 -0500
In-Reply-To: <1296491266-6949-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Archit Taneja <archit@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Archit Taneja <archit@ti.com>

The dss struct in dss.c has omap2/3 specific clock names. Making them generic,
to increase readability and extendability.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.c |   82 ++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 2873c30..c7cdbea 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -64,10 +64,10 @@ static struct {
 
 	struct clk	*dpll4_m4_ck;
 	struct clk	*dss_ick;
-	struct clk	*dss1_fck;
-	struct clk	*dss2_fck;
-	struct clk	*dss_54m_fck;
-	struct clk	*dss_96m_fck;
+	struct clk	*dss_fck;
+	struct clk	*dss_sys_clk;
+	struct clk	*dss_tv_fck;
+	struct clk	*dss_video_fck;
 	unsigned	num_clks_enabled;
 
 	unsigned long	cache_req_pck;
@@ -749,28 +749,28 @@ static int dss_get_clocks(void)
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
 
-	r = dss_get_clock(&dss.dss1_fck, "fck");
+	r = dss_get_clock(&dss.dss_fck, "fck");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss2_fck, "sys_clk");
+	r = dss_get_clock(&dss.dss_sys_clk, "sys_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_54m_fck, "tv_clk");
+	r = dss_get_clock(&dss.dss_tv_fck, "tv_clk");
 	if (r)
 		goto err;
 
-	r = dss_get_clock(&dss.dss_96m_fck, "video_clk");
+	r = dss_get_clock(&dss.dss_video_fck, "video_clk");
 	if (r)
 		goto err;
 
@@ -779,25 +779,25 @@ static int dss_get_clocks(void)
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
 
@@ -807,13 +807,13 @@ unsigned long dss_clk_get_rate(enum dss_clock clk)
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
@@ -845,13 +845,13 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
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
@@ -873,13 +873,13 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
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
@@ -925,10 +925,10 @@ static void core_dump_clocks(struct seq_file *s)
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
-- 
1.7.1

