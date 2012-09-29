From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 4/5] OMAPDSS: Replace multi part debug prints with pr_debug
Date: Sat, 29 Sep 2012 16:19:25 +0530
Message-ID: <8fb0b3848f5d6148889f2b5160b8aa40e764f409.1348914940.git.cmahapatra@ti.com>
References: <cover.1348826106.git.cmahapatra@ti.com> <cover.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab2I2KwM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Sep 2012 06:52:12 -0400
In-Reply-To: <cover.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The omap_dispc_unregister_isr() and _dsi_print_reset_status() consist of a
number of debug prints which need to be enabled all at once or none at all. So,
these debug prints in corresponding functions are replaced with one dynamic
debug enabled pr_debug() each.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   32 +++++++++++++-------------------
 drivers/video/omap2/dss/dsi.c   |   30 ++++++++++++++----------------
 2 files changed, 27 insertions(+), 35 deletions(-)

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
index b0345f3..6dd073a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1121,14 +1121,6 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
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
@@ -1139,14 +1131,20 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
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

