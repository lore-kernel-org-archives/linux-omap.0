From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/26] OMAPDSS: only probe pdata if there's one
Date: Tue, 26 Mar 2013 15:33:31 +0200
Message-ID: <1364304836-18134-2-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934241Ab3CZNed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:33 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss output drivers always read the platform data. This crashes when
there's no platform data when using DT.

Add a check to read the platform data only if it exists.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    3 ++-
 drivers/video/omap2/dss/dsi.c  |    3 ++-
 drivers/video/omap2/dss/hdmi.c |    3 ++-
 drivers/video/omap2/dss/rfbi.c |    3 ++-
 drivers/video/omap2/dss/sdi.c  |    3 ++-
 drivers/video/omap2/dss/venc.c |    3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index abe1a4e2..ad67a9c 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -702,7 +702,8 @@ static int __init omap_dpi_probe(struct platform_device *pdev)
 
 	dpi_init_output(pdev);
 
-	dpi_probe_pdata(pdev);
+	if (pdev->dev.platform_data)
+		dpi_probe_pdata(pdev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8db29bf..ddb8bf6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5573,7 +5573,8 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 
 	dsi_init_output(dsidev);
 
-	dsi_probe_pdata(dsidev);
+	if (dsidev->dev.platform_data)
+		dsi_probe_pdata(dsidev);
 
 	dsi_runtime_put(dsidev);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index a6f9538..4b32dd3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1102,7 +1102,8 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
-	hdmi_probe_pdata(pdev);
+	if (pdev->dev.platform_data)
+		hdmi_probe_pdata(pdev);
 
 	return 0;
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1a691bb..946c415 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1091,7 +1091,8 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 
 	rfbi_init_output(pdev);
 
-	rfbi_probe_pdata(pdev);
+	if (pdev->dev.platform_data)
+		rfbi_probe_pdata(pdev);
 
 	return 0;
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index e6baee2..0155c7e 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -361,7 +361,8 @@ static int __init omap_sdi_probe(struct platform_device *pdev)
 {
 	sdi_init_output(pdev);
 
-	sdi_probe_pdata(pdev);
+	if (pdev->dev.platform_data)
+		sdi_probe_pdata(pdev);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 5cb983e..f5e8a5b 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -879,7 +879,8 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	venc_init_output(pdev);
 
-	venc_probe_pdata(pdev);
+	if (pdev->dev.platform_data)
+		venc_probe_pdata(pdev);
 
 	return 0;
 
-- 
1.7.10.4

