From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAP: DSS2: Delay regulator_get() calls
Date: Wed, 23 Feb 2011 15:08:04 +0200
Message-ID: <1298466484-19324-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53604 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080Ab1BWNIR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 08:08:17 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ND8Gbd024453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 07:08:16 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ND8GSa006205
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 07:08:16 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ND8GxQ028229
	for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 07:08:16 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS submodules DPI/SDI/DSI/VENC require a regulator to function.
However, if the board doesn't use, say, SDI, the board shouldn't need to
configure vdds_sdi regulator required by the SDI module.

Currently the regulators are acquired when the DSS driver is loaded.
This means that if the kernel is configured with SDI, vdds_sdi regulator
is needed for all boards.

This patch changes the DSS driver to acquire the regulators only when a
display of particular type is initialized. For example, vdds_sdi is
acquired when sdi_init_display() is called.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |   21 +++++++++++++--------
 drivers/video/omap2/dss/dsi.c  |   36 +++++++++++++-----------------------
 drivers/video/omap2/dss/sdi.c  |   18 +++++++++++++-----
 drivers/video/omap2/dss/venc.c |   31 +++++++++++++------------------
 4 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 746f1b6..026702b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -303,22 +303,27 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	return 0;
-}
+	if (cpu_is_omap34xx() && dpi.vdds_dsi_reg == NULL) {
+		struct regulator *vdds_dsi;
 
-int dpi_init(struct platform_device *pdev)
-{
-	if (cpu_is_omap34xx()) {
-		dpi.vdds_dsi_reg = dss_get_vdds_dsi();
-		if (IS_ERR(dpi.vdds_dsi_reg)) {
+		vdds_dsi = dss_get_vdds_dsi();
+
+		if (IS_ERR(vdds_dsi)) {
 			DSSERR("can't get VDDS_DSI regulator\n");
-			return PTR_ERR(dpi.vdds_dsi_reg);
+			return PTR_ERR(vdds_dsi);
 		}
+
+		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
 	return 0;
 }
 
+int dpi_init(struct platform_device *pdev)
+{
+	return 0;
+}
+
 void dpi_exit(void)
 {
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e189e45..0207065 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -291,20 +291,6 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
 	return __raw_readl(dsi.base + idx.idx);
 }
 
-static struct regulator *dsi_get_vdds_dsi(void)
-{
-	struct regulator *reg;
-
-	if (dsi.vdds_dsi_reg != NULL)
-		return dsi.vdds_dsi_reg;
-
-	reg = regulator_get(&dsi.pdev->dev, "vdds_dsi");
-	if (!IS_ERR(reg))
-		dsi.vdds_dsi_reg = reg;
-
-	return reg;
-}
-
 
 void dsi_save_context(void)
 {
@@ -3236,6 +3222,19 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dsi.vc[0].dssdev = dssdev;
 	dsi.vc[1].dssdev = dssdev;
 
+	if (dsi.vdds_dsi_reg == NULL) {
+		struct regulator *vdds_dsi;
+
+		vdds_dsi = regulator_get(&dsi.pdev->dev, "vdds_dsi");
+
+		if (IS_ERR(vdds_dsi)) {
+			DSSERR("can't get VDDS_DSI regulator\n");
+			return PTR_ERR(vdds_dsi);
+		}
+
+		dsi.vdds_dsi_reg = vdds_dsi;
+	}
+
 	return 0;
 }
 
@@ -3295,13 +3294,6 @@ static int dsi_init(struct platform_device *pdev)
 		goto err1;
 	}
 
-	dsi.vdds_dsi_reg = dsi_get_vdds_dsi();
-	if (IS_ERR(dsi.vdds_dsi_reg)) {
-		DSSERR("can't get VDDS_DSI regulator\n");
-		r = PTR_ERR(dsi.vdds_dsi_reg);
-		goto err2;
-	}
-
 	enable_clocks(1);
 
 	rev = dsi_read_reg(DSI_REVISION);
@@ -3311,8 +3303,6 @@ static int dsi_init(struct platform_device *pdev)
 	enable_clocks(0);
 
 	return 0;
-err2:
-	iounmap(dsi.base);
 err1:
 	destroy_workqueue(dsi.workqueue);
 	return r;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 8272fc1..9f10a0d 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -157,6 +157,19 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
+	if (sdi.vdds_sdi_reg == NULL) {
+		struct regulator *vdds_sdi;
+
+		vdds_sdi = dss_get_vdds_sdi();
+
+		if (IS_ERR(vdds_sdi)) {
+			DSSERR("can't get VDDS_SDI regulator\n");
+			return PTR_ERR(vdds_sdi);
+		}
+
+		sdi.vdds_sdi_reg = vdds_sdi;
+	}
+
 	return 0;
 }
 
@@ -165,11 +178,6 @@ int sdi_init(bool skip_init)
 	/* we store this for first display enable, then clear it */
 	sdi.skip_init = skip_init;
 
-	sdi.vdds_sdi_reg = dss_get_vdds_sdi();
-	if (IS_ERR(sdi.vdds_sdi_reg)) {
-		DSSERR("can't get VDDS_SDI regulator\n");
-		return PTR_ERR(sdi.vdds_sdi_reg);
-	}
 	/*
 	 * Enable clocks already here, otherwise there would be a toggle
 	 * of them until sdi_display_enable is called.
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2adae12..9cfcc36 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -305,17 +305,6 @@ static inline u32 venc_read_reg(int idx)
 	return l;
 }
 
-static struct regulator *venc_get_vdda_dac(void)
-{
-	struct regulator *reg;
-
-	reg = regulator_get(&venc.pdev->dev, "vdda_dac");
-	if (!IS_ERR(reg))
-		venc.vdda_dac_reg = reg;
-
-	return reg;
-}
-
 static void venc_write_config(const struct venc_config *config)
 {
 	DSSDBG("write venc conf\n");
@@ -655,6 +644,19 @@ int venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
+	if (venc.vdda_dac_reg == NULL) {
+		struct regulator *vdda_dac;
+
+		vdda_dac = regulator_get(&venc.pdev->dev, "vdda_dac");
+
+		if (IS_ERR(vdda_dac)) {
+			DSSERR("can't get VDDA_DAC regulator\n");
+			return PTR_ERR(vdda_dac);
+		}
+
+		venc.vdda_dac_reg = vdda_dac;
+	}
+
 	return 0;
 }
 
@@ -734,13 +736,6 @@ static int omap_venchw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	venc.vdda_dac_reg = venc_get_vdda_dac();
-	if (IS_ERR(venc.vdda_dac_reg)) {
-		iounmap(venc.base);
-		DSSERR("can't get VDDA_DAC regulator\n");
-		return PTR_ERR(venc.vdda_dac_reg);
-	}
-
 	venc_enable_clocks(1);
 
 	rev_id = (u8)(venc_read_reg(VENC_REV_ID) & 0xff);
-- 
1.7.1

