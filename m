From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 14/23] OMAPDSS: RFBI: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:36 +0530
Message-ID: <1346326845-16583-15-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57656 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab2H3LnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 07:43:11 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a RFBI function, it passes the omap_dss_device
pointer, this pointer currently propagates within the RFBI driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to RFBI functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the RFBI interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 3450f51..545e14f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -307,11 +307,12 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-static int rfbi_transfer_area(struct omap_dss_device *dssdev,
+static int rfbi_transfer_area(struct omap_dss_output *out,
 		void (*callback)(void *data), void *data)
 {
 	u32 l;
 	int r;
+	struct omap_overlay_manager *mgr = out->manager;
 	u16 width = rfbi.timings.x_res;
 	u16 height = rfbi.timings.y_res;
 
@@ -320,9 +321,9 @@ static int rfbi_transfer_area(struct omap_dss_device *dssdev,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dss_mgr_set_timings(dssdev->manager, &rfbi.timings);
+	dss_mgr_set_timings(mgr, &rfbi.timings);
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(mgr);
 	if (r)
 		return r;
 
@@ -779,7 +780,9 @@ EXPORT_SYMBOL(omap_rfbi_configure);
 int omap_rfbi_update(struct omap_dss_device *dssdev, void (*callback)(void *),
 		void *data)
 {
-	return rfbi_transfer_area(dssdev, callback, data);
+	struct omap_dss_output *out = dssdev->output;
+
+	return rfbi_transfer_area(out, callback, data);
 }
 EXPORT_SYMBOL(omap_rfbi_update);
 
@@ -849,7 +852,7 @@ static void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void rfbi_config_lcd_manager(struct omap_dss_output *out)
 {
 	struct dss_lcd_mgr_config mgr_config;
 
@@ -862,7 +865,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	mgr_config.video_port_width = rfbi.pixel_size;
 	mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &mgr_config);
 
 	/*
 	 * Set rfbi.timings with default values, the x_res and y_res fields
@@ -883,15 +886,16 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 	rfbi.timings.de_level = OMAPDSS_SIG_ACTIVE_HIGH;
 	rfbi.timings.sync_pclk_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
-	dss_mgr_set_timings(dssdev->manager, &rfbi.timings);
+	dss_mgr_set_timings(out->manager, &rfbi.timings);
 }
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
 		return -ENODEV;
 	}
 
@@ -912,7 +916,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	rfbi_config_lcd_manager(dssdev);
+	rfbi_config_lcd_manager(out);
 
 	rfbi_configure(dssdev->phy.rfbi.channel, rfbi.pixel_size,
 			rfbi.data_lines);
-- 
1.7.9.5

