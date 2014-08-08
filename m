From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 08/14] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
Date: Fri, 8 Aug 2014 16:23:49 +0300
Message-ID: <e1efcf27e2c9a3f6b9f477eda8614965bc3cdf51.1407503813.git.jsarha@ti.com>
References: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080AbaHHNYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:17 -0400
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
 drivers/video/fbdev/omap2/dss/hdmi4.c |   87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index b98186e..707dcec 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -34,6 +34,9 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
 #include "hdmi4_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -655,6 +658,73 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
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
+	int ret = 0;
+
+	if (enable)
+		ret = hdmi4_audio_start(&hd->core, &hd->wp);
+	else
+		hdmi4_audio_stop(&hd->core, &hd->wp);
+
+	return ret;
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
+		ret = hdmi4_audio_config(&hd->core, &hd->wp, dss_audio,
+					 hd->cfg.timings.pixelclock);
+	mutex_unlock(&hd->lock);
+
+	return ret;
+}
+
+static struct snd_soc_dai_driver omap_hdmi_dai = {
+	.name = "omap4-hdmi-dai",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+			  SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |
+			  SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 |
+			  SNDRV_PCM_RATE_192000),
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+};
+#endif
+
 /* HDMI HW IP initialisation */
 static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
@@ -712,6 +782,20 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
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
@@ -719,6 +803,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

