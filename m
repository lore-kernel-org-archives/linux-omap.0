From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/27] OMAPDSS: HDMI: Add ops
Date: Thu, 30 May 2013 12:36:07 +0300
Message-ID: <1369906580-27585-15-git-send-email-tomi.valkeinen@ti.com>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42842 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030431Ab3E3JhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:37:07 -0400
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "ops" style method for using HDMI functionality.

Ops style calls will allow us to have arbitrarily long display
pipelines, where each entity can call ops in the previous display
entity.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c | 248 ++++++++++++++++++++++++++++++++++++++++-
 include/video/omapdss.h        |  47 +++++++-
 2 files changed, 284 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 42376d1..9420923 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -70,6 +70,8 @@ static struct {
 	int ls_oe_gpio;
 	int hpd_gpio;
 
+	bool core_enabled;
+
 	struct omap_dss_device output;
 } hdmi;
 
@@ -521,8 +523,10 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
-	gpio_set_value(hdmi.ls_oe_gpio, 1);
+	if (gpio_is_valid(hdmi.ct_cp_hpd_gpio))
+		gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
+	if (gpio_is_valid(hdmi.ls_oe_gpio))
+		gpio_set_value(hdmi.ls_oe_gpio, 1);
 
 	/* wait 300us after CT_CP_HPD for the 5V power output to reach 90% */
 	udelay(300);
@@ -538,22 +542,30 @@ static int hdmi_power_on_core(struct omap_dss_device *dssdev)
 	/* Make selection of HDMI in DSS */
 	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
 
+	hdmi.core_enabled = true;
+
 	return 0;
 
 err_runtime_get:
 	regulator_disable(hdmi.vdda_hdmi_dac_reg);
 err_vdac_enable:
-	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
-	gpio_set_value(hdmi.ls_oe_gpio, 0);
+	if (gpio_is_valid(hdmi.ct_cp_hpd_gpio))
+		gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	if (gpio_is_valid(hdmi.ls_oe_gpio))
+		gpio_set_value(hdmi.ls_oe_gpio, 0);
 	return r;
 }
 
 static void hdmi_power_off_core(struct omap_dss_device *dssdev)
 {
+	hdmi.core_enabled = false;
+
 	hdmi_runtime_put();
 	regulator_disable(hdmi.vdda_hdmi_dac_reg);
-	gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
-	gpio_set_value(hdmi.ls_oe_gpio, 0);
+	if (gpio_is_valid(hdmi.ct_cp_hpd_gpio))
+		gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
+	if (gpio_is_valid(hdmi.ls_oe_gpio))
+		gpio_set_value(hdmi.ls_oe_gpio, 0);
 }
 
 static int hdmi_power_on_full(struct omap_dss_device *dssdev)
@@ -666,6 +678,18 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 	mutex_unlock(&hdmi.lock);
 }
 
+static void omapdss_hdmi_display_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	const struct hdmi_config *cfg;
+
+	cfg = hdmi_get_timings();
+	if (cfg == NULL)
+		cfg = &vesa_timings[0];
+
+	memcpy(timings, &cfg->timings, sizeof(cfg->timings));
+}
+
 static void hdmi_dump_regs(struct seq_file *s)
 {
 	mutex_lock(&hdmi.lock);
@@ -1033,6 +1057,213 @@ static int hdmi_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int hdmi_connect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	struct omap_overlay_manager *mgr;
+	int r;
+
+	dss_init_hdmi_ip_ops(&hdmi.ip_data, omapdss_get_version());
+
+	r = hdmi_init_regulator();
+	if (r)
+		return r;
+
+	mgr = omap_dss_get_overlay_manager(dssdev->dispc_channel);
+	if (!mgr)
+		return -ENODEV;
+
+	r = dss_mgr_connect(mgr, dssdev);
+	if (r)
+		return r;
+
+	r = omapdss_output_set_device(dssdev, dst);
+	if (r) {
+		DSSERR("failed to connect output to new device: %s\n",
+				dst->name);
+		dss_mgr_disconnect(mgr, dssdev);
+		return r;
+	}
+
+	return 0;
+}
+
+static void hdmi_disconnect(struct omap_dss_device *dssdev,
+		struct omap_dss_device *dst)
+{
+	WARN_ON(dst != dssdev->device);
+
+	if (dst != dssdev->device)
+		return;
+
+	omapdss_output_unset_device(dssdev);
+
+	if (dssdev->manager)
+		dss_mgr_disconnect(dssdev->manager, dssdev);
+}
+
+static void omapdss_hdmi_set_hpd_gpio(struct omap_dss_device *dssdev,
+			int hpd_gpio)
+{
+	hdmi.hpd_gpio = hpd_gpio;
+}
+
+static int hdmi_read_edid(struct omap_dss_device *dssdev,
+		u8 *edid, int len)
+{
+	bool need_enable;
+	int r;
+
+	need_enable = hdmi.core_enabled == false;
+
+	if (need_enable) {
+		r = omapdss_hdmi_core_enable(dssdev);
+		if (r)
+			return r;
+	}
+
+	r = omapdss_hdmi_read_edid(edid, len);
+
+	if (need_enable)
+		omapdss_hdmi_core_disable(dssdev);
+
+	return r;
+}
+
+static bool hdmi_detect(struct omap_dss_device *dssdev)
+{
+	return omapdss_hdmi_detect();
+}
+
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int omapdss_hdmi_audio_enable(struct omap_dss_device *dssdev)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	if (!hdmi_mode_has_audio()) {
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_audio_enable();
+	if (r)
+		goto err;
+
+	mutex_unlock(&hdmi.lock);
+	return 0;
+
+err:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+static void omapdss_hdmi_audio_disable(struct omap_dss_device *dssdev)
+{
+	hdmi_audio_disable();
+}
+
+static int omapdss_hdmi_audio_start(struct omap_dss_device *dssdev)
+{
+	return hdmi_audio_start();
+}
+
+static void omapdss_hdmi_audio_stop(struct omap_dss_device *dssdev)
+{
+	hdmi_audio_stop();
+}
+
+static bool omapdss_hdmi_audio_supported(struct omap_dss_device *dssdev)
+{
+	bool r;
+
+	mutex_lock(&hdmi.lock);
+
+	r = hdmi_mode_has_audio();
+
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+static int omapdss_hdmi_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio)
+{
+	int r;
+
+	mutex_lock(&hdmi.lock);
+
+	if (!hdmi_mode_has_audio()) {
+		r = -EPERM;
+		goto err;
+	}
+
+	r = hdmi_audio_config(audio);
+	if (r)
+		goto err;
+
+	mutex_unlock(&hdmi.lock);
+	return 0;
+
+err:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+#else
+static int omapdss_hdmi_audio_enable(struct omap_dss_device *dssdev)
+{
+	return -EPERM;
+}
+
+static void omapdss_hdmi_audio_disable(struct omap_dss_device *dssdev)
+{
+}
+
+static int omapdss_hdmi_audio_start(struct omap_dss_device *dssdev)
+{
+	return -EPERM;
+}
+
+static void omapdss_hdmi_audio_stop(struct omap_dss_device *dssdev)
+{
+}
+
+static bool omapdss_hdmi_audio_supported(struct omap_dss_device *dssdev)
+{
+	return false;
+}
+
+static int omapdss_hdmi_audio_config(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio)
+{
+	return -EPERM;
+}
+#endif
+
+static const struct omapdss_hdmi_ops hdmi_ops = {
+	.connect		= hdmi_connect,
+	.disconnect		= hdmi_disconnect,
+
+	.enable			= omapdss_hdmi_display_enable,
+	.disable		= omapdss_hdmi_display_disable,
+
+	.check_timings		= omapdss_hdmi_display_check_timing,
+	.set_timings		= omapdss_hdmi_display_set_timing,
+	.get_timings		= omapdss_hdmi_display_get_timings,
+
+	.set_hpd_gpio		= omapdss_hdmi_set_hpd_gpio,
+
+	.read_edid		= hdmi_read_edid,
+	.detect			= hdmi_detect,
+
+	.audio_enable		= omapdss_hdmi_audio_enable,
+	.audio_disable		= omapdss_hdmi_audio_disable,
+	.audio_start		= omapdss_hdmi_audio_start,
+	.audio_stop		= omapdss_hdmi_audio_stop,
+	.audio_supported	= omapdss_hdmi_audio_supported,
+	.audio_config		= omapdss_hdmi_audio_config,
+};
+
 static void hdmi_init_output(struct platform_device *pdev)
 {
 	struct omap_dss_device *out = &hdmi.output;
@@ -1042,6 +1273,7 @@ static void hdmi_init_output(struct platform_device *pdev)
 	out->output_type = OMAP_DISPLAY_TYPE_HDMI;
 	out->name = "hdmi.0";
 	out->dispc_channel = OMAP_DSS_CHANNEL_DIGIT;
+	out->ops.hdmi = &hdmi_ops;
 	out->owner = THIS_MODULE;
 
 	omapdss_register_output(out);
@@ -1089,6 +1321,10 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
 	hdmi.ip_data.phy_offset = HDMI_PHY;
 
+	hdmi.ct_cp_hpd_gpio = -1;
+	hdmi.ls_oe_gpio = -1;
+	hdmi.hpd_gpio = -1;
+
 	hdmi_init_output(pdev);
 
 	r = hdmi_panel_init();
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cb6c478..f0aee54 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -172,6 +172,11 @@ enum omap_dss_audio_state {
 	OMAP_DSS_AUDIO_PLAYING,
 };
 
+struct omap_dss_audio {
+	struct snd_aes_iec958 *iec;
+	struct snd_cea_861_aud_if *cea;
+};
+
 enum omap_dss_rotation_type {
 	OMAP_DSS_ROT_DMA	= 1 << 0,
 	OMAP_DSS_ROT_VRFB	= 1 << 1,
@@ -653,6 +658,42 @@ struct omapdss_atv_ops {
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 };
 
+struct omapdss_hdmi_ops {
+	int (*connect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+	void (*disconnect)(struct omap_dss_device *dssdev,
+			struct omap_dss_device *dst);
+
+	int (*enable)(struct omap_dss_device *dssdev);
+	void (*disable)(struct omap_dss_device *dssdev);
+
+	int (*check_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*set_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+	void (*get_timings)(struct omap_dss_device *dssdev,
+			struct omap_video_timings *timings);
+
+	void (*set_hpd_gpio)(struct omap_dss_device *dssdev,
+			int hpd_gpio);
+
+	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
+	bool (*detect)(struct omap_dss_device *dssdev);
+
+	/*
+	 * Note: These functions might sleep. Do not call while
+	 * holding a spinlock/readlock.
+	 */
+	int (*audio_enable)(struct omap_dss_device *dssdev);
+	void (*audio_disable)(struct omap_dss_device *dssdev);
+	bool (*audio_supported)(struct omap_dss_device *dssdev);
+	int (*audio_config)(struct omap_dss_device *dssdev,
+		struct omap_dss_audio *audio);
+	/* Note: These functions may not sleep */
+	int (*audio_start)(struct omap_dss_device *dssdev);
+	void (*audio_stop)(struct omap_dss_device *dssdev);
+};
+
 struct omap_dss_device {
 	/* old device, to be removed */
 	struct device old_dev;
@@ -729,6 +770,7 @@ struct omap_dss_device {
 		const struct omapdss_dpi_ops *dpi;
 		const struct omapdss_sdi_ops *sdi;
 		const struct omapdss_dvi_ops *dvi;
+		const struct omapdss_hdmi_ops *hdmi;
 		const struct omapdss_atv_ops *atv;
 	} ops;
 
@@ -773,11 +815,6 @@ struct omap_dss_hdmi_data
 	int hpd_gpio;
 };
 
-struct omap_dss_audio {
-	struct snd_aes_iec958 *iec;
-	struct snd_cea_861_aud_if *cea;
-};
-
 struct omap_dss_driver {
 	struct device_driver driver;
 
-- 
1.8.1.2

