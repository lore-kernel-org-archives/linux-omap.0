From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 30/32] OMAPDSS: add THIS_MODULE owner to DSS outputs
Date: Thu, 30 May 2013 12:34:51 +0300
Message-ID: <1369906493-27538-31-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49846 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030377Ab3E3JgC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:02 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Setup the owner field for DSS output's omap_dss_device so that module
refcounting works.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  | 1 +
 drivers/video/omap2/dss/dsi.c  | 1 +
 drivers/video/omap2/dss/hdmi.c | 1 +
 drivers/video/omap2/dss/rfbi.c | 1 +
 drivers/video/omap2/dss/sdi.c  | 1 +
 drivers/video/omap2/dss/venc.c | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 03d8afd..0afbcd5 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -691,6 +691,7 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_DPI;
 	out->name = "dpi.0";
 	out->dispc_channel = dpi_get_channel();
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9aafefc..2f90019 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5424,6 +5424,7 @@ static void dsi_init_output(struct platform_device *dsidev)
 	out->output_type = OMAP_DISPLAY_TYPE_DSI;
 	out->name = dsi->module_id == 0 ? "dsi.0" : "dsi.1";
 	out->dispc_channel = dsi_get_channel(dsi->module_id);
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index e33e708..1a7b179 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1042,6 +1042,7 @@ static void hdmi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_HDMI;
 	out->name = "hdmi.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 35836eb..f18c946 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1020,6 +1020,7 @@ static void rfbi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_DBI;
 	out->name = "rfbi.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index a226c37..10268a2 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -348,6 +348,7 @@ static void sdi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_SDI;
 	out->name = "sdi.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7bfcba4..0deb771 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -792,6 +792,7 @@ static void venc_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_VENC;
 	out->name = "venc.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
+	out->owner = THIS_MODULE;
 
 	dss_register_output(out);
 }
-- 
1.8.1.2

