From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/23] OMAPDSS: outputs: Create and initialize output instances
Date: Tue, 21 Aug 2012 11:28:09 +0530
Message-ID: <1345528711-27801-3-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab2HUGAR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:17 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

Create output instances by having an init function in the probes of the platform
device drivers for different interfaces. Create a small function for each
interface to initialize the output entity's fields type and id.

In the probe of each interface driver, the output entities are created before
the *_probe_pdata() functions intentionally. This is done to ensure that the
output entity is prepared before the panels connected to the output are
registered. We need the output entities to be ready because OMAPDSS will try
to make connections between overlays, managers, outputs and devices during the
panel's probe.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |   20 ++++++++++++++++++++
 drivers/video/omap2/dss/dsi.c  |   26 ++++++++++++++++++++++++--
 drivers/video/omap2/dss/hdmi.c |   18 ++++++++++++++++++
 drivers/video/omap2/dss/rfbi.c |   19 +++++++++++++++++++
 drivers/video/omap2/dss/sdi.c  |   20 ++++++++++++++++++++
 drivers/video/omap2/dss/venc.c |   20 ++++++++++++++++++++
 6 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index f260343..4eca2e7 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -408,10 +408,30 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static int __init dpi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(pdev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = OMAP_DSS_OUTPUT_DPI;
+	out->type = OMAP_DISPLAY_TYPE_DPI;
+
+	return 0;
+}
+
 static int __init omap_dpi_probe(struct platform_device *pdev)
 {
+	int r;
+
 	mutex_init(&dpi.lock);
 
+	r = dpi_init_output(pdev);
+	if (r)
+		return r;
+
 	dpi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 659b6cd..22e0873 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4903,6 +4903,23 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 	}
 }
 
+static int __init dsi_init_output(struct platform_device *dsidev,
+		struct dsi_data *dsi)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(dsidev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = dsi->module_id == 0 ?
+			OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
+
+	out->type = OMAP_DISPLAY_TYPE_DSI;
+
+	return 0;
+}
+
 /* DSI1 HW IP initialisation */
 static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
@@ -4997,10 +5014,14 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else
 		dsi->num_lanes_supported = 3;
 
-	dsi_probe_pdata(dsidev);
-
 	dsi_runtime_put(dsidev);
 
+	r = dsi_init_output(dsidev, dsi);
+	if (r)
+		goto err_init_output;
+
+	dsi_probe_pdata(dsidev);
+
 	if (dsi->module_id == 0)
 		dss_debugfs_create_file("dsi1_regs", dsi1_dump_regs);
 	else if (dsi->module_id == 1)
@@ -5014,6 +5035,7 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 #endif
 	return 0;
 
+err_init_output:
 err_runtime_get:
 	pm_runtime_disable(&dsidev->dev);
 	dsi_put_clocks(dsidev);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0cdf246..d32dbc3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -890,6 +890,20 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static int __init hdmi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(pdev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = OMAP_DSS_OUTPUT_HDMI;
+	out->type = OMAP_DISPLAY_TYPE_HDMI;
+
+	return 0;
+}
+
 /* HDMI HW IP initialisation */
 static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -933,6 +947,10 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
+	r = hdmi_init_output(pdev);
+	if (r)
+		return r;
+
 	hdmi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5a9c0e9..9d9244c 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -967,6 +967,20 @@ static void __init rfbi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static int __init rfbi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(pdev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = OMAP_DSS_OUTPUT_DBI;
+	out->type = OMAP_DISPLAY_TYPE_DBI;
+
+	return 0;
+}
+
 /* RFBI HW IP initialisation */
 static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
@@ -1018,10 +1032,15 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
 
+	r = rfbi_init_output(pdev);
+	if (r)
+		goto err_init_output;
+
 	rfbi_probe_pdata(pdev);
 
 	return 0;
 
+err_init_output:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	return r;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 3bf1bfe..a5632d0 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -216,8 +216,28 @@ static void __init sdi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static int __init sdi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(pdev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = OMAP_DSS_OUTPUT_SDI;
+	out->type = OMAP_DISPLAY_TYPE_SDI;
+
+	return 0;
+}
+
 static int __init omap_sdi_probe(struct platform_device *pdev)
 {
+	int r;
+
+	r = sdi_init_output(pdev);
+	if (r)
+		return r;
+
 	sdi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7d3eef8..264c5ec 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -778,6 +778,20 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static int __init venc_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out;
+
+	out = dss_create_output(pdev);
+	if (!out)
+		return -ENOMEM;
+
+	out->id = OMAP_DSS_OUTPUT_VENC;
+	out->type = OMAP_DISPLAY_TYPE_VENC;
+
+	return 0;
+}
+
 /* VENC HW IP initialisation */
 static int __init omap_venchw_probe(struct platform_device *pdev)
 {
@@ -825,10 +839,16 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
+	r = venc_init_output(pdev);
+	if (r)
+		goto err_init_output;
+
 	venc_probe_pdata(pdev);
 
 	return 0;
 
+err_init_output:
+	venc_panel_exit();
 err_panel_init:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

