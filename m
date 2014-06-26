From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 08/12] OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
Date: Thu, 26 Jun 2014 22:20:59 +0300
Message-ID: <4bc595e2f43e56e88e7bfc82d4ca2a639cc452df.1403807781.git.jsarha@ti.com>
References: <cover.1403807781.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36329 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbaFZTVg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2014 15:21:36 -0400
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
 drivers/video/fbdev/omap2/dss/hdmi5.c |   57 +++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/video/fbdev/omap2/dss/hdmi5.c
index 713e35a..b49b33b 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/dss/hdmi5.c
@@ -43,6 +43,11 @@
 #include "dss.h"
 #include "dss_features.h"
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#endif
+
 static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
@@ -57,6 +62,9 @@ static struct {
 	struct clk *sys_clk;
 	struct regulator *vdda_reg;
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	struct hdmi_audio_data audio;
+#endif
 	bool core_enabled;
 
 	struct omap_dss_device output;
@@ -696,6 +704,33 @@ err:
 	return r;
 }
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+static int audio_start(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
+{
+	hdmi_wp_audio_core_req_enable(wp, true);
+
+	return 0;
+}
+
+static void audio_stop(struct hdmi_core_data *core, struct hdmi_wp_data *wp)
+{
+	hdmi_wp_audio_core_req_enable(wp, false);
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
@@ -752,6 +787,25 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	/* drvdata is only used by HDMI audio */
+	hdmi.audio.hdmi_lock = &hdmi.lock;
+	hdmi.audio.wp = &hdmi.wp;
+	hdmi.audio.core = &hdmi.core;
+	hdmi.audio.cfg = &hdmi.cfg;
+	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
+	hdmi.audio.audio_start = audio_start;
+	hdmi.audio.audio_stop = audio_stop;
+	hdmi.audio.audio_config = hdmi5_audio_config;
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
@@ -759,6 +813,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP5_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

