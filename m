From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/25] OMAPDSS: interface drivers register their panel devices
Date: Thu,  3 May 2012 16:57:57 +0300
Message-ID: <1336053481-25433-22-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:59639 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756303Ab2ECN6z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:55 -0400
Received: by lbok6 with SMTP id k6so1553116lbo.4
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:52 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently the higher level omapdss platform driver gets the list of
displays in its platform data, and uses that list to create the
omap_dss_device for each display.

With DT, the logical way to do the above is to list the displays under
each individual output, i.e. we'd have "dpi" node, under which we would
have the display that uses DPI. In other words, each output driver
handles the displays that use that particular output.

To make the current code ready for DT, this patch modifies the output
drivers so that each of them creates the display devices which use that
output. However, instead of changing the platform data to suit this
method, each output driver is passed the full list of displays, and the
drivers pick the displays that are meant for them. This allows us to
keep the old platform data, and thus we avoid the need to change the
board files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c  |    9 ++++----
 drivers/video/omap2/dss/core.c |   46 ++++++++++++++--------------------------
 drivers/video/omap2/dss/dpi.c  |   17 +++++++++++++++
 drivers/video/omap2/dss/dsi.c  |   18 ++++++++++++++++
 drivers/video/omap2/dss/dss.h  |    5 +++++
 drivers/video/omap2/dss/hdmi.c |   17 ++++++++++++++-
 drivers/video/omap2/dss/rfbi.c |   16 +++++++++++++-
 drivers/video/omap2/dss/sdi.c  |   17 +++++++++++++++
 drivers/video/omap2/dss/venc.c |   18 +++++++++++++++-
 9 files changed, 126 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 2c05a60..2c51809 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -325,7 +325,7 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 		pdev = create_dss_pdev(curr_dss_hwmod[i].dev_name,
 				curr_dss_hwmod[i].id,
 				curr_dss_hwmod[i].oh_name,
-				NULL, 0,
+				board_data, sizeof(*board_data),
 				dss_pdev);
 
 		if (IS_ERR(pdev)) {
@@ -341,15 +341,16 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 
 	/* Create devices for DPI and SDI */
 
-	pdev = create_simple_dss_pdev("omapdss_dpi", -1, NULL, 0, dss_pdev);
+	pdev = create_simple_dss_pdev("omapdss_dpi", -1,
+			board_data, sizeof(*board_data), dss_pdev);
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build platform_device for omapdss_dpi\n");
 		return PTR_ERR(pdev);
 	}
 
 	if (cpu_is_omap34xx()) {
-		pdev = create_simple_dss_pdev("omapdss_sdi", -1, NULL, 0,
-				dss_pdev);
+		pdev = create_simple_dss_pdev("omapdss_sdi", -1,
+				board_data, sizeof(*board_data), dss_pdev);
 		if (IS_ERR(pdev)) {
 			pr_err("Could not build platform_device for omapdss_sdi\n");
 			return PTR_ERR(pdev);
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index c3566a0..9915e9d 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -56,9 +56,6 @@ bool dss_debug;
 module_param_named(debug, dss_debug, bool, 0644);
 #endif
 
-static int omap_dss_register_device(struct omap_dss_device *);
-static void omap_dss_unregister_device(struct omap_dss_device *);
-
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
@@ -209,7 +206,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
-	int i;
 
 	core.pdev = pdev;
 
@@ -229,25 +225,8 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 	else if (pdata->default_device)
 		core.default_display_name = pdata->default_device->name;
 
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		r = omap_dss_register_device(dssdev);
-		if (r) {
-			DSSERR("device %d %s register failed %d\n", i,
-				dssdev->name ?: "unnamed", r);
-
-			while (--i >= 0)
-				omap_dss_unregister_device(pdata->devices[i]);
-
-			goto err_register;
-		}
-	}
-
 	return 0;
 
-err_register:
-	dss_uninitialize_debugfs();
 err_debugfs:
 
 	return r;
@@ -255,17 +234,11 @@ err_debugfs:
 
 static int omap_dss_remove(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int i;
-
 	dss_uninitialize_debugfs();
 
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
-	for (i = 0; i < pdata->num_devices; ++i)
-		omap_dss_unregister_device(pdata->devices[i]);
-
 	return 0;
 }
 
@@ -467,7 +440,8 @@ static void omap_dss_dev_release(struct device *dev)
 	reset_device(dev, 0);
 }
 
-static int omap_dss_register_device(struct omap_dss_device *dssdev)
+int omap_dss_register_device(struct omap_dss_device *dssdev,
+		struct device *parent)
 {
 	static int dev_num;
 
@@ -475,17 +449,29 @@ static int omap_dss_register_device(struct omap_dss_device *dssdev)
 
 	reset_device(&dssdev->dev, 1);
 	dssdev->dev.bus = &dss_bus_type;
-	dssdev->dev.parent = &dss_bus;
+	dssdev->dev.parent = parent;
 	dssdev->dev.release = omap_dss_dev_release;
 	dev_set_name(&dssdev->dev, "display%d", dev_num++);
 	return device_register(&dssdev->dev);
 }
 
-static void omap_dss_unregister_device(struct omap_dss_device *dssdev)
+void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
 }
 
+static int dss_unregister_dss_dev(struct device *dev, void *data)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	omap_dss_unregister_device(dssdev);
+	return 0;
+}
+
+void omap_dss_unregister_child_devices(struct device *parent)
+{
+	device_for_each_child(parent, NULL, dss_unregister_dss_dev);
+}
+
 /* BUS */
 static int __init omap_dss_bus_register(void)
 {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index f92134c..631953b 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -366,11 +366,28 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 
 static int __init omap_dpi_probe(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int i, r;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_DPI)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+
 	return 0;
 }
 
 static int __exit omap_dpi_remove(struct platform_device *pdev)
 {
+	omap_dss_unregister_child_devices(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f37e7ee..0ff1e63 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4616,6 +4616,7 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
 	struct resource *dsi_mem;
 	struct dsi_data *dsi;
+	struct omap_dss_board_info *pdata = dsidev->dev.platform_data;
 
 	dsi = devm_kzalloc(&dsidev->dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
@@ -4702,6 +4703,21 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else
 		dsi->num_lanes_supported = 3;
 
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_DSI)
+			continue;
+
+		if (dssdev->phy.dsi.module != dsi_module)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &dsidev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+				dssdev->name, r);
+	}
+
 	dsi_runtime_put(dsidev);
 
 	if (dsi_module == 0)
@@ -4729,6 +4745,8 @@ static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
+	omap_dss_unregister_child_devices(&dsidev->dev);
+
 	pm_runtime_disable(&dsidev->dev);
 
 	dsi_put_clocks(dsidev);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3ac9d1d..828f669 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -165,6 +165,11 @@ void dss_dsi_disable_pads(int dsi_id, unsigned lane_mask);
 int dss_set_min_bus_tput(struct device *dev, unsigned long tput);
 int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *));
 
+int omap_dss_register_device(struct omap_dss_device *dssdev,
+		struct device *parent);
+void omap_dss_unregister_device(struct omap_dss_device *dssdev);
+void omap_dss_unregister_child_devices(struct device *parent);
+
 /* apply */
 void dss_apply_init(void);
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 02933bc..28ce057 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -772,8 +772,9 @@ static void hdmi_put_clocks(void)
 /* HDMI HW IP initialisation */
 static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	struct resource *hdmi_mem;
-	int r;
+	int r, i;
 
 	hdmi.pdev = pdev;
 
@@ -810,6 +811,18 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
 	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
 
@@ -826,6 +839,8 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+	omap_dss_unregister_child_devices(&pdev->dev);
+
 	hdmi_panel_exit();
 
 #if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 6d489c0..d0d24a0 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -930,10 +930,11 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
 /* RFBI HW IP initialisation */
 static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	u32 rev;
 	struct resource *rfbi_mem;
 	struct clk *clk;
-	int r;
+	int r, i;
 
 	rfbi.pdev = pdev;
 
@@ -978,6 +979,18 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
 
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_DBI)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+				dssdev->name, r);
+	}
+
 	return 0;
 
 err_runtime_get:
@@ -987,6 +1000,7 @@ err_runtime_get:
 
 static int __exit omap_rfbihw_remove(struct platform_device *pdev)
 {
+	omap_dss_unregister_child_devices(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 7dfe4fe..bf48fb4 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -178,11 +178,28 @@ int sdi_init_display(struct omap_dss_device *dssdev)
 
 static int __init omap_sdi_probe(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	int i, r;
+
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_SDI)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+
 	return 0;
 }
 
 static int __exit omap_sdi_remove(struct platform_device *pdev)
 {
+	omap_dss_unregister_child_devices(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index a19138b..646903a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -780,9 +780,10 @@ static void venc_put_clocks(void)
 /* VENC HW IP initialisation */
 static int __init omap_venchw_probe(struct platform_device *pdev)
 {
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	u8 rev_id;
 	struct resource *venc_mem;
-	int r;
+	int r, i;
 
 	venc.pdev = pdev;
 
@@ -824,6 +825,18 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
+	for (i = 0; i < pdata->num_devices; ++i) {
+		struct omap_dss_device *dssdev = pdata->devices[i];
+
+		if (dssdev->type != OMAP_DISPLAY_TYPE_VENC)
+			continue;
+
+		r = omap_dss_register_device(dssdev, &pdev->dev);
+		if (r)
+			DSSERR("device %s register failed: %d\n",
+					dssdev->name, r);
+	}
+
 	return 0;
 
 err_reg_panel_driver:
@@ -835,10 +848,13 @@ err_runtime_get:
 
 static int __exit omap_venchw_remove(struct platform_device *pdev)
 {
+	omap_dss_unregister_child_devices(&pdev->dev);
+
 	if (venc.vdda_dac_reg != NULL) {
 		regulator_put(venc.vdda_dac_reg);
 		venc.vdda_dac_reg = NULL;
 	}
+
 	omap_dss_unregister_driver(&venc_driver);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

