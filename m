From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/5] ASoC: Add HA (HEAD acoustics) DSP codec driver template
Date: Mon, 28 Apr 2014 14:17:53 +0200
Message-ID: <1398687476-10829-2-git-send-email-sr@denx.de>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:55933 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaD1MX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 08:23:56 -0400
In-Reply-To: <1398687476-10829-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>

From: Jarkko Nikula <jarkko.nikula@bitmer.com>

This codec driver template represents an I2C controlled multichannel audio
codec that has many typical ASoC codec driver features like volume controls,
mixer stages, mux selection, output power control, in-codec audio routings,
codec bias management and DAI link configuration.

Updates from Stefan Roese, 2014-04-28:
Port the HA DSP codec driver to Linux v3.15-rc. This includes
support for DT based probing. No platform-data code is needed
any more, DT nodes are sufficient.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
---
 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ha-dsp.c | 419 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ha-dsp.h |  50 ++++++
 4 files changed, 475 insertions(+)
 create mode 100644 sound/soc/codecs/ha-dsp.c
 create mode 100644 sound/soc/codecs/ha-dsp.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f0e8401..f357988 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -51,6 +51,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_BT_SCO
+	select SND_SOC_HA_DSP if I2C
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -343,6 +344,9 @@ config SND_SOC_BT_SCO
 config SND_SOC_DMIC
 	tristate
 
+config SND_SOC_HA_DSP
+	tristate
+
 config SND_SOC_HDMI_CODEC
        tristate "HDMI stub CODEC"
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3c4d275..f296bec 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -39,6 +39,7 @@ snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-ha-dsp-objs := ha-dsp.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -190,6 +191,7 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
+obj-$(CONFIG_SND_SOC_HA_DSP)	+= snd-soc-ha-dsp.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/ha-dsp.c b/sound/soc/codecs/ha-dsp.c
new file mode 100644
index 0000000..7cf24dc
--- /dev/null
+++ b/sound/soc/codecs/ha-dsp.c
@@ -0,0 +1,419 @@
+/*
+ * ha-dsp.c  --  HA DSP ALSA SoC Audio driver
+ *
+ * Copyright 2011 Head acoustics GmbH
+ *
+ * Author: Jarkko Nikula <jarkko.nikula@bitmer.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/initval.h>
+
+#include "ha-dsp.h"
+
+/* Reset default register values for soc-cache */
+static const struct reg_default ha_dsp_reg_defaults[] = {
+	{ 0x00, 0x00 },
+	{ 0x01, 0x55 },
+	{ 0x02, 0x55 },
+	{ 0x03, 0x00 },
+	{ 0x04, 0x00 },
+	{ 0x05, 0x00 },
+	{ 0x06, 0x00 },
+	{ 0x07, 0x00 },
+	{ 0x08, 0x02 },
+	{ 0x09, 0x02 },
+	{ 0x0a, 0x02 },
+	{ 0x0b, 0x02 },
+	{ 0x0c, 0x02 },
+	{ 0x0d, 0x02 },
+	{ 0x0e, 0x02 },
+	{ 0x0f, 0x02 },
+};
+
+/* DSP mode selection */
+static const char *ha_dsp_mode_texts[] = {"Mode 1", "Mode 2"};
+static SOC_ENUM_SINGLE_DECL(ha_dsp_mode_enum, HA_DSP_CTRL, 0,
+			    ha_dsp_mode_texts);
+
+/* Monitor output mux selection */
+static const char *ha_dsp_monitor_texts[] = {"Off", "ADC", "DAC"};
+static SOC_ENUM_SINGLE_DECL(ha_dsp_monitor_enum, HA_DSP_CTRL, 1,
+			    ha_dsp_monitor_texts);
+
+static const struct snd_kcontrol_new ha_dsp_monitor_control =
+	SOC_DAPM_ENUM("Route", ha_dsp_monitor_enum);
+
+/* Output mixers */
+static const struct snd_kcontrol_new ha_dsp_out1_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT1_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT1_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out2_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT2_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT2_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out3_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT3_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT3_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out4_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT4_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT4_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out5_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT5_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT5_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out6_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT6_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT6_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out7_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT7_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT1_CTRL, 2, 1, 0),
+};
+static const struct snd_kcontrol_new ha_dsp_out8_mixer_controls[] = {
+	SOC_DAPM_SINGLE("DAC Switch", HA_DSP_OUT8_CTRL, 1, 1, 0),
+	SOC_DAPM_SINGLE("IN Bypass Switch", HA_DSP_OUT8_CTRL, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new ha_dsp_snd_controls[] = {
+	SOC_SINGLE("ADC Capture Volume",
+		   HA_DSP_ADC_VOL, 0, 0x7f, 0),
+	SOC_SINGLE("ADC Capture Switch",
+		   HA_DSP_ADC_VOL, 7, 0x01, 1),
+
+	SOC_SINGLE("PCM Playback Volume",
+		   HA_DSP_DAC_VOL, 0, 0x7f, 0),
+	SOC_SINGLE("PCM Playback Switch",
+		   HA_DSP_DAC_VOL, 7, 0x01, 1),
+
+	SOC_ENUM("DSP Mode", ha_dsp_mode_enum),
+};
+
+static const struct snd_soc_dapm_widget ha_dsp_widgets[] = {
+	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_MIXER("OUT1 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out1_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out1_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT2 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out2_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out2_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT3 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out3_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out3_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT4 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out4_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out4_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT5 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out5_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out5_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT6 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out6_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out6_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT7 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out7_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out7_mixer_controls)),
+	SND_SOC_DAPM_MIXER("OUT8 Mixer", SND_SOC_NOPM, 0, 0,
+			   &ha_dsp_out8_mixer_controls[0],
+			   ARRAY_SIZE(ha_dsp_out8_mixer_controls)),
+
+	SND_SOC_DAPM_PGA("OUT1 PGA", HA_DSP_OUT1_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT2 PGA", HA_DSP_OUT2_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT3 PGA", HA_DSP_OUT3_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT4 PGA", HA_DSP_OUT4_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT5 PGA", HA_DSP_OUT5_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT6 PGA", HA_DSP_OUT6_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT7 PGA", HA_DSP_OUT7_CTRL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("OUT8 PGA", HA_DSP_OUT8_CTRL, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("Monitor Out Mux", SND_SOC_NOPM, 0, 0,
+			 &ha_dsp_monitor_control),
+
+	/* Input pins */
+	SND_SOC_DAPM_INPUT("IN1"),
+	SND_SOC_DAPM_INPUT("IN2"),
+	SND_SOC_DAPM_INPUT("IN3"),
+	SND_SOC_DAPM_INPUT("IN4"),
+	SND_SOC_DAPM_INPUT("IN5"),
+	SND_SOC_DAPM_INPUT("IN6"),
+	SND_SOC_DAPM_INPUT("IN7"),
+	SND_SOC_DAPM_INPUT("IN8"),
+
+	/* Output pins */
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+	SND_SOC_DAPM_OUTPUT("OUT4"),
+	SND_SOC_DAPM_OUTPUT("OUT5"),
+	SND_SOC_DAPM_OUTPUT("OUT6"),
+	SND_SOC_DAPM_OUTPUT("OUT7"),
+	SND_SOC_DAPM_OUTPUT("OUT8"),
+	SND_SOC_DAPM_OUTPUT("MONITOR"),
+};
+
+static const struct snd_soc_dapm_route ha_dsp_routes[] = {
+	/* Inputs to ADC */
+	{"ADC", NULL, "IN1"},
+	{"ADC", NULL, "IN2"},
+	{"ADC", NULL, "IN3"},
+	{"ADC", NULL, "IN4"},
+	{"ADC", NULL, "IN5"},
+	{"ADC", NULL, "IN6"},
+	{"ADC", NULL, "IN7"},
+	{"ADC", NULL, "IN8"},
+
+	/* DAC and input bypass paths to outputs */
+	{"OUT1 Mixer", "DAC Switch", "DAC"},
+	{"OUT1 Mixer", "IN Bypass Switch", "IN1"},
+	{"OUT1 PGA", NULL, "OUT1 Mixer"},
+	{"OUT1", NULL, "OUT1 PGA"},
+
+	{"OUT2 Mixer", "DAC Switch", "DAC"},
+	{"OUT2 Mixer", "IN Bypass Switch", "IN2"},
+	{"OUT2 PGA", NULL, "OUT2 Mixer"},
+	{"OUT2", NULL, "OUT2 PGA"},
+
+	{"OUT3 Mixer", "DAC Switch", "DAC"},
+	{"OUT3 Mixer", "IN Bypass Switch", "IN3"},
+	{"OUT3 PGA", NULL, "OUT3 Mixer"},
+	{"OUT3", NULL, "OUT3 PGA"},
+
+	{"OUT4 Mixer", "DAC Switch", "DAC"},
+	{"OUT4 Mixer", "IN Bypass Switch", "IN4"},
+	{"OUT4 PGA", NULL, "OUT4 Mixer"},
+	{"OUT4", NULL, "OUT4 PGA"},
+
+	{"OUT5 Mixer", "DAC Switch", "DAC"},
+	{"OUT5 Mixer", "IN Bypass Switch", "IN5"},
+	{"OUT5 PGA", NULL, "OUT5 Mixer"},
+	{"OUT5", NULL, "OUT5 PGA"},
+
+	{"OUT6 Mixer", "DAC Switch", "DAC"},
+	{"OUT6 Mixer", "IN Bypass Switch", "IN6"},
+	{"OUT6 PGA", NULL, "OUT6 Mixer"},
+	{"OUT6", NULL, "OUT6 PGA"},
+
+	{"OUT7 Mixer", "DAC Switch", "DAC"},
+	{"OUT7 Mixer", "IN Bypass Switch", "IN7"},
+	{"OUT7 PGA", NULL, "OUT7 Mixer"},
+	{"OUT7", NULL, "OUT7 PGA"},
+
+	{"OUT8 Mixer", "DAC Switch", "DAC"},
+	{"OUT8 Mixer", "IN Bypass Switch", "IN8"},
+	{"OUT8 PGA", NULL, "OUT8 Mixer"},
+	{"OUT8", NULL, "OUT8 PGA"},
+
+	/* Monitor output */
+	{"Monitor Out Mux", "ADC", "ADC"},
+	{"Monitor Out Mux", "DAC", "DAC"},
+	{"MONITOR", NULL, "Monitor Out Mux"},
+};
+
+static int ha_dsp_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	dev_dbg(codec->dev, "Sample format 0x%X\n", params_format(params));
+	dev_dbg(codec->dev, "Channels %d\n", params_channels(params));
+	dev_dbg(codec->dev, "Rate %d\n", params_rate(params));
+
+	return 0;
+}
+
+static int ha_dsp_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+
+	/* codec role */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		dev_dbg(codec->dev, "Codec is master\n");
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		dev_dbg(codec->dev, "Codec is slave\n");
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* DAI format */
+	dev_dbg(codec->dev, "DAI format 0x%X",
+		fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+
+	/* Bit clock and frame sync polarities */
+	dev_dbg(codec->dev, "Clock polarities 0x%X\n",
+		fmt & SND_SOC_DAIFMT_INV_MASK);
+
+	return 0;
+}
+
+static int ha_dsp_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	dev_dbg(codec->dev, "Changing bias from %d to %d\n",
+		codec->dapm.bias_level, level);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		/* Set PLL on */
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/* Set power on, Set PLL off */
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* Set power down */
+		break;
+	}
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops ha_dsp_dai_ops = {
+	.hw_params	= ha_dsp_hw_params,
+	.set_fmt	= ha_dsp_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver ha_dsp_dai = {
+	.name = "ha-dsp-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 16,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		/* We use only 32 Bits for Audio */
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 16,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		/* We use only 32 Bits for Audio */
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &ha_dsp_dai_ops,
+};
+
+static int ha_dsp_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);
+	ret = snd_soc_codec_set_cache_io(codec, codec->control_data);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ha_dsp_remove(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, HA_DSP_CTRL, HA_DSP_SW_RESET);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_ha_dsp = {
+	.probe = ha_dsp_probe,
+	.remove = ha_dsp_remove,
+	.set_bias_level = ha_dsp_set_bias_level,
+
+	.controls = ha_dsp_snd_controls,
+	.num_controls = ARRAY_SIZE(ha_dsp_snd_controls),
+	.dapm_widgets = ha_dsp_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ha_dsp_widgets),
+	.dapm_routes = ha_dsp_routes,
+	.num_dapm_routes = ARRAY_SIZE(ha_dsp_routes),
+};
+
+static const struct regmap_config ha_dsp_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = 0x0f,
+	.reg_defaults = ha_dsp_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ha_dsp_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int ha_dsp_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &ha_dsp_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to create regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_register_codec(&client->dev, &soc_codec_dev_ha_dsp,
+				     &ha_dsp_dai, 1);
+
+	return ret;
+}
+
+static int ha_dsp_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+
+	return 0;
+}
+
+/*
+ * This name/ID is neded to match the DT node for the codec
+ */
+static const struct i2c_device_id ha_dsp_i2c_id[] = {
+	{ "ha-dsp-audio", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ha_dsp_i2c_id);
+
+static struct i2c_driver ha_dsp_i2c_driver = {
+	.driver = {
+		.name = "ha-dsp-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = ha_dsp_i2c_probe,
+	.remove = ha_dsp_i2c_remove,
+	.id_table = ha_dsp_i2c_id,
+};
+
+module_i2c_driver(ha_dsp_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC HA DSP driver");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ha-dsp.h b/sound/soc/codecs/ha-dsp.h
new file mode 100644
index 0000000..cab82f8
--- /dev/null
+++ b/sound/soc/codecs/ha-dsp.h
@@ -0,0 +1,50 @@
+/*
+ * ha-dsp.h  --  HA DSP ALSA SoC Audio driver
+ *
+ * Copyright 2011 Head acoustics GmbH
+ *
+ * Author: Jarkko Nikula <jhnikula@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __HA_DSP_H__
+#define __HA_DSP_H__
+
+/* Registers */
+
+/*
+ * Bit 2-1: Monitor output selection: Off, ADC, DAC
+ * Bit 0: DSP Mode
+ */
+#define HA_DSP_CTRL		0x00
+
+/*
+ * Bit 7: Mute
+ * Bit 6-0: Volume
+ */
+#define HA_DSP_DAC_VOL		0x01
+#define HA_DSP_ADC_VOL		0x02
+
+/*
+ * Bit 2: INx Bypass to OUTx Switch
+ * Bit 1: DAC to OUTx switch
+ * Bit 0: Output power
+ */
+#define HA_DSP_OUT1_CTRL	0x08
+#define HA_DSP_OUT2_CTRL	0x09
+#define HA_DSP_OUT3_CTRL	0x0a
+#define HA_DSP_OUT4_CTRL	0x0b
+#define HA_DSP_OUT5_CTRL	0x0c
+#define HA_DSP_OUT6_CTRL	0x0d
+#define HA_DSP_OUT7_CTRL	0x0e
+#define HA_DSP_OUT8_CTRL	0x0f
+
+/* Register bits and values */
+
+/* HA_DSP_CTRL */
+#define HA_DSP_SW_RESET		0xff
+
+#endif
-- 
1.9.1

