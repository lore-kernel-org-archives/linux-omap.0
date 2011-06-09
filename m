From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 27/28] OMAP: DSS2: DISPC: Fix context save/restore
Date: Thu,  9 Jun 2011 16:56:49 +0300
Message-ID: <1307627810-3768-28-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42386 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758164Ab1FIN6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:58:06 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current method of saving and restoring the context could cause a
restore before saving, effectively "restoring" zero values to registers.

Add ctx_valid field to indicate if the saved context is valid and can be
restored.

Also restructure the code to save the ctx_loss_count in save_context(),
which makes more sense than the previous method of storing new
ctx_loss_count in dispc_need_ctx_restore.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   97 +++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2de7e92..eac768f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -108,6 +108,7 @@ static struct {
 	u32 error_irqs;
 	struct work_struct error_work;
 
+	bool		ctx_valid;
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
@@ -140,6 +141,23 @@ static inline u32 dispc_read_reg(const u16 idx)
 	return __raw_readl(dispc.base + idx);
 }
 
+static int dispc_get_ctx_loss_count(void)
+{
+	struct device *dev = &dispc.pdev->dev;
+	struct omap_display_platform_data *pdata = dev->platform_data;
+	struct omap_dss_board_info *board_data = pdata->board_data;
+	int cnt;
+
+	if (!board_data->get_context_loss_count)
+		return -ENOENT;
+
+	cnt = board_data->get_context_loss_count(dev);
+
+	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
+
+	return cnt;
+}
+
 #define SR(reg) \
 	dispc.ctx[DISPC_##reg / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
 #define RR(reg) \
@@ -316,14 +334,30 @@ static void dispc_save_context(void)
 
 	if (dss_has_feature(FEAT_CORE_CLK_DIV))
 		SR(DIVISOR);
+
+	dispc.ctx_loss_cnt = dispc_get_ctx_loss_count();
+	dispc.ctx_valid = true;
+
+	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
 }
 
 static void dispc_restore_context(void)
 {
-	int i;
+	int i, ctx;
 
 	DSSDBG("dispc_restore_context\n");
 
+	if (!dispc.ctx_valid)
+		return;
+
+	ctx = dispc_get_ctx_loss_count();
+
+	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
+		return;
+
+	DSSDBG("ctx_loss_count: saved %d, current %d\n",
+			dispc.ctx_loss_cnt, ctx);
+
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
@@ -502,65 +536,13 @@ static void dispc_restore_context(void)
 	 * the context is fully restored
 	 */
 	RR(IRQENABLE);
+
+	DSSDBG("context restored\n");
 }
 
 #undef SR
 #undef RR
 
-static void dispc_init_ctx_loss_count(void)
-{
-	struct device *dev = &dispc.pdev->dev;
-	struct omap_display_platform_data *pdata = dev->platform_data;
-	struct omap_dss_board_info *board_data = pdata->board_data;
-	int cnt = 0;
-
-	/*
-	 * get_context_loss_count returns negative on error. We'll ignore the
-	 * error and store the error to ctx_loss_cnt, which will cause
-	 * dispc_need_ctx_restore() call to return true.
-	 */
-
-	if (board_data->get_context_loss_count)
-		cnt = board_data->get_context_loss_count(dev);
-
-	WARN_ON(cnt < 0);
-
-	dispc.ctx_loss_cnt = cnt;
-
-	DSSDBG("initial ctx_loss_cnt %u\n", cnt);
-}
-
-static bool dispc_need_ctx_restore(void)
-{
-	struct device *dev = &dispc.pdev->dev;
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
-		dispc.ctx_loss_cnt = cnt;
-		return true;
-	}
-
-	if (cnt == dispc.ctx_loss_cnt)
-		return false;
-
-	DSSDBG("ctx_loss_cnt %d -> %d\n", dispc.ctx_loss_cnt, cnt);
-	dispc.ctx_loss_cnt = cnt;
-
-	return true;
-}
-
 int dispc_runtime_get(void)
 {
 	int r;
@@ -3641,8 +3623,6 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	dispc_init_ctx_loss_count();
-
 	pm_runtime_enable(&pdev->dev);
 
 	r = dispc_runtime_get();
@@ -3701,8 +3681,7 @@ static int dispc_runtime_resume(struct device *dev)
 		return r;
 
 	clk_enable(dispc.dss_clk);
-	if (dispc_need_ctx_restore())
-		dispc_restore_context();
+	dispc_restore_context();
 
 	return 0;
 }
-- 
1.7.4.1

