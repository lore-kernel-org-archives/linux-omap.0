From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/6] OMAPDSS: DISPC: Remove context restore
Date: Mon, 18 Nov 2013 14:50:05 +0200
Message-ID: <1384779009-10512-3-git-send-email-tomi.valkeinen@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52137 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418Ab3KRMuR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:50:17 -0500
In-Reply-To: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the apply layer writes the registers after DISPC has been
resumed, we can remove all the context restore code.

Only _omap_dispc_initial_config call is needed on resume, which
configures the non-user-configurable registers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 255 +---------------------------------------
 1 file changed, 1 insertion(+), 254 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 91c687f..54716ad 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -43,9 +43,6 @@
 #include "dss_features.h"
 #include "dispc.h"
 
-/* DISPC */
-#define DISPC_SZ_REGS			SZ_4K
-
 enum omap_burst_size {
 	BURST_SIZE_X2 = 0,
 	BURST_SIZE_X4 = 1,
@@ -98,8 +95,6 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 
-	int		ctx_loss_cnt;
-
 	int irq;
 
 	unsigned long core_clk_rate;
@@ -109,9 +104,6 @@ static struct {
 	/* maps which plane is using a fifo. fifo-id -> plane-id */
 	int fifo_assignment[DISPC_MAX_NR_FIFOS];
 
-	bool		ctx_valid;
-	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
-
 	const struct dispc_features *feat;
 } dispc;
 
@@ -248,249 +240,6 @@ static void mgr_fld_write(enum omap_channel channel,
 	REG_FLD_MOD(rfld.reg, val, rfld.high, rfld.low);
 }
 
-#define SR(reg) \
-	dispc.ctx[DISPC_##reg / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
-#define RR(reg) \
-	dispc_write_reg(DISPC_##reg, dispc.ctx[DISPC_##reg / sizeof(u32)])
-
-static void dispc_save_context(void)
-{
-	int i, j;
-
-	DSSDBG("dispc_save_context\n");
-
-	SR(IRQENABLE);
-	SR(CONTROL);
-	SR(CONFIG);
-	SR(LINE_NUMBER);
-	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER) ||
-			dss_has_feature(FEAT_ALPHA_FREE_ZORDER))
-		SR(GLOBAL_ALPHA);
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		SR(CONTROL2);
-		SR(CONFIG2);
-	}
-	if (dss_has_feature(FEAT_MGR_LCD3)) {
-		SR(CONTROL3);
-		SR(CONFIG3);
-	}
-
-	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
-		SR(DEFAULT_COLOR(i));
-		SR(TRANS_COLOR(i));
-		SR(SIZE_MGR(i));
-		if (i == OMAP_DSS_CHANNEL_DIGIT)
-			continue;
-		SR(TIMING_H(i));
-		SR(TIMING_V(i));
-		SR(POL_FREQ(i));
-		SR(DIVISORo(i));
-
-		SR(DATA_CYCLE1(i));
-		SR(DATA_CYCLE2(i));
-		SR(DATA_CYCLE3(i));
-
-		if (dss_has_feature(FEAT_CPR)) {
-			SR(CPR_COEF_R(i));
-			SR(CPR_COEF_G(i));
-			SR(CPR_COEF_B(i));
-		}
-	}
-
-	for (i = 0; i < dss_feat_get_num_ovls(); i++) {
-		SR(OVL_BA0(i));
-		SR(OVL_BA1(i));
-		SR(OVL_POSITION(i));
-		SR(OVL_SIZE(i));
-		SR(OVL_ATTRIBUTES(i));
-		SR(OVL_FIFO_THRESHOLD(i));
-		SR(OVL_ROW_INC(i));
-		SR(OVL_PIXEL_INC(i));
-		if (dss_has_feature(FEAT_PRELOAD))
-			SR(OVL_PRELOAD(i));
-		if (i == OMAP_DSS_GFX) {
-			SR(OVL_WINDOW_SKIP(i));
-			SR(OVL_TABLE_BA(i));
-			continue;
-		}
-		SR(OVL_FIR(i));
-		SR(OVL_PICTURE_SIZE(i));
-		SR(OVL_ACCU0(i));
-		SR(OVL_ACCU1(i));
-
-		for (j = 0; j < 8; j++)
-			SR(OVL_FIR_COEF_H(i, j));
-
-		for (j = 0; j < 8; j++)
-			SR(OVL_FIR_COEF_HV(i, j));
-
-		for (j = 0; j < 5; j++)
-			SR(OVL_CONV_COEF(i, j));
-
-		if (dss_has_feature(FEAT_FIR_COEF_V)) {
-			for (j = 0; j < 8; j++)
-				SR(OVL_FIR_COEF_V(i, j));
-		}
-
-		if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-			SR(OVL_BA0_UV(i));
-			SR(OVL_BA1_UV(i));
-			SR(OVL_FIR2(i));
-			SR(OVL_ACCU2_0(i));
-			SR(OVL_ACCU2_1(i));
-
-			for (j = 0; j < 8; j++)
-				SR(OVL_FIR_COEF_H2(i, j));
-
-			for (j = 0; j < 8; j++)
-				SR(OVL_FIR_COEF_HV2(i, j));
-
-			for (j = 0; j < 8; j++)
-				SR(OVL_FIR_COEF_V2(i, j));
-		}
-		if (dss_has_feature(FEAT_ATTR2))
-			SR(OVL_ATTRIBUTES2(i));
-	}
-
-	if (dss_has_feature(FEAT_CORE_CLK_DIV))
-		SR(DIVISOR);
-
-	dispc.ctx_loss_cnt = dss_get_ctx_loss_count();
-	dispc.ctx_valid = true;
-
-	DSSDBG("context saved, ctx_loss_count %d\n", dispc.ctx_loss_cnt);
-}
-
-static void dispc_restore_context(void)
-{
-	int i, j, ctx;
-
-	DSSDBG("dispc_restore_context\n");
-
-	if (!dispc.ctx_valid)
-		return;
-
-	ctx = dss_get_ctx_loss_count();
-
-	if (ctx >= 0 && ctx == dispc.ctx_loss_cnt)
-		return;
-
-	DSSDBG("ctx_loss_count: saved %d, current %d\n",
-			dispc.ctx_loss_cnt, ctx);
-
-	/*RR(IRQENABLE);*/
-	/*RR(CONTROL);*/
-	RR(CONFIG);
-	RR(LINE_NUMBER);
-	if (dss_has_feature(FEAT_ALPHA_FIXED_ZORDER) ||
-			dss_has_feature(FEAT_ALPHA_FREE_ZORDER))
-		RR(GLOBAL_ALPHA);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		RR(CONFIG2);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		RR(CONFIG3);
-
-	for (i = 0; i < dss_feat_get_num_mgrs(); i++) {
-		RR(DEFAULT_COLOR(i));
-		RR(TRANS_COLOR(i));
-		RR(SIZE_MGR(i));
-		if (i == OMAP_DSS_CHANNEL_DIGIT)
-			continue;
-		RR(TIMING_H(i));
-		RR(TIMING_V(i));
-		RR(POL_FREQ(i));
-		RR(DIVISORo(i));
-
-		RR(DATA_CYCLE1(i));
-		RR(DATA_CYCLE2(i));
-		RR(DATA_CYCLE3(i));
-
-		if (dss_has_feature(FEAT_CPR)) {
-			RR(CPR_COEF_R(i));
-			RR(CPR_COEF_G(i));
-			RR(CPR_COEF_B(i));
-		}
-	}
-
-	for (i = 0; i < dss_feat_get_num_ovls(); i++) {
-		RR(OVL_BA0(i));
-		RR(OVL_BA1(i));
-		RR(OVL_POSITION(i));
-		RR(OVL_SIZE(i));
-		RR(OVL_ATTRIBUTES(i));
-		RR(OVL_FIFO_THRESHOLD(i));
-		RR(OVL_ROW_INC(i));
-		RR(OVL_PIXEL_INC(i));
-		if (dss_has_feature(FEAT_PRELOAD))
-			RR(OVL_PRELOAD(i));
-		if (i == OMAP_DSS_GFX) {
-			RR(OVL_WINDOW_SKIP(i));
-			RR(OVL_TABLE_BA(i));
-			continue;
-		}
-		RR(OVL_FIR(i));
-		RR(OVL_PICTURE_SIZE(i));
-		RR(OVL_ACCU0(i));
-		RR(OVL_ACCU1(i));
-
-		for (j = 0; j < 8; j++)
-			RR(OVL_FIR_COEF_H(i, j));
-
-		for (j = 0; j < 8; j++)
-			RR(OVL_FIR_COEF_HV(i, j));
-
-		for (j = 0; j < 5; j++)
-			RR(OVL_CONV_COEF(i, j));
-
-		if (dss_has_feature(FEAT_FIR_COEF_V)) {
-			for (j = 0; j < 8; j++)
-				RR(OVL_FIR_COEF_V(i, j));
-		}
-
-		if (dss_has_feature(FEAT_HANDLE_UV_SEPARATE)) {
-			RR(OVL_BA0_UV(i));
-			RR(OVL_BA1_UV(i));
-			RR(OVL_FIR2(i));
-			RR(OVL_ACCU2_0(i));
-			RR(OVL_ACCU2_1(i));
-
-			for (j = 0; j < 8; j++)
-				RR(OVL_FIR_COEF_H2(i, j));
-
-			for (j = 0; j < 8; j++)
-				RR(OVL_FIR_COEF_HV2(i, j));
-
-			for (j = 0; j < 8; j++)
-				RR(OVL_FIR_COEF_V2(i, j));
-		}
-		if (dss_has_feature(FEAT_ATTR2))
-			RR(OVL_ATTRIBUTES2(i));
-	}
-
-	if (dss_has_feature(FEAT_CORE_CLK_DIV))
-		RR(DIVISOR);
-
-	/* enable last, because LCD & DIGIT enable are here */
-	RR(CONTROL);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		RR(CONTROL2);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		RR(CONTROL3);
-	/* clear spurious SYNC_LOST_DIGIT interrupts */
-	dispc_clear_irqstatus(DISPC_IRQ_SYNC_LOST_DIGIT);
-
-	/*
-	 * enable last so IRQs won't trigger before
-	 * the context is fully restored
-	 */
-	RR(IRQENABLE);
-
-	DSSDBG("context restored\n");
-}
-
-#undef SR
-#undef RR
-
 int dispc_runtime_get(void)
 {
 	int r;
@@ -3726,14 +3475,12 @@ static int __exit omap_dispchw_remove(struct platform_device *pdev)
 
 static int dispc_runtime_suspend(struct device *dev)
 {
-	dispc_save_context();
-
 	return 0;
 }
 
 static int dispc_runtime_resume(struct device *dev)
 {
-	dispc_restore_context();
+	_omap_dispc_initial_config();
 
 	return 0;
 }
-- 
1.8.3.2

