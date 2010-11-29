From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 13/17] OMAP2,3: DSS: DISPC Move init,exit to driver
Date: Mon, 29 Nov 2010 17:21:39 +0530
Message-ID: <1291031503-21036-14-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34151 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab0K2Lv5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 06:51:57 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe,remove.
pdev member has to be maintained by its own drivers.
Replace printk with dev_dbg for boot time optimize

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c  |    9 -----
 drivers/video/omap2/dss/dispc.c |   75 +++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index edb025c..3711553 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -198,12 +198,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_dpi;
 	}
 
-	r = dispc_init();
-	if (r) {
-		DSSERR("Failed to initialize dispc\n");
-		goto err_dispc;
-	}
-
 	r = venc_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize venc\n");
@@ -261,8 +255,6 @@ err_dsi:
 err_sdi:
 	venc_exit();
 err_venc:
-	dispc_exit();
-err_dispc:
 	dpi_exit();
 err_dpi:
 
@@ -277,7 +269,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dss_uninitialize_debugfs();
 
 	venc_exit();
-	dispc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 942dea5..57de1c9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -173,6 +173,7 @@ struct dispc_irq_stats {
 };
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem    *base;
 
 	u32	fifo_size[3];
@@ -3079,47 +3080,6 @@ static void _omap_dispc_initial_config(void)
 	dispc_read_plane_fifo_sizes();
 }
 
-int dispc_init(void)
-{
-	u32 rev;
-
-	spin_lock_init(&dispc.irq_lock);
-
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spin_lock_init(&dispc.irq_stats_lock);
-	dispc.irq_stats.last_reset = jiffies;
-#endif
-
-	INIT_WORK(&dispc.error_work, dispc_error_worker);
-
-	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
-	if (!dispc.base) {
-		DSSERR("can't ioremap DISPC\n");
-		return -ENOMEM;
-	}
-
-	enable_clocks(1);
-
-	_omap_dispc_initial_config();
-
-	_omap_dispc_initialize_irq();
-
-	dispc_save_context();
-
-	rev = dispc_read_reg(DISPC_REVISION);
-	printk(KERN_INFO "OMAP DISPC rev %d.%d\n",
-	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-
-	enable_clocks(0);
-
-	return 0;
-}
-
-void dispc_exit(void)
-{
-	iounmap(dispc.base);
-}
-
 int dispc_enable_plane(enum omap_plane plane, bool enable)
 {
 	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
@@ -3171,11 +3131,44 @@ int dispc_setup_plane(enum omap_plane plane,
 /* DISPC HW IP initialisation */
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
+	u32 rev;
+	dispc.pdev = pdev;
+
+	spin_lock_init(&dispc.irq_lock);
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock_init(&dispc.irq_stats_lock);
+	dispc.irq_stats.last_reset = jiffies;
+#endif
+
+	INIT_WORK(&dispc.error_work, dispc_error_worker);
+
+	dispc.base = ioremap(DISPC_BASE, DISPC_SZ_REGS);
+	if (!dispc.base) {
+		DSSERR("can't ioremap DISPC\n");
+		return -ENOMEM;
+	}
+
+	enable_clocks(1);
+
+	_omap_dispc_initial_config();
+
+	_omap_dispc_initialize_irq();
+
+	dispc_save_context();
+
+	rev = dispc_read_reg(DISPC_REVISION);
+	dev_dbg(&pdev->dev, "OMAP DISPC rev %d.%d\n",
+	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
+	enable_clocks(0);
+
 	return 0;
 }
 
 static int omap_dispchw_remove(struct platform_device *pdev)
 {
+	iounmap(dispc.base);
 	return 0;
 }
 
-- 
1.6.3.3

