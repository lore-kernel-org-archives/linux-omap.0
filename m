From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/20] OMAPDSS: HDMI: split power_on/off to two parts
Date: Wed, 24 Oct 2012 12:29:02 +0300
Message-ID: <1351070951-18616-12-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47953 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933474Ab2JXJ3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 05:29:42 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

There's currently just one power-on function for HDMI, which enables the
IP and the video output. When reading EDID or detecting if a monitor is
connected, we don't need the video output.

Enabling the video output for these operations is not a big problem in
itself, but the quick enable/disable cycles caused by the operations
seem to cause sync lost errors from time to time. Also, this makes it
possible to read the EDID before the full video path has been set up.

This patch splits the hdmi_power_on into two parts, hdmi_power_on_core
and hdmi_power_on_full. The "full" version does what hdmi_power_on does
currently, and hdmi_power_on_core only enables the core IP. Similar
changes are made for power_off.

Note that these don't allow the HDMI IP to be first enabled, and later
enable the video output, but the HDMI IP will first need to be powered
off before calling the full version. So this is rather limited
implementation, but it fills the needs for reading EDID.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   75 ++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index c1c5488..50d5a10 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -500,12 +500,9 @@ static void hdmi_compute_pll(struct omap_dss_device *dssdev, int phy,
 	DSSDBG("range = %d sd = %d\n", pi->dcofreq, pi->regsd);
 }
 
-static int hdmi_power_on(struct omap_dss_device *dssdev)
+static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 {
 	int r;
-	struct omap_video_timings *p;
-	struct omap_overlay_manager *mgr = dssdev->output->manager;
-	unsigned long phy;
 
 	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
 	gpio_set_value(hdmi.ls_oe_gpio, 1);
@@ -521,6 +518,46 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_runtime_get;
 
+	/* Make selection of HDMI in DSS */
+	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
+
+	/* Select the dispc clock source as PRCM clock, to ensure that it is not
+	 * DSI PLL source as the clock selected by DSI PLL might not be
+	 * sufficient for the resolution selected / that can be changed
+	 * dynamically by user. This can be moved to single location , say
+	 * Boardfile.
+	 */
+	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+
+	return 0;
+
+err_runtime_get:
+	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+err_vdac_enable:
+	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	gpio_set_value(hdmi.ls_oe_gpio, 0);
+	return r;
+}
+
+static void hdmi_power_off_core(struct omap_dss_device *dssdev)
+{
+	hdmi_runtime_put();
+	regulator_disable(hdmi.vdda_hdmi_dac_reg);
+	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	gpio_set_value(hdmi.ls_oe_gpio, 0);
+}
+
+static int hdmi_power_on_full(struct omap_dss_device *dssdev)
+{
+	int r;
+	struct omap_video_timings *p;
+	struct omap_overlay_manager *mgr = dssdev->output->manager;
+	unsigned long phy;
+
+	r = hdmi_power_on_core(dssdev);
+	if (r)
+		return r;
+
 	dss_mgr_disable(mgr);
 
 	p = &hdmi.ip_data.cfg.timings;
@@ -548,17 +585,6 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 
 	hdmi.ip_data.ops->video_configure(&hdmi.ip_data);
 
-	/* Make selection of HDMI in DSS */
-	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
-
-	/* Select the dispc clock source as PRCM clock, to ensure that it is not
-	 * DSI PLL source as the clock selected by DSI PLL might not be
-	 * sufficient for the resolution selected / that can be changed
-	 * dynamically by user. This can be moved to single location , say
-	 * Boardfile.
-	 */
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
-
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
 
@@ -582,16 +608,11 @@ err_vid_enable:
 err_phy_enable:
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
 err_pll_enable:
-	hdmi_runtime_put();
-err_runtime_get:
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
-err_vdac_enable:
-	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
-	gpio_set_value(hdmi.ls_oe_gpio, 0);
+	hdmi_power_off_core(dssdev);
 	return -EIO;
 }
 
-static void hdmi_power_off(struct omap_dss_device *dssdev)
+static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = dssdev->output->manager;
 
@@ -600,12 +621,8 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
 	hdmi.ip_data.ops->video_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->phy_disable(&hdmi.ip_data);
 	hdmi.ip_data.ops->pll_disable(&hdmi.ip_data);
-	hdmi_runtime_put();
 
-	regulator_disable(hdmi.vdda_hdmi_dac_reg);
-
-	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
-	gpio_set_value(hdmi.ls_oe_gpio, 0);
+	hdmi_power_off_core(dssdev);
 }
 
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
@@ -713,7 +730,7 @@ int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
-	r = hdmi_power_on(dssdev);
+	r = hdmi_power_on_full(dssdev);
 	if (r) {
 		DSSERR("failed to power on device\n");
 		goto err1;
@@ -735,7 +752,7 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&hdmi.lock);
 
-	hdmi_power_off(dssdev);
+	hdmi_power_off_full(dssdev);
 
 	omap_dss_stop_device(dssdev);
 
-- 
1.7.9.5

