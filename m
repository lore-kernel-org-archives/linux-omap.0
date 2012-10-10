From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V5 4/5] OMAPDSS: Replace multi part debug prints with pr_debug
Date: Wed, 10 Oct 2012 14:52:46 +0530
Message-ID: <1349860966-15223-1-git-send-email-cmahapatra@ti.com>
References: <8fb0b3848f5d6148889f2b5160b8aa40e764f409.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44296 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab2JJJZe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 05:25:34 -0400
In-Reply-To: <8fb0b3848f5d6148889f2b5160b8aa40e764f409.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The various functions in dispc and dsi such as print_irq_status(),
print_irq_status_vc(), print_irq_status_cio() and _dsi_print_reset_status()
consist of a number of debug prints which need to be enabled all at once or none
at all. So, these debug prints in corresponding functions are replaced with one
dynamic debug enabled pr_debug() each.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
Changes from V4 to V5:
 * replaced prints in dsi functions print_irq_status, print_irq_status_vc() and
   print_irq_status_cio() with single pr_debug()
 * replaced macro VERBOSE_IRQ with static variable verbose_irq

 drivers/video/omap2/dss/dispc.c |   32 +++-----
 drivers/video/omap2/dss/dsi.c   |  168 ++++++++++++++++++---------------------
 2 files changed, 90 insertions(+), 110 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a173a94..67d9f3b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3675,26 +3675,20 @@ static void print_irq_status(u32 status)
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
 #endif
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b0345f3..19daee9 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -45,7 +45,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-/*#define VERBOSE_IRQ*/
 #define DSI_CATCH_MISSING_TE
 
 struct dsi_reg { u16 idx; };
@@ -526,42 +525,38 @@ static inline void dsi_perf_show(struct platform_device *dsidev,
 }
 #endif
 
+static int verbose_irq;
+
 static void print_irq_status(u32 status)
 {
 	if (status == 0)
 		return;
 
-#ifndef VERBOSE_IRQ
-	if ((status & ~DSI_IRQ_CHANNEL_MASK) == 0)
+	if (!verbose_irq && (status & ~DSI_IRQ_CHANNEL_MASK) == 0)
 		return;
-#endif
-	printk(KERN_DEBUG "DSI IRQ: 0x%x: ", status);
 
-#define PIS(x) \
-	if (status & DSI_IRQ_##x) \
-		printk(#x " ");
-#ifdef VERBOSE_IRQ
-	PIS(VC0);
-	PIS(VC1);
-	PIS(VC2);
-	PIS(VC3);
-#endif
-	PIS(WAKEUP);
-	PIS(RESYNC);
-	PIS(PLL_LOCK);
-	PIS(PLL_UNLOCK);
-	PIS(PLL_RECALL);
-	PIS(COMPLEXIO_ERR);
-	PIS(HS_TX_TIMEOUT);
-	PIS(LP_RX_TIMEOUT);
-	PIS(TE_TRIGGER);
-	PIS(ACK_TRIGGER);
-	PIS(SYNC_LOST);
-	PIS(LDO_POWER_GOOD);
-	PIS(TA_TIMEOUT);
+#define PIS(x) (status & DSI_IRQ_##x) ? (#x " ") : ""
+
+	pr_debug("DSI IRQ: 0x%x: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+		status,
+		verbose_irq ? PIS(VC0) : "",
+		verbose_irq ? PIS(VC1) : "",
+		verbose_irq ? PIS(VC2) : "",
+		verbose_irq ? PIS(VC3) : "",
+		PIS(WAKEUP),
+		PIS(RESYNC),
+		PIS(PLL_LOCK),
+		PIS(PLL_UNLOCK),
+		PIS(PLL_RECALL),
+		PIS(COMPLEXIO_ERR),
+		PIS(HS_TX_TIMEOUT),
+		PIS(LP_RX_TIMEOUT),
+		PIS(TE_TRIGGER),
+		PIS(ACK_TRIGGER),
+		PIS(SYNC_LOST),
+		PIS(LDO_POWER_GOOD),
+		PIS(TA_TIMEOUT));
 #undef PIS
-
-	printk("\n");
 }
 
 static void print_irq_status_vc(int channel, u32 status)
@@ -569,28 +564,24 @@ static void print_irq_status_vc(int channel, u32 status)
 	if (status == 0)
 		return;
 
-#ifndef VERBOSE_IRQ
-	if ((status & ~DSI_VC_IRQ_PACKET_SENT) == 0)
+	if (!verbose_irq && (status & ~DSI_VC_IRQ_PACKET_SENT) == 0)
 		return;
-#endif
-	printk(KERN_DEBUG "DSI VC(%d) IRQ 0x%x: ", channel, status);
 
-#define PIS(x) \
-	if (status & DSI_VC_IRQ_##x) \
-		printk(#x " ");
-	PIS(CS);
-	PIS(ECC_CORR);
-#ifdef VERBOSE_IRQ
-	PIS(PACKET_SENT);
-#endif
-	PIS(FIFO_TX_OVF);
-	PIS(FIFO_RX_OVF);
-	PIS(BTA);
-	PIS(ECC_NO_CORR);
-	PIS(FIFO_TX_UDF);
-	PIS(PP_BUSY_CHANGE);
+#define PIS(x) (status & DSI_VC_IRQ_##x) ? (#x " ") : ""
+
+	pr_debug("DSI VC(%d) IRQ 0x%x: %s%s%s%s%s%s%s%s%s\n",
+		channel,
+		status,
+		PIS(CS),
+		PIS(ECC_CORR),
+		PIS(ECC_NO_CORR),
+		verbose_irq ? PIS(PACKET_SENT) : "",
+		PIS(BTA),
+		PIS(FIFO_TX_OVF),
+		PIS(FIFO_RX_OVF),
+		PIS(FIFO_TX_UDF),
+		PIS(PP_BUSY_CHANGE));
 #undef PIS
-	printk("\n");
 }
 
 static void print_irq_status_cio(u32 status)
@@ -598,34 +589,31 @@ static void print_irq_status_cio(u32 status)
 	if (status == 0)
 		return;
 
-	printk(KERN_DEBUG "DSI CIO IRQ 0x%x: ", status);
-
-#define PIS(x) \
-	if (status & DSI_CIO_IRQ_##x) \
-		printk(#x " ");
-	PIS(ERRSYNCESC1);
-	PIS(ERRSYNCESC2);
-	PIS(ERRSYNCESC3);
-	PIS(ERRESC1);
-	PIS(ERRESC2);
-	PIS(ERRESC3);
-	PIS(ERRCONTROL1);
-	PIS(ERRCONTROL2);
-	PIS(ERRCONTROL3);
-	PIS(STATEULPS1);
-	PIS(STATEULPS2);
-	PIS(STATEULPS3);
-	PIS(ERRCONTENTIONLP0_1);
-	PIS(ERRCONTENTIONLP1_1);
-	PIS(ERRCONTENTIONLP0_2);
-	PIS(ERRCONTENTIONLP1_2);
-	PIS(ERRCONTENTIONLP0_3);
-	PIS(ERRCONTENTIONLP1_3);
-	PIS(ULPSACTIVENOT_ALL0);
-	PIS(ULPSACTIVENOT_ALL1);
+#define PIS(x) (status & DSI_CIO_IRQ_##x) ? (#x " ") : ""
+
+	pr_debug("DSI CIO IRQ 0x%x: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
+		status,
+		PIS(ERRSYNCESC1),
+		PIS(ERRSYNCESC2),
+		PIS(ERRSYNCESC3),
+		PIS(ERRESC1),
+		PIS(ERRESC2),
+		PIS(ERRESC3),
+		PIS(ERRCONTROL1),
+		PIS(ERRCONTROL2),
+		PIS(ERRCONTROL3),
+		PIS(STATEULPS1),
+		PIS(STATEULPS2),
+		PIS(STATEULPS3),
+		PIS(ERRCONTENTIONLP0_1),
+		PIS(ERRCONTENTIONLP1_1),
+		PIS(ERRCONTENTIONLP0_2),
+		PIS(ERRCONTENTIONLP1_2),
+		PIS(ERRCONTENTIONLP0_3),
+		PIS(ERRCONTENTIONLP1_3),
+		PIS(ULPSACTIVENOT_ALL0),
+		PIS(ULPSACTIVENOT_ALL1));
 #undef PIS
-
-	printk("\n");
 }
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
@@ -1121,14 +1109,6 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
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
@@ -1139,14 +1119,20 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
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
 #else
 #define _dsi_print_reset_status(x)
-- 
1.7.10

