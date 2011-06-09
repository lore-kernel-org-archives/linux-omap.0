From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 25/28] OMAP: DSS2: Remove ctx loss count from dss.c
Date: Thu,  9 Jun 2011 16:56:47 +0300
Message-ID: <1307627810-3768-26-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36282 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758150Ab1FIN6B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:58:01 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss.c only saves 1 register (3 in OMAP3) so the extra overhead from
need_ctx_restore & co. is probably bigger than the time spent saving and
restoring those few registers every time.

So remove the code from dss.c and restore context every time dss has
been off.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   62 +----------------------------------------
 1 files changed, 1 insertions(+), 61 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4e36a07..21c8389 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -62,8 +62,6 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 
-	int		ctx_loss_cnt;
-
 	struct clk	*dpll4_m4_ck;
 	struct clk	*dss_clk;
 
@@ -631,61 +629,6 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
-/* CONTEXT */
-static void dss_init_ctx_loss_count(void)
-{
-	struct device *dev = &dss.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt = 0;
-
-	/*
-	 * get_context_loss_count returns negative on error. We'll ignore the
-	 * error and store the error to ctx_loss_cnt, which will cause
-	 * dss_need_ctx_restore() call to return true.
-	 */
-
-	if (board_data->get_context_loss_count)
-		cnt = board_data->get_context_loss_count(dev);
-
-	WARN_ON(cnt < 0);
-
-	dss.ctx_loss_cnt = cnt;
-
-	DSSDBG("initial ctx_loss_cnt %u\n", cnt);
-}
-
-static bool dss_need_ctx_restore(void)
-{
-	struct device *dev = &dss.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt;
-
-	/*
-	 * If get_context_loss_count is not available, assume that we need
-	 * context restore always.
-	 */
-	if (!board_data->get_context_loss_count)
-		return true;
-
-	cnt = board_data->get_context_loss_count(dev);
-	if (cnt < 0) {
-		dev_err(dev, "getting context loss count failed, will force "
-				"context restore\n");
-		dss.ctx_loss_cnt = cnt;
-		return true;
-	}
-
-	if (cnt == dss.ctx_loss_cnt)
-		return false;
-
-	DSSDBG("ctx_loss_cnt %d -> %d\n", dss.ctx_loss_cnt, cnt);
-	dss.ctx_loss_cnt = cnt;
-
-	return true;
-}
-
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
@@ -797,8 +740,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_clocks;
 
-	dss_init_ctx_loss_count();
-
 	pm_runtime_enable(&pdev->dev);
 
 	r = dss_runtime_get();
@@ -875,8 +816,7 @@ static int dss_runtime_suspend(struct device *dev)
 static int dss_runtime_resume(struct device *dev)
 {
 	clk_enable(dss.dss_clk);
-	if (dss_need_ctx_restore())
-		dss_restore_context();
+	dss_restore_context();
 	return 0;
 }
 
-- 
1.7.4.1

