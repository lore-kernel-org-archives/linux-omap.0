From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 14/17] OMAP2,3: DSS: VENC Move init,exit to driver
Date: Mon, 29 Nov 2010 17:21:40 +0530
Message-ID: <1291031503-21036-15-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab0K2Lv5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 06:51:57 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe, remove.
pdev member has to be maintained by its own drivers.
regulator has to be privately handled in each driver.
Replace printk to dev_dbg for boot time optimize.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 +-
 drivers/video/omap2/dss/core.c      |   29 -----------
 drivers/video/omap2/dss/dss.h       |    1 -
 drivers/video/omap2/dss/venc.c      |   88 ++++++++++++++++++----------------
 4 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7ff747e..2e3c68b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -302,7 +302,7 @@ static struct omap_dss_board_info sdp3430_dss_data = {
 };
 
 static struct regulator_consumer_supply sdp3430_vdda_dac_supply =
-	REGULATOR_SUPPLY("vdda_dac", "omap_display");
+	REGULATOR_SUPPLY("vdda_dac", "omap_venc");
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
 };
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 3711553..6f9fc38 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -43,7 +43,6 @@ static struct {
 
 	struct regulator *vdds_dsi_reg;
 	struct regulator *vdds_sdi_reg;
-	struct regulator *vdda_dac_reg;
 } core;
 
 static char *def_disp_name;
@@ -85,20 +84,6 @@ struct regulator *dss_get_vdds_sdi(void)
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
@@ -198,12 +183,6 @@ static int omap_dss_probe(struct platform_device *pdev)
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
@@ -253,8 +232,6 @@ err_dsi:
 	if (cpu_is_omap34xx())
 		sdi_exit();
 err_sdi:
-	venc_exit();
-err_venc:
 	dpi_exit();
 err_dpi:
 
@@ -268,7 +245,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	venc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
@@ -561,11 +537,6 @@ static void __exit omap_dss_exit(void)
 		core.vdds_sdi_reg = NULL;
 	}
 
-	if (core.vdda_dac_reg != NULL) {
-		regulator_put(core.vdda_dac_reg);
-		core.vdda_dac_reg = NULL;
-	}
-
 	platform_driver_unregister(&omap_dss_driver);
 
 	omap_dss_bus_unregister();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0029aff..734e052 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -172,7 +172,6 @@ struct platform_device;
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
-struct regulator *dss_get_vdda_dac(void);
 
 /* display */
 int dss_suspend_all_devices(void);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index ac63cee..4e84e71 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -289,6 +289,7 @@ const struct omap_video_timings omap_dss_ntsc_timings = {
 EXPORT_SYMBOL(omap_dss_ntsc_timings);
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct mutex venc_lock;
 	u32 wss_data;
@@ -306,6 +307,17 @@ static inline u32 venc_read_reg(int idx)
 	return l;
 }
 
+static struct regulator *venc_get_vdda_dac(void)
+{
+	struct regulator *reg;
+
+	reg = regulator_get(&venc.pdev->dev, "vdda_dac");
+	if (!IS_ERR(reg))
+		venc.vdda_dac_reg = reg;
+
+	return reg;
+}
+
 static void venc_write_config(const struct venc_config *config)
 {
 	DSSDBG("write venc conf\n");
@@ -641,46 +653,6 @@ static struct omap_dss_driver venc_driver = {
 };
 /* driver end */
 
-
-
-int venc_init(struct platform_device *pdev)
-{
-	u8 rev_id;
-
-	mutex_init(&venc.venc_lock);
-
-	venc.wss_data = 0;
-
-	venc.base = ioremap(VENC_BASE, SZ_1K);
-	if (!venc.base) {
-		DSSERR("can't ioremap VENC\n");
-		return -ENOMEM;
-	}
-
-	venc.vdda_dac_reg = dss_get_vdda_dac();
-	if (IS_ERR(venc.vdda_dac_reg)) {
-		iounmap(venc.base);
-		DSSERR("can't get VDDA_DAC regulator\n");
-		return PTR_ERR(venc.vdda_dac_reg);
-	}
-
-	venc_enable_clocks(1);
-
-	rev_id = (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
-	printk(KERN_INFO "OMAP VENC rev %d\n", rev_id);
-
-	venc_enable_clocks(0);
-
-	return omap_dss_register_driver(&venc_driver);
-}
-
-void venc_exit(void)
-{
-	omap_dss_unregister_driver(&venc_driver);
-
-	iounmap(venc.base);
-}
-
 int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
@@ -744,11 +716,45 @@ void venc_dump_regs(struct seq_file *s)
 /* VENC HW IP initialisation */
 static int omap_venchw_probe(struct platform_device *pdev)
 {
-	return 0;
+	u8 rev_id;
+	venc.pdev = pdev;
+
+	mutex_init(&venc.venc_lock);
+
+	venc.wss_data = 0;
+
+	venc.base = ioremap(VENC_BASE, SZ_1K);
+	if (!venc.base) {
+		DSSERR("can't ioremap VENC\n");
+		return -ENOMEM;
+	}
+
+	venc.vdda_dac_reg = venc_get_vdda_dac();
+	if (IS_ERR(venc.vdda_dac_reg)) {
+		iounmap(venc.base);
+		DSSERR("can't get VDDA_DAC regulator\n");
+		return PTR_ERR(venc.vdda_dac_reg);
+	}
+
+	venc_enable_clocks(1);
+
+	rev_id = (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
+	dev_dbg(&pdev->dev, "OMAP VENC rev %d\n", rev_id);
+
+	venc_enable_clocks(0);
+
+	return omap_dss_register_driver(&venc_driver);
 }
 
 static int omap_venchw_remove(struct platform_device *pdev)
 {
+	if (venc.vdda_dac_reg != NULL) {
+		regulator_put(venc.vdda_dac_reg);
+		venc.vdda_dac_reg = NULL;
+	}
+	omap_dss_unregister_driver(&venc_driver);
+
+	iounmap(venc.base);
 	return 0;
 }
 
-- 
1.6.3.3

