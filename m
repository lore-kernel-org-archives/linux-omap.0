From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 13/16] OMAP3: hwmod DSS: VENC Move init,exit to driver
Date: Wed,  6 Oct 2010 16:44:56 +0530
Message-ID: <1286363699-9614-14-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758772Ab0JFLPZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:25 -0400
In-Reply-To: <1286363699-9614-13-git-send-email-svadivu@ti.com>
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
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 drivers/video/omap2/dss/core.c      |   29 ---------------
 drivers/video/omap2/dss/venc.c      |   69 +++++++++++++++++++++++++----------
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 62b6523..edcfaff 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -303,7 +303,7 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 };
 
 static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omapdisplay");
+	REGULATOR_SUPPLY("vdda_dac", "dss_venc");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9652ed7..df74116 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,7 +43,6 @@ static struct {
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
-	struct regulator *vdda_dac_reg;
 } core;
 
 
@@ -86,20 +85,6 @@ struct regulator *dss_get_vdds_sdi(void)
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
-
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 static int dss_debug_show(struct seq_file *s, void *unused)
 {
@@ -199,12 +184,6 @@ static int omap_dss_probe(struct platform_device *pdev)
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
@@ -254,8 +233,6 @@ err_dsi:
 	if (cpu_is_omap34xx())
 		sdi_exit();
 err_sdi:
-	venc_exit();
-err_venc:
 	dpi_exit();
 err_dpi:
 
@@ -269,7 +246,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	venc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
@@ -562,11 +538,6 @@ static void __exit omap_dss_exit(void)
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
index ec17b28..3a121cb 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -87,26 +87,6 @@
 #define VENC_OUTPUT_TEST			0xC8
 #define VENC_DAC_B__DAC_C			0xC8
 
-/* VENC HW IP initialisation */
-static int omap_venchw_probe(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int omap_venchw_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static struct platform_driver omap_venchw_driver = {
-	.probe          = omap_venchw_probe,
-	.remove         = omap_venchw_remove,
-	.driver         = {
-		.name   = "dss_venc",
-		.owner  = THIS_MODULE,
-	},
-};
-
 struct venc_config {
 	u32 f_control;
 	u32 vidout_ctrl;
@@ -309,6 +289,7 @@ const struct omap_video_timings omap_dss_ntsc_timings = {
 EXPORT_SYMBOL(omap_dss_ntsc_timings);
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct mutex venc_lock;
 	u32 wss_data;
@@ -326,6 +307,37 @@ static inline u32 venc_read_reg(int idx)
 	return l;
 }
 
+/* VENC HW IP initialisation */
+static int omap_venchw_probe(struct platform_device *pdev)
+{
+	int r;
+	venc.pdev = pdev;
+
+	r = venc_init(pdev);
+	if (r) {
+		DSSERR("Failed to initialize venc\n");
+		goto err_venc;
+	}
+
+err_venc:
+	return r;
+}
+
+static int omap_venchw_remove(struct platform_device *pdev)
+{
+	venc_exit();
+	return 0;
+}
+
+static struct platform_driver omap_venchw_driver = {
+	.probe          = omap_venchw_probe,
+	.remove         = omap_venchw_remove,
+	.driver         = {
+		.name   = "dss_venc",
+		.owner  = THIS_MODULE,
+	},
+};
+
 static void venc_write_config(const struct venc_config *config)
 {
 	DSSDBG("write venc conf\n");
@@ -661,7 +673,19 @@ static struct omap_dss_driver venc_driver = {
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
@@ -696,6 +720,11 @@ int venc_init(struct platform_device *pdev)
 
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

