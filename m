From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/25] OMAPDSS: separate pdata based initialization
Date: Thu,  3 May 2012 16:58:01 +0300
Message-ID: <1336053481-25433-26-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:55470 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756461Ab2ECN7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:59:07 -0400
Received: by lagu2 with SMTP id u2so1700604lag.35
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:59 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move the platform-data based display device initialization into a
separate function, so that we may later add of-based initialization.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    7 +++++-
 drivers/video/omap2/dss/dsi.c  |   50 +++++++++++++++++++++++-----------------
 drivers/video/omap2/dss/hdmi.c |   46 +++++++++++++++++++++---------------
 drivers/video/omap2/dss/rfbi.c |   45 +++++++++++++++++++++---------------
 drivers/video/omap2/dss/sdi.c  |    7 +++++-
 drivers/video/omap2/dss/venc.c |   45 +++++++++++++++++++++---------------
 6 files changed, 120 insertions(+), 80 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 4f8defe..835e106 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -364,7 +364,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int __init omap_dpi_probe(struct platform_device *pdev)
+static void __init dpi_probe_pdata(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int i, r;
@@ -386,6 +386,11 @@ static int __init omap_dpi_probe(struct platform_device *pdev)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
 	}
+}
+
+static int __init omap_dpi_probe(struct platform_device *pdev)
+{
+	dpi_probe_pdata(pdev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ce964dd..429d918 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4607,6 +4607,34 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 		clk_put(dsi->sys_clk);
 }
 
+static void __init dsi_probe_pdata(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct omap_dss_board_info *pdata = dsidev->dev.platform_data;
+	int i, r;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_DSI)
+			continue;
+
+		if (dssdev->phy.dsi.module != dsi->module_id)
+			continue;
+
+		r = dsi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
+		r = omap_dss_register_device(dssdev, &dsidev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+}
+
 /* DSI1 HW IP initialisation */
 static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
@@ -4614,7 +4642,6 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	int r, i;
 	struct resource *dsi_mem;
 	struct dsi_data *dsi;
-	struct omap_dss_board_info *pdata = dsidev->dev.platform_data;
 
 	dsi = devm_kzalloc(&dsidev->dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
@@ -4702,26 +4729,7 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else
 		dsi->num_lanes_supported = 3;
 
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		if (dssdev->type != OMAP_DISPLAY_TYPE_DSI)
-			continue;
-
-		if (dssdev->phy.dsi.module != dsi->module_id)
-			continue;
-
-		r = dsi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
-		}
-
-		r = omap_dss_register_device(dssdev, &dsidev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-				dssdev->name, r);
-	}
+	dsi_probe_pdata(dsidev);
 
 	dsi_runtime_put(dsidev);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 8b3ac6e..1b06df2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -769,12 +769,36 @@ static void hdmi_put_clocks(void)
 		clk_put(hdmi.sys_clk);
 }
 
+static void __init hdmi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int r, i;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+		struct omap_dss_hdmi_data *priv = dssdev->data;
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
+			continue;
+
+		r = hdmi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+}
+
 /* HDMI HW IP initialisation */
 static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	struct resource *hdmi_mem;
-	int r, i;
+	int r;
 
 	hdmi.pdev = pdev;
 
@@ -811,23 +835,7 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
-			continue;
-
-		r = hdmi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
-		}
-
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
-	}
+	hdmi_probe_pdata(pdev);
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a5d38a3..8ea266f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -927,14 +927,37 @@ static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static void __init rfbi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int i, r;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_DBI)
+			continue;
+
+		r = rfbi_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+				dssdev->name, r);
+	}
+}
+
 /* RFBI HW IP initialisation */
 static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	u32 rev;
 	struct resource *rfbi_mem;
 	struct clk *clk;
-	int r, i;
+	int r;
 
 	rfbi.pdev = pdev;
 
@@ -979,23 +1002,7 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
 
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		if (dssdev->type != OMAP_DISPLAY_TYPE_DBI)
-			continue;
-
-		r = rfbi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
-		}
-
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-				dssdev->name, r);
-	}
+	rfbi_probe_pdata(pdev);
 
 	return 0;
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d0785b..c322335 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -176,7 +176,7 @@ static int __init sdi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static int __init omap_sdi_probe(struct platform_device *pdev)
+static void __init sdi_probe_pdata(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int i, r;
@@ -198,6 +198,11 @@ static int __init omap_sdi_probe(struct platform_device *pdev)
 			DSSERR("device %s register failed: %d\n",
 					dssdev->name, r);
 	}
+}
+
+static int __init omap_sdi_probe(struct platform_device *pdev)
+{
+	sdi_probe_pdata(pdev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4d3128a..2c0747b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -777,13 +777,36 @@ static void venc_put_clocks(void)
 		clk_put(venc.tv_dac_clk);
 }
 
+static void __init venc_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int r, i;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_VENC)
+			continue;
+
+		r = venc_init_display(dssdev);
+		if (r) {
+			DSSERR("device %s init failed: %d\n", dssdev->name, r);
+			continue;
+		}
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+}
+
 /* VENC HW IP initialisation */
 static int __init omap_venchw_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	u8 rev_id;
 	struct resource *venc_mem;
-	int r, i;
+	int r;
 
 	venc.pdev = pdev;
 
@@ -825,23 +848,7 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		if (dssdev->type != OMAP_DISPLAY_TYPE_VENC)
-			continue;
-
-		r = venc_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
-		}
-
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
-	}
+	venc_probe_pdata(pdev);
 
 	return 0;
 
-- 
1.7.9.5

