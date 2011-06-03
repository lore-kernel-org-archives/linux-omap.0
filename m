From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 24/27] OMAP: DSS2: Remove ctx loss count from dss.c
Date: Fri,  3 Jun 2011 13:00:34 +0300
Message-ID: <1307095237-14805-25-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44425 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754320Ab1FCKBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:54 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
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
 drivers/video/omap2/dss/dss.c |   61 +----------------------------------------
 1 files changed, 1 insertions(+), 60 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c8d7357..91572b6 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -62,7 +62,6 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 
-	int		ctx_loss_cnt;
 	struct mutex	runtime_lock;
 	int		runtime_count;
 
@@ -633,61 +632,6 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
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
@@ -756,8 +700,7 @@ int dss_runtime_get(void)
 		if (r < 0)
 			goto err;
 
-		if (dss_need_ctx_restore())
-			dss_restore_context();
+		dss_restore_context();
 	}
 
 	mutex_unlock(&dss.runtime_lock);
@@ -828,8 +771,6 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_clocks;
 
-	dss_init_ctx_loss_count();
-
 	mutex_init(&dss.runtime_lock);
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.4.1

