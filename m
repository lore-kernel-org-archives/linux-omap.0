From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 13/23] OMAPDSS: SDI: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:35 +0530
Message-ID: <1346326845-16583-14-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36959 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab2H3LnI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:08 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a SDI function, it passes the omap_dss_device
pointer, this pointer currently propagates within the SDI driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to SDI functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the SDI interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/sdi.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index d8879f3..24f9ba0 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -40,7 +40,7 @@ static struct {
 	struct omap_dss_output output;
 } sdi;
 
-static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void sdi_config_lcd_manager(struct omap_dss_output *out)
 {
 	sdi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
@@ -50,19 +50,20 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	sdi.mgr_config.video_port_width = 24;
 	sdi.mgr_config.lcden_sig_polarity = 1;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &sdi.mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &sdi.mgr_config);
 }
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	struct omap_video_timings *t = &sdi.timings;
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 	unsigned long pck;
 	int r;
 
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
 		return -ENODEV;
 	}
 
@@ -100,14 +101,13 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-
-	dss_mgr_set_timings(dssdev->manager, t);
+	dss_mgr_set_timings(out->manager, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
 		goto err_set_dss_clock_div;
 
-	sdi_config_lcd_manager(dssdev);
+	sdi_config_lcd_manager(out);
 
 	dss_sdi_init(sdi.datapairs);
 
@@ -116,7 +116,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err_sdi_enable;
 	mdelay(2);
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r)
 		goto err_mgr_enable;
 
@@ -139,7 +139,9 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	dss_mgr_disable(dssdev->manager);
+	struct omap_dss_output *out = dssdev->output;
+
+	dss_mgr_disable(out->manager);
 
 	dss_sdi_disable();
 
-- 
1.7.9.5

