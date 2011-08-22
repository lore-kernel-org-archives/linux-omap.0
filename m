From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] Revert "HACK: OMAP: DSS2: clk hack for OMAP2/3"
Date: Mon, 22 Aug 2011 11:26:09 +0300
Message-ID: <1314001571-17877-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:33451 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752799Ab1HVI0Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:26:24 -0400
In-Reply-To: <1314001571-17877-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This reverts commit 9ede365aa6f74428a1f69c21ca1cf21213167576.

The hack is no longer needed, as the HWMOD data has been fixed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c  |    5 +----
 drivers/video/omap2/dss/dss.c  |    5 -----
 drivers/video/omap2/dss/dss.h  |    2 --
 drivers/video/omap2/dss/rfbi.c |    5 +----
 drivers/video/omap2/dss/venc.c |    5 +----
 5 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 12da2fb..707e5af 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4441,10 +4441,7 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 
 	dsi->dss_clk = clk;
 
-	if (cpu_is_omap34xx() || cpu_is_omap3630())
-		clk = clk_get(&dsidev->dev, "dss2_alwon_fck");
-	else
-		clk = clk_get(&dsidev->dev, "sys_clk");
+	clk = clk_get(&dsidev->dev, "sys_clk");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get sys_clk\n");
 		clk_put(dsi->dss_clk);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 0f9c3a6..9423a2e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -691,11 +691,6 @@ static void dss_put_clocks(void)
 	clk_put(dss.dss_clk);
 }
 
-struct clk *dss_get_ick(void)
-{
-	return clk_get(&dss.pdev->dev, "ick");
-}
-
 int dss_runtime_get(void)
 {
 	int r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9c94b11..adeff04 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -209,8 +209,6 @@ void dss_uninit_platform_driver(void);
 int dss_runtime_get(void);
 void dss_runtime_put(void);
 
-struct clk *dss_get_ick(void);
-
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1bb8ce1..50394ba 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -957,10 +957,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	msleep(10);
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap3630())
-		clk = dss_get_ick();
-	else
-		clk = clk_get(&pdev->dev, "ick");
+	clk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get ick\n");
 		r = PTR_ERR(clk);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 173c664..71e005d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -741,10 +741,7 @@ static int venc_get_clocks(struct platform_device *pdev)
 	venc.tv_clk = clk;
 
 	if (dss_has_feature(FEAT_VENC_REQUIRES_TV_DAC_CLK)) {
-		if (cpu_is_omap34xx() || cpu_is_omap3630())
-			clk = clk_get(&pdev->dev, "dss_96m_fck");
-		else
-			clk = clk_get(&pdev->dev, "tv_dac_clk");
+		clk = clk_get(&pdev->dev, "tv_dac_clk");
 		if (IS_ERR(clk)) {
 			DSSERR("can't get tv_dac_clk\n");
 			clk_put(venc.tv_clk);
-- 
1.7.4.1

