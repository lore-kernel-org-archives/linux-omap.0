From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 07/13] OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
Date: Fri, 27 Jun 2014 21:38:49 +0300
Message-ID: <d17af10b870cd5911322e35a3ba9a37f6635793d.1403894190.git.jsarha@ti.com>
References: <cover.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42180 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbaF0SjU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 14:39:20 -0400
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

Call register and unregister functions form hdmi_audio.c. Register
function registers the integrated cpu dai, dummy HDMI codec, and
simple-card machine driver for complete HDMI audio support.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi4.c |   34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/video/fbdev/omap2/dss/hdmi4.c
index 58f1295..3840f3f 100644
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
@@ -656,6 +659,21 @@ err:
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
@@ -714,6 +732,19 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_init_output(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	hdmi.audio.hdmi_dai_drv = &omap_hdmi_dai;
+	hdmi.audio.audio_start = hdmi4_audio_start;
+	hdmi.audio.audio_stop = hdmi4_audio_stop;
+	hdmi.audio.audio_config = hdmi4_audio_config;
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
@@ -721,6 +752,9 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	hdmi_audio_unregister(pdev);
+#endif
 	hdmi_uninit_output(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.9.5

