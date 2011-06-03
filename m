From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/27] OMAP: DSS2: DISPC: Fix context save/restore
Date: Fri,  3 Jun 2011 13:00:36 +0300
Message-ID: <1307095237-14805-27-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57183 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754392Ab1FCKB6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:58 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
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
index b13a656..73f1105 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -110,6 +110,7 @@ static struct {
 	u32 error_irqs;
 	struct work_struct error_work;
 
+	bool		ctx_valid;
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
@@ -142,6 +143,23 @@ static inline u32 dispc_read_reg(const u16 idx)
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
@@ -318,14 +336,30 @@ static void dispc_save_context(void)
 
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
@@ -504,65 +538,13 @@ static void dispc_restore_context(void)
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
@@ -584,8 +566,7 @@ int dispc_runtime_get(void)
 		if (r < 0)
 			goto err_runtime_get;
 
-		if (dispc_need_ctx_restore())
-			dispc_restore_context();
+		dispc_restore_context();
 	}
 
 	mutex_unlock(&dispc.runtime_lock);
@@ -3682,8 +3663,6 @@ static int omap_dispchw_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	dispc_init_ctx_loss_count();
-
 	mutex_init(&dispc.runtime_lock);
 
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.4.1

