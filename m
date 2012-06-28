From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/12] OMAPDSS: RFBI: Configure dss_lcd_mgr_config struct with lcd manager parameters
Date: Thu, 28 Jun 2012 20:00:34 +0530
Message-ID: <1340893842-10626-6-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36396 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2F1OcU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 10:32:20 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a dss_lcd_mgr_config struct instance in RFBI. Fill up all the parameters
of the struct with configurations held by the panel, and the configurations
required by RFBI.

Use these to write to the DISPC registers. These direct register writes would be
later replaced by a function which applies the configuration using the shadow
register programming model.

Create function rfbi_config_lcd_manager() which fills up the mgr_config
parameters and writes to the DISPC regs.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 45084d8..847f694 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -859,6 +859,33 @@ static void rfbi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
+static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
+{
+	struct dss_lcd_mgr_config mgr_config;
+
+	mgr_config.io_pad_mode = DSS_IO_PAD_MODE_RFBI;
+
+	mgr_config.stallmode = true;
+	/* Do we need fifohandcheck for RFBI? */
+	mgr_config.fifohandcheck = false;
+
+	mgr_config.video_port_width = dssdev->ctrl.pixel_size;
+	mgr_config.lcden_sig_polarity = 0;
+
+	dispc_mgr_set_io_pad_mode(mgr_config.io_pad_mode);
+
+	dispc_mgr_enable_stallmode(dssdev->manager->id, mgr_config.stallmode);
+	dispc_mgr_enable_fifohandcheck(dssdev->manager->id,
+			mgr_config.fifohandcheck);
+
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+			mgr_config.video_port_width);
+
+	dispc_lcd_enable_signal_polarity(mgr_config.lcden_sig_polarity);
+
+	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
+}
+
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r;
@@ -885,12 +912,7 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	dispc_mgr_set_lcd_type_tft(dssdev->manager->id);
-
-	dispc_mgr_set_io_pad_mode(DSS_IO_PAD_MODE_RFBI);
-	dispc_mgr_enable_stallmode(dssdev->manager->id, true);
-
-	dispc_mgr_set_tft_data_lines(dssdev->manager->id, dssdev->ctrl.pixel_size);
+	rfbi_config_lcd_manager(dssdev);
 
 	rfbi_configure(dssdev->phy.rfbi.channel,
 			       dssdev->ctrl.pixel_size,
-- 
1.7.9.5

