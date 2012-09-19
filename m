From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/8] OMAPDSS: register only one display device per output
Date: Wed, 19 Sep 2012 11:30:33 +0300
Message-ID: <1348043438-2624-4-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42098 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753244Ab2ISIbI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:08 -0400
Received: by lbbgj3 with SMTP id gj3so618926lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:06 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have boards with multiple panel devices connected to the same
physical output, of which only one panel can be enabled at one time.
Examples of these are Overo, where you can use different daughter boards
that have different LCDs, and 3430SDP which has an LCD and a DVI output
and a physical switch to select the active display.

These are supported by omapdss so that we add all the possible display
devices at probe, but the displays are inactive until somebody enables
one. At this point the panel driver starts using the DSS, thus reserving
the physcal resource and excluding the other panels.

This is problematic:
- Panel drivers can't allocate their resources properly at probe(),
  because the resources can be shared with other panels. Thus they can
  be only reserved at enable time.
- Managing this in omapdss is confusing. It's not natural to have
  child devices, which may not even exist (for example, a daughterboard
  that is not connected).

Only some boards have multiple displays per output, and of those, only
very few have possibility of switching the display during runtime.
Because of the above points:
- We don't want to make omapdss and all the panel drivers more complex
  just because some boards have complex setups.
- Only few boards support runtime switching, and afaik even then it's
  not required. So we don't need to support runtime switching.

Thus we'll change to a model where we will have only one display device
per output and this cannot be (currently) changed at runtime. We'll
still have the possibility to select the display from multiple options
during boot with the default display option.

This patch accomplishes the above by changing how the output drivers
register the display device. Instead of registering all the devices
given from the board file, we'll only register one. If the default
display option is set, the output driver selects that display from its
displays. If the default display is not set, or the default display is
not one of the output's displays, the output driver selects the first
display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |   47 ++++++++++++++++++++++++++-------
 drivers/video/omap2/dss/dsi.c  |   51 ++++++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h  |    1 +
 drivers/video/omap2/dss/hdmi.c |   57 ++++++++++++++++++++++++++++++----------
 drivers/video/omap2/dss/rfbi.c |   47 ++++++++++++++++++++++++++-------
 drivers/video/omap2/dss/sdi.c  |   47 ++++++++++++++++++++++++++-------
 drivers/video/omap2/dss/venc.c |   47 ++++++++++++++++++++++++++-------
 7 files changed, 231 insertions(+), 66 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 703fc1d..6f9a199 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -371,10 +371,14 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void __init dpi_probe_pdata(struct platform_device *pdev)
+static struct omap_dss_device * __init dpi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int i, r;
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -382,16 +386,39 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_DPI)
 			continue;
 
-		r = dpi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
+
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
+	return def_dssdev;
+}
+
+static void __init dpi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dssdev = dpi_find_dssdev(pdev);
+
+	if (!dssdev)
+		return;
+
+	r = dpi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
+
+	r = omap_dss_register_device(dssdev, &pdev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f7078fc..ee9ae52 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5006,11 +5006,15 @@ static void dsi_put_clocks(struct platform_device *dsidev)
 		clk_put(dsi->sys_clk);
 }
 
-static void __init dsi_probe_pdata(struct platform_device *dsidev)
+static struct omap_dss_device * __init dsi_find_dssdev(struct platform_device *pdev)
 {
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_dss_board_info *pdata = dsidev->dev.platform_data;
-	int i, r;
+	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(pdev);
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -5021,16 +5025,39 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 		if (dssdev->phy.dsi.module != dsi->module_id)
 			continue;
 
-		r = dsi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
+
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
 
-		r = omap_dss_register_device(dssdev, &dsidev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
+	return def_dssdev;
+}
+
+static void __init dsi_probe_pdata(struct platform_device *dsidev)
+{
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dssdev = dsi_find_dssdev(dsidev);
+
+	if (!dssdev)
+		return;
+
+	r = dsi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
+
+	r = omap_dss_register_device(dssdev, &dsidev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7bac8ee..a977826 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -175,6 +175,7 @@ struct seq_file;
 struct platform_device;
 
 /* core */
+const char *dss_get_default_display_name(void);
 struct bus_type *dss_get_bus(void);
 struct regulator *dss_get_vdds_dsi(void);
 struct regulator *dss_get_vdds_sdi(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bb07143..76d100b 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -901,32 +901,61 @@ int hdmi_audio_config(struct omap_dss_audio *audio)
 
 #endif
 
-static void __init hdmi_probe_pdata(struct platform_device *pdev)
+static struct omap_dss_device * __init hdmi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int r, i;
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
-		struct omap_dss_hdmi_data *priv = dssdev->data;
 
 		if (dssdev->type != OMAP_DISPLAY_TYPE_HDMI)
 			continue;
 
-		hdmi.ct_cp_hpd_gpio = priv->ct_cp_hpd_gpio;
-		hdmi.ls_oe_gpio = priv->ls_oe_gpio;
-		hdmi.hpd_gpio = priv->hpd_gpio;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
 
-		r = hdmi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
+
+	return def_dssdev;
+}
+
+static void __init hdmi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_device *dssdev;
+	struct omap_dss_hdmi_data *priv;
+	int r;
 
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
+	dssdev = hdmi_find_dssdev(pdev);
+
+	if (!dssdev)
+		return;
+
+	priv = dssdev->data;
+
+	hdmi.ct_cp_hpd_gpio = priv->ct_cp_hpd_gpio;
+	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
+	hdmi.hpd_gpio = priv->hpd_gpio;
+
+	r = hdmi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
+
+	r = omap_dss_register_device(dssdev, &pdev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 845b4e7..1127037 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -942,10 +942,14 @@ static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void __init rfbi_probe_pdata(struct platform_device *pdev)
+static struct omap_dss_device * __init rfbi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int i, r;
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -953,16 +957,39 @@ static void __init rfbi_probe_pdata(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_DBI)
 			continue;
 
-		r = rfbi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
+
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
+
+	return def_dssdev;
+}
+
+static void __init rfbi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dssdev = rfbi_find_dssdev(pdev);
 
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-				dssdev->name, r);
+	if (!dssdev)
+		return;
+
+	r = rfbi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
+
+	r = omap_dss_register_device(dssdev, &pdev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index c9a9045..0aaa7f3 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -195,10 +195,14 @@ static int __init sdi_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void __init sdi_probe_pdata(struct platform_device *pdev)
+static struct omap_dss_device * __init sdi_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int i, r;
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -206,16 +210,39 @@ static void __init sdi_probe_pdata(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_SDI)
 			continue;
 
-		r = sdi_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
+
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
+	return def_dssdev;
+}
+
+static void __init sdi_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dssdev = sdi_find_dssdev(pdev);
+
+	if (!dssdev)
+		return;
+
+	r = sdi_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
+
+	r = omap_dss_register_device(dssdev, &pdev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 60bfc58..b9c0a8f 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -735,10 +735,14 @@ static void venc_put_clocks(void)
 		clk_put(venc.tv_dac_clk);
 }
 
-static void __init venc_probe_pdata(struct platform_device *pdev)
+static struct omap_dss_device * __init venc_find_dssdev(struct platform_device *pdev)
 {
 	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	int r, i;
+	const char *def_disp_name = dss_get_default_display_name();
+	struct omap_dss_device *def_dssdev;
+	int i;
+
+	def_dssdev = NULL;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
@@ -746,16 +750,39 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 		if (dssdev->type != OMAP_DISPLAY_TYPE_VENC)
 			continue;
 
-		r = venc_init_display(dssdev);
-		if (r) {
-			DSSERR("device %s init failed: %d\n", dssdev->name, r);
-			continue;
+		if (def_dssdev == NULL)
+			def_dssdev = dssdev;
+
+		if (def_disp_name != NULL &&
+				strcmp(dssdev->name, def_disp_name) == 0) {
+			def_dssdev = dssdev;
+			break;
 		}
+	}
+
+	return def_dssdev;
+}
+
+static void __init venc_probe_pdata(struct platform_device *pdev)
+{
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dssdev = venc_find_dssdev(pdev);
+
+	if (!dssdev)
+		return;
+
+	r = venc_init_display(dssdev);
+	if (r) {
+		DSSERR("device %s init failed: %d\n", dssdev->name, r);
+		return;
+	}
 
-		r = omap_dss_register_device(dssdev, &pdev->dev);
-		if (r)
-			DSSERR("device %s register failed: %d\n",
-					dssdev->name, r);
+	r = omap_dss_register_device(dssdev, &pdev->dev);
+	if (r) {
+		DSSERR("device %s register failed: %d\n", dssdev->name, r);
+		return;
 	}
 }
 
-- 
1.7.9.5

