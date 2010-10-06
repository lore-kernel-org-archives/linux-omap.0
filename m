From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 14/16] OMAP3: hwmod DSS: DSI Move init, exit to driver
Date: Wed,  6 Oct 2010 16:44:57 +0530
Message-ID: <1286363699-9614-15-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
 <1286363699-9614-9-git-send-email-svadivu@ti.com>
 <1286363699-9614-10-git-send-email-svadivu@ti.com>
 <1286363699-9614-11-git-send-email-svadivu@ti.com>
 <1286363699-9614-12-git-send-email-svadivu@ti.com>
 <1286363699-9614-13-git-send-email-svadivu@ti.com>
 <1286363699-9614-14-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60276 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758893Ab0JFLP2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:28 -0400
In-Reply-To: <1286363699-9614-14-git-send-email-svadivu@ti.com>
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
index edcfaff..fc27cd5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -528,6 +528,7 @@ static struct regulator_init_data sdp3430_vdac = {
 /* VPLL2 for digital video outputs */
 static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
 	REGULATOR_SUPPLY("vdds_dsi", "omapdisplay"),
+	REGULATOR_SUPPLY("vdds_dsi", "dss_dsi1"),
 };
 
 static struct regulator_init_data sdp3430_vpll2 = {
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index df74116..d44ed6c 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -191,11 +191,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 			goto err_sdi;
 		}
 
-		r = dsi_init(pdev);
-		if (r) {
-			DSSERR("Failed to initialize DSI\n");
-			goto err_dsi;
-		}
 	}
 
 	r = dss_initialize_debugfs();
@@ -228,9 +223,6 @@ err_register:
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
index fd49663..092d7fe 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -222,6 +222,7 @@ struct dsi_irq_stats {
 
 static struct
 {
+	struct platform_device *pdev;
 	void __iomem	*base;
 
 	struct dsi_clock_info current_cinfo;
@@ -295,11 +296,20 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
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
 
@@ -312,6 +322,20 @@ static struct platform_driver omap_dsi1hw_driver = {
 	},
 };
 
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
@@ -3292,7 +3316,7 @@ int dsi_init(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dsi.vdds_dsi_reg = dss_get_vdds_dsi();
+	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
 	if (IS_ERR(dsi.vdds_dsi_reg)) {
 		iounmap(dsi.base);
 		DSSERR("can't get VDDS_DSI regulator\n");
-- 
1.6.3.3

