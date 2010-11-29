From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 15/17] OMAP2,3: DSS: DSI Move init, exit to driver
Date: Mon, 29 Nov 2010 17:21:41 +0530
Message-ID: <1291031503-21036-16-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab0K2LwA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 06:52:00 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe, remove.
pdev member has to be maintained by its own drivers.
regulator has to be privately handled in each driver.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    1 +
 drivers/video/omap2/dss/core.c      |    8 --------
 drivers/video/omap2/dss/dsi.c       |   28 ++++++++++++++++++++++++++--
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2e3c68b..2c3ddd8 100644
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
index 037d366..a8f3335 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -222,6 +222,7 @@ struct dsi_irq_stats {
 
 static struct
 {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	struct dsi_clock_info current_cinfo;
@@ -3271,7 +3272,7 @@ int dsi_init(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
+	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
 		DSSERR("can't get VDDS_DSI regulator\n");
 		r = PTR_ERR(dsi.vdds_dsi_reg);
@@ -3306,11 +3307,20 @@ void dsi_exit(void)
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
 
@@ -3330,4 +3340,18 @@ static int __init omap_dsi1_init(void)
 
 device_initcall(omap_dsi1_init);
 
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
 
-- 
1.6.3.3

