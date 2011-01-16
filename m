From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v7 15/18] OMAP2,3: DSS2: DSI: create platform_driver, move init,exit to driver
Date: Sun, 16 Jan 2011 22:11:40 +0530
Message-ID: <1295196103-29417-16-git-send-email-sumit.semwal@ti.com>
References: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34863 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1APQo1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jan 2011 11:44:27 -0500
In-Reply-To: <1295196103-29417-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Hwmod adaptation design requires each of the DSS HW IP to be a platform driver.
So a platform_driver for DSI is created and init exit methods are moved from core.c
to its driver probe,remove. pdev member has to be maintained by its own drivers.

Also, vdds_dsi regulator handling is copied to dsi.c.

DSI platform driver is registered from inside omap_dss_probe, in the order desired.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 +
 drivers/video/omap2/dss/core.c      |    8 ++--
 drivers/video/omap2/dss/dsi.c       |   64 +++++++++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss.h       |    8 ++--
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e0d13ae..33ff4f6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -533,6 +533,7 @@ static struct regulator_init_data sdp3430_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omap_display"),
+	REGULATOR_SUPPLY("vdds_dsi", "omap_dsi1"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9852a70..85add9c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -222,9 +222,9 @@ static int omap_dss_probe(struct platform_device *pdev)
 			goto err_sdi;
 		}
 
-		r = dsi_init(pdev);
+		r = dsi_init_platform_driver();
 		if (r) {
-			DSSERR("Failed to initialize DSI\n");
+			DSSERR("Failed to initialize DSI platform driver\n");
 			goto err_dsi;
 		}
 	}
@@ -259,7 +259,7 @@ err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
 	if (cpu_is_omap34xx())
-		dsi_exit();
+		dsi_uninit_platform_driver();
 err_dsi:
 	if (cpu_is_omap34xx())
 		sdi_exit();
@@ -290,7 +290,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dpi_exit();
 	rfbi_uninit_platform_driver();
 	if (cpu_is_omap34xx()) {
-		dsi_exit();
+		dsi_uninit_platform_driver();
 		sdi_exit();
 	}
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ddf3a05..d854137 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -222,6 +222,7 @@ struct dsi_irq_stats {
 
 static struct
 {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	struct dsi_clock_info current_cinfo;
@@ -292,6 +293,20 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
 	return __raw_readl(dsi.base + idx.idx);
 }
 
+static struct regulator *dsi_get_vdds_dsi(void)
+{
+	struct regulator *reg;
+
+	if (dsi.vdds_dsi_reg != NULL)
+		return dsi.vdds_dsi_reg;
+
+	reg = regulator_get(&dsi.pdev->dev, "vdds_dsi");
+	if (!IS_ERR(reg))
+		dsi.vdds_dsi_reg = reg;
+
+	return reg;
+}
+
 
 void dsi_save_context(void)
 {
@@ -3238,7 +3253,7 @@ void dsi_wait_dsi2_pll_active(void)
 		DSSERR("DSI2 PLL clock not active\n");
 }
 
-int dsi_init(struct platform_device *pdev)
+static int dsi_init(struct platform_device *pdev)
 {
 	u32 rev;
 	int r;
@@ -3275,7 +3290,7 @@ int dsi_init(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
+	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		r = PTR_ERR(dsi.vdds_dsi_reg);
@@ -3298,8 +3313,13 @@ err1:
 	return r;
 }
 
-void dsi_exit(void)
+static void dsi_exit(void)
 {
+	if (dsi.vdds_dsi_reg != NULL) {
+		regulator_put(dsi.vdds_dsi_reg);
+		dsi.vdds_dsi_reg = NULL;
+	}
+
 	iounmap(dsi.base);
 
 	destroy_workqueue(dsi.workqueue);
@@ -3307,3 +3327,41 @@ void dsi_exit(void)
 	DSSDBG("omap_dsi_exit\n");
 }
 
+/* DSI1 HW IP initialisation */
+static int omap_dsi1hw_probe(struct platform_device *pdev)
+{
+	int r;
+	dsi.pdev = pdev;
+	r = dsi_init(pdev);
+	if (r) {
+		DSSERR("Failed to initialize DSI\n");
+		goto err_dsi;
+	}
+err_dsi:
+	return r;
+}
+
+static int omap_dsi1hw_remove(struct platform_device *pdev)
+{
+	dsi_exit();
+	return 0;
+}
+
+static struct platform_driver omap_dsi1hw_driver = {
+	.probe          = omap_dsi1hw_probe,
+	.remove         = omap_dsi1hw_remove,
+	.driver         = {
+		.name   = "omap_dsi1",
+		.owner  = THIS_MODULE,
+	},
+};
+
+int dsi_init_platform_driver(void)
+{
+	return platform_driver_register(&omap_dsi1hw_driver);
+}
+
+void dsi_uninit_platform_driver(void)
+{
+	return platform_driver_unregister(&omap_dsi1hw_driver);
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9313851..981d247 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -261,8 +261,8 @@ static inline void sdi_exit(void)
 
 /* DSI */
 #ifdef CONFIG_OMAP2_DSS_DSI
-int dsi_init(struct platform_device *pdev);
-void dsi_exit(void);
+int dsi_init_platform_driver(void);
+void dsi_uninit_platform_driver(void);
 
 void dsi_dump_clocks(struct seq_file *s);
 void dsi_dump_irqs(struct seq_file *s);
@@ -287,11 +287,11 @@ void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 void dsi_wait_dsi1_pll_active(void);
 void dsi_wait_dsi2_pll_active(void);
 #else
-static inline int dsi_init(struct platform_device *pdev)
+static inline int dsi_init_platform_driver(void)
 {
 	return 0;
 }
-static inline void dsi_exit(void)
+static inline void dsi_uninit_platform_driver(void)
 {
 }
 static inline void dsi_wait_dsi1_pll_active(void)
-- 
1.7.0.4

