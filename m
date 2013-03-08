From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/20] OMAPDSS: add output->recommended_channel
Date: Fri, 8 Mar 2013 13:51:46 +0200
Message-ID: <1362743515-10152-12-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57873 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932887Ab3CHLwV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:21 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add recommended_channel for omapdss's outputs. The field tells which
DISPC channel should be used for that output.

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
index 3261644..fb38019 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -540,6 +540,7 @@ static void __init dpi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_DPI;
 	out->type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi";
+	out->recommended_channel = dpi_get_channel();
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c39ca86..e0c9e31 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5232,6 +5232,7 @@ static void __init dsi_init_output(struct platform_device *dsidev)
 
 	out->type = OMAP_DISPLAY_TYPE_DSI;
 	out->name = dsi->module_id == 0 ? "dsi0" : "dsi1";
+	out->recommended_channel = dsi_get_channel(dsi->module_id);
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 888cfe3..e4c3be4 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1047,6 +1047,7 @@ static void __init hdmi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_HDMI;
 	out->type = OMAP_DISPLAY_TYPE_HDMI;
 	out->name = "hdmi";
+	out->recommended_channel = OMAP_DSS_CHANNEL_DIGIT;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 04c4ab6..991ec93 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1028,6 +1028,7 @@ static void __init rfbi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_DBI;
 	out->type = OMAP_DISPLAY_TYPE_DBI;
 	out->name = "rfbi";
+	out->recommended_channel = OMAP_DSS_CHANNEL_LCD;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index d24e971..c797b33 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -281,6 +281,7 @@ static void __init sdi_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_SDI;
 	out->type = OMAP_DISPLAY_TYPE_SDI;
 	out->name = "sdi";
+	out->recommended_channel = OMAP_DSS_CHANNEL_LCD;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index c8130f8..b85fd3d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -820,6 +820,7 @@ static void __init venc_init_output(struct platform_device *pdev)
 	out->id = OMAP_DSS_OUTPUT_VENC;
 	out->type = OMAP_DISPLAY_TYPE_VENC;
 	out->name = "venc";
+	out->recommended_channel = OMAP_DSS_CHANNEL_DIGIT;
 
 	dss_register_output(out);
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ba9cea7..8647646 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -547,6 +547,9 @@ struct omap_dss_output {
 	/* display type supported by the output */
 	enum omap_display_type type;
 
+	/* recommended DISPC channel for this output */
+	enum omap_channel recommended_channel;
+
 	/* output instance */
 	enum omap_dss_output_id id;
 
-- 
1.7.10.4

