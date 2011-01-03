From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 15/17] OMAP2,3: DSS2: DSI Move init, exit to driver
Date: Mon,  3 Jan 2011 18:21:07 +0530
Message-ID: <1294059069-26737-16-git-send-email-svadivu@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab1ACMv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 07:51:27 -0500
In-Reply-To: <1294059069-26737-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

For hwmod adaptation, move init exit methods from core.c to its driver probe,
remove.  pdev member has to be maintained by its own drivers.  Regulator has
to be privately handled in each driver.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 +
 drivers/video/omap2/dss/core.c      |    8 --------
 drivers/video/omap2/dss/dsi.c       |   29 ++++++++++++++++++++++++++---
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 83baba7..88f5b01 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -527,6 +527,7 @@ static struct regulator_init_data sdp3430_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omap_display"),
+	REGULATOR_SUPPLY("vdds_dsi", "omap_dsi1"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 6f9fc38..21944d7 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -190,11 +190,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 			goto err_sdi;
 		}
 
-		r = dsi_init(pdev);
-		if (r) {
-			DSSERR("Failed to initialize DSI\n");
-			goto err_dsi;
-		}
 	}
 
 	r = dss_initialize_debugfs();
@@ -227,9 +222,6 @@ err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
 	if (cpu_is_omap34xx())
-		dsi_exit();
-err_dsi:
-	if (cpu_is_omap34xx())
 		sdi_exit();
 err_sdi:
 	dpi_exit();
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 037d366..b592075 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -222,6 +222,7 @@ struct dsi_irq_stats {
 
 static struct
 {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	struct dsi_clock_info current_cinfo;
@@ -277,6 +278,20 @@ static struct
 #endif
 } dsi;
 
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
 #ifdef DEBUG
 static unsigned int dsi_perf;
 module_param_named(dsi_perf, dsi_perf, bool, 0644);
@@ -3271,7 +3286,7 @@ int dsi_init(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
+	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		r = PTR_ERR(dsi.vdds_dsi_reg);
@@ -3306,11 +3321,20 @@ void dsi_exit(void)
 /* DSI1 HW IP initialisation */
 static int omap_dsi1hw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	dsi.pdev = pdev;
+	r = dsi_init(pdev);
+	if (r) {
+		DSSERR("Failed to initialize DSI\n");
+		goto err_dsi;
+	}
+err_dsi:
+	return r;
 }
 
 static int omap_dsi1hw_remove(struct platform_device *pdev)
 {
+	dsi_exit();
 	return 0;
 }
 
@@ -3330,4 +3354,3 @@ static int __init omap_dsi1_init(void)
 
 device_initcall(omap_dsi1_init);
 
-
-- 
1.6.3.3

