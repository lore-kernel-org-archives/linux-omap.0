From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 10/14] OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
Date: Fri, 8 Aug 2014 16:23:51 +0300
Message-ID: <be0d313cea0b6c5fab98a3adb189a54aae11f56c.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44002 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756659AbaHHNYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:18 -0400
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Initialize the callbacks in struct hdmi_audio_data and call register
and unregister functions form hdmi_audio.c. Register function
registers the integrated cpu dai, dummy HDMI codec, and simple-card
machine driver for complete HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi5.c |   80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 90410f5..d796071 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -39,6 +39,9 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
 #include "hdmi5_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -679,6 +682,66 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+static int mode_has_audio(struct omap_hdmi *hd)
+{
+	int ret;
+
+	mutex_lock(&hd->lock);
+	ret = hdmi_mode_has_audio(&hd->cfg);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int audio_enable(struct omap_hdmi *hd, bool enable)
+{
+	int ret;
+
+	mutex_lock(&hd->lock);
+	if (!hdmi_mode_has_audio(&hd->cfg))
+		ret = -EPERM;
+	else
+		ret = hdmi_wp_audio_enable(&hd->wp, enable);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static int audio_start(struct omap_hdmi *hd, bool enable)
+{
+	return hdmi_wp_audio_core_req_enable(&hd->wp, enable);
+}
+
+static int audio_config(struct omap_hdmi *hd, struct omap_dss_audio *dss_audio)
+{
+	int ret;
+
+	mutex_lock(&hd->lock);
+	if (!hdmi_mode_has_audio(&hd->cfg))
+		ret = -EPERM;
+	else
+		ret = hdmi5_audio_config(&hd->core, &hd->wp, dss_audio,
+					 hd->cfg.timings.pixelclock);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.name = "omap5-hdmi-dai",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+#endif
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -736,6 +799,20 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
+	hdmi.audio.mode_has_audio = mode_has_audio;
+	hdmi.audio.audio_enable = audio_enable;
+	hdmi.audio.audio_start = audio_start;
+	hdmi.audio.audio_config = audio_config;
+	r = hdmi_audio_register(pdev);
+	if (r) {
+		DSSERR("Registering HDMI audio failed\n");
+		hdmi_uninit_output(pdev);
+		pm_runtime_disable(&pdev->dev);
+		return r;
+	}
+#endif
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	return 0;
@@ -743,6 +820,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

