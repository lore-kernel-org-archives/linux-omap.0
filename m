From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 2/2] OMAPDSS: Remove dss_debug variable
Date: Wed, 26 Sep 2012 10:46:02 +0530
Message-ID: <79ccb18ca1c45477e4d8cb77ee240090be06cda9.1348636132.git.cmahapatra@ti.com>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com> <cover.1348636132.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60643 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781Ab2IZFSP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 01:18:15 -0400
In-Reply-To: <cover.1348636132.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The debug prints in omap_dispc_unregister_isr() and _dsi_print_reset_status()
are replaced with dynamic debug enabled pr_debug(). So, as the final dependency
on dss_debug variable is replaced with dyndbg, the dss_debug variable is
removed.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/core.c  |    5 -----
 drivers/video/omap2/dss/dispc.c |   39 ++++++++++++++-------------------------
 drivers/video/omap2/dss/dsi.c   |   37 ++++++++++++++-----------------------
 drivers/video/omap2/dss/dss.h   |    4 ----
 4 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 58bd9c2..5d77c86 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -52,11 +52,6 @@ static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
 MODULE_PARM_DESC(def_disp, "default display name");
 
-#ifdef DEBUG
-bool dss_debug;
-module_param_named(debug, dss_debug, bool, 0644);
-#endif
-
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1121823..6c813a6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3447,34 +3447,26 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 }
 EXPORT_SYMBOL(omap_dispc_unregister_isr);
 
-#ifdef DEBUG
 static void print_irq_status(u32 status)
 {
 	if ((status & dispc.irq_error_mask) == 0)
 		return;
 
-	printk(KERN_DEBUG "DISPC IRQ: 0x%x: ", status);
-
-#define PIS(x) \
-	if (status & DISPC_IRQ_##x) \
-		printk(#x " ");
-	PIS(GFX_FIFO_UNDERFLOW);
-	PIS(OCP_ERR);
-	PIS(VID1_FIFO_UNDERFLOW);
-	PIS(VID2_FIFO_UNDERFLOW);
-	if (dss_feat_get_num_ovls() > 3)
-		PIS(VID3_FIFO_UNDERFLOW);
-	PIS(SYNC_LOST);
-	PIS(SYNC_LOST_DIGIT);
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		PIS(SYNC_LOST2);
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		PIS(SYNC_LOST3);
+#define PIS(x) (status & DISPC_IRQ_##x) ? (#x " ") : ""
+
+	pr_debug("DISPC IRQ: 0x%x: %s%s%s%s%s%s%s%s%s\n",
+		status,
+		PIS(OCP_ERR),
+		PIS(GFX_FIFO_UNDERFLOW),
+		PIS(VID1_FIFO_UNDERFLOW),
+		PIS(VID2_FIFO_UNDERFLOW),
+		dss_feat_get_num_ovls() > 3 ? PIS(VID3_FIFO_UNDERFLOW) : "",
+		PIS(SYNC_LOST),
+		PIS(SYNC_LOST_DIGIT),
+		dss_has_feature(FEAT_MGR_LCD2) ? PIS(SYNC_LOST2) : "",
+		dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : "");
 #undef PIS
-
-	printk("\n");
 }
-#endif
 
 /* Called from dss.c. Note that we don't touch clocks here,
  * but we presume they are on because we got an IRQ. However,
@@ -3507,10 +3499,7 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 	spin_unlock(&dispc.irq_stats_lock);
 #endif
 
-#ifdef DEBUG
-	if (dss_debug)
-		print_irq_status(irqstatus);
-#endif
+	print_irq_status(irqstatus);
 	/* Ack the interrupt. Do it here before clocks are possibly turned
 	 * off */
 	dispc_write_reg(DISPC_IRQSTATUS, irqstatus);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 18834f3..ed7ff72 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1100,28 +1100,16 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 	}
 }
 
-#ifdef DEBUG
 static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
 	u32 l;
 	int b0, b1, b2;
 
-	if (!dss_debug)
-		return;
-
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
 	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
-	printk(KERN_DEBUG "DSI resets: ");
-
-	l = dsi_read_reg(dsidev, DSI_PLL_STATUS);
-	printk("PLL (%d) ", FLD_GET(l, 0, 0));
-
-	l = dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG1);
-	printk("CIO (%d) ", FLD_GET(l, 29, 29));
-
 	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
 		b0 = 28;
 		b1 = 27;
@@ -1132,18 +1120,21 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
 		b2 = 26;
 	}
 
-	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
-	printk("PHY (%x%x%x, %d, %d, %d)\n",
-			FLD_GET(l, b0, b0),
-			FLD_GET(l, b1, b1),
-			FLD_GET(l, b2, b2),
-			FLD_GET(l, 29, 29),
-			FLD_GET(l, 30, 30),
-			FLD_GET(l, 31, 31));
+#define DSI_FLD_GET(fld, start, end)\
+	FLD_GET(dsi_read_reg(dsidev, DSI_##fld), start, end)
+
+	pr_debug("DSI resets: PLL (%d) CIO (%d) PHY (%x%x%x, %d, %d, %d)\n",
+		DSI_FLD_GET(PLL_STATUS, 0, 0),
+		DSI_FLD_GET(COMPLEXIO_CFG1, 29, 29),
+		DSI_FLD_GET(DSIPHY_CFG5, b0, b0),
+		DSI_FLD_GET(DSIPHY_CFG5, b1, b1),
+		DSI_FLD_GET(DSIPHY_CFG5, b2, b2),
+		DSI_FLD_GET(DSIPHY_CFG5, 29, 29),
+		DSI_FLD_GET(DSIPHY_CFG5, 30, 30),
+		DSI_FLD_GET(DSIPHY_CFG5, 31, 31));
+
+#undef DSI_FLD_GET
 }
-#else
-#define _dsi_print_reset_status(x)
-#endif
 
 static inline int dsi_if_enable(struct platform_device *dsidev, bool enable)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3a2caab..0015803 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -27,10 +27,6 @@
 #define DEBUG
 #endif
 
-#ifdef DEBUG
-extern bool dss_debug;
-#endif
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
-- 
1.7.10

