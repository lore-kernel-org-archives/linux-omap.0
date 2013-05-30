From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/27] OMAPDSS: public omapdss_register_output()
Date: Thu, 30 May 2013 12:35:54 +0300
Message-ID: <1369906580-27585-2-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030397Ab3E3Jgu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:36:50 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

In order to allow multiple display block in a video pipeline, we need to
give the drivers way to register themselves. For now we have
the omapdss_register_display() which is used to register panels, and
dss_register_output() which is used to register DSS encoders.

This patch makes dss_register_output() public (with the name of
omapdss_register_output), which can be used to register also external
encoders. The distinction between register_output and register_display
is that a "display" is an entity at the end of the videopipeline, and
"output" is something inside the pipeline.

The registration and naming will be made saner in the future, but the
current names and functions are kept to minimize changes during the dss
device model transition.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c    | 4 ++--
 drivers/video/omap2/dss/dsi.c    | 4 ++--
 drivers/video/omap2/dss/dss.h    | 4 ----
 drivers/video/omap2/dss/hdmi.c   | 4 ++--
 drivers/video/omap2/dss/output.c | 7 +++++--
 drivers/video/omap2/dss/rfbi.c   | 4 ++--
 drivers/video/omap2/dss/sdi.c    | 4 ++--
 drivers/video/omap2/dss/venc.c   | 4 ++--
 include/video/omapdss.h          | 2 ++
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 0afbcd5..3299e27 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -693,14 +693,14 @@ static void dpi_init_output(struct platform_device *pdev)
 	out->dispc_channel = dpi_get_channel();
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void __exit dpi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &dpi.output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 static int omap_dpi_probe(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2f90019..4ecc0c1 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5426,7 +5426,7 @@ static void dsi_init_output(struct platform_device *dsidev)
 	out->dispc_channel = dsi_get_channel(dsi->module_id);
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void dsi_uninit_output(struct platform_device *dsidev)
@@ -5434,7 +5434,7 @@ static void dsi_uninit_output(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct omap_dss_device *out = &dsi->output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 /* DSI1 HW IP initialisation */
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 67a509e..902d458 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,10 +179,6 @@ void dss_put_device(struct omap_dss_device *dssdev);
 void dss_copy_device_pdata(struct omap_dss_device *dst,
 		const struct omap_dss_device *src);
 
-/* output */
-void dss_register_output(struct omap_dss_device *out);
-void dss_unregister_output(struct omap_dss_device *out);
-
 /* display */
 int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 1a7b179..42376d1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1044,14 +1044,14 @@ static void hdmi_init_output(struct platform_device *pdev)
 	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void __exit hdmi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 /* HDMI HW IP initialisation */
diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
index 9ad7d21..0ba168e 100644
--- a/drivers/video/omap2/dss/output.c
+++ b/drivers/video/omap2/dss/output.c
@@ -92,15 +92,18 @@ err:
 }
 EXPORT_SYMBOL(omapdss_output_unset_device);
 
-void dss_register_output(struct omap_dss_device *out)
+int omapdss_register_output(struct omap_dss_device *out)
 {
 	list_add_tail(&out->list, &output_list);
+	return 0;
 }
+EXPORT_SYMBOL(omapdss_register_output);
 
-void dss_unregister_output(struct omap_dss_device *out)
+void omapdss_unregister_output(struct omap_dss_device *out)
 {
 	list_del(&out->list);
 }
+EXPORT_SYMBOL(omapdss_unregister_output);
 
 struct omap_dss_device *omap_dss_get_output(enum omap_dss_output_id id)
 {
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index f18c946..fdfe6e6 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -1022,14 +1022,14 @@ static void rfbi_init_output(struct platform_device *pdev)
 	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void __exit rfbi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &rfbi.output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 /* RFBI HW IP initialisation */
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 10268a2..0343d08 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -350,14 +350,14 @@ static void sdi_init_output(struct platform_device *pdev)
 	out->dispc_channel = OMAP_DSS_CHANNEL_LCD;
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void __exit sdi_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &sdi.output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 static int omap_sdi_probe(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 0deb771..291a40d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -794,14 +794,14 @@ static void venc_init_output(struct platform_device *pdev)
 	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
 	out->owner = THIS_MODULE;
 
-	dss_register_output(out);
+	omapdss_register_output(out);
 }
 
 static void __exit venc_uninit_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &venc.output;
 
-	dss_unregister_output(out);
+	omapdss_unregister_output(out);
 }
 
 /* VENC HW IP initialisation */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b2e6160..3582edf 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -793,6 +793,8 @@ struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
 int omap_dss_get_num_overlays(void);
 struct omap_overlay *omap_dss_get_overlay(int num);
 
+int omapdss_register_output(struct omap_dss_device *output);
+void omapdss_unregister_output(struct omap_dss_device *output);
 struct omap_dss_device *omap_dss_get_output(enum omap_dss_output_id id);
 struct omap_dss_device *omap_dss_find_output(const char *name);
 struct omap_dss_device *omap_dss_find_output_by_node(struct device_node *node);
-- 
1.8.1.2

