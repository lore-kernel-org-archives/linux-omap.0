From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC v3 2/7] ASoC: hdmi: Remove obsolete dummy HDMI codec
Date: Fri, 14 Aug 2015 12:30:40 +0300
Message-ID: <360a38c83ae2a24620da85b8496b745326d995de.1439542916.git.jsarha@ti.com>
References: <cover.1439542916.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1439542916.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The hdmi stub codec has not been used since refactoring of OMAP HDMI
audio support.

Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/Kconfig  |   4 --
 sound/soc/codecs/Makefile |   2 -
 sound/soc/codecs/hdmi.c   | 109 ----------------------------------------------
 3 files changed, 115 deletions(-)
 delete mode 100644 sound/soc/codecs/hdmi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce..fc8e729 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -76,7 +76,6 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_MC13783 if MFD_MC13XXX
 	select SND_SOC_ML26124 if I2C
-	select SND_SOC_HDMI_CODEC
 	select SND_SOC_PCM1681 if I2C
 	select SND_SOC_PCM1792A if SPI_MASTER
 	select SND_SOC_PCM3008
@@ -432,9 +431,6 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
-config SND_SOC_HDMI_CODEC
-       tristate "HDMI stub CODEC"
-
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index cf160d9..01b4601 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -69,7 +69,6 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
-snd-soc-hdmi-codec-objs := hdmi.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm1792a-codec-objs := pcm1792a.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -256,7 +255,6 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
-obj-$(CONFIG_SND_SOC_HDMI_CODEC) += snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM1792A)	+= snd-soc-pcm1792a-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
diff --git a/sound/soc/codecs/hdmi.c b/sound/soc/codecs/hdmi.c
deleted file mode 100644
index bd42ad3..0000000
--- a/sound/soc/codecs/hdmi.c
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * ALSA SoC codec driver for HDMI audio codecs.
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
- * Author: Ricardo Neri <ricardo.neri-l0cyMroinI0@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-#include <linux/module.h>
-#include <sound/soc.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-
-#define DRV_NAME "hdmi-audio-codec"
-
-static const struct snd_soc_dapm_widget hdmi_widgets[] = {
-	SND_SOC_DAPM_INPUT("RX"),
-	SND_SOC_DAPM_OUTPUT("TX"),
-};
-
-static const struct snd_soc_dapm_route hdmi_routes[] = {
-	{ "Capture", NULL, "RX" },
-	{ "TX", NULL, "Playback" },
-};
-
-static struct snd_soc_dai_driver hdmi_codec_dai = {
-	.name = "hdmi-hifi",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 8,
-		.rates = SNDRV_PCM_RATE_32000 |
-			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
-		.sig_bits = 24,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_32000 |
-			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S24_LE,
-	},
-
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id hdmi_audio_codec_ids[] = {
-	{ .compatible = "linux,hdmi-audio", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, hdmi_audio_codec_ids);
-#endif
-
-static struct snd_soc_codec_driver hdmi_codec = {
-	.dapm_widgets = hdmi_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
-	.dapm_routes = hdmi_routes,
-	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
-	.ignore_pmdown_time = true,
-};
-
-static int hdmi_codec_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_codec(&pdev->dev, &hdmi_codec,
-			&hdmi_codec_dai, 1);
-}
-
-static int hdmi_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver hdmi_codec_driver = {
-	.driver		= {
-		.name	= DRV_NAME,
-		.of_match_table = of_match_ptr(hdmi_audio_codec_ids),
-	},
-
-	.probe		= hdmi_codec_probe,
-	.remove		= hdmi_codec_remove,
-};
-
-module_platform_driver(hdmi_codec_driver);
-
-MODULE_AUTHOR("Ricardo Neri <ricardo.neri-l0cyMroinI0@public.gmane.org>");
-MODULE_DESCRIPTION("ASoC generic HDMI codec driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
