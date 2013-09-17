From: Archit Taneja <archit@ti.com>
Subject: [PATCH 05/11] omapdss: HDMI: remove hdmi_ip_data struct
Date: Tue, 17 Sep 2013 12:36:31 +0530
Message-ID: <1379401597-27222-6-git-send-email-archit@ti.com>
References: <1379401597-27222-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34371 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab3IQHHp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Sep 2013 03:07:45 -0400
In-Reply-To: <1379401597-27222-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The struct hdmi_ip_data contains information related to HDMI wrapper, PLL, PHY
and core sub-blocks. Now that each of these sub blocks has it's own struct,
hdmi_ip_data serves no purpose. The mutex lock in the struct was also never
used.

Remove this struct to make things cleaner.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/hdmi.c    | 91 ++++++++++++++++++++-------------------
 drivers/video/omap2/dss/ti_hdmi.h | 14 ------
 2 files changed, 47 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0e9ecd6..f03d6c7 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -53,7 +53,12 @@ static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
 
-	struct hdmi_ip_data ip_data;
+	struct hdmi_wp_data	wp;
+	struct hdmi_pll_data	pll;
+	struct hdmi_phy_data	phy;
+	struct hdmi_core_data	core;
+
+	struct hdmi_config cfg;
 
 	struct clk *sys_clk;
 	struct regulator *vdda_hdmi_dac_reg;
@@ -348,7 +353,7 @@ static const struct hdmi_config *hdmi_find_timing(
 	int i;
 
 	for (i = 0; i < len; i++) {
-		if (timings_arr[i].cm.code == hdmi.ip_data.cfg.cm.code)
+		if (timings_arr[i].cm.code == hdmi.cfg.cm.code)
 			return &timings_arr[i];
 	}
 	return NULL;
@@ -359,15 +364,15 @@ static const struct hdmi_config *hdmi_get_timings(void)
        const struct hdmi_config *arr;
        int len;
 
-       if (hdmi.ip_data.cfg.cm.mode == HDMI_DVI) {
-               arr = vesa_timings;
-               len = ARRAY_SIZE(vesa_timings);
-       } else {
-               arr = cea_timings;
-               len = ARRAY_SIZE(cea_timings);
-       }
+	if (hdmi.cfg.cm.mode == HDMI_DVI) {
+		arr = vesa_timings;
+		len = ARRAY_SIZE(vesa_timings);
+	} else {
+		arr = cea_timings;
+		len = ARRAY_SIZE(cea_timings);
+	}
 
-       return hdmi_find_timing(arr, len);
+	return hdmi_find_timing(arr, len);
 }
 
 static bool hdmi_timings_compare(struct omap_video_timings *timing1,
@@ -467,32 +472,30 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(mgr);
 
-	p = &hdmi.ip_data.cfg.timings;
+	p = &hdmi.cfg.timings;
 
 	DSSDBG("hdmi_power_on x_res= %d y_res = %d\n", p->x_res, p->y_res);
 
 	phy = p->pixel_clock;
 
-	hdmi_pll_compute(&hdmi.ip_data.pll, clk_get_rate(hdmi.sys_clk), phy);
+	hdmi_pll_compute(&hdmi.pll, clk_get_rate(hdmi.sys_clk), phy);
 
-	hdmi_wp_video_stop(&hdmi.ip_data.wp);
+	hdmi_wp_video_stop(&hdmi.wp);
 
 	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
-	r = hdmi_pll_enable(&hdmi.ip_data.pll, &hdmi.ip_data.wp);
+	r = hdmi_pll_enable(&hdmi.pll, &hdmi.wp);
 	if (r) {
 		DSSDBG("Failed to lock PLL\n");
 		goto err_pll_enable;
 	}
 
-	r = hdmi_phy_enable(&hdmi.ip_data.phy, &hdmi.ip_data.wp,
-		&hdmi.ip_data.cfg);
+	r = hdmi_phy_enable(&hdmi.phy, &hdmi.wp, &hdmi.cfg);
 	if (r) {
 		DSSDBG("Failed to start PHY\n");
 		goto err_phy_enable;
 	}
 
-	hdmi4_configure(&hdmi.ip_data.core, &hdmi.ip_data.wp,
-		&hdmi.ip_data.cfg);
+	hdmi4_configure(&hdmi.core, &hdmi.wp, &hdmi.cfg);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
@@ -500,7 +503,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	/* tv size */
 	dss_mgr_set_timings(mgr, p);
 
-	r = hdmi_wp_video_start(&hdmi.ip_data.wp);
+	r = hdmi_wp_video_start(&hdmi.wp);
 	if (r)
 		goto err_vid_enable;
 
@@ -511,11 +514,11 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	return 0;
 
 err_mgr_enable:
-	hdmi_wp_video_stop(&hdmi.ip_data.wp);
+	hdmi_wp_video_stop(&hdmi.wp);
 err_vid_enable:
-	hdmi_phy_disable(&hdmi.ip_data.phy, &hdmi.ip_data.wp);
+	hdmi_phy_disable(&hdmi.phy, &hdmi.wp);
 err_phy_enable:
-	hdmi_pll_disable(&hdmi.ip_data.pll, &hdmi.ip_data.wp);
+	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
 err_pll_enable:
 	hdmi_power_off_core(dssdev);
 	return -EIO;
@@ -527,9 +530,9 @@ static void hdmi_power_off_full(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(mgr);
 
-	hdmi_wp_video_stop(&hdmi.ip_data.wp);
-	hdmi_phy_disable(&hdmi.ip_data.phy, &hdmi.ip_data.wp);
-	hdmi_pll_disable(&hdmi.ip_data.pll, &hdmi.ip_data.wp);
+	hdmi_wp_video_stop(&hdmi.wp);
+	hdmi_phy_disable(&hdmi.phy, &hdmi.wp);
+	hdmi_pll_disable(&hdmi.pll, &hdmi.wp);
 
 	hdmi_power_off_core(dssdev);
 }
@@ -557,11 +560,11 @@ static void hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	mutex_lock(&hdmi.lock);
 
 	cm = hdmi_get_code(timings);
-	hdmi.ip_data.cfg.cm = cm;
+	hdmi.cfg.cm = cm;
 
 	t = hdmi_get_timings();
 	if (t != NULL) {
-		hdmi.ip_data.cfg = *t;
+		hdmi.cfg = *t;
 
 		dispc_set_tv_pclk(t->timings.pixel_clock * 1000);
 	}
@@ -590,10 +593,10 @@ static void hdmi_dump_regs(struct seq_file *s)
 		return;
 	}
 
-	hdmi_wp_dump(&hdmi.ip_data.wp, s);
-	hdmi_pll_dump(&hdmi.ip_data.pll, s);
-	hdmi_phy_dump(&hdmi.ip_data.phy, s);
-	hdmi4_core_dump(&hdmi.ip_data.core, s);
+	hdmi_wp_dump(&hdmi.wp, s);
+	hdmi_pll_dump(&hdmi.pll, s);
+	hdmi_phy_dump(&hdmi.phy, s);
+	hdmi4_core_dump(&hdmi.core, s);
 
 	hdmi_runtime_put();
 	mutex_unlock(&hdmi.lock);
@@ -608,7 +611,7 @@ static int read_edid(u8 *buf, int len)
 	r = hdmi_runtime_get();
 	BUG_ON(r);
 
-	r = hdmi4_read_edid(&hdmi.ip_data.core,  buf, len);
+	r = hdmi4_read_edid(&hdmi.core,  buf, len);
 
 	hdmi_runtime_put();
 	mutex_unlock(&hdmi.lock);
@@ -709,7 +712,7 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
 	bool deep_color_correct = false;
-	u32 pclk = hdmi.ip_data.cfg.timings.pixel_clock;
+	u32 pclk = hdmi.cfg.timings.pixel_clock;
 
 	if (n == NULL || cts == NULL)
 		return -EINVAL;
@@ -807,11 +810,12 @@ int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 
 static bool hdmi_mode_has_audio(void)
 {
-	if (hdmi.ip_data.cfg.cm.mode == HDMI_HDMI)
+	if (hdmi.cfg.cm.mode == HDMI_HDMI)
 		return true;
 	else
 		return false;
 }
+
 #endif
 
 static int hdmi_connect(struct omap_dss_device *dssdev,
@@ -891,7 +895,7 @@ static int hdmi_audio_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	r = hdmi_wp_audio_enable(&hdmi.ip_data.wp, true);
+	r = hdmi_wp_audio_enable(&hdmi.wp, true);
 	if (r)
 		goto err;
 
@@ -905,17 +909,17 @@ err:
 
 static void hdmi_audio_disable(struct omap_dss_device *dssdev)
 {
-	hdmi_wp_audio_enable(&hdmi.ip_data.wp, false);
+	hdmi_wp_audio_enable(&hdmi.wp, false);
 }
 
 static int hdmi_audio_start(struct omap_dss_device *dssdev)
 {
-	return hdmi4_audio_start(&hdmi.ip_data.core, &hdmi.ip_data.wp);
+	return hdmi4_audio_start(&hdmi.core, &hdmi.wp);
 }
 
 static void hdmi_audio_stop(struct omap_dss_device *dssdev)
 {
-	hdmi4_audio_stop(&hdmi.ip_data.core, &hdmi.ip_data.wp);
+	hdmi4_audio_stop(&hdmi.core, &hdmi.wp);
 }
 
 static bool hdmi_audio_supported(struct omap_dss_device *dssdev)
@@ -942,7 +946,7 @@ static int hdmi_audio_config(struct omap_dss_device *dssdev,
 		goto err;
 	}
 
-	r = hdmi4_audio_config(&hdmi.ip_data.core, &hdmi.ip_data.wp, audio);
+	r = hdmi4_audio_config(&hdmi.core, &hdmi.wp, audio);
 	if (r)
 		goto err;
 
@@ -1035,21 +1039,20 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.pdev = pdev;
 
 	mutex_init(&hdmi.lock);
-	mutex_init(&hdmi.ip_data.lock);
 
-	r = hdmi_wp_init(pdev, &hdmi.ip_data.wp);
+	r = hdmi_wp_init(pdev, &hdmi.wp);
 	if (r)
 		return r;
 
-	r = hdmi_pll_init(pdev, &hdmi.ip_data.pll);
+	r = hdmi_pll_init(pdev, &hdmi.pll);
 	if (r)
 		return r;
 
-	r = hdmi_phy_init(pdev, &hdmi.ip_data.phy);
+	r = hdmi_phy_init(pdev, &hdmi.phy);
 	if (r)
 		return r;
 
-	r = hdmi4_core_init(pdev, &hdmi.ip_data.core);
+	r = hdmi4_core_init(pdev, &hdmi.core);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
index 9eb9b32..107a606 100644
--- a/drivers/video/omap2/dss/ti_hdmi.h
+++ b/drivers/video/omap2/dss/ti_hdmi.h
@@ -23,8 +23,6 @@
 
 #include <linux/platform_device.h>
 
-struct hdmi_ip_data;
-
 enum hdmi_pll_pwr {
 	HDMI_PLLPWRCMD_ALLOFF = 0,
 	HDMI_PLLPWRCMD_PLLONLY = 1,
@@ -208,18 +206,6 @@ struct hdmi_core_data {
 	struct hdmi_core_infoframe_avi avi_cfg;
 };
 
-struct hdmi_ip_data {
-	struct hdmi_wp_data	wp;
-	struct hdmi_pll_data	pll;
-	struct hdmi_phy_data	phy;
-	struct hdmi_core_data	core;
-
-	struct hdmi_config cfg;
-
-	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
-	struct mutex lock;
-};
-
 /* HDMI wrapper funcs */
 int hdmi_wp_video_start(struct hdmi_wp_data *wp);
 void hdmi_wp_video_stop(struct hdmi_wp_data *wp);
-- 
1.8.1.2

