From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 02/23] OMAPDSS: outputs: Create and register output instances
Date: Thu, 30 Aug 2012 17:10:24 +0530
Message-ID: <1346326845-16583-3-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34246 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab2H3Lmc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:32 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add output structs to output driver's private data. Register output instances by
having an init function in the probes of the platform device drivers for
different outputs. The *_init_output for each output registers the output and
fill up the output's plaform device, type and id fields.

In the probe of each interface driver, the output entities are initialized
before the *_probe_pdata() functions intentionally. This is done to ensure that
the output entity is prepared before the panels connected to the output are
registered. We need the output entities to be ready because OMAPDSS will try
to make connections between overlays, managers, outputs and devices during the
panel's probe.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |   15 +++++++++++++++
 drivers/video/omap2/dss/dsi.c  |   18 ++++++++++++++++++
 drivers/video/omap2/dss/hdmi.c |   15 +++++++++++++++
 drivers/video/omap2/dss/rfbi.c |   17 +++++++++++++++++
 drivers/video/omap2/dss/sdi.c  |   15 +++++++++++++++
 drivers/video/omap2/dss/venc.c |   15 +++++++++++++++
 6 files changed, 95 insertions(+)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 25fb895..9a7aee5 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -45,6 +45,8 @@ static struct {
 	struct omap_video_timings timings;
 	struct dss_lcd_mgr_config mgr_config;
 	int data_lines;
+
+	struct omap_dss_output output;
 } dpi;
 
 static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
@@ -410,10 +412,23 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static void __init dpi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out = &dpi.output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_DPI;
+	out->type = OMAP_DISPLAY_TYPE_DPI;
+}
+
 static int __init omap_dpi_probe(struct platform_device *pdev)
 {
 	mutex_init(&dpi.lock);
 
+	dpi_init_output(pdev);
+
 	dpi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 659b6cd..6a83ab7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -337,6 +337,8 @@ struct dsi_data {
 	enum omap_dss_dsi_pixel_format pix_fmt;
 	enum omap_dss_dsi_mode mode;
 	struct omap_dss_dsi_videomode_timings vm_timings;
+
+	struct omap_dss_output output;
 };
 
 struct dsi_packet_sent_handler_data {
@@ -4903,6 +4905,20 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
 	}
 }
 
+static void __init dsi_init_output(struct platform_device *dsidev,
+		struct dsi_data *dsi)
+{
+	struct omap_dss_output *out = &dsi->output;
+
+	dss_register_output(out);
+
+	out->pdev = dsidev;
+	out->id = dsi->module_id == 0 ?
+			OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
+
+	out->type = OMAP_DISPLAY_TYPE_DSI;
+}
+
 /* DSI1 HW IP initialisation */
 static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
@@ -4997,6 +5013,8 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	else
 		dsi->num_lanes_supported = 3;
 
+	dsi_init_output(dsidev, dsi);
+
 	dsi_probe_pdata(dsidev);
 
 	dsi_runtime_put(dsidev);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0cdf246..d93954d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -61,6 +61,8 @@ static struct {
 	struct hdmi_ip_data ip_data;
 
 	struct clk *sys_clk;
+
+	struct omap_dss_output output;
 } hdmi;
 
 /*
@@ -890,6 +892,17 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static void __init hdmi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out = &hdmi.output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_HDMI;
+	out->type = OMAP_DISPLAY_TYPE_HDMI;
+}
+
 /* HDMI HW IP initialisation */
 static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -933,6 +946,8 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
+	hdmi_init_output(pdev);
+
 	hdmi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5a9c0e9..3450f51 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -116,6 +116,8 @@ static struct {
 	int pixel_size;
 	int data_lines;
 	struct rfbi_timings intf_timings;
+
+	struct omap_dss_output output;
 } rfbi;
 
 static inline void rfbi_write_reg(const struct rfbi_reg idx, u32 val)
@@ -967,6 +969,19 @@ static void __init rfbi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static void __init rfbi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out = &rfbi.output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_DBI;
+	out->type = OMAP_DISPLAY_TYPE_DBI;
+
+	return 0;
+}
+
 /* RFBI HW IP initialisation */
 static int __init omap_rfbihw_probe(struct platform_device *pdev)
 {
@@ -1018,6 +1033,8 @@ static int __init omap_rfbihw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("rfbi", rfbi_dump_regs);
 
+	rfbi_init_output(pdev);
+
 	rfbi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 3bf1bfe..d8879f3 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -36,6 +36,8 @@ static struct {
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
 	int datapairs;
+
+	struct omap_dss_output output;
 } sdi;
 
 static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
@@ -216,8 +218,21 @@ static void __init sdi_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static void __init sdi_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out = &sdi.output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_SDI;
+	out->type = OMAP_DISPLAY_TYPE_SDI;
+}
+
 static int __init omap_sdi_probe(struct platform_device *pdev)
 {
+	sdi_init_output(pdev);
+
 	sdi_probe_pdata(pdev);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4a6caf9..942a378 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -304,6 +304,8 @@ static struct {
 	struct omap_video_timings timings;
 	enum omap_dss_venc_type type;
 	bool invert_polarity;
+
+	struct omap_dss_output output;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -773,6 +775,17 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 	}
 }
 
+static void __init venc_init_output(struct platform_device *pdev)
+{
+	struct omap_dss_output *out = &venc.output;
+
+	dss_register_output(out);
+
+	out->pdev = pdev;
+	out->id = OMAP_DSS_OUTPUT_VENC;
+	out->type = OMAP_DISPLAY_TYPE_VENC;
+}
+
 /* VENC HW IP initialisation */
 static int __init omap_venchw_probe(struct platform_device *pdev)
 {
@@ -820,6 +833,8 @@ static int __init omap_venchw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("venc", venc_dump_regs);
 
+	venc_init_output(pdev);
+
 	venc_probe_pdata(pdev);
 
 	return 0;
-- 
1.7.9.5

