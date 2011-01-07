From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v4 11/17] OMAP2,3: DSS2: RFBI: create platform_driver, move init,exit to driver
Date: Fri,  7 Jan 2011 08:49:05 +0530
Message-ID: <1294370351-8654-12-git-send-email-sumit.semwal@ti.com>
References: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33818 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab1AGDU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 22:20:26 -0500
In-Reply-To: <1294370351-8654-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Hwmod adaptation design requires each of the DSS HW IP to be a platform driver.
So a platform_driver for RFBI is created and init exit methods are moved from core.c
to its driver probe,remove. pdev member has to be maintained by its own drivers.

RFBI platform driver is registered from inside omap_dss_probe, in the order desired.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/core.c |    9 ++--
 drivers/video/omap2/dss/dss.h  |    8 ++--
 drivers/video/omap2/dss/rfbi.c |  110 ++++++++++++++++++++++++----------------
 3 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index b146bd8..751381b 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -200,9 +200,10 @@ static int omap_dss_probe(struct platform_device *pdev)
 
         dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M
                         | DSS_CLK_FCK2);
-	r = rfbi_init();
+
+	r = rfbi_init_platform_driver();
 	if (r) {
-		DSSERR("Failed to initialize rfbi\n");
+		DSSERR("Failed to initialize rfbi platform driver\n");
 		goto err_rfbi;
 	}
 
@@ -285,7 +286,7 @@ err_venc:
 err_dispc:
 	dpi_exit();
 err_dpi:
-	rfbi_exit();
+	rfbi_deinit_platform_driver();
 err_rfbi:
 	dss_deinit_platform_driver();
 err_dss:
@@ -303,7 +304,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 	venc_exit();
 	dispc_exit();
 	dpi_exit();
-	rfbi_exit();
+	rfbi_deinit_platform_driver();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
 		sdi_exit();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7c6bff5..665ad58 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -421,8 +421,8 @@ static inline void venc_exit(void)
 
 /* RFBI */
 #ifdef CONFIG_OMAP2_DSS_RFBI
-int rfbi_init(void);
-void rfbi_exit(void);
+int rfbi_init_platform_driver(void);
+void rfbi_deinit_platform_driver(void);
 void rfbi_dump_regs(struct seq_file *s);
 
 int rfbi_configure(int rfbi_module, int bpp, int lines);
@@ -433,11 +433,11 @@ void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
 #else
-static inline int rfbi_init(void)
+static inline int rfbi_init_platform_driver(void)
 {
 	return 0;
 }
-static inline void rfbi_exit(void)
+static inline void rfbi_deinit_platform_driver(void)
 {
 }
 #endif
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index bbe6246..52bfb1c 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -100,6 +100,7 @@ static int rfbi_convert_timings(struct rfbi_timings *t);
 static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	unsigned long	l4_khz;
@@ -957,50 +958,6 @@ void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-int rfbi_init(void)
-{
-	u32 rev;
-	u32 l;
-
-	spin_lock_init(&rfbi.cmd_lock);
-
-	init_completion(&rfbi.cmd_done);
-	atomic_set(&rfbi.cmd_fifo_full, 0);
-	atomic_set(&rfbi.cmd_pending, 0);
-
-	rfbi.base = ioremap(RFBI_BASE, SZ_256);
-	if (!rfbi.base) {
-		DSSERR("can't ioremap RFBI\n");
-		return -ENOMEM;
-	}
-
-	rfbi_enable_clocks(1);
-
-	msleep(10);
-
-	rfbi.l4_khz = dss_clk_get_rate(DSS_CLK_ICK) / 1000;
-
-	/* Enable autoidle and smart-idle */
-	l = rfbi_read_reg(RFBI_SYSCONFIG);
-	l |= (1 << 0) | (2 << 3);
-	rfbi_write_reg(RFBI_SYSCONFIG, l);
-
-	rev = rfbi_read_reg(RFBI_REVISION);
-	printk(KERN_INFO "OMAP RFBI rev %d.%d\n",
-	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
-
-	rfbi_enable_clocks(0);
-
-	return 0;
-}
-
-void rfbi_exit(void)
-{
-	DSSDBG("rfbi_exit\n");
-
-	iounmap(rfbi.base);
-}
-
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -1054,3 +1011,68 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	return 0;
 }
+
+/* RFBI HW IP initialisation */
+static int omap_rfbihw_probe(struct platform_device *pdev)
+{
+	u32 rev;
+	u32 l;
+
+	rfbi.pdev = pdev;
+
+	spin_lock_init(&rfbi.cmd_lock);
+
+	init_completion(&rfbi.cmd_done);
+	atomic_set(&rfbi.cmd_fifo_full, 0);
+	atomic_set(&rfbi.cmd_pending, 0);
+
+	rfbi.base = ioremap(RFBI_BASE, SZ_256);
+	if (!rfbi.base) {
+		DSSERR("can't ioremap RFBI\n");
+		return -ENOMEM;
+	}
+
+	rfbi_enable_clocks(1);
+
+	msleep(10);
+
+	rfbi.l4_khz = dss_clk_get_rate(DSS_CLK_ICK) / 1000;
+
+	/* Enable autoidle and smart-idle */
+	l = rfbi_read_reg(RFBI_SYSCONFIG);
+	l |= (1 << 0) | (2 << 3);
+	rfbi_write_reg(RFBI_SYSCONFIG, l);
+
+	rev = rfbi_read_reg(RFBI_REVISION);
+	printk(KERN_INFO "OMAP RFBI rev %d.%d\n",
+	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
+
+	rfbi_enable_clocks(0);
+
+	return 0;
+}
+
+static int omap_rfbihw_remove(struct platform_device *pdev)
+{
+	iounmap(rfbi.base);
+	return 0;
+}
+
+static struct platform_driver omap_rfbihw_driver = {
+	.probe          = omap_rfbihw_probe,
+	.remove         = omap_rfbihw_remove,
+	.driver         = {
+		.name   = "omap_rfbi",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int rfbi_init_platform_driver(void)
+{
+	return platform_driver_register(&omap_rfbihw_driver);
+}
+
+void rfbi_deinit_platform_driver(void)
+{
+	return platform_driver_unregister(&omap_rfbihw_driver);
+}
-- 
1.7.0.4

