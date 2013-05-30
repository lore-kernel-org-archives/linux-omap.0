From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/32] OMAPDSS: only probe pdata if there's one
Date: Thu, 30 May 2013 12:34:23 +0300
Message-ID: <1369906493-27538-3-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41377 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968001Ab3E3JfY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:24 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss output drivers always read the platform data. This crashes when
there's no platform data when using DT.

Add a check to read the platform data only if it exists.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  | 12 ++++++++----
 drivers/video/omap2/dss/dsi.c  | 13 +++++++------
 drivers/video/omap2/dss/hdmi.c | 16 ++++++++++------
 drivers/video/omap2/dss/rfbi.c | 11 ++++++-----
 drivers/video/omap2/dss/sdi.c  | 12 ++++++++----
 drivers/video/omap2/dss/venc.c | 13 +++++++------
 6 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 757b57f..ef8fca2 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -706,13 +706,17 @@ static int omap_dpi_probe(struct platform_device *pdev)
 
 	dpi_init_output(pdev);
 
-	r = dpi_probe_pdata(pdev);
-	if (r) {
-		dpi_uninit_output(pdev);
-		return r;
+	if (pdev->dev.platform_data) {
+		r = dpi_probe_pdata(pdev);
+		if (r)
+			goto err_probe;
 	}
 
 	return 0;
+
+err_probe:
+	dpi_uninit_output(pdev);
+	return r;
 }
 
 static int __exit omap_dpi_remove(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a73dedc..bdddd0d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5563,12 +5563,10 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi_init_output(dsidev);
 
-	r = dsi_probe_pdata(dsidev);
-	if (r) {
-		dsi_runtime_put(dsidev);
-		dsi_uninit_output(dsidev);
-		pm_runtime_disable(&dsidev->dev);
-		return r;
+	if (dsidev->dev.platform_data) {
+		r = dsi_probe_pdata(dsidev);
+		if (r)
+			goto err_probe;
 	}
 
 	dsi_runtime_put(dsidev);
@@ -5586,6 +5584,9 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 #endif
 	return 0;
 
+err_probe:
+	dsi_runtime_put(dsidev);
+	dsi_uninit_output(dsidev);
 err_runtime_get:
 	pm_runtime_disable(&dsidev->dev);
 	return r;
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 17f4d55..99f4ab5 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1098,15 +1098,19 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
-	r = hdmi_probe_pdata(pdev);
-	if (r) {
-		hdmi_panel_exit();
-		hdmi_uninit_output(pdev);
-		pm_runtime_disable(&pdev->dev);
-		return r;
+	if (pdev->dev.platform_data) {
+		r = hdmi_probe_pdata(pdev);
+		if (r)
+			goto err_probe;
 	}
 
 	return 0;
+
+err_probe:
+	hdmi_panel_exit();
+	hdmi_uninit_output(pdev);
+	pm_runtime_disable(&pdev->dev);
+	return r;
 }
 
 static int __exit hdmi_remove_child(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1a17dd1..1ff221e 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1093,15 +1093,16 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 
 	rfbi_init_output(pdev);
 
-	r = rfbi_probe_pdata(pdev);
-	if (r) {
-		rfbi_uninit_output(pdev);
-		pm_runtime_disable(&pdev->dev);
-		return r;
+	if (pdev->dev.platform_data) {
+		r = rfbi_probe_pdata(pdev);
+		if (r)
+			goto err_probe;
 	}
 
 	return 0;
 
+err_probe:
+	rfbi_uninit_output(pdev);
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
 	return r;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0bcd302..6277c05 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -365,13 +365,17 @@ static int omap_sdi_probe(struct platform_device *pdev)
 
 	sdi_init_output(pdev);
 
-	r = sdi_probe_pdata(pdev);
-	if (r) {
-		sdi_uninit_output(pdev);
-		return r;
+	if (pdev->dev.platform_data) {
+		r = sdi_probe_pdata(pdev);
+		if (r)
+			goto err_probe;
 	}
 
 	return 0;
+
+err_probe:
+	sdi_uninit_output(pdev);
+	return r;
 }
 
 static int __exit omap_sdi_remove(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 74fdb3e..7b2e3ae 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -866,16 +866,17 @@ static int omap_venchw_probe(struct platform_device *pdev)
 
 	venc_init_output(pdev);
 
-	r = venc_probe_pdata(pdev);
-	if (r) {
-		venc_panel_exit();
-		venc_uninit_output(pdev);
-		pm_runtime_disable(&pdev->dev);
-		return r;
+	if (pdev->dev.platform_data) {
+		r = venc_probe_pdata(pdev);
+		if (r)
+			goto err_probe;
 	}
 
 	return 0;
 
+err_probe:
+	venc_panel_exit();
+	venc_uninit_output(pdev);
 err_panel_init:
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-- 
1.8.1.2

