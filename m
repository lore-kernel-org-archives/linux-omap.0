From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 1/5] [RFC] ALSA ASoC driver for TLVaic23b audio codec
Date: Mon, 29 Sep 2008 15:15:04 +0530
Message-ID: <dfeb90390809290245v77aea7b8s5a24a7d635a46a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:41795 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbYI2JpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:45:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2163546rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 02:45:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

ASOC Audio driver for TLVaic23b audio codec

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/Kconfig       |    4 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tlv320aic23.c |  634 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23.h |  143 +++++++++
 4 files changed, 783 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic23.c
 create mode 100644 sound/soc/codecs/tlv320aic23.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b1a5eed..7be0b37 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -55,3 +55,7 @@ config SND_SOC_TWL4030
 	tristate
 	depends on SND_SOC && TWL4030_CORE

+config SND_SOC_TLV320AIC23
+	tristate
+	depends on I2C
+
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a519ced..adb5aa6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -11,6 +11,7 @@ snd-soc-wm9713-objs := wm9713.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-twl4030-objs := twl4030.o
+snd-soc-tlv320aic23-objs := tlv320aic23.o

 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
@@ -25,3 +26,4 @@ obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TWL4030)	+= snd-soc-twl4030.o
+obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
new file mode 100644
index 0000000..eefeb2d
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -0,0 +1,634 @@
+/*
+ * ALSA SoC TLV320AIC23 codec driver
+ *
+ * Author:      Arun KS, <arunks@mistralsolutions.com>
+ * Copyright:   (C) 2008 Mistral Solutions Pvt Ltd.,
+ *
+ * Based on sound/soc/codecs/tlv320aic23.c by Vladimir Barinov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Notes:
+ *  The AIC23 is a driver for a low power stereo audio
+ *  codec aic23
+ *
+ *  The machine layer should disable unsupported inputs/outputs by
+ *  snd_soc_dapm_disable_pin(codec, "LHPOUT"), etc.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "tlv320aic23.h"
+
+#define AUDIO_NAME "aic23"
+#define AIC23_VERSION "0.1"
+
+/* codec private data */
+struct aic23_priv {
+	unsigned int sysclk;
+	int master;
+};
+
+/*
+ * AIC23 register cache
+ */
+static const u16 aic23_reg[AIC23_CACHEREGNUM] = {
+	0x0097, 0x0097, 0x00F9, 0x00F9,	/* 0 */
+	0x001A, 0x0004, 0x0007, 0x0001,	/* 4 */
+	0x0020, 0x0000, 0x0000, 0x0000,	/* 8 */
+	0x0000, 0x0000, 0x0000, 0x0000,	/* 12 */
+};
+
+/*
+ * read aic23 register cache
+ */
+static inline unsigned int aic23_read_reg_cache(struct snd_soc_codec *codec,
+						unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= AIC23_CACHEREGNUM)
+		return -1;
+	return cache[reg];
+}
+
+/*
+ * write aic23 register cache
+ */
+static inline void aic23_write_reg_cache(struct snd_soc_codec *codec,
+					 u8 reg, u16 value)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= AIC23_CACHEREGNUM)
+		return;
+	cache[reg] = value;
+}
+
+/*
+ * write to the aic23 register space
+ */
+static int aic23_write(struct snd_soc_codec *codec, unsigned int reg,
+		       unsigned int value)
+{
+
+	u8 data;
+
+	/* TLV320AIC23 has 7 bit address and 9 bits of data
+	 * so we need to switch one data bit into reg and rest
+	 * of data into val
+	 */
+
+	if ((reg < 0 || reg > 9) && (reg != 15)) {
+		printk(KERN_WARNING "Invalid register R%d\n", reg);
+		return -1;
+	}
+
+	data = (reg << 1) | (value >> 8 & 0x01);
+
+	aic23_write_reg_cache(codec, reg, value);
+
+	if (codec->hw_write(codec->control_data, (u8) data,
+			    (u8) (value & 0xff)) == 0)
+		return 0;
+
+	printk(KERN_ERR "I2C: cannot write %03x to register R%d\n", value, reg);
+
+	return -EIO;
+}
+
+static const struct snd_kcontrol_new aic23_snd_controls[] = {
+	SOC_DOUBLE_R("PCM Playback Volume", LEFT_CHANNEL_VOLUME_ADDR,
+		     RIGHT_CHANNEL_VOLUME_ADDR, 0, 0x7f, 0),
+	SOC_SINGLE("PCM Playback Switch", DIGITAL_AUDIO_CONTROL_ADDR, 3, 0x01,
+		   1),
+	SOC_DOUBLE_R("Line Input Mute", LEFT_LINE_VOLUME_ADDR,
+		     RIGHT_LINE_VOLUME_ADDR, 7, 0x01, 0),
+	SOC_DOUBLE_R("Line Input Volume", LEFT_LINE_VOLUME_ADDR,
+		     RIGHT_LINE_VOLUME_ADDR, 0, 0x1f, 0),
+	SOC_SINGLE("Mic Mute", ANALOG_AUDIO_CONTROL_ADDR, 1, 0x01, 0),
+	SOC_SINGLE("Mic Booster Switch", ANALOG_AUDIO_CONTROL_ADDR, 0, 0x01, 0),
+
+};
+
+/* add non dapm controls */
+static int aic23_add_controls(struct snd_soc_codec *codec)
+{
+
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(aic23_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&aic23_snd_controls[i],
+					       codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+
+}
+static const char *aic23_rec_src[] = { "Line", "Mic" };
+
+static const struct soc_enum aic23_enum[] = {
+	SOC_ENUM_SINGLE(ANALOG_AUDIO_CONTROL_ADDR, 2, 2, aic23_rec_src),
+};
+
+static const struct snd_kcontrol_new aic23_rec_src_mux_controls =
+SOC_DAPM_ENUM("Route", aic23_enum[0]);
+
+/* PGA Mixer controls for Line and Mic switch */
+static const struct snd_kcontrol_new aic23_pga_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Switch", POWER_DOWN_CONTROL_ADDR, 0, 1, 1),
+	SOC_DAPM_SINGLE("Mic Switch", POWER_DOWN_CONTROL_ADDR, 1, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", POWER_DOWN_CONTROL_ADDR, 3, 1),
+	SND_SOC_DAPM_PGA("OUT", POWER_DOWN_CONTROL_ADDR, 4, 1, NULL, 0),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", POWER_DOWN_CONTROL_ADDR, 2, 1),
+	SND_SOC_DAPM_MIXER("PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic23_pga_mixer_controls[0],
+			   ARRAY_SIZE(aic23_pga_mixer_controls)),
+	SND_SOC_DAPM_MUX("Capture Source", SND_SOC_NOPM, 0, 0,
+			 &aic23_rec_src_mux_controls),
+
+	SND_SOC_DAPM_OUTPUT("LHPOUT"),
+	SND_SOC_DAPM_OUTPUT("RHPOUT"),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+	SND_SOC_DAPM_OUTPUT("ROUT"),
+	SND_SOC_DAPM_INPUT("LLINEIN"),
+	SND_SOC_DAPM_INPUT("RLINEIN"),
+	SND_SOC_DAPM_INPUT("MICIN"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"OUT", NULL, "DAC"},
+
+	{"LHPOUT", NULL, "OUT"},
+	{"RHPOUT", NULL, "OUT"},
+
+	{"LOUT", NULL, "OUT"},
+	{"ROUT", NULL, "OUT"},
+
+	{"Capture Source", "Line", "LLINEIN"},
+	{"Capture Source", "Line", "RLINEIN"},
+
+	{"Capture Source", "Mic", "MICIN"},
+
+	{"PGA Mixer", "Line Switch", "Capture Source"},
+	{"PGA Mixer", "Mic Switch", "Capture Source"},
+
+	{"ADC", NULL, "PGA Mixer"},
+
+};
+
+/* aic23 related */
+static const struct aic23_samplerate_reg_info
+ rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
+	{4000, 0x06, 1},	/*  4000 */
+	{8000, 0x06, 0},	/*  8000 */
+	{16000, 0x0C, 1},	/* 16000 */
+	{22050, 0x11, 1},	/* 22050 */
+	{24000, 0x00, 1},	/* 24000 */
+	{32000, 0x0C, 0},	/* 32000 */
+	{44100, 0x11, 0},	/* 44100 */
+	{48000, 0x00, 0},	/* 48000 */
+	{88200, 0x1F, 0},	/* 88200 */
+	{96000, 0x0E, 0},	/* 96000 */
+};
+
+static int aic23_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, aic23_dapm_widgets,
+				  ARRAY_SIZE(aic23_dapm_widgets));
+
+	/* set up audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static int aic23_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 iface_reg, data;
+	u8 count = 0;
+
+	iface_reg =
+	    aic23_read_reg_cache(codec,
+				 DIGITAL_AUDIO_FORMAT_ADDR) & ~(0x03 << 2);
+
+	/* Search for the right sample rate */
+	/* Verify what happens if the rate is not supported
+	 * now it goes to 96Khz */
+	while ((rate_reg_info[count].sample_rate != params_rate(params)) &&
+	       (count < ARRAY_SIZE(rate_reg_info))) {
+		count++;
+	}
+
+	data = (rate_reg_info[count].divider << CLKIN_SHIFT) |
+	    (rate_reg_info[count].control << BOSR_SHIFT) | USB_CLK_ON;
+
+	aic23_write(codec, SAMPLE_RATE_CONTROL_ADDR, data);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		iface_reg |= (0x01 << 2);
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		iface_reg |= (0x02 << 2);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		iface_reg |= (0x03 << 2);
+		break;
+	}
+	aic23_write(codec, DIGITAL_AUDIO_FORMAT_ADDR, iface_reg);
+
+	return 0;
+}
+
+static int aic23_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 reg;
+
+	reg =
+	    aic23_read_reg_cache(codec,
+				 DIGITAL_AUDIO_CONTROL_ADDR) & ~DACM_MUTE;
+
+	if (mute)
+		aic23_write(codec, DIGITAL_AUDIO_CONTROL_ADDR, reg | DACM_MUTE);
+
+	else
+		aic23_write(codec, DIGITAL_AUDIO_CONTROL_ADDR, reg);
+
+	return 0;
+}
+
+static int aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic23_priv *aic23 = codec->private_data;
+
+	aic23->sysclk = freq;
+	return 0;
+}
+
+static int aic23_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct aic23_priv *aic23 = codec->private_data;
+	u16 iface_reg;
+
+	iface_reg =
+	    aic23_read_reg_cache(codec, DIGITAL_AUDIO_FORMAT_ADDR) & (~0x03);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		aic23->master = 1;
+		iface_reg |= MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		aic23->master = 0;
+		break;
+	default:
+		return -EINVAL;
+
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface_reg |= FOR_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface_reg |= FOR_DSP;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface_reg |= FOR_LJUST;
+		break;
+	default:
+		return -EINVAL;
+
+	}
+
+	aic23_write(codec, DIGITAL_AUDIO_FORMAT_ADDR, iface_reg);
+
+	return 0;
+}
+
+static int aic23_set_bias_level(struct snd_soc_codec *codec,
+				enum snd_soc_bias_level level)
+{
+	u16 reg;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		reg = aic23_read_reg_cache(codec, POWER_DOWN_CONTROL_ADDR);
+		aic23_write(codec, POWER_DOWN_CONTROL_ADDR,
+			    reg & (~DEVICE_POWER_OFF));
+		/* Activate interface */
+		reg = aic23_read_reg_cache(codec, DIGITAL_INTERFACE_ACT_ADDR);
+		aic23_write(codec, DIGITAL_INTERFACE_ACT_ADDR, reg | ACT_ON);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		reg = aic23_read_reg_cache(codec, POWER_DOWN_CONTROL_ADDR);
+		aic23_write(codec, POWER_DOWN_CONTROL_ADDR,
+			    reg | DEVICE_POWER_OFF);
+		/* Deactivate interface */
+		reg = aic23_read_reg_cache(codec, DIGITAL_INTERFACE_ACT_ADDR);
+		aic23_write(codec, DIGITAL_INTERFACE_ACT_ADDR, reg & (~ACT_ON));
+
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+
+	codec->bias_level = level;
+
+	return 0;
+}
+
+#define AIC23_RATES	SNDRV_PCM_RATE_8000_96000
+#define AIC23_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai aic23_dai = {
+	.name = "aic23",
+	.playback = {
+		     .stream_name = "Playback",
+		     .channels_min = 2,
+		     .channels_max = 2,
+		     .rates = AIC23_RATES,
+		     .formats = AIC23_FORMATS,},
+	.capture = {
+		    .stream_name = "Capture",
+		    .channels_min = 2,
+		    .channels_max = 2,
+		    .rates = AIC23_RATES,
+		    .formats = AIC23_FORMATS,},
+	.ops = {
+		.hw_params = aic23_hw_params,
+		},
+	.dai_ops = {
+		    .digital_mute = aic23_mute,
+		    .set_sysclk = aic23_set_dai_sysclk,
+		    .set_fmt = aic23_set_dai_fmt,
+		    }
+};
+EXPORT_SYMBOL_GPL(aic23_dai);
+
+static int aic23_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int aic23_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u8 data[2];
+	u8 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(aic23_reg); i++) {
+		data[0] = i;
+		data[1] = cache[i];
+		codec->hw_write(codec->control_data, data, 2);
+	}
+
+	aic23_set_bias_level(codec, codec->suspend_bias_level);
+
+	return 0;
+}
+
+/*
+ * initialise the AIC23 driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int aic23_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+	u16 reg;
+
+	codec->name = "aic23";
+	codec->owner = THIS_MODULE;
+	codec->read = aic23_read_reg_cache;
+	codec->write = aic23_write;
+	codec->set_bias_level = aic23_set_bias_level;
+	codec->dai = &aic23_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(aic23_reg);
+	codec->reg_cache = kmemdup(aic23_reg, sizeof(aic23_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	/* Reset codec */
+	aic23_write(codec, RESET_CONTROL_ADDR, 0);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "aic23: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	aic23_write(codec, DIGITAL_AUDIO_CONTROL_ADDR, DEEMP_44K);
+
+	/* Unmute input */
+	reg = aic23_read_reg_cache(codec, LEFT_LINE_VOLUME_ADDR);
+	aic23_write(codec, LEFT_LINE_VOLUME_ADDR,
+		    (reg & (~LIM_MUTED)) | (LRS_ENABLED));
+	reg = aic23_read_reg_cache(codec, RIGHT_LINE_VOLUME_ADDR);
+	aic23_write(codec, RIGHT_LINE_VOLUME_ADDR,
+		    (reg & (~LIM_MUTED)) | LRS_ENABLED);
+	reg = aic23_read_reg_cache(codec, ANALOG_AUDIO_CONTROL_ADDR);
+	aic23_write(codec, ANALOG_AUDIO_CONTROL_ADDR,
+		    (reg | DAC_SELECTED) & (~MICM_MUTED) & (~BYPASS_ON));
+
+	/* Default output volume */
+	aic23_write(codec, LEFT_CHANNEL_VOLUME_ADDR,
+		    DEFAULT_OUTPUT_VOLUME & OUTPUT_VOLUME_MASK);
+	aic23_write(codec, RIGHT_CHANNEL_VOLUME_ADDR,
+		    DEFAULT_OUTPUT_VOLUME & OUTPUT_VOLUME_MASK);
+
+	/* off, with power on */
+	aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	aic23_add_controls(codec);
+	aic23_add_widgets(codec);
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "aic23: failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	kfree(codec->reg_cache);
+	return ret;
+}
+static struct snd_soc_device *aic23_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+/*
+ * If the i2c layer weren't so broken, we could pass this kind of data
+ * around
+ */
+static int aic23_codec_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *i2c_id)
+{
+	struct snd_soc_device *socdev = aic23_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EINVAL;
+
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = aic23_init(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "aic23: failed to initialise AIC23\n");
+		goto err;
+	}
+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+static int __exit aic23_i2c_remove(struct i2c_client *i2c)
+{
+
+	put_device(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id tlvaic23b_id[] = {
+	{"tlvaic23b", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tlvaic23b_id);
+
+static struct i2c_driver aic23b_i2c_driver = {
+	.driver = {
+		   .name = "tlvaic23b",
+		   },
+	.probe = aic23_codec_probe,
+	.remove = __exit_p(aic23_i2c_remove),
+	.id_table = tlvaic23b_id,
+};
+
+#endif
+
+static int aic23_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct aic23_priv *aic23;
+	int ret = 0;
+
+	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	aic23 = kzalloc(sizeof(struct aic23_priv), GFP_KERNEL);
+	if (aic23 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = aic23;
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	aic23_socdev = socdev;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	codec->hw_write = (hw_write_t) i2c_smbus_write_byte_data;
+	codec->hw_read = NULL;
+	ret = i2c_add_driver(&aic23b_i2c_driver);
+	if (ret != 0)
+		printk(KERN_ERR "can't add i2c driver");
+#else
+	/* Add other interfaces here */
+#endif
+	return ret;
+}
+
+static int aic23_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	/* power down chip */
+	if (codec->control_data)
+		aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&aic23b_i2c_driver);
+#endif
+	kfree(codec->private_data);
+	kfree(codec->reg_cache);
+	kfree(codec);
+
+	return 0;
+}
+struct snd_soc_codec_device soc_codec_dev_aic23 = {
+	.probe = aic23_probe,
+	.remove = aic23_remove,
+	.suspend = aic23_suspend,
+	.resume = aic23_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_aic23);
+
+MODULE_DESCRIPTION("ASoC TLV320AIC23 codec driver");
+MODULE_AUTHOR("Arun KS");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic23.h b/sound/soc/codecs/tlv320aic23.h
new file mode 100644
index 0000000..9c3808c
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.h
@@ -0,0 +1,143 @@
+/*
+ * ALSA SoC TLV320AIC23 codec driver
+ *
+ * Author:      Arun KS, <arunks@mistralsolutions.com>
+ * Copyright:   (C) 2008 Mistral Solutions Pvt Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _AIC23_H
+#define _AIC23_H
+
+#define AIC23_CACHEREGNUM		16
+/* Codec TLV320AIC23 */
+#define LEFT_LINE_VOLUME_ADDR		0x00
+#define RIGHT_LINE_VOLUME_ADDR		0x01
+#define LEFT_CHANNEL_VOLUME_ADDR	0x02
+#define RIGHT_CHANNEL_VOLUME_ADDR	0x03
+#define ANALOG_AUDIO_CONTROL_ADDR	0x04
+#define DIGITAL_AUDIO_CONTROL_ADDR	0x05
+#define POWER_DOWN_CONTROL_ADDR		0x06
+#define DIGITAL_AUDIO_FORMAT_ADDR	0x07
+#define SAMPLE_RATE_CONTROL_ADDR	0x08
+#define DIGITAL_INTERFACE_ACT_ADDR	0x09
+#define RESET_CONTROL_ADDR		0x0F
+
+/* Left (right) line input volume control register */
+#define LRS_ENABLED			0x0100
+#define LIM_MUTED			0x0080
+#define LIV_DEFAULT			0x0017
+#define LIV_MAX				0x001f
+#define LIV_MIN				0x0000
+
+/* Left (right) channel headphone volume control register */
+#define LZC_ON				0x0080
+#define LHV_DEFAULT			0x0079
+#define LHV_MAX				0x007f
+#define LHV_MIN				0x0000
+
+/* Analog audio path control register */
+#define STA_REG(x)			((x)<<6)
+#define STE_ENABLED			0x0020
+#define DAC_SELECTED			0x0010
+#define BYPASS_ON			0x0008
+#define INSEL_MIC			0x0004
+#define MICM_MUTED			0x0002
+#define MICB_20DB			0x0001
+
+/* Digital audio path control register */
+#define DACM_MUTE			0x0008
+#define DEEMP_32K			0x0002
+#define DEEMP_44K			0x0004
+#define DEEMP_48K			0x0006
+#define ADCHP_ON			0x0001
+
+/* Power control down register */
+#define DEVICE_POWER_OFF	  	0x0080
+#define CLK_OFF				0x0040
+#define OSC_OFF				0x0020
+#define OUT_OFF				0x0010
+#define DAC_OFF				0x0008
+#define ADC_OFF				0x0004
+#define MIC_OFF				0x0002
+#define LINE_OFF			0x0001
+
+/* Digital audio interface register */
+#define MS_MASTER			0x0040
+#define LRSWAP_ON			0x0020
+#define LRP_ON				0x0010
+#define IWL_16				0x0000
+#define IWL_20				0x0004
+#define IWL_24				0x0008
+#define IWL_32				0x000C
+#define FOR_I2S				0x0002
+#define FOR_DSP				0x0003
+#define FOR_LJUST			0x0001
+
+/* Sample rate control register */
+#define CLKOUT_HALF			0x0080
+#define CLKIN_HALF			0x0040
+#define BOSR_384fs			0x0002 /* BOSR_272fs when in USB mode */
+#define USB_CLK_ON			0x0001
+#define SR_MASK                         0xf
+#define CLKOUT_SHIFT                    7
+#define CLKIN_SHIFT                     6
+#define SR_SHIFT                        2
+#define BOSR_SHIFT                      1
+
+/* Digital interface register */
+#define ACT_ON				0x0001
+
+/* Define to set the AIC23 as the master w.r.t McBSP */
+#define AIC23_MASTER
+
+#define NUMBER_SAMPLE_RATES_SUPPORTED	10
+
+/*
+ * AUDIO related MACROS
+ */
+#ifndef DEFAULT_BITPERSAMPLE
+#define DEFAULT_BITPERSAMPLE		16
+#endif
+
+#define DEFAULT_SAMPLE_RATE		44100
+#define CODEC_CLOCK			12000000
+#define AUDIO_MCBSP			OMAP_MCBSP1
+
+#define DEFAULT_OUTPUT_VOLUME		0x70
+#define DEFAULT_INPUT_VOLUME		0x10	/* 0 ==> mute line in */
+
+#define OUTPUT_VOLUME_MIN		LHV_MIN
+#define OUTPUT_VOLUME_MAX		LHV_MAX
+#define OUTPUT_VOLUME_RANGE		(OUTPUT_VOLUME_MAX - OUTPUT_VOLUME_MIN)
+#define OUTPUT_VOLUME_MASK		OUTPUT_VOLUME_MAX
+
+#define INPUT_VOLUME_MIN		LIV_MIN
+#define INPUT_VOLUME_MAX		LIV_MAX
+#define INPUT_VOLUME_RANGE		(INPUT_VOLUME_MAX - INPUT_VOLUME_MIN)
+#define INPUT_VOLUME_MASK		INPUT_VOLUME_MAX
+
+#define SIDETONE_MASK			0x1c0
+#define SIDETONE_0			0x100
+#define SIDETONE_6			0x000
+#define SIDETONE_9			0x040
+#define SIDETONE_12			0x080
+#define SIDETONE_18			0x0c0
+
+#define DEFAULT_ANALOG_AUDIO_CONTROL  (DAC_SELECTED | STE_ENABLED | \
+					INSEL_MIC | MICB_20DB)
+
+struct aic23_samplerate_reg_info {
+	u32 sample_rate;
+	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
+	u8 divider		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
+};
+
+extern struct snd_soc_dai aic23_dai;
+extern struct snd_soc_codec_device soc_codec_dev_aic23;
+
+#endif /* _AIC23_H */
+
-- 
1.5.3.4
