From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 1/5 v1] ASoC Add TLV320AIC23 codec driver
Date: Tue, 30 Sep 2008 15:29:32 +0530
Message-ID: <dfeb90390809300259k1b848aaehc3519ec50c6ec96d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: linux-omap@vger.kernel.org

ASoC codec driver for TLV320AIC23 device

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/Kconfig       |    5 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tlv320aic23.c |  631 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23.h |  125 ++++++++
 4 files changed, 763 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic23.c
 create mode 100644 sound/soc/codecs/tlv320aic23.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0507fcf..bdead2d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -7,6 +7,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4535
 	select SND_SOC_CS4270
 	select SND_SOC_SSM2602
+	select SND_SOC_TLV320AIC23
 	select SND_SOC_TLV320AIC26
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_UDA1380
@@ -62,6 +63,10 @@ config SND_SOC_CS4270_VD33_ERRATA
 config SND_SOC_SSM2602
 	tristate

+config SND_SOC_TLV320AIC23
+	tristate
+	depends on I2C
+
 config SND_SOC_TLV320AIC26
 	tristate "TI TLV320AIC26 Codec support"
 	depends on SND_SOC && SPI
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0731844..90f0a58 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -4,6 +4,7 @@ snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-ssm2602-objs := ssm2602.o
+snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-uda1380-objs := uda1380.o
@@ -25,6 +26,7 @@ obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
+obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
new file mode 100644
index 0000000..b602c87
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -0,0 +1,631 @@
+/*
+ * ALSA SoC TLV320AIC23 codec driver
+ *
+ * Author:      Arun KS, <arunks@mistralsolutions.com>
+ * Copyright:   (C) 2008 Mistral Solutions Pvt Ltd.,
+ *
+ * Based on sound/soc/codecs/tlv320aic3x.c by Vladimir Barinov
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Notes:
+ *  The AIC23 is a driver for a low power stereo audio
+ *  codec tlv320aic23
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
+#define AUDIO_NAME "tlv320aic23"
+#define AIC23_VERSION "0.1"
+
+/* codec private data */
+struct tlv320aic23_priv {
+	unsigned int sysclk;
+	int master;
+};
+
+struct tlv320aic23_samplerate_reg_info {
+	u32 sample_rate;
+	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
+	u8 divider;		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
+};
+
+/*
+ * AIC23 register cache
+ */
+static const u16 tlv320aic23_reg[] = {
+	0x0097, 0x0097, 0x00F9, 0x00F9,	/* 0 */
+	0x001A, 0x0004, 0x0007, 0x0001,	/* 4 */
+	0x0020, 0x0000, 0x0000, 0x0000,	/* 8 */
+	0x0000, 0x0000, 0x0000, 0x0000,	/* 12 */
+};
+
+/*
+ * read tlv320aic23 register cache
+ */
+static inline unsigned int tlv320aic23_read_reg_cache(struct snd_soc_codec
+						      *codec, unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= ARRAY_SIZE(tlv320aic23_reg))
+		return -1;
+	return cache[reg];
+}
+
+/*
+ * write tlv320aic23 register cache
+ */
+static inline void tlv320aic23_write_reg_cache(struct snd_soc_codec *codec,
+					       u8 reg, u16 value)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg >= ARRAY_SIZE(tlv320aic23_reg))
+		return;
+	cache[reg] = value;
+}
+
+/*
+ * write to the tlv320aic23 register space
+ */
+static int tlv320aic23_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
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
+		printk(KERN_WARNING "%s Invalid register R%d\n", __func__, reg);
+		return -1;
+	}
+
+	data = (reg << 1) | (value >> 8 & 0x01);
+
+	tlv320aic23_write_reg_cache(codec, reg, value);
+
+	if (codec->hw_write(codec->control_data, (u8) data,
+			    (u8) (value & 0xff)) == 0)
+		return 0;
+
+	printk(KERN_ERR "%s cannot write %03x to register R%d\n", __func__,
+	       value, reg);
+
+	return -EIO;
+}
+
+static const char *tlv320aic23_rec_src[] = { "Line", "Mic" };
+static const char *tlv320aic23_sidetone_src[] =
+    { "-6db", "-9db", "-12db", "-18db", "0db" };
+
+static const struct soc_enum tlv320aic23_enum[] = {
+	SOC_ENUM_SINGLE(TLV320AIC23_ANALOG_AUDIO_CONTROL, 2, 2,
+			tlv320aic23_rec_src),
+	SOC_ENUM_SINGLE(TLV320AIC23_ANALOG_AUDIO_CONTROL, 6, 5,
+			tlv320aic23_sidetone_src),
+};
+
+static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
+SOC_DAPM_ENUM("Route", tlv320aic23_enum[0]);
+
+static const struct snd_kcontrol_new tlv320aic23_sidetone_src_controls =
+SOC_DAPM_ENUM("Route", tlv320aic23_enum[1]);
+
+static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
+	SOC_DOUBLE_R("PCM Playback Volume", TLV320AIC23_LEFT_CHANNEL_VOLUME,
+		     TLV320AIC23_RIGHT_CHANNEL_VOLUME, 0, 0x7f, 0),
+	SOC_SINGLE("PCM Playback Switch", TLV320AIC23_DIGITAL_AUDIO_CONTROL, 3,
+		   0x01, 1),
+	SOC_DOUBLE_R("Line Input Mute", TLV320AIC23_LEFT_LINE_VOLUME,
+		     TLV320AIC23_RIGHT_LINE_VOLUME, 7, 0x01, 0),
+	SOC_DOUBLE_R("Line Input Volume", TLV320AIC23_LEFT_LINE_VOLUME,
+		     TLV320AIC23_RIGHT_LINE_VOLUME, 0, 0x1f, 0),
+	SOC_SINGLE("Mic Switch", TLV320AIC23_ANALOG_AUDIO_CONTROL, 1, 0x01, 0),
+	SOC_SINGLE("Mic Booster Switch", TLV320AIC23_ANALOG_AUDIO_CONTROL, 0,
+		   0x01, 0),
+	SOC_SINGLE("Sidetone Switch", TLV320AIC23_ANALOG_AUDIO_CONTROL, 5, 1,
+		   0),
+	SOC_ENUM("Sidetone Gain", tlv320aic23_enum[1]),
+	SOC_SINGLE("Line Bypass", TLV320AIC23_ANALOG_AUDIO_CONTROL, 3, 1, 0),
+
+};
+
+/* add non dapm controls */
+static int tlv320aic23_add_controls(struct snd_soc_codec *codec)
+{
+
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(tlv320aic23_snd_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				  snd_soc_cnew(&tlv320aic23_snd_controls[i],
+					       codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+
+}
+
+/* PGA Mixer controls for Line and Mic switch */
+static const struct snd_kcontrol_new tlv320aic23_pga_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Switch", TLV320AIC23_POWER_DOWN_CONTROL, 0, 1, 1),
+	SOC_DAPM_SINGLE("Mic Switch", TLV320AIC23_POWER_DOWN_CONTROL, 1, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", TLV320AIC23_POWER_DOWN_CONTROL, 3,
+			 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", TLV320AIC23_POWER_DOWN_CONTROL, 2,
+			 1),
+	SND_SOC_DAPM_MIXER("PGA Mixer", SND_SOC_NOPM, 0, 0,
+			   &tlv320aic23_pga_mixer_controls[0],
+			   ARRAY_SIZE(tlv320aic23_pga_mixer_controls)),
+	SND_SOC_DAPM_MUX("Capture Source", SND_SOC_NOPM, 0, 0,
+			 &tlv320aic23_rec_src_mux_controls),
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
+
+	{"LHPOUT", NULL, "DAC"},
+	{"RHPOUT", NULL, "DAC"},
+
+	{"LOUT", NULL, "DAC"},
+	{"ROUT", NULL, "DAC"},
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
+};
+
+/* tlv320aic23 related */
+static const struct tlv320aic23_samplerate_reg_info rate_reg_info[] = {
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
+static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	/* set up audio path interconnects */
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
+
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 iface_reg, data;
+	u8 count = 0;
+
+	iface_reg = tlv320aic23_read_reg_cache(codec,
+					       TLV320AIC23_DIGITAL_AUDIO_FORMAT)
+	    & ~(0x03 << 2);
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
+	tlv320aic23_write(codec, TLV320AIC23_SAMPLE_RATE_CONTROL, data);
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
+	tlv320aic23_write(codec, TLV320AIC23_DIGITAL_AUDIO_FORMAT, iface_reg);
+
+	return 0;
+}
+
+static int tlv320aic23_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 reg;
+
+	reg =
+	    tlv320aic23_read_reg_cache(codec,
+				       TLV320AIC23_DIGITAL_AUDIO_CONTROL) &
+	    ~DACM_MUTE;
+
+	if (mute)
+		tlv320aic23_write(codec, TLV320AIC23_DIGITAL_AUDIO_CONTROL,
+				  reg | DACM_MUTE);
+
+	else
+		tlv320aic23_write(codec, TLV320AIC23_DIGITAL_AUDIO_CONTROL,
+				  reg);
+
+	return 0;
+}
+
+static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				      int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tlv320aic23_priv *tlv320aic23 = codec->private_data;
+
+	tlv320aic23->sysclk = freq;
+	return 0;
+}
+
+static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				   unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tlv320aic23_priv *tlv320aic23 = codec->private_data;
+	u16 iface_reg;
+
+	iface_reg =
+	    tlv320aic23_read_reg_cache(codec,
+				       TLV320AIC23_DIGITAL_AUDIO_FORMAT) &
+	    (~0x03);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		tlv320aic23->master = 1;
+		iface_reg |= MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		tlv320aic23->master = 0;
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
+	tlv320aic23_write(codec, TLV320AIC23_DIGITAL_AUDIO_FORMAT, iface_reg);
+
+	return 0;
+}
+
+#define AIC23_RATES	SNDRV_PCM_RATE_8000_96000
+#define AIC23_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai tlv320aic23_dai = {
+	.name = "tlv320aic23",
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
+		.hw_params = tlv320aic23_hw_params,
+		},
+	.dai_ops = {
+		    .digital_mute = tlv320aic23_mute,
+		    .set_sysclk = tlv320aic23_set_dai_sysclk,
+		    .set_fmt = tlv320aic23_set_dai_fmt,
+		    }
+};
+EXPORT_SYMBOL_GPL(tlv320aic23_dai);
+
+static int tlv320aic23_suspend(struct platform_device *pdev,
pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	u16 reg;
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_POWER_DOWN_CONTROL);
+	tlv320aic23_write(codec, TLV320AIC23_POWER_DOWN_CONTROL,
+			  reg | DEVICE_POWER_OFF | OUT_OFF);
+
+	return 0;
+}
+
+static int tlv320aic23_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u8 data[2];
+	u16 reg;
+	u8 *cache = codec->reg_cache;
+
+	/* Sync reg_cache with the hardware */
+	for (i = 0; i < ARRAY_SIZE(tlv320aic23_reg); i++) {
+		data[0] = i;
+		data[1] = cache[i];
+		codec->hw_write(codec->control_data, data, 2);
+	}
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_POWER_DOWN_CONTROL);
+	tlv320aic23_write(codec, TLV320AIC23_POWER_DOWN_CONTROL,
+			  reg & (~DEVICE_POWER_OFF) & (~OUT_OFF));
+
+	return 0;
+}
+
+/*
+ * initialise the AIC23 driver
+ * register the mixer and dsp interfaces with the kernel
+ */
+static int tlv320aic23_init(struct snd_soc_device *socdev)
+{
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret = 0;
+	u16 reg;
+
+	codec->name = "tlv320aic23";
+	codec->owner = THIS_MODULE;
+	codec->read = tlv320aic23_read_reg_cache;
+	codec->write = tlv320aic23_write;
+	codec->dai = &tlv320aic23_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(tlv320aic23_reg);
+	codec->reg_cache =
+	    kmemdup(tlv320aic23_reg, sizeof(tlv320aic23_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	/* Reset codec */
+	tlv320aic23_write(codec, TLV320AIC23_RESET_CONTROL, 0);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "tlv320aic23: failed to create pcms\n");
+		goto pcm_err;
+	}
+	/* Power on the device */
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_POWER_DOWN_CONTROL);
+	tlv320aic23_write(codec, TLV320AIC23_POWER_DOWN_CONTROL,
+			  reg & (~DEVICE_POWER_OFF) & (~OUT_OFF));
+
+	tlv320aic23_write(codec, TLV320AIC23_DIGITAL_AUDIO_CONTROL, DEEMP_44K);
+
+	/* Unmute input */
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_LEFT_LINE_VOLUME);
+	tlv320aic23_write(codec, TLV320AIC23_LEFT_LINE_VOLUME,
+			  (reg & (~LIM_MUTED)) | (LRS_ENABLED));
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_RIGHT_LINE_VOLUME);
+	tlv320aic23_write(codec, TLV320AIC23_RIGHT_LINE_VOLUME,
+			  (reg & (~LIM_MUTED)) | LRS_ENABLED);
+	reg =
+	    tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANALOG_AUDIO_CONTROL);
+	tlv320aic23_write(codec, TLV320AIC23_ANALOG_AUDIO_CONTROL,
+			  (reg | DAC_SELECTED) & (~MICM_MUTED) & (~BYPASS_ON));
+
+	/* Default output volume */
+	tlv320aic23_write(codec, TLV320AIC23_LEFT_CHANNEL_VOLUME,
+			  DEFAULT_OUTPUT_VOLUME & OUTPUT_VOLUME_MASK);
+	tlv320aic23_write(codec, TLV320AIC23_RIGHT_CHANNEL_VOLUME,
+			  DEFAULT_OUTPUT_VOLUME & OUTPUT_VOLUME_MASK);
+
+	/* Activate interface */
+	reg =
+	    tlv320aic23_read_reg_cache(codec,
+				       TLV320AIC23_DIGITAL_INTERFACE_ACT);
+	tlv320aic23_write(codec, TLV320AIC23_DIGITAL_INTERFACE_ACT,
+			  reg | ACT_ON);
+
+	tlv320aic23_add_controls(codec);
+	tlv320aic23_add_widgets(codec);
+	ret = snd_soc_register_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "tlv320aic23: failed to register card\n");
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
+static struct snd_soc_device *tlv320aic23_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+/*
+ * If the i2c layer weren't so broken, we could pass this kind of data
+ * around
+ */
+static int tlv320aic23_codec_probe(struct i2c_client *i2c,
+				   const struct i2c_device_id *i2c_id)
+{
+	struct snd_soc_device *socdev = tlv320aic23_socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EINVAL;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	ret = tlv320aic23_init(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "tlv320aic23: failed to initialise AIC23\n");
+		goto err;
+	}
+	return ret;
+
+err:
+	kfree(codec);
+	kfree(i2c);
+	return ret;
+}
+static int __exit tlv320aic23_i2c_remove(struct i2c_client *i2c)
+{
+	put_device(&i2c->dev);
+	return 0;
+}
+
+static const struct i2c_device_id tlv320aic23_id[] = {
+	{"tlv320aic23", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tlv320aic23_id);
+
+static struct i2c_driver tlv320aic23_i2c_driver = {
+	.driver = {
+		   .name = "tlv320aic23",
+		   },
+	.probe = tlv320aic23_codec_probe,
+	.remove = __exit_p(tlv320aic23_i2c_remove),
+	.id_table = tlv320aic23_id,
+};
+
+#endif
+
+static int tlv320aic23_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	struct tlv320aic23_priv *tlv320aic23;
+	int ret = 0;
+
+	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
+	tlv320aic23 = kzalloc(sizeof(struct tlv320aic23_priv), GFP_KERNEL);
+	if (tlv320aic23 == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
+
+	codec->private_data = tlv320aic23;
+	socdev->codec = codec;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	tlv320aic23_socdev = socdev;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	codec->hw_write = (hw_write_t) i2c_smbus_write_byte_data;
+	codec->hw_read = NULL;
+	ret = i2c_add_driver(&tlv320aic23_i2c_driver);
+	if (ret != 0)
+		printk(KERN_ERR "can't add i2c driver");
+#endif
+	return ret;
+}
+
+static int tlv320aic23_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&tlv320aic23_i2c_driver);
+#endif
+	kfree(codec->private_data);
+	kfree(codec->reg_cache);
+	kfree(codec);
+
+	return 0;
+}
+struct snd_soc_codec_device soc_codec_dev_tlv320aic23 = {
+	.probe = tlv320aic23_probe,
+	.remove = tlv320aic23_remove,
+	.suspend = tlv320aic23_suspend,
+	.resume = tlv320aic23_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320aic23);
+
+MODULE_DESCRIPTION("ASoC TLV320AIC23 codec driver");
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tlv320aic23.h b/sound/soc/codecs/tlv320aic23.h
new file mode 100644
index 0000000..7ffeaf6
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.h
@@ -0,0 +1,125 @@
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
+#ifndef _TLV320AIC23_H
+#define _TLV320AIC23_H
+
+/* Codec TLV320AIC23 */
+#define TLV320AIC23_LEFT_LINE_VOLUME		0x00
+#define TLV320AIC23_RIGHT_LINE_VOLUME		0x01
+#define TLV320AIC23_LEFT_CHANNEL_VOLUME		0x02
+#define TLV320AIC23_RIGHT_CHANNEL_VOLUME	0x03
+#define TLV320AIC23_ANALOG_AUDIO_CONTROL	0x04
+#define TLV320AIC23_DIGITAL_AUDIO_CONTROL	0x05
+#define TLV320AIC23_POWER_DOWN_CONTROL		0x06
+#define TLV320AIC23_DIGITAL_AUDIO_FORMAT	0x07
+#define TLV320AIC23_SAMPLE_RATE_CONTROL		0x08
+#define TLV320AIC23_DIGITAL_INTERFACE_ACT	0x09
+#define TLV320AIC23_RESET_CONTROL		0x0F
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
+/*
+ * AUDIO related MACROS
+ */
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
+
+extern struct snd_soc_dai tlv320aic23_dai;
+extern struct snd_soc_codec_device soc_codec_dev_tlv320aic23;
+
+#endif /* _TLV320AIC23_H */
+
-- 
1.5.3.4
