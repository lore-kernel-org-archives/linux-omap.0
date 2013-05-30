From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/32] OMAPDSS: remove dssdev uses in trivial cases
Date: Thu, 30 May 2013 12:34:41 +0300
Message-ID: <1369906493-27538-21-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49827 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030352Ab3E3Jfs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:48 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

In the future the "dssdev" parameter passed to output drivers will
change its meaning. Instead of being a pointer to the panel device, it's
a pointer to the output instance.

To make the transition easier, some of the uses for this dssdev
parameter can be easily removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c | 6 +++---
 drivers/video/omap2/dss/rfbi.c | 8 ++++----
 drivers/video/omap2/dss/sdi.c  | 6 +++---
 drivers/video/omap2/dss/venc.c | 6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 960083b..6d1e97c 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -560,7 +560,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 {
 	int r;
 	struct omap_video_timings *p;
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = hdmi.output.manager;
 	unsigned long phy;
 
 	r = hdmi_power_on_core(dssdev);
@@ -623,7 +623,7 @@ err_pll_enable:
 
 static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = hdmi.output.manager;
 
 	dss_mgr_disable(mgr);
 
@@ -720,7 +720,7 @@ bool omapdss_hdmi_detect(void)
 
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &hdmi.output;
 	int r = 0;
 
 	DSSDBG("ENTER hdmi_display_enable\n");
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1ff221e..cfcb52f 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -312,7 +312,7 @@ static int rfbi_transfer_area(struct omap_dss_device *dssdev,
 {
 	u32 l;
 	int r;
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = rfbi.output.manager;
 	u16 width = rfbi.timings.x_res;
 	u16 height = rfbi.timings.y_res;
 
@@ -852,7 +852,7 @@ static void rfbi_dump_regs(struct seq_file *s)
 
 static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = rfbi.output.manager;
 	struct dss_lcd_mgr_config mgr_config;
 
 	mgr_config.io_pad_mode = DSS_IO_PAD_MODE_RFBI;
@@ -890,7 +890,7 @@ static void rfbi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &rfbi.output;
 	int r;
 
 	if (out == NULL || out->manager == NULL) {
@@ -933,7 +933,7 @@ EXPORT_SYMBOL(omapdss_rfbi_display_enable);
 
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &rfbi.output;
 
 	dss_mgr_unregister_framedone_handler(out->manager,
 			framedone_callback, NULL);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 9801a6e..e723687 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -112,7 +112,7 @@ static int sdi_calc_clock_div(unsigned long pclk,
 
 static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = sdi.output.manager;
 
 	sdi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
@@ -127,7 +127,7 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &sdi.output;
 	struct omap_video_timings *t = &sdi.timings;
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
@@ -224,7 +224,7 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = sdi.output.manager;
 
 	dss_mgr_disable(mgr);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index f484b9f..af404b4 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -429,7 +429,7 @@ static const struct venc_config *venc_timings_to_config(
 
 static int venc_power_on(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = venc.output.manager;
 	u32 l;
 	int r;
 
@@ -480,7 +480,7 @@ err0:
 
 static void venc_power_off(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	struct omap_overlay_manager *mgr = venc.output.manager;
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, 0);
 	dss_set_dac_pwrdn_bgz(0);
@@ -500,7 +500,7 @@ unsigned long venc_get_pixel_clock(void)
 
 int omapdss_venc_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_output *out = dssdev->output;
+	struct omap_dss_output *out = &venc.output;
 	int r;
 
 	DSSDBG("venc_display_enable\n");
-- 
1.8.1.2

