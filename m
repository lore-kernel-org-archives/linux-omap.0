From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 8/8] ASoC: OMAP: Remove obsolete machine drivers for Zoom2 and SDP3430
Date: Mon, 31 Dec 2012 11:51:49 +0100
Message-ID: <1356951109-4286-9-git-send-email-peter.ujfalusi@ti.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab2LaKwy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 05:52:54 -0500
In-Reply-To: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, NeilBrown <neilb@suse.de>

These boards are using the common omap-twl4030 machine driver, no need for
separate machine drivers anymore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig   |  17 ----
 sound/soc/omap/Makefile  |   4 -
 sound/soc/omap/sdp3430.c | 245 -----------------------------------------------
 sound/soc/omap/zoom2.c   | 193 -------------------------------------
 4 files changed, 459 deletions(-)
 delete mode 100644 sound/soc/omap/sdp3430.c
 delete mode 100644 sound/soc/omap/zoom2.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index e8d2a2f..60259f2 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -70,15 +70,6 @@ config SND_OMAP_SOC_AM3517EVM
 	  Say Y if you want to add support for SoC audio on the OMAP3517 / AM3517
 	  EVM.
 
-config SND_OMAP_SOC_SDP3430
-	tristate "SoC Audio support for Texas Instruments SDP3430"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on Texas Instruments
-	  SDP3430.
-
 config SND_OMAP_SOC_OMAP_TWL4030
 	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
 	depends on TWL4030_CORE && SND_OMAP_SOC
@@ -125,11 +116,3 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
-
-config SND_OMAP_SOC_ZOOM2
-	tristate "SoC Audio support for Zoom2"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for Soc audio on Zoom2 board.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 19637e5..2b22594 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -17,11 +17,9 @@ snd-soc-rx51-objs := rx51.o
 snd-soc-ams-delta-objs := ams-delta.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-am3517evm-objs := am3517evm.o
-snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
 snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
-snd-soc-zoom2-objs := zoom2.o
 snd-soc-omap-hdmi-card-objs := omap-hdmi-card.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
@@ -30,9 +28,7 @@ obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
-obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
-obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap-hdmi-card.o
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
deleted file mode 100644
index 216cbdd..0000000
--- a/sound/soc/omap/sdp3430.c
+++ /dev/null
@@ -1,245 +0,0 @@
-/*
- * sdp3430.c  --  SoC audio for TI OMAP3430 SDP
- *
- * Author: Misael Lopez Cruz <x0052729@ti.com>
- *
- * Based on:
- * Author: Steve Sakoman <steve@sakoman.com>
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
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/jack.h>
-
-#include <asm/mach-types.h>
-#include <linux/platform_data/gpio-omap.h>
-
-#include <linux/module.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static struct snd_soc_card snd_soc_sdp3430;
-
-static int sdp3430_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops sdp3430_ops = {
-	.hw_params = sdp3430_hw_params,
-};
-
-/* Headset jack */
-static struct snd_soc_jack hs_jack;
-
-/* Headset jack detection DAPM pins */
-static struct snd_soc_jack_pin hs_jack_pins[] = {
-	{
-		.pin = "Headset Mic",
-		.mask = SND_JACK_MICROPHONE,
-	},
-	{
-		.pin = "Headset Stereophone",
-		.mask = SND_JACK_HEADPHONE,
-	},
-};
-
-/* Headset jack detection gpios */
-static struct snd_soc_jack_gpio hs_jack_gpios[] = {
-	{
-		.gpio = (OMAP_MAX_GPIO_LINES + 2),
-		.name = "hsdet-gpio",
-		.report = SND_JACK_HEADSET,
-		.debounce_time = 200,
-	},
-};
-
-/* SDP3430 machine DAPM */
-static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Ext Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
-};
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	/* External Mics: MAINMIC, SUBMIC with bias */
-	{"MAINMIC", NULL, "Ext Mic"},
-	{"SUBMIC", NULL, "Ext Mic"},
-	{"Ext Mic", NULL, "Mic Bias 1"},
-	{"Ext Mic", NULL, "Mic Bias 2"},
-
-	/* External Speakers: HFL, HFR */
-	{"Ext Spk", NULL, "HFL"},
-	{"Ext Spk", NULL, "HFR"},
-
-	/* Headset Mic: HSMIC with bias */
-	{"HSMIC", NULL, "Headset Mic"},
-	{"Headset Mic", NULL, "Headset Mic Bias"},
-
-	/* Headset Stereophone (Headphone): HSOL, HSOR */
-	{"Headset Stereophone", NULL, "HSOL"},
-	{"Headset Stereophone", NULL, "HSOR"},
-};
-
-static int sdp3430_twl4030_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	/* SDP3430 connected pins */
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_disable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_disable_pin(dapm, "Headset Stereophone");
-
-	/* TWL4030 not connected pins */
-	snd_soc_dapm_nc_pin(dapm, "AUXL");
-	snd_soc_dapm_nc_pin(dapm, "AUXR");
-	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
-	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
-	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
-
-	snd_soc_dapm_nc_pin(dapm, "OUTL");
-	snd_soc_dapm_nc_pin(dapm, "OUTR");
-	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
-	snd_soc_dapm_nc_pin(dapm, "PREDRIVEL");
-	snd_soc_dapm_nc_pin(dapm, "PREDRIVER");
-	snd_soc_dapm_nc_pin(dapm, "CARKITL");
-	snd_soc_dapm_nc_pin(dapm, "CARKITR");
-
-	/* Headset jack detection */
-	ret = snd_soc_jack_new(codec, "Headset Jack",
-				SND_JACK_HEADSET, &hs_jack);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
-				hs_jack_pins);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
-				hs_jack_gpios);
-
-	return ret;
-}
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link sdp3430_dai[] = {
-	{
-		.name = "TWL4030 I2S",
-		.stream_name = "TWL4030 Audio",
-		.cpu_dai_name = "omap-mcbsp.2",
-		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-pcm-audio",
-		.codec_name = "twl4030-codec",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBM_CFM,
-		.init = sdp3430_twl4030_init,
-		.ops = &sdp3430_ops,
-	},
-	{
-		.name = "TWL4030 PCM",
-		.stream_name = "TWL4030 Voice",
-		.cpu_dai_name = "omap-mcbsp.3",
-		.codec_dai_name = "twl4030-voice",
-		.platform_name = "omap-pcm-audio",
-		.codec_name = "twl4030-codec",
-		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
-			   SND_SOC_DAIFMT_CBM_CFM,
-		.ops = &sdp3430_ops,
-	},
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_sdp3430 = {
-	.name = "SDP3430",
-	.owner = THIS_MODULE,
-	.dai_link = sdp3430_dai,
-	.num_links = ARRAY_SIZE(sdp3430_dai),
-
-	.dapm_widgets = sdp3430_twl4030_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(sdp3430_twl4030_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
-};
-
-static struct platform_device *sdp3430_snd_device;
-
-static int __init sdp3430_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap_3430sdp())
-		return -ENODEV;
-	printk(KERN_INFO "SDP3430 SoC init\n");
-
-	sdp3430_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!sdp3430_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(sdp3430_snd_device, &snd_soc_sdp3430);
-
-	ret = platform_device_add(sdp3430_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(sdp3430_snd_device);
-
-	return ret;
-}
-module_init(sdp3430_soc_init);
-
-static void __exit sdp3430_soc_exit(void)
-{
-	snd_soc_jack_free_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
-				hs_jack_gpios);
-
-	platform_device_unregister(sdp3430_snd_device);
-}
-module_exit(sdp3430_soc_exit);
-
-MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
-MODULE_DESCRIPTION("ALSA SoC SDP3430");
-MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
deleted file mode 100644
index 62a6b02..0000000
--- a/sound/soc/omap/zoom2.c
+++ /dev/null
@@ -1,193 +0,0 @@
-/*
- * zoom2.c  --  SoC audio for Zoom2
- *
- * Author: Misael Lopez Cruz <x0052729@ti.com>
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
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <linux/platform_data/gpio-omap.h>
-
-/* Register descriptions for twl4030 codec part */
-#include <linux/mfd/twl4030-audio.h>
-#include <linux/module.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static int zoom2_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops zoom2_ops = {
-	.hw_params = zoom2_hw_params,
-};
-
-/* Zoom2 machine DAPM */
-static const struct snd_soc_dapm_widget zoom2_twl4030_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Ext Mic", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
-	SND_SOC_DAPM_LINE("Aux In", NULL),
-};
-
-static const struct snd_soc_dapm_route audio_map[] = {
-	/* External Mics: MAINMIC, SUBMIC with bias */
-	{"MAINMIC", NULL, "Ext Mic"},
-	{"SUBMIC", NULL, "Ext Mic"},
-	{"Ext Mic", NULL, "Mic Bias 1"},
-	{"Ext Mic", NULL, "Mic Bias 2"},
-
-	/* External Speakers: HFL, HFR */
-	{"Ext Spk", NULL, "HFL"},
-	{"Ext Spk", NULL, "HFR"},
-
-	/* Headset Stereophone:  HSOL, HSOR */
-	{"Headset Stereophone", NULL, "HSOL"},
-	{"Headset Stereophone", NULL, "HSOR"},
-
-	/* Headset Mic: HSMIC with bias */
-	{"HSMIC", NULL, "Headset Mic"},
-	{"Headset Mic", NULL, "Headset Mic Bias"},
-
-	/* Aux In: AUXL, AUXR */
-	{"Aux In", NULL, "AUXL"},
-	{"Aux In", NULL, "AUXR"},
-};
-
-static int zoom2_twl4030_init(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* TWL4030 not connected pins */
-	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
-	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
-	snd_soc_dapm_nc_pin(dapm, "DIGIMIC1");
-	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
-	snd_soc_dapm_nc_pin(dapm, "PREDRIVEL");
-	snd_soc_dapm_nc_pin(dapm, "PREDRIVER");
-	snd_soc_dapm_nc_pin(dapm, "CARKITL");
-	snd_soc_dapm_nc_pin(dapm, "CARKITR");
-
-	return 0;
-}
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link zoom2_dai[] = {
-	{
-		.name = "TWL4030 I2S",
-		.stream_name = "TWL4030 Audio",
-		.cpu_dai_name = "omap-mcbsp.2",
-		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-pcm-audio",
-		.codec_name = "twl4030-codec",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			   SND_SOC_DAIFMT_CBM_CFM,
-		.init = zoom2_twl4030_init,
-		.ops = &zoom2_ops,
-	},
-	{
-		.name = "TWL4030 PCM",
-		.stream_name = "TWL4030 Voice",
-		.cpu_dai_name = "omap-mcbsp.3",
-		.codec_dai_name = "twl4030-voice",
-		.platform_name = "omap-pcm-audio",
-		.codec_name = "twl4030-codec",
-		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
-			   SND_SOC_DAIFMT_CBM_CFM,
-		.ops = &zoom2_ops,
-	},
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_zoom2 = {
-	.name = "Zoom2",
-	.owner = THIS_MODULE,
-	.dai_link = zoom2_dai,
-	.num_links = ARRAY_SIZE(zoom2_dai),
-
-	.dapm_widgets = zoom2_twl4030_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(zoom2_twl4030_dapm_widgets),
-	.dapm_routes = audio_map,
-	.num_dapm_routes = ARRAY_SIZE(audio_map),
-};
-
-static struct platform_device *zoom2_snd_device;
-
-static int __init zoom2_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap_zoom2())
-		return -ENODEV;
-	printk(KERN_INFO "Zoom2 SoC init\n");
-
-	zoom2_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!zoom2_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(zoom2_snd_device, &snd_soc_zoom2);
-	ret = platform_device_add(zoom2_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(zoom2_snd_device);
-
-	return ret;
-}
-module_init(zoom2_soc_init);
-
-static void __exit zoom2_soc_exit(void)
-{
-	platform_device_unregister(zoom2_snd_device);
-}
-module_exit(zoom2_soc_exit);
-
-MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
-MODULE_DESCRIPTION("ALSA SoC Zoom2");
-MODULE_LICENSE("GPL");
-
-- 
1.8.0.2

