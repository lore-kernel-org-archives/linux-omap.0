From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/5] ASoC: sdp4430: Add support for digital microphones
Date: Tue, 22 Nov 2011 16:02:00 +0200
Message-ID: <1321970520-8909-6-git-send-email-peter.ujfalusi@ti.com>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37944 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755697Ab1KVOC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 09:02:29 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so197092eye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 06:02:28 -0800 (PST)
In-Reply-To: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

OMAP4 SDP/Blaze boards have digital microphones.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig   |    2 +
 sound/soc/omap/sdp4430.c |   84 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 052254a..fb1bf25 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -100,8 +100,10 @@ config SND_OMAP_SOC_SDP3430
 config SND_OMAP_SOC_SDP4430
 	tristate "SoC Audio support for Texas Instruments SDP4430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
+	select SND_SOC_DMIC
 	help
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP4430.
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 03d9fa4..a8c4926 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -33,6 +33,7 @@
 #include <plat/hardware.h>
 #include <plat/mux.h>
 
+#include "omap-dmic.h"
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 #include "../codecs/twl6040.h"
@@ -67,6 +68,31 @@ static struct snd_soc_ops sdp4430_ops = {
 	.hw_params = sdp4430_hw_params,
 };
 
+static int sdp4430_dmic_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_DMIC_SYSCLK_PAD_CLKS,
+				     19200000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set DMIC cpu system clock\n");
+		return ret;
+	}
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_DMIC_CLKDIV, 8);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set DMIC cpu clock divider\n");
+		return ret;
+	}
+	return 0;
+}
+
+static struct snd_soc_ops sdp4430_dmic_ops = {
+	.hw_params = sdp4430_dmic_hw_params,
+};
+
 /* Headset jack */
 static struct snd_soc_jack hs_jack;
 
@@ -148,23 +174,59 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static const struct snd_soc_dapm_widget sdp4430_dmic_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Digital Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route dmic_audio_map[] = {
+	{"DMic", NULL, "Digital Mic1 Bias"},
+	{"Digital Mic1 Bias", NULL, "Digital Mic"},
+};
+
+static int sdp4430_dmic_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, sdp4430_dmic_dapm_widgets,
+				ARRAY_SIZE(sdp4430_dmic_dapm_widgets));
+	if (ret)
+		return ret;
+
+	return snd_soc_dapm_add_routes(dapm, dmic_audio_map,
+				ARRAY_SIZE(dmic_audio_map));
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link sdp4430_dai = {
-	.name = "TWL6040",
-	.stream_name = "TWL6040",
-	.cpu_dai_name = "omap-mcpdm",
-	.codec_dai_name = "twl6040-legacy",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "twl6040-codec",
-	.init = sdp4430_twl6040_init,
-	.ops = &sdp4430_ops,
+static struct snd_soc_dai_link sdp4430_dai[] = {
+	{
+		.name = "TWL6040",
+		.stream_name = "TWL6040",
+		.cpu_dai_name = "omap-mcpdm",
+		.codec_dai_name = "twl6040-legacy",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl6040-codec",
+		.init = sdp4430_twl6040_init,
+		.ops = &sdp4430_ops,
+	},
+	{
+		.name = "DMIC",
+		.stream_name = "DMIC Capture",
+		.cpu_dai_name = "omap-dmic",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "dmic-codec",
+		.init = sdp4430_dmic_init,
+		.ops = &sdp4430_dmic_ops,
+	},
 };
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_sdp4430 = {
 	.name = "SDP4430",
-	.dai_link = &sdp4430_dai,
-	.num_links = 1,
+	.dai_link = sdp4430_dai,
+	.num_links = ARRAY_SIZE(sdp4430_dai),
 
 	.dapm_widgets = sdp4430_twl6040_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(sdp4430_twl6040_dapm_widgets),
-- 
1.7.8.rc3

