From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/20] OMAPDSS: add output->name
Date: Fri, 8 Mar 2013 13:51:44 +0200
Message-ID: <1362743515-10152-10-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33513 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756965Ab3CHLwT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:19 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add name field to omapdss's outputs to help debugging.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    1 +
 drivers/video/omap2/dss/dsi.c  |    1 +
 drivers/video/omap2/dss/hdmi.c |    1 +
 drivers/video/omap2/dss/rfbi.c |    1 +
 drivers/video/omap2/dss/sdi.c  |    1 +
 drivers/video/omap2/dss/venc.c |    1 +
 include/video/omapdss.h        |    3 +++
 7 files changed, 9 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index cb6b280..e282456 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -512,6 +512,7 @@ static void __init dpi_init_output(struct platform_device *pdev)
 	out->pdev = pdev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->type = OMAP_DISPLAY_TYPE_DPI;
+	out->name = "dpi";
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 815c930..1a6ad6f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5183,6 +5183,7 @@ static void __init dsi_init_output(struct platform_device *dsidev)
 			OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
 
 	out->type = OMAP_DISPLAY_TYPE_DSI;
+	out->name = dsi->module_id == 0 ? "dsi0" : "dsi1";
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index f3768d0..888cfe3 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1046,6 +1046,7 @@ static void __init hdmi_init_output(struct platform_device *pdev)
 	out->pdev = pdev;
 	out->id = OMAP_DSS_OUTPUT_HDMI;
 	out->type = OMAP_DISPLAY_TYPE_HDMI;
+	out->name = "hdmi";
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index e903dd3..a47a9e5 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1025,6 +1025,7 @@ static void __init rfbi_init_output(struct platform_device *pdev)
 	out->pdev = pdev;
 	out->id = OMAP_DSS_OUTPUT_DBI;
 	out->type = OMAP_DISPLAY_TYPE_DBI;
+	out->name = "rfbi";
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 62b5374..0802927 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -278,6 +278,7 @@ static void __init sdi_init_output(struct platform_device *pdev)
 	out->pdev = pdev;
 	out->id = OMAP_DSS_OUTPUT_SDI;
 	out->type = OMAP_DISPLAY_TYPE_SDI;
+	out->name = "sdi";
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 006caf3..c8130f8 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -819,6 +819,7 @@ static void __init venc_init_output(struct platform_device *pdev)
 	out->pdev = pdev;
 	out->id = OMAP_DSS_OUTPUT_VENC;
 	out->type = OMAP_DISPLAY_TYPE_VENC;
+	out->name = "venc";
 
 	dss_register_output(out);
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2cb2b0e..ba9cea7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -541,6 +541,9 @@ struct omap_dss_writeback_info {
 struct omap_dss_output {
 	struct list_head list;
 
+	/* name of the output for debug */
+	const char *name;
+
 	/* display type supported by the output */
 	enum omap_display_type type;
 
-- 
1.7.10.4

