From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 12/20] Move venc init to venc probe
Date: Mon, 23 Aug 2010 21:28:01 +0530
Message-ID: <1282579089-10487-13-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com>
 <1282579089-10487-12-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238Ab0HWP6Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Aug 2010 11:58:25 -0400
In-Reply-To: <1282579089-10487-12-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

VENC init and exit moved to venc probe and remove.
regulator used by venc is moved to venc driver alone.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 drivers/video/omap2/dss/core.c      |   40 +++++++++-------------------------
 drivers/video/omap2/dss/venc.c      |   19 ++++++++++++++++
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9b721a4..cb66d65 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -302,7 +302,7 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 };
 
 static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+	REGULATOR_SUPPLY("vdda_dac", "dss_venc");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index a72d2fa..df0cfea 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,7 +43,6 @@ static struct {
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
-	struct regulator *vdda_dac_reg;
 	struct omap_dss_board_info *pdata;
 } core;
 
@@ -90,19 +89,6 @@ struct regulator *dss_get_vdds_sdi(void)
 	return reg;
 }
 
-struct regulator *dss_get_vdda_dac(void)
-{
-	struct regulator *reg;
-
-	if (core.vdda_dac_reg != NULL)
-		return core.vdda_dac_reg;
-
-	reg = regulator_get(&core.pdev->dev, "vdda_dac");
-	if (!IS_ERR(reg))
-		core.vdda_dac_reg = reg;
-
-	return reg;
-}
 
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
@@ -205,12 +191,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_dpi;
 	}
 
-	r = venc_init(pdev);
-	if (r) {
-		DSSERR("Failed to initialize venc\n");
-		goto err_venc;
-	}
-
 	if (cpu_is_omap34xx()) {
 		r = sdi_init(skip_init);
 		if (r) {
@@ -260,8 +240,6 @@ err_dsi:
 	if (cpu_is_omap34xx())
 		sdi_exit();
 err_sdi:
-	venc_exit();
-err_venc:
 	dpi_exit();
 err_dpi:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
@@ -277,7 +255,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	venc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
@@ -370,11 +347,21 @@ static int omap_rfbihw_remove(struct platform_device *pdev)
 /* VENC HW IP initialisation */
 static int omap_venchw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	r = venc_init(pdev);
+	if (r) {
+		DSSERR("Failed to initialize venc\n");
+		goto err_venc;
+	}
+err_venc:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	return r;
 }
 
 static int omap_venchw_remove(struct platform_device *pdev)
 {
+	venc_exit();
 	return 0;
 }
 
@@ -684,11 +671,6 @@ static void __exit omap_dss_exit(void)
 		core.vdds_sdi_reg = NULL;
 	}
 
-	if (core.vdda_dac_reg != NULL) {
-		regulator_put(core.vdda_dac_reg);
-		core.vdda_dac_reg = NULL;
-	}
-
 	platform_driver_unregister(&omap_dss_driver);
 
 	omap_dss_bus_unregister();
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index eff3505..576f0df 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -293,6 +293,7 @@ static struct {
 	struct mutex venc_lock;
 	u32 wss_data;
 	struct regulator *vdda_dac_reg;
+	struct platform_device *pdev;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -641,7 +642,19 @@ static struct omap_dss_driver venc_driver = {
 };
 /* driver end */
 
+struct regulator *dss_get_vdda_dac(void)
+{
+	struct regulator *reg;
+
+	if (venc.vdda_dac_reg != NULL)
+		return venc.vdda_dac_reg;
+
+	reg = regulator_get(&venc.pdev->dev, "vdda_dac");
+	if (!IS_ERR(reg))
+		venc.vdda_dac_reg = reg;
 
+	return reg;
+}
 
 int venc_init(struct platform_device *pdev)
 {
@@ -649,6 +662,7 @@ int venc_init(struct platform_device *pdev)
 
 	mutex_init(&venc.venc_lock);
 
+	venc.pdev = pdev;
 	venc.wss_data = 0;
 
 	venc.base = ioremap(VENC_BASE, SZ_1K);
@@ -676,6 +690,11 @@ int venc_init(struct platform_device *pdev)
 
 void venc_exit(void)
 {
+	if (venc.vdda_dac_reg != NULL) {
+		regulator_put(venc.vdda_dac_reg);
+		venc.vdda_dac_reg = NULL;
+	}
+
 	omap_dss_unregister_driver(&venc_driver);
 
 	iounmap(venc.base);
-- 
1.6.3.3

