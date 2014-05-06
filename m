From: Stefan Roese <sr@denx.de>
Subject: [PATCH 1/2 v2] ASoC: Add HA (HEAD acoustics) DSP codec
	driver template
Date: Tue,  6 May 2014 12:36:35 +0200
Message-ID: <1399372596-10744-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
List-Id: linux-omap@vger.kernel.org

This codec driver template represents an I2C controlled multichannel audio
codec that has many typical ASoC codec driver features like volume controls,
mixer stages, mux selection, output power control, in-codec audio routings,
codec bias management and DAI link configuration.

This driver is based on an early version provided by Jarkko Nikula.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
---
v2:
- Added/changed copyright line
- Changed authorship (as suggested by Jarkko the original author)
- Added Thorsten as maintainer
- Remove ha_dsp_hw_params() and ha_dsp_set_dai_fmt() as its not used
  (only needed for CODEC as clock master which is currently not suported).
- Removed some unneeded include files
- "const char *const foo" used instead of "const char *foo"
- SOC_MIXER_ARRAY() helper macro used
- Removed ha_dsp_set_bias_level() and use default implementation
- Use codec->dev instead of codec->dev->parent in dev_get_regmap()
- Added CODEC reset to probe
- Remove "ret" in ha_dsp_i2c_probe()

 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ha-dsp.c | 333 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ha-dsp.h |  50 +++++++
 4 files changed, 389 insertions(+)
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
index 0000000..5a3c7ef
--- /dev/null
+++ b/sound/soc/codecs/ha-dsp.c
@@ -0,0 +1,333 @@
+/*
+ * ha-dsp.c  --  HA DSP ALSA SoC Audio driver
+ *
+ * Copyright 2011-2014 HEAD acoustics GmbH
+ *
+ * Authors:
+ *   Jarkko Nikula <jarkko.nikula@bitmer.com>
+ *   Stefan Roese <sr@denx.de>
+ *   Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * Maintainer: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
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
+static const char *const ha_dsp_mode_texts[] = {"Mode 1", "Mode 2"};
+static SOC_ENUM_SINGLE_DECL(ha_dsp_mode_enum, HA_DSP_CTRL, 0,
+			    ha_dsp_mode_texts);
+
+/* Monitor output mux selection */
+static const char *const ha_dsp_monitor_texts[] = {"Off", "ADC", "DAC"};
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
+	SOC_MIXER_ARRAY("OUT1 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out1_mixer_controls),
+	SOC_MIXER_ARRAY("OUT2 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out2_mixer_controls),
+	SOC_MIXER_ARRAY("OUT3 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out3_mixer_controls),
+	SOC_MIXER_ARRAY("OUT4 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out4_mixer_controls),
+	SOC_MIXER_ARRAY("OUT5 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out5_mixer_controls),
+	SOC_MIXER_ARRAY("OUT6 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out6_mixer_controls),
+	SOC_MIXER_ARRAY("OUT7 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out7_mixer_controls),
+	SOC_MIXER_ARRAY("OUT8 Mixer", SND_SOC_NOPM, 0, 0,
+			ha_dsp_out8_mixer_controls),
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
+};
+
+static int ha_dsp_probe(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	codec->control_data = dev_get_regmap(codec->dev, NULL);
+	ret = snd_soc_codec_set_cache_io(codec, codec->control_data);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_write(codec, HA_DSP_CTRL, HA_DSP_SW_RESET);
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
+
+	regmap = devm_regmap_init_i2c(client, &ha_dsp_regmap);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to create regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return snd_soc_register_codec(&client->dev, &soc_codec_dev_ha_dsp,
+				      &ha_dsp_dai, 1);
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
index 0000000..6622f8a
--- /dev/null
+++ b/sound/soc/codecs/ha-dsp.h
@@ -0,0 +1,50 @@
+/*
+ * ha-dsp.h  --  HA DSP ALSA SoC Audio driver
+ *
+ * Copyright 2011-2014 HEAD acoustics GmbH
+ *
+ * Author: Jarkko Nikula <jhnikula@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
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
1.9.2
