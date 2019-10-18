From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] omapfb: reduce stack usage
Date: Fri, 18 Oct 2019 17:30:04 +0100
Message-ID: <20191018163004.23498-1-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-omap@vger.kernel.org

The build of xtensa allmodconfig is giving a warning of:
In function 'dsi_dump_dsidev_irqs':
warning: the frame size of 1120 bytes is larger than 1024 bytes

Allocate the memory for 'struct dsi_irq_stats' dynamically instead
of assigning it in stack.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index d620376216e1..43402467bf40 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -1536,22 +1536,25 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
-	struct dsi_irq_stats stats;
+	struct dsi_irq_stats *stats;
 
+	stats = kmalloc(sizeof(*stats), GFP_KERNEL);
+	if (!stats)
+		return;
 	spin_lock_irqsave(&dsi->irq_stats_lock, flags);
 
-	stats = dsi->irq_stats;
+	memcpy(stats, &dsi->irq_stats, sizeof(*stats));
 	memset(&dsi->irq_stats, 0, sizeof(dsi->irq_stats));
 	dsi->irq_stats.last_reset = jiffies;
 
 	spin_unlock_irqrestore(&dsi->irq_stats_lock, flags);
 
 	seq_printf(s, "period %u ms\n",
-			jiffies_to_msecs(jiffies - stats.last_reset));
+			jiffies_to_msecs(jiffies - stats->last_reset));
 
-	seq_printf(s, "irqs %d\n", stats.irq_count);
+	seq_printf(s, "irqs %d\n", stats->irq_count);
 #define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
+	seq_printf(s, "%-20s %10d\n", #x, stats->dsi_irqs[ffs(DSI_IRQ_##x)-1]);
 
 	seq_printf(s, "-- DSI%d interrupts --\n", dsi->module_id + 1);
 	PIS(VC0);
@@ -1575,10 +1578,10 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 
 #define PIS(x) \
 	seq_printf(s, "%-20s %10d %10d %10d %10d\n", #x, \
-			stats.vc_irqs[0][ffs(DSI_VC_IRQ_##x)-1], \
-			stats.vc_irqs[1][ffs(DSI_VC_IRQ_##x)-1], \
-			stats.vc_irqs[2][ffs(DSI_VC_IRQ_##x)-1], \
-			stats.vc_irqs[3][ffs(DSI_VC_IRQ_##x)-1]);
+			stats->vc_irqs[0][ffs(DSI_VC_IRQ_##x)-1], \
+			stats->vc_irqs[1][ffs(DSI_VC_IRQ_##x)-1], \
+			stats->vc_irqs[2][ffs(DSI_VC_IRQ_##x)-1], \
+			stats->vc_irqs[3][ffs(DSI_VC_IRQ_##x)-1]);
 
 	seq_printf(s, "-- VC interrupts --\n");
 	PIS(CS);
@@ -1594,7 +1597,7 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 
 #define PIS(x) \
 	seq_printf(s, "%-20s %10d\n", #x, \
-			stats.cio_irqs[ffs(DSI_CIO_IRQ_##x)-1]);
+			stats->cio_irqs[ffs(DSI_CIO_IRQ_##x)-1]);
 
 	seq_printf(s, "-- CIO interrupts --\n");
 	PIS(ERRSYNCESC1);
@@ -1618,6 +1621,7 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
 	PIS(ULPSACTIVENOT_ALL0);
 	PIS(ULPSACTIVENOT_ALL1);
 #undef PIS
+	kfree(stats);
 }
 
 static void dsi1_dump_irqs(struct seq_file *s)
-- 
2.11.0
