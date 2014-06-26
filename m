From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 06/12] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
Date: Thu, 26 Jun 2014 22:20:57 +0300
Message-ID: <f61b31d0b08c8a0b6ee295d5b0da62ead23983c9.1403807781.git.jsarha@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48988 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbaFZTVj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 15:21:39 -0400
In-Reply-To: <cover.1403807781.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Add audio datamember to hdmi struct and call register and unregister
functions form hdmi_audio.c. Register function registers the
integrated cpu dai, dummy HDMI codec, and simple-card machine driver
for complete HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |   45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 342ddb4..48f11f8 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi4.c
@@ -34,6 +34,11 @@
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#endif
+
 #include "hdmi4_core.h"
 #include "dss.h"
 #include "dss_features.h"
@@ -52,6 +57,9 @@ static struct {
 	struct clk *sys_clk;
 	struct regulator *vdda_hdmi_dac_reg;
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	struct hdmi_audio_data audio;
+#endif
 	bool core_enabled;
 
 	struct omap_dss_device output;
@@ -671,6 +679,21 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
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
@@ -727,6 +750,25 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	/* drvdata is only used by HDMI audio */
+	hdmi.audio.hdmi_lock = &hdmi.lock;
+	hdmi.audio.wp = &hdmi.wp;
+	hdmi.audio.core = &hdmi.core;
+	hdmi.audio.cfg = &hdmi.cfg;
+	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
+	hdmi.audio.audio_start = hdmi4_audio_start;
+	hdmi.audio.audio_stop = hdmi4_audio_stop;
+	hdmi.audio.audio_config = hdmi4_audio_config;
+	dev_set_drvdata(&pdev->dev, &hdmi.audio);
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
@@ -734,6 +776,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

