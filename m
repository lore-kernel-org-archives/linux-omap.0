From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 1/5 v2] ASoC Add TLV320AIC23 codec driver
Date: Thu, 2 Oct 2008 14:55:27 +0530
Message-ID: <dfeb90390810020225h2e5e33a5jc4b71816bda0c21e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68167_8509622.1222939527323"
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, troy.kisky@boundarydevices.com
List-Id: linux-omap@vger.kernel.org

------=_Part_68167_8509622.1222939527323
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ASoC codec driver for TLV320AIC23 device

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/codecs/Kconfig       |    5 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/tlv320aic23.c |  670 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23.h |  122 ++++++++
 4 files changed, 799 insertions(+), 0 deletions(-)
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
index 0000000..c2d35e9
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -0,0 +1,670 @@
+/*
+ * ALSA SoC TLV320AIC23 codec driver
+ *
+ * Author:      Arun KS, <arunks@mistralsolutions.com>
+ * Copyright:   (C) 2008 Mistral Solutions Pvt Ltd.,
+ *
+ * Based on sound/soc/codecs/wm8731.c by Richard Purdie
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
+#include <sound/tlv.h>
+#include <sound/initval.h>
+
+#include "tlv320aic23.h"
+
+#define AUDIO_NAME "tlv320aic23"
+#define AIC23_VERSION "0.1"
+
+struct tlv320aic23_srate_reg_info {
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
+	if (codec->hw_write(codec->control_data, data,
+			    (value & 0xff)) == 0)
+		return 0;
+
+	printk(KERN_ERR "%s cannot write %03x to register R%d\n", __func__,
+	       value, reg);
+
+	return -EIO;
+}
+
+static const char *rec_src_text[] = { "Line", "Mic" };
+static const char *deemph_text[] = {"None", "32Khz", "44.1Khz", "48Khz"};
+static const char *sidetone_text[] = {"-6db", "-9db", "-12db", "-18db", "0db"};
+
+static const struct soc_enum rec_src_enum =
+	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
+
+static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
+SOC_DAPM_ENUM("Input Select", rec_src_enum);
+
+static const struct soc_enum tlv320aic23_rec_src =
+	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 2, 2, rec_src_text);
+static const struct soc_enum tlv320aic23_deemph =
+	SOC_ENUM_SINGLE(TLV320AIC23_DIGT, 1, 4, deemph_text);
+static const struct soc_enum tlv320aic23_sidetone =
+	SOC_ENUM_SINGLE(TLV320AIC23_ANLG, 6, 5, sidetone_text);
+
+static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -12100, 100, 0);
+static const DECLARE_TLV_DB_SCALE(input_gain_tlv, -1725, 75, 0);
+
+static const struct snd_kcontrol_new tlv320aic23_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("Digital Playback Volume", TLV320AIC23_LCHNVOL,
+			 TLV320AIC23_RCHNVOL, 0, 127, 0, out_gain_tlv),
+	SOC_SINGLE("Digital Playback Switch", TLV320AIC23_DIGT, 3, 1, 1),
+	SOC_DOUBLE_R("Line Input Switch", TLV320AIC23_LINVOL,
+		     TLV320AIC23_RINVOL, 7, 1, 0),
+	SOC_DOUBLE_R_TLV("Line Input Volume", TLV320AIC23_LINVOL,
+			 TLV320AIC23_RINVOL, 0, 31, 0, input_gain_tlv),
+	SOC_SINGLE("Mic Input Switch", TLV320AIC23_ANLG, 1, 1, 1),
+	SOC_SINGLE("Mic Booster Switch", TLV320AIC23_ANLG, 0, 1, 0),
+	SOC_ENUM("Sidetone Gain", tlv320aic23_sidetone),
+	SOC_ENUM("Playback De-emphasis", tlv320aic23_deemph),
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
+static const struct snd_kcontrol_new tlv320aic23_output_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line Bypass Switch", TLV320AIC23_ANLG, 3, 1, 0),
+	SOC_DAPM_SINGLE("Mic Sidetone Switch", TLV320AIC23_ANLG, 5, 1, 0),
+	SOC_DAPM_SINGLE("Playback Switch", TLV320AIC23_ANLG, 4, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", TLV320AIC23_PWR, 3, 1),
+	SND_SOC_DAPM_ADC("ADC", "Capture", TLV320AIC23_PWR, 2, 1),
+	SND_SOC_DAPM_MUX("Capture Source", SND_SOC_NOPM, 0, 0,
+			 &tlv320aic23_rec_src_mux_controls),
+	SND_SOC_DAPM_MIXER("Output Mixer", TLV320AIC23_PWR, 4, 1,
+			   &tlv320aic23_output_mixer_controls[0],
+			   ARRAY_SIZE(tlv320aic23_output_mixer_controls)),
+	SND_SOC_DAPM_PGA("Line Input", TLV320AIC23_PWR, 0, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Mic Input", TLV320AIC23_PWR, 1, 1, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("LHPOUT"),
+	SND_SOC_DAPM_OUTPUT("RHPOUT"),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+	SND_SOC_DAPM_OUTPUT("ROUT"),
+
+	SND_SOC_DAPM_INPUT("LLINEIN"),
+	SND_SOC_DAPM_INPUT("RLINEIN"),
+
+	SND_SOC_DAPM_INPUT("MICIN"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	/* Output Mixer */
+	{"Output Mixer", "Line Bypass Switch", "Line Input"},
+	{"Output Mixer", "Playback Switch", "DAC"},
+	{"Output Mixer", "Mic Sidetone Switch", "Mic Input"},
+
+	/* Outputs */
+	{"RHPOUT", NULL, "Output Mixer"},
+	{"LHPOUT", NULL, "Output Mixer"},
+	{"LOUT", NULL, "Output Mixer"},
+	{"ROUT", NULL, "Output Mixer"},
+
+	/* Inputs */
+	{"Line Input", "NULL", "LLINEIN"},
+	{"Line Input", "NULL", "RLINEIN"},
+
+	{"Mic Input", "NULL", "MICIN"},
+
+	/* input mux */
+	{"Capture Source", "Line", "Line Input"},
+	{"Capture Source", "Mic", "Mic Input"},
+	{"ADC", NULL, "Capture Source"},
+
+};
+
+/* tlv320aic23 related */
+static const struct tlv320aic23_srate_reg_info srate_reg_info[] = {
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
+	iface_reg =
+	    tlv320aic23_read_reg_cache(codec,
+				       TLV320AIC23_DIGT_FMT) & ~(0x03 << 2);
+
+	/* Search for the right sample rate */
+	/* Verify what happens if the rate is not supported
+	 * now it goes to 96Khz */
+	while ((srate_reg_info[count].sample_rate != params_rate(params)) &&
+	       (count < ARRAY_SIZE(srate_reg_info))) {
+		count++;
+	}
+
+	data =  (srate_reg_info[count].divider << TLV320AIC23_CLKIN_SHIFT) |
+		(srate_reg_info[count]. control << TLV320AIC23_BOSR_SHIFT) |
+		TLV320AIC23_USB_CLK_ON;
+
+	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
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
+	tlv320aic23_write(codec, TLV320AIC23_DIGT_FMT, iface_reg);
+
+	return 0;
+}
+
+static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+
+	/* set active */
+	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0001);
+
+	return 0;
+}
+
+static void tlv320aic23_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_codec *codec = socdev->codec;
+
+	/* deactivate */
+	if (!codec->active) {
+		udelay(50);
+		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
+	}
+}
+
+static int tlv320aic23_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u16 reg;
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_DIGT);
+	if (mute)
+		reg |= TLV320AIC23_DACM_MUTE;
+
+	else
+		reg &= ~TLV320AIC23_DACM_MUTE;
+
+	tlv320aic23_write(codec, TLV320AIC23_DIGT, reg);
+
+	return 0;
+}
+
+static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
+				   unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	u16 iface_reg;
+
+	iface_reg =
+	    tlv320aic23_read_reg_cache(codec, TLV320AIC23_DIGT_FMT) & (~0x03);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		iface_reg |= TLV320AIC23_MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+
+	}
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface_reg |= TLV320AIC23_FOR_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface_reg |= TLV320AIC23_FOR_DSP;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		iface_reg |= TLV320AIC23_FOR_LJUST;
+		break;
+	default:
+		return -EINVAL;
+
+	}
+
+	tlv320aic23_write(codec, TLV320AIC23_DIGT_FMT, iface_reg);
+
+	return 0;
+}
+
+static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				      int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+
+	switch (freq) {
+	case 12000000:
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int tlv320aic23_set_bias_level(struct snd_soc_codec *codec,
+				      enum snd_soc_bias_level level)
+{
+	u16 reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_PWR) & 0xff7f;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		/* vref/mid, osc on, dac unmute */
+		tlv320aic23_write(codec, TLV320AIC23_PWR, reg);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		/* everything off except vref/vmid, */
+		tlv320aic23_write(codec, TLV320AIC23_PWR, reg | 0x0040);
+		break;
+	case SND_SOC_BIAS_OFF:
+		/* everything off, dac mute, inactive */
+		tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
+		tlv320aic23_write(codec, TLV320AIC23_PWR, 0xffff);
+		break;
+	}
+	codec->bias_level = level;
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
+		.prepare = tlv320aic23_pcm_prepare,
+		.hw_params = tlv320aic23_hw_params,
+		.shutdown = tlv320aic23_shutdown,
+		},
+	.dai_ops = {
+		    .digital_mute = tlv320aic23_mute,
+		    .set_fmt = tlv320aic23_set_dai_fmt,
+		    .set_sysclk = tlv320aic23_set_dai_sysclk,
+		    }
+};
+EXPORT_SYMBOL_GPL(tlv320aic23_dai);
+
+static int tlv320aic23_suspend(struct platform_device *pdev,
+			       pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+
+	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
+	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
+}
+
+static int tlv320aic23_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->codec;
+	int i;
+	u16 reg;
+
+	/* Sync reg_cache with the hardware */
+	for (reg = 0; reg < ARRAY_SIZE(tlv320aic23_reg); i++) {
+		u16 val = tlv320aic23_read_reg_cache(codec, reg);
+		tlv320aic23_write(codec, reg, val);
+	}
+
+	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	tlv320aic23_set_bias_level(codec, codec->suspend_bias_level);
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
+	codec->set_bias_level = tlv320aic23_set_bias_level;
+	codec->dai = &tlv320aic23_dai;
+	codec->num_dai = 1;
+	codec->reg_cache_size = ARRAY_SIZE(tlv320aic23_reg);
+	codec->reg_cache =
+	    kmemdup(tlv320aic23_reg, sizeof(tlv320aic23_reg), GFP_KERNEL);
+	if (codec->reg_cache == NULL)
+		return -ENOMEM;
+
+	/* Reset codec */
+	tlv320aic23_write(codec, TLV320AIC23_RESET, 0);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "tlv320aic23: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	/* power on device */
+	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	tlv320aic23_write(codec, TLV320AIC23_DIGT, TLV320AIC23_DEEMP_44K);
+
+	/* Unmute input */
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_LINVOL);
+	tlv320aic23_write(codec, TLV320AIC23_LINVOL,
+			  (reg & (~TLV320AIC23_LIM_MUTED)) |
+			  (TLV320AIC23_LRS_ENABLED));
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_RINVOL);
+	tlv320aic23_write(codec, TLV320AIC23_RINVOL,
+			  (reg & (~TLV320AIC23_LIM_MUTED)) |
+			  TLV320AIC23_LRS_ENABLED);
+
+	reg = tlv320aic23_read_reg_cache(codec, TLV320AIC23_ANLG);
+	tlv320aic23_write(codec, TLV320AIC23_ANLG,
+			 (reg) & (~TLV320AIC23_BYPASS_ON) &
+			 (~TLV320AIC23_MICM_MUTED));
+
+	/* Default output volume */
+	tlv320aic23_write(codec, TLV320AIC23_LCHNVOL,
+			  TLV320AIC23_DEFAULT_OUT_VOL &
+			  TLV320AIC23_OUT_VOL_MASK);
+	tlv320aic23_write(codec, TLV320AIC23_RCHNVOL,
+			  TLV320AIC23_DEFAULT_OUT_VOL &
+			  TLV320AIC23_OUT_VOL_MASK);
+
+	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x1);
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
+	int ret = 0;
+
+	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+
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
+	if (codec->control_data)
+		tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&tlv320aic23_i2c_driver);
+#endif
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
index 0000000..79d1faf
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic23.h
@@ -0,0 +1,122 @@
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
+#define TLV320AIC23_LINVOL		0x00
+#define TLV320AIC23_RINVOL		0x01
+#define TLV320AIC23_LCHNVOL		0x02
+#define TLV320AIC23_RCHNVOL		0x03
+#define TLV320AIC23_ANLG		0x04
+#define TLV320AIC23_DIGT		0x05
+#define TLV320AIC23_PWR			0x06
+#define TLV320AIC23_DIGT_FMT		0x07
+#define TLV320AIC23_SRATE		0x08
+#define TLV320AIC23_ACTIVE		0x09
+#define TLV320AIC23_RESET		0x0F
+
+/* Left (right) line input volume control register */
+#define TLV320AIC23_LRS_ENABLED		0x0100
+#define TLV320AIC23_LIM_MUTED		0x0080
+#define TLV320AIC23_LIV_DEFAULT		0x0017
+#define TLV320AIC23_LIV_MAX		0x001f
+#define TLV320AIC23_LIV_MIN		0x0000
+
+/* Left (right) channel headphone volume control register */
+#define TLV320AIC23_LZC_ON		0x0080
+#define TLV320AIC23_LHV_DEFAULT		0x0079
+#define TLV320AIC23_LHV_MAX		0x007f
+#define TLV320AIC23_LHV_MIN		0x0000
+
+/* Analog audio path control register */
+#define TLV320AIC23_STA_REG(x)		((x)<<6)
+#define TLV320AIC23_STE_ENABLED		0x0020
+#define TLV320AIC23_DAC_SELECTED	0x0010
+#define TLV320AIC23_BYPASS_ON		0x0008
+#define TLV320AIC23_INSEL_MIC		0x0004
+#define TLV320AIC23_MICM_MUTED		0x0002
+#define TLV320AIC23_MICB_20DB		0x0001
+
+/* Digital audio path control register */
+#define TLV320AIC23_DACM_MUTE		0x0008
+#define TLV320AIC23_DEEMP_32K		0x0002
+#define TLV320AIC23_DEEMP_44K		0x0004
+#define TLV320AIC23_DEEMP_48K		0x0006
+#define TLV320AIC23_ADCHP_ON		0x0001
+
+/* Power control down register */
+#define TLV320AIC23_DEVICE_PWR_OFF  	0x0080
+#define TLV320AIC23_CLK_OFF		0x0040
+#define TLV320AIC23_OSC_OFF		0x0020
+#define TLV320AIC23_OUT_OFF		0x0010
+#define TLV320AIC23_DAC_OFF		0x0008
+#define TLV320AIC23_ADC_OFF		0x0004
+#define TLV320AIC23_MIC_OFF		0x0002
+#define TLV320AIC23_LINE_OFF		0x0001
+
+/* Digital audio interface register */
+#define TLV320AIC23_MS_MASTER		0x0040
+#define TLV320AIC23_LRSWAP_ON		0x0020
+#define TLV320AIC23_LRP_ON		0x0010
+#define TLV320AIC23_IWL_16		0x0000
+#define TLV320AIC23_IWL_20		0x0004
+#define TLV320AIC23_IWL_24		0x0008
+#define TLV320AIC23_IWL_32		0x000C
+#define TLV320AIC23_FOR_I2S		0x0002
+#define TLV320AIC23_FOR_DSP		0x0003
+#define TLV320AIC23_FOR_LJUST		0x0001
+
+/* Sample rate control register */
+#define TLV320AIC23_CLKOUT_HALF		0x0080
+#define TLV320AIC23_CLKIN_HALF		0x0040
+#define TLV320AIC23_BOSR_384fs		0x0002	/* BOSR_272fs in USB mode */
+#define TLV320AIC23_USB_CLK_ON		0x0001
+#define TLV320AIC23_SR_MASK             0xf
+#define TLV320AIC23_CLKOUT_SHIFT        7
+#define TLV320AIC23_CLKIN_SHIFT         6
+#define TLV320AIC23_SR_SHIFT            2
+#define TLV320AIC23_BOSR_SHIFT          1
+
+/* Digital interface register */
+#define TLV320AIC23_ACT_ON		0x0001
+
+/*
+ * AUDIO related MACROS
+ */
+
+#define TLV320AIC23_DEFAULT_OUT_VOL	0x70
+#define TLV320AIC23_DEFAULT_IN_VOLUME	0x10
+
+#define TLV320AIC23_OUT_VOL_MIN		TLV320AIC23_LHV_MIN
+#define TLV320AIC23_OUT_VOL_MAX		TLV320AIC23_LHV_MAX
+#define TLV320AIC23_OUT_VO_RANGE	(TLV320AIC23_OUT_VOL_MAX - \
+					TLV320AIC23_OUT_VOL_MIN)
+#define TLV320AIC23_OUT_VOL_MASK	TLV320AIC23_OUT_VOL_MAX
+
+#define TLV320AIC23_IN_VOL_MIN		TLV320AIC23_LIV_MIN
+#define TLV320AIC23_IN_VOL_MAX		TLV320AIC23_LIV_MAX
+#define TLV320AIC23_IN_VOL_RANGE	(TLV320AIC23_IN_VOL_MAX - \
+					TLV320AIC23_IN_VOL_MIN)
+#define TLV320AIC23_IN_VOL_MASK		TLV320AIC23_IN_VOL_MAX
+
+#define TLV320AIC23_SIDETONE_MASK	0x1c0
+#define TLV320AIC23_SIDETONE_0		0x100
+#define TLV320AIC23_SIDETONE_6		0x000
+#define TLV320AIC23_SIDETONE_9		0x040
+#define TLV320AIC23_SIDETONE_12		0x080
+#define TLV320AIC23_SIDETONE_18		0x0c0
+
+extern struct snd_soc_dai tlv320aic23_dai;
+extern struct snd_soc_codec_device soc_codec_dev_tlv320aic23;
+
+#endif /* _TLV320AIC23_H */
-- 
1.5.3.4

------=_Part_68167_8509622.1222939527323
Content-Type: text/x-patch;
 name=0001-ASoC-Add-TLV320AIC23-codec-driver.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flt6lnwa0
Content-Disposition: attachment;
 filename=0001-ASoC-Add-TLV320AIC23-codec-driver.patch

RnJvbSBjMmU1ZDFhYzE0NTFkNDNlY2FjZmJkNzU5MzRiNzQ2NTUzYmFiZDNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcnVuIEtTIDxhcnVua3NAbWlzdHJhbHNvbHV0aW9ucy5jb20+
CkRhdGU6IFdlZCwgMSBPY3QgMjAwOCAyMzoyMToyNiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIEFT
b0MgQWRkIFRMVjMyMEFJQzIzIGNvZGVjIGRyaXZlcgoKQVNvQyBjb2RlYyBkcml2ZXIgZm9yIFRM
VjMyMEFJQzIzIGRldmljZQoKU2lnbmVkLW9mZi1ieTogQXJ1biBLUyA8YXJ1bmtzQG1pc3RyYWxz
b2x1dGlvbnMuY29tPgotLS0KIHNvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZyAgICAgICB8ICAgIDUg
Kwogc291bmQvc29jL2NvZGVjcy9NYWtlZmlsZSAgICAgIHwgICAgMiArCiBzb3VuZC9zb2MvY29k
ZWNzL3RsdjMyMGFpYzIzLmMgfCAgNjcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIHNvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljMjMuaCB8ICAxMjIgKysrKysrKysK
IDQgZmlsZXMgY2hhbmdlZCwgNzk5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVh
dGUgbW9kZSAxMDA2NDQgc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5jCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5oCgpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2NvZGVjcy9LY29uZmlnIGIvc291bmQvc29jL2NvZGVjcy9LY29uZmlnCmluZGV4IDA1
MDdmY2YuLmJkZWFkMmQgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvS2NvbmZpZworKysg
Yi9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcKQEAgLTcsNiArNyw3IEBAIGNvbmZpZyBTTkRfU09D
X0FMTF9DT0RFQ1MKIAlzZWxlY3QgU05EX1NPQ19BSzQ1MzUKIAlzZWxlY3QgU05EX1NPQ19DUzQy
NzAKIAlzZWxlY3QgU05EX1NPQ19TU00yNjAyCisJc2VsZWN0IFNORF9TT0NfVExWMzIwQUlDMjMK
IAlzZWxlY3QgU05EX1NPQ19UTFYzMjBBSUMyNgogCXNlbGVjdCBTTkRfU09DX1RMVjMyMEFJQzNY
CiAJc2VsZWN0IFNORF9TT0NfVURBMTM4MApAQCAtNjIsNiArNjMsMTAgQEAgY29uZmlnIFNORF9T
T0NfQ1M0MjcwX1ZEMzNfRVJSQVRBCiBjb25maWcgU05EX1NPQ19TU00yNjAyCiAJdHJpc3RhdGUK
IAorY29uZmlnIFNORF9TT0NfVExWMzIwQUlDMjMKKwl0cmlzdGF0ZQorCWRlcGVuZHMgb24gSTJD
CisKIGNvbmZpZyBTTkRfU09DX1RMVjMyMEFJQzI2CiAJdHJpc3RhdGUgIlRJIFRMVjMyMEFJQzI2
IENvZGVjIHN1cHBvcnQiCiAJZGVwZW5kcyBvbiBTTkRfU09DICYmIFNQSQpkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy9NYWtlZmlsZSBiL3NvdW5kL3NvYy9jb2RlY3MvTWFrZWZpbGUKaW5k
ZXggMDczMTg0NC4uOTBmMGE1OCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2NvZGVjcy9NYWtlZmls
ZQorKysgYi9zb3VuZC9zb2MvY29kZWNzL01ha2VmaWxlCkBAIC00LDYgKzQsNyBAQCBzbmQtc29j
LWFkNzMzMTEtb2JqcyA6PSBhZDczMzExLm8KIHNuZC1zb2MtYWs0NTM1LW9ianMgOj0gYWs0NTM1
Lm8KIHNuZC1zb2MtY3M0MjcwLW9ianMgOj0gY3M0MjcwLm8KIHNuZC1zb2Mtc3NtMjYwMi1vYmpz
IDo9IHNzbTI2MDIubworc25kLXNvYy10bHYzMjBhaWMyMy1vYmpzIDo9IHRsdjMyMGFpYzIzLm8K
IHNuZC1zb2MtdGx2MzIwYWljMjYtb2JqcyA6PSB0bHYzMjBhaWMyNi5vCiBzbmQtc29jLXRsdjMy
MGFpYzN4LW9ianMgOj0gdGx2MzIwYWljM3gubwogc25kLXNvYy11ZGExMzgwLW9ianMgOj0gdWRh
MTM4MC5vCkBAIC0yNSw2ICsyNiw3IEBAIG9iai0kKENPTkZJR19TTkRfU09DX0FENzMzMTEpICs9
IHNuZC1zb2MtYWQ3MzMxMS5vCiBvYmotJChDT05GSUdfU05EX1NPQ19BSzQ1MzUpCSs9IHNuZC1z
b2MtYWs0NTM1Lm8KIG9iai0kKENPTkZJR19TTkRfU09DX0NTNDI3MCkJKz0gc25kLXNvYy1jczQy
NzAubwogb2JqLSQoQ09ORklHX1NORF9TT0NfU1NNMjYwMikJKz0gc25kLXNvYy1zc20yNjAyLm8K
K29iai0kKENPTkZJR19TTkRfU09DX1RMVjMyMEFJQzIzKQkrPSBzbmQtc29jLXRsdjMyMGFpYzIz
Lm8KIG9iai0kKENPTkZJR19TTkRfU09DX1RMVjMyMEFJQzI2KQkrPSBzbmQtc29jLXRsdjMyMGFp
YzI2Lm8KIG9iai0kKENPTkZJR19TTkRfU09DX1RMVjMyMEFJQzNYKQkrPSBzbmQtc29jLXRsdjMy
MGFpYzN4Lm8KIG9iai0kKENPTkZJR19TTkRfU09DX1VEQTEzODApCSs9IHNuZC1zb2MtdWRhMTM4
MC5vCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzIzLmMgYi9zb3VuZC9z
b2MvY29kZWNzL3RsdjMyMGFpYzIzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MC4uYzJkMzVlOQotLS0gL2Rldi9udWxsCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWlj
MjMuYwpAQCAtMCwwICsxLDY3MCBAQAorLyoKKyAqIEFMU0EgU29DIFRMVjMyMEFJQzIzIGNvZGVj
IGRyaXZlcgorICoKKyAqIEF1dGhvcjogICAgICBBcnVuIEtTLCA8YXJ1bmtzQG1pc3RyYWxzb2x1
dGlvbnMuY29tPgorICogQ29weXJpZ2h0OiAgIChDKSAyMDA4IE1pc3RyYWwgU29sdXRpb25zIFB2
dCBMdGQuLAorICoKKyAqIEJhc2VkIG9uIHNvdW5kL3NvYy9jb2RlY3Mvd204NzMxLmMgYnkgUmlj
aGFyZCBQdXJkaWUKKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKKyAqIHB1Ymxpc2hl
ZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIE5vdGVzOgorICogIFRo
ZSBBSUMyMyBpcyBhIGRyaXZlciBmb3IgYSBsb3cgcG93ZXIgc3RlcmVvIGF1ZGlvCisgKiAgY29k
ZWMgdGx2MzIwYWljMjMKKyAqCisgKiAgVGhlIG1hY2hpbmUgbGF5ZXIgc2hvdWxkIGRpc2FibGUg
dW5zdXBwb3J0ZWQgaW5wdXRzL291dHB1dHMgYnkKKyAqICBzbmRfc29jX2RhcG1fZGlzYWJsZV9w
aW4oY29kZWMsICJMSFBPVVQiKSwgZXRjLgorICovCisKKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgorI2luY2x1ZGUgPGxpbnV4L2luaXQu
aD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L3BtLmg+CisjaW5j
bHVkZSA8bGludXgvaTJjLmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cisj
aW5jbHVkZSA8c291bmQvY29yZS5oPgorI2luY2x1ZGUgPHNvdW5kL3BjbS5oPgorI2luY2x1ZGUg
PHNvdW5kL3BjbV9wYXJhbXMuaD4KKyNpbmNsdWRlIDxzb3VuZC9zb2MuaD4KKyNpbmNsdWRlIDxz
b3VuZC9zb2MtZGFwbS5oPgorI2luY2x1ZGUgPHNvdW5kL3Rsdi5oPgorI2luY2x1ZGUgPHNvdW5k
L2luaXR2YWwuaD4KKworI2luY2x1ZGUgInRsdjMyMGFpYzIzLmgiCisKKyNkZWZpbmUgQVVESU9f
TkFNRSAidGx2MzIwYWljMjMiCisjZGVmaW5lIEFJQzIzX1ZFUlNJT04gIjAuMSIKKworc3RydWN0
IHRsdjMyMGFpYzIzX3NyYXRlX3JlZ19pbmZvIHsKKwl1MzIgc2FtcGxlX3JhdGU7CisJdTggY29u
dHJvbDsJCS8qIFNSMywgU1IyLCBTUjEsIFNSMCBhbmQgQk9TUiAqLworCXU4IGRpdmlkZXI7CQkv
KiBpZiAwIENMS0lOID0gTUNMSywgaWYgMSBDTEtJTiA9IE1DTEsvMiAqLworfTsKKworLyoKKyAq
IEFJQzIzIHJlZ2lzdGVyIGNhY2hlCisgKi8KK3N0YXRpYyBjb25zdCB1MTYgdGx2MzIwYWljMjNf
cmVnW10gPSB7CisJMHgwMDk3LCAweDAwOTcsIDB4MDBGOSwgMHgwMEY5LAkvKiAwICovCisJMHgw
MDFBLCAweDAwMDQsIDB4MDAwNywgMHgwMDAxLAkvKiA0ICovCisJMHgwMDIwLCAweDAwMDAsIDB4
MDAwMCwgMHgwMDAwLAkvKiA4ICovCisJMHgwMDAwLCAweDAwMDAsIDB4MDAwMCwgMHgwMDAwLAkv
KiAxMiAqLworfTsKKworLyoKKyAqIHJlYWQgdGx2MzIwYWljMjMgcmVnaXN0ZXIgY2FjaGUKKyAq
Lworc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgdGx2MzIwYWljMjNfcmVhZF9yZWdfY2FjaGUo
c3RydWN0IHNuZF9zb2NfY29kZWMKKwkJCQkJCSAgICAgICpjb2RlYywgdW5zaWduZWQgaW50IHJl
ZykKK3sKKwl1MTYgKmNhY2hlID0gY29kZWMtPnJlZ19jYWNoZTsKKwlpZiAocmVnID49IEFSUkFZ
X1NJWkUodGx2MzIwYWljMjNfcmVnKSkKKwkJcmV0dXJuIC0xOworCXJldHVybiBjYWNoZVtyZWdd
OworfQorCisvKgorICogd3JpdGUgdGx2MzIwYWljMjMgcmVnaXN0ZXIgY2FjaGUKKyAqLworc3Rh
dGljIGlubGluZSB2b2lkIHRsdjMyMGFpYzIzX3dyaXRlX3JlZ19jYWNoZShzdHJ1Y3Qgc25kX3Nv
Y19jb2RlYyAqY29kZWMsCisJCQkJCSAgICAgICB1OCByZWcsIHUxNiB2YWx1ZSkKK3sKKwl1MTYg
KmNhY2hlID0gY29kZWMtPnJlZ19jYWNoZTsKKwlpZiAocmVnID49IEFSUkFZX1NJWkUodGx2MzIw
YWljMjNfcmVnKSkKKwkJcmV0dXJuOworCWNhY2hlW3JlZ10gPSB2YWx1ZTsKK30KKworLyoKKyAq
IHdyaXRlIHRvIHRoZSB0bHYzMjBhaWMyMyByZWdpc3RlciBzcGFjZQorICovCitzdGF0aWMgaW50
IHRsdjMyMGFpYzIzX3dyaXRlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYywgdW5zaWduZWQg
aW50IHJlZywKKwkJCSAgICAgdW5zaWduZWQgaW50IHZhbHVlKQoreworCisJdTggZGF0YTsKKwor
CS8qIFRMVjMyMEFJQzIzIGhhcyA3IGJpdCBhZGRyZXNzIGFuZCA5IGJpdHMgb2YgZGF0YQorCSAq
IHNvIHdlIG5lZWQgdG8gc3dpdGNoIG9uZSBkYXRhIGJpdCBpbnRvIHJlZyBhbmQgcmVzdAorCSAq
IG9mIGRhdGEgaW50byB2YWwKKwkgKi8KKworCWlmICgocmVnIDwgMCB8fCByZWcgPiA5KSAmJiAo
cmVnICE9IDE1KSkgeworCQlwcmludGsoS0VSTl9XQVJOSU5HICIlcyBJbnZhbGlkIHJlZ2lzdGVy
IFIlZFxuIiwgX19mdW5jX18sIHJlZyk7CisJCXJldHVybiAtMTsKKwl9CisKKwlkYXRhID0gKHJl
ZyA8PCAxKSB8ICh2YWx1ZSA+PiA4ICYgMHgwMSk7CisKKwl0bHYzMjBhaWMyM193cml0ZV9yZWdf
Y2FjaGUoY29kZWMsIHJlZywgdmFsdWUpOworCisJaWYgKGNvZGVjLT5od193cml0ZShjb2RlYy0+
Y29udHJvbF9kYXRhLCBkYXRhLAorCQkJICAgICh2YWx1ZSAmIDB4ZmYpKSA9PSAwKQorCQlyZXR1
cm4gMDsKKworCXByaW50ayhLRVJOX0VSUiAiJXMgY2Fubm90IHdyaXRlICUwM3ggdG8gcmVnaXN0
ZXIgUiVkXG4iLCBfX2Z1bmNfXywKKwkgICAgICAgdmFsdWUsIHJlZyk7CisKKwlyZXR1cm4gLUVJ
TzsKK30KKworc3RhdGljIGNvbnN0IGNoYXIgKnJlY19zcmNfdGV4dFtdID0geyAiTGluZSIsICJN
aWMiIH07CitzdGF0aWMgY29uc3QgY2hhciAqZGVlbXBoX3RleHRbXSA9IHsiTm9uZSIsICIzMkto
eiIsICI0NC4xS2h6IiwgIjQ4S2h6In07CitzdGF0aWMgY29uc3QgY2hhciAqc2lkZXRvbmVfdGV4
dFtdID0geyItNmRiIiwgIi05ZGIiLCAiLTEyZGIiLCAiLTE4ZGIiLCAiMGRiIn07CisKK3N0YXRp
YyBjb25zdCBzdHJ1Y3Qgc29jX2VudW0gcmVjX3NyY19lbnVtID0KKwlTT0NfRU5VTV9TSU5HTEUo
VExWMzIwQUlDMjNfQU5MRywgMiwgMiwgcmVjX3NyY190ZXh0KTsKKworc3RhdGljIGNvbnN0IHN0
cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHRsdjMyMGFpYzIzX3JlY19zcmNfbXV4X2NvbnRyb2xzID0K
K1NPQ19EQVBNX0VOVU0oIklucHV0IFNlbGVjdCIsIHJlY19zcmNfZW51bSk7CisKK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qgc29jX2VudW0gdGx2MzIwYWljMjNfcmVjX3NyYyA9CisJU09DX0VOVU1fU0lO
R0xFKFRMVjMyMEFJQzIzX0FOTEcsIDIsIDIsIHJlY19zcmNfdGV4dCk7CitzdGF0aWMgY29uc3Qg
c3RydWN0IHNvY19lbnVtIHRsdjMyMGFpYzIzX2RlZW1waCA9CisJU09DX0VOVU1fU0lOR0xFKFRM
VjMyMEFJQzIzX0RJR1QsIDEsIDQsIGRlZW1waF90ZXh0KTsKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
c29jX2VudW0gdGx2MzIwYWljMjNfc2lkZXRvbmUgPQorCVNPQ19FTlVNX1NJTkdMRShUTFYzMjBB
SUMyM19BTkxHLCA2LCA1LCBzaWRldG9uZV90ZXh0KTsKKworc3RhdGljIGNvbnN0IERFQ0xBUkVf
VExWX0RCX1NDQUxFKG91dF9nYWluX3RsdiwgLTEyMTAwLCAxMDAsIDApOworc3RhdGljIGNvbnN0
IERFQ0xBUkVfVExWX0RCX1NDQUxFKGlucHV0X2dhaW5fdGx2LCAtMTcyNSwgNzUsIDApOworCitz
dGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcgdGx2MzIwYWljMjNfc25kX2NvbnRy
b2xzW10gPSB7CisJU09DX0RPVUJMRV9SX1RMVigiRGlnaXRhbCBQbGF5YmFjayBWb2x1bWUiLCBU
TFYzMjBBSUMyM19MQ0hOVk9MLAorCQkJIFRMVjMyMEFJQzIzX1JDSE5WT0wsIDAsIDEyNywgMCwg
b3V0X2dhaW5fdGx2KSwKKwlTT0NfU0lOR0xFKCJEaWdpdGFsIFBsYXliYWNrIFN3aXRjaCIsIFRM
VjMyMEFJQzIzX0RJR1QsIDMsIDEsIDEpLAorCVNPQ19ET1VCTEVfUigiTGluZSBJbnB1dCBTd2l0
Y2giLCBUTFYzMjBBSUMyM19MSU5WT0wsCisJCSAgICAgVExWMzIwQUlDMjNfUklOVk9MLCA3LCAx
LCAwKSwKKwlTT0NfRE9VQkxFX1JfVExWKCJMaW5lIElucHV0IFZvbHVtZSIsIFRMVjMyMEFJQzIz
X0xJTlZPTCwKKwkJCSBUTFYzMjBBSUMyM19SSU5WT0wsIDAsIDMxLCAwLCBpbnB1dF9nYWluX3Rs
diksCisJU09DX1NJTkdMRSgiTWljIElucHV0IFN3aXRjaCIsIFRMVjMyMEFJQzIzX0FOTEcsIDEs
IDEsIDEpLAorCVNPQ19TSU5HTEUoIk1pYyBCb29zdGVyIFN3aXRjaCIsIFRMVjMyMEFJQzIzX0FO
TEcsIDAsIDEsIDApLAorCVNPQ19FTlVNKCJTaWRldG9uZSBHYWluIiwgdGx2MzIwYWljMjNfc2lk
ZXRvbmUpLAorCVNPQ19FTlVNKCJQbGF5YmFjayBEZS1lbXBoYXNpcyIsIHRsdjMyMGFpYzIzX2Rl
ZW1waCksCit9OworCisvKiBhZGQgbm9uIGRhcG0gY29udHJvbHMgKi8KK3N0YXRpYyBpbnQgdGx2
MzIwYWljMjNfYWRkX2NvbnRyb2xzKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKK3sKKwor
CWludCBlcnIsIGk7CisKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0bHYzMjBhaWMyM19z
bmRfY29udHJvbHMpOyBpKyspIHsKKwkJZXJyID0gc25kX2N0bF9hZGQoY29kZWMtPmNhcmQsCisJ
CQkJICBzbmRfc29jX2NuZXcoJnRsdjMyMGFpYzIzX3NuZF9jb250cm9sc1tpXSwKKwkJCQkJICAg
ICAgIGNvZGVjLCBOVUxMKSk7CisJCWlmIChlcnIgPCAwKQorCQkJcmV0dXJuIGVycjsKKwl9CisK
KwlyZXR1cm4gMDsKKworfQorCisvKiBQR0EgTWl4ZXIgY29udHJvbHMgZm9yIExpbmUgYW5kIE1p
YyBzd2l0Y2ggKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyB0bHYzMjBh
aWMyM19vdXRwdXRfbWl4ZXJfY29udHJvbHNbXSA9IHsKKwlTT0NfREFQTV9TSU5HTEUoIkxpbmUg
QnlwYXNzIFN3aXRjaCIsIFRMVjMyMEFJQzIzX0FOTEcsIDMsIDEsIDApLAorCVNPQ19EQVBNX1NJ
TkdMRSgiTWljIFNpZGV0b25lIFN3aXRjaCIsIFRMVjMyMEFJQzIzX0FOTEcsIDUsIDEsIDApLAor
CVNPQ19EQVBNX1NJTkdMRSgiUGxheWJhY2sgU3dpdGNoIiwgVExWMzIwQUlDMjNfQU5MRywgNCwg
MSwgMCksCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgdGx2
MzIwYWljMjNfZGFwbV93aWRnZXRzW10gPSB7CisJU05EX1NPQ19EQVBNX0RBQygiREFDIiwgIlBs
YXliYWNrIiwgVExWMzIwQUlDMjNfUFdSLCAzLCAxKSwKKwlTTkRfU09DX0RBUE1fQURDKCJBREMi
LCAiQ2FwdHVyZSIsIFRMVjMyMEFJQzIzX1BXUiwgMiwgMSksCisJU05EX1NPQ19EQVBNX01VWCgi
Q2FwdHVyZSBTb3VyY2UiLCBTTkRfU09DX05PUE0sIDAsIDAsCisJCQkgJnRsdjMyMGFpYzIzX3Jl
Y19zcmNfbXV4X2NvbnRyb2xzKSwKKwlTTkRfU09DX0RBUE1fTUlYRVIoIk91dHB1dCBNaXhlciIs
IFRMVjMyMEFJQzIzX1BXUiwgNCwgMSwKKwkJCSAgICZ0bHYzMjBhaWMyM19vdXRwdXRfbWl4ZXJf
Y29udHJvbHNbMF0sCisJCQkgICBBUlJBWV9TSVpFKHRsdjMyMGFpYzIzX291dHB1dF9taXhlcl9j
b250cm9scykpLAorCVNORF9TT0NfREFQTV9QR0EoIkxpbmUgSW5wdXQiLCBUTFYzMjBBSUMyM19Q
V1IsIDAsIDEsIE5VTEwsIDApLAorCVNORF9TT0NfREFQTV9QR0EoIk1pYyBJbnB1dCIsIFRMVjMy
MEFJQzIzX1BXUiwgMSwgMSwgTlVMTCwgMCksCisKKwlTTkRfU09DX0RBUE1fT1VUUFVUKCJMSFBP
VVQiKSwKKwlTTkRfU09DX0RBUE1fT1VUUFVUKCJSSFBPVVQiKSwKKwlTTkRfU09DX0RBUE1fT1VU
UFVUKCJMT1VUIiksCisJU05EX1NPQ19EQVBNX09VVFBVVCgiUk9VVCIpLAorCisJU05EX1NPQ19E
QVBNX0lOUFVUKCJMTElORUlOIiksCisJU05EX1NPQ19EQVBNX0lOUFVUKCJSTElORUlOIiksCisK
KwlTTkRfU09DX0RBUE1fSU5QVVQoIk1JQ0lOIiksCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0
IHNuZF9zb2NfZGFwbV9yb3V0ZSBpbnRlcmNvbltdID0geworCS8qIE91dHB1dCBNaXhlciAqLwor
CXsiT3V0cHV0IE1peGVyIiwgIkxpbmUgQnlwYXNzIFN3aXRjaCIsICJMaW5lIElucHV0In0sCisJ
eyJPdXRwdXQgTWl4ZXIiLCAiUGxheWJhY2sgU3dpdGNoIiwgIkRBQyJ9LAorCXsiT3V0cHV0IE1p
eGVyIiwgIk1pYyBTaWRldG9uZSBTd2l0Y2giLCAiTWljIElucHV0In0sCisKKwkvKiBPdXRwdXRz
ICovCisJeyJSSFBPVVQiLCBOVUxMLCAiT3V0cHV0IE1peGVyIn0sCisJeyJMSFBPVVQiLCBOVUxM
LCAiT3V0cHV0IE1peGVyIn0sCisJeyJMT1VUIiwgTlVMTCwgIk91dHB1dCBNaXhlciJ9LAorCXsi
Uk9VVCIsIE5VTEwsICJPdXRwdXQgTWl4ZXIifSwKKworCS8qIElucHV0cyAqLworCXsiTGluZSBJ
bnB1dCIsICJOVUxMIiwgIkxMSU5FSU4ifSwKKwl7IkxpbmUgSW5wdXQiLCAiTlVMTCIsICJSTElO
RUlOIn0sCisKKwl7Ik1pYyBJbnB1dCIsICJOVUxMIiwgIk1JQ0lOIn0sCisKKwkvKiBpbnB1dCBt
dXggKi8KKwl7IkNhcHR1cmUgU291cmNlIiwgIkxpbmUiLCAiTGluZSBJbnB1dCJ9LAorCXsiQ2Fw
dHVyZSBTb3VyY2UiLCAiTWljIiwgIk1pYyBJbnB1dCJ9LAorCXsiQURDIiwgTlVMTCwgIkNhcHR1
cmUgU291cmNlIn0sCisKK307CisKKy8qIHRsdjMyMGFpYzIzIHJlbGF0ZWQgKi8KK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgdGx2MzIwYWljMjNfc3JhdGVfcmVnX2luZm8gc3JhdGVfcmVnX2luZm9bXSA9
IHsKKwl7NDAwMCwgMHgwNiwgMX0sCS8qICA0MDAwICovCisJezgwMDAsIDB4MDYsIDB9LAkvKiAg
ODAwMCAqLworCXsxNjAwMCwgMHgwQywgMX0sCS8qIDE2MDAwICovCisJezIyMDUwLCAweDExLCAx
fSwJLyogMjIwNTAgKi8KKwl7MjQwMDAsIDB4MDAsIDF9LAkvKiAyNDAwMCAqLworCXszMjAwMCwg
MHgwQywgMH0sCS8qIDMyMDAwICovCisJezQ0MTAwLCAweDExLCAwfSwJLyogNDQxMDAgKi8KKwl7
NDgwMDAsIDB4MDAsIDB9LAkvKiA0ODAwMCAqLworCXs4ODIwMCwgMHgxRiwgMH0sCS8qIDg4MjAw
ICovCisJezk2MDAwLCAweDBFLCAwfSwJLyogOTYwMDAgKi8KK307CisKK3N0YXRpYyBpbnQgdGx2
MzIwYWljMjNfYWRkX3dpZGdldHMoc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjKQoreworCXNu
ZF9zb2NfZGFwbV9uZXdfY29udHJvbHMoY29kZWMsIHRsdjMyMGFpYzIzX2RhcG1fd2lkZ2V0cywK
KwkJCQkgIEFSUkFZX1NJWkUodGx2MzIwYWljMjNfZGFwbV93aWRnZXRzKSk7CisKKwkvKiBzZXQg
dXAgYXVkaW8gcGF0aCBpbnRlcmNvbm5lY3RzICovCisJc25kX3NvY19kYXBtX2FkZF9yb3V0ZXMo
Y29kZWMsIGludGVyY29uLCBBUlJBWV9TSVpFKGludGVyY29uKSk7CisKKwlzbmRfc29jX2RhcG1f
bmV3X3dpZGdldHMoY29kZWMpOworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHRsdjMyMGFp
YzIzX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKKwkJCQkg
c3RydWN0IHNuZF9wY21faHdfcGFyYW1zICpwYXJhbXMpCit7CisJc3RydWN0IHNuZF9zb2NfcGNt
X3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+cHJpdmF0ZV9kYXRhOworCXN0cnVjdCBzbmRfc29j
X2RldmljZSAqc29jZGV2ID0gcnRkLT5zb2NkZXY7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNv
ZGVjID0gc29jZGV2LT5jb2RlYzsKKwl1MTYgaWZhY2VfcmVnLCBkYXRhOworCXU4IGNvdW50ID0g
MDsKKworCWlmYWNlX3JlZyA9CisJICAgIHRsdjMyMGFpYzIzX3JlYWRfcmVnX2NhY2hlKGNvZGVj
LAorCQkJCSAgICAgICBUTFYzMjBBSUMyM19ESUdUX0ZNVCkgJiB+KDB4MDMgPDwgMik7CisKKwkv
KiBTZWFyY2ggZm9yIHRoZSByaWdodCBzYW1wbGUgcmF0ZSAqLworCS8qIFZlcmlmeSB3aGF0IGhh
cHBlbnMgaWYgdGhlIHJhdGUgaXMgbm90IHN1cHBvcnRlZAorCSAqIG5vdyBpdCBnb2VzIHRvIDk2
S2h6ICovCisJd2hpbGUgKChzcmF0ZV9yZWdfaW5mb1tjb3VudF0uc2FtcGxlX3JhdGUgIT0gcGFy
YW1zX3JhdGUocGFyYW1zKSkgJiYKKwkgICAgICAgKGNvdW50IDwgQVJSQVlfU0laRShzcmF0ZV9y
ZWdfaW5mbykpKSB7CisJCWNvdW50Kys7CisJfQorCisJZGF0YSA9ICAoc3JhdGVfcmVnX2luZm9b
Y291bnRdLmRpdmlkZXIgPDwgVExWMzIwQUlDMjNfQ0xLSU5fU0hJRlQpIHwKKwkJKHNyYXRlX3Jl
Z19pbmZvW2NvdW50XS4gY29udHJvbCA8PCBUTFYzMjBBSUMyM19CT1NSX1NISUZUKSB8CisJCVRM
VjMyMEFJQzIzX1VTQl9DTEtfT047CisKKwl0bHYzMjBhaWMyM193cml0ZShjb2RlYywgVExWMzIw
QUlDMjNfU1JBVEUsIGRhdGEpOworCisJc3dpdGNoIChwYXJhbXNfZm9ybWF0KHBhcmFtcykpIHsK
KwljYXNlIFNORFJWX1BDTV9GT1JNQVRfUzE2X0xFOgorCQlicmVhazsKKwljYXNlIFNORFJWX1BD
TV9GT1JNQVRfUzIwXzNMRToKKwkJaWZhY2VfcmVnIHw9ICgweDAxIDw8IDIpOworCQlicmVhazsK
KwljYXNlIFNORFJWX1BDTV9GT1JNQVRfUzI0X0xFOgorCQlpZmFjZV9yZWcgfD0gKDB4MDIgPDwg
Mik7CisJCWJyZWFrOworCWNhc2UgU05EUlZfUENNX0ZPUk1BVF9TMzJfTEU6CisJCWlmYWNlX3Jl
ZyB8PSAoMHgwMyA8PCAyKTsKKwkJYnJlYWs7CisJfQorCXRsdjMyMGFpYzIzX3dyaXRlKGNvZGVj
LCBUTFYzMjBBSUMyM19ESUdUX0ZNVCwgaWZhY2VfcmVnKTsKKworCXJldHVybiAwOworfQorCitz
dGF0aWMgaW50IHRsdjMyMGFpYzIzX3BjbV9wcmVwYXJlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVh
bSAqc3Vic3RyZWFtKQoreworCXN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQgPSBzdWJz
dHJlYW0tPnByaXZhdGVfZGF0YTsKKwlzdHJ1Y3Qgc25kX3NvY19kZXZpY2UgKnNvY2RldiA9IHJ0
ZC0+c29jZGV2OworCXN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IHNvY2Rldi0+Y29kZWM7
CisKKwkvKiBzZXQgYWN0aXZlICovCisJdGx2MzIwYWljMjNfd3JpdGUoY29kZWMsIFRMVjMyMEFJ
QzIzX0FDVElWRSwgMHgwMDAxKTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCB0bHYz
MjBhaWMyM19zaHV0ZG93bihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKK3sK
KwlzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkID0gc3Vic3RyZWFtLT5wcml2YXRlX2Rh
dGE7CisJc3RydWN0IHNuZF9zb2NfZGV2aWNlICpzb2NkZXYgPSBydGQtPnNvY2RldjsKKwlzdHJ1
Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBzb2NkZXYtPmNvZGVjOworCisJLyogZGVhY3RpdmF0
ZSAqLworCWlmICghY29kZWMtPmFjdGl2ZSkgeworCQl1ZGVsYXkoNTApOworCQl0bHYzMjBhaWMy
M193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfQUNUSVZFLCAweDApOworCX0KK30KKworc3RhdGlj
IGludCB0bHYzMjBhaWMyM19tdXRlKHN0cnVjdCBzbmRfc29jX2RhaSAqZGFpLCBpbnQgbXV0ZSkK
K3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBkYWktPmNvZGVjOworCXUxNiByZWc7
CisKKwlyZWcgPSB0bHYzMjBhaWMyM19yZWFkX3JlZ19jYWNoZShjb2RlYywgVExWMzIwQUlDMjNf
RElHVCk7CisJaWYgKG11dGUpCisJCXJlZyB8PSBUTFYzMjBBSUMyM19EQUNNX01VVEU7CisKKwll
bHNlCisJCXJlZyAmPSB+VExWMzIwQUlDMjNfREFDTV9NVVRFOworCisJdGx2MzIwYWljMjNfd3Jp
dGUoY29kZWMsIFRMVjMyMEFJQzIzX0RJR1QsIHJlZyk7CisKKwlyZXR1cm4gMDsKK30KKworc3Rh
dGljIGludCB0bHYzMjBhaWMyM19zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNvZGVj
X2RhaSwKKwkJCQkgICB1bnNpZ25lZCBpbnQgZm10KQoreworCXN0cnVjdCBzbmRfc29jX2NvZGVj
ICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7CisJdTE2IGlmYWNlX3JlZzsKKworCWlmYWNlX3Jl
ZyA9CisJICAgIHRsdjMyMGFpYzIzX3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBUTFYzMjBBSUMyM19E
SUdUX0ZNVCkgJiAofjB4MDMpOworCisJLyogc2V0IG1hc3Rlci9zbGF2ZSBhdWRpbyBpbnRlcmZh
Y2UgKi8KKwlzd2l0Y2ggKGZtdCAmIFNORF9TT0NfREFJRk1UX01BU1RFUl9NQVNLKSB7CisJY2Fz
ZSBTTkRfU09DX0RBSUZNVF9DQk1fQ0ZNOgorCQlpZmFjZV9yZWcgfD0gVExWMzIwQUlDMjNfTVNf
TUFTVEVSOworCQlicmVhazsKKwljYXNlIFNORF9TT0NfREFJRk1UX0NCU19DRlM6CisJCWJyZWFr
OworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOworCisJfQorCisJLyogaW50ZXJmYWNlIGZv
cm1hdCAqLworCXN3aXRjaCAoZm10ICYgU05EX1NPQ19EQUlGTVRfRk9STUFUX01BU0spIHsKKwlj
YXNlIFNORF9TT0NfREFJRk1UX0kyUzoKKwkJaWZhY2VfcmVnIHw9IFRMVjMyMEFJQzIzX0ZPUl9J
MlM7CisJCWJyZWFrOworCWNhc2UgU05EX1NPQ19EQUlGTVRfRFNQX0E6CisJCWlmYWNlX3JlZyB8
PSBUTFYzMjBBSUMyM19GT1JfRFNQOworCQlicmVhazsKKwljYXNlIFNORF9TT0NfREFJRk1UX1JJ
R0hUX0o6CisJCWJyZWFrOworCWNhc2UgU05EX1NPQ19EQUlGTVRfTEVGVF9KOgorCQlpZmFjZV9y
ZWcgfD0gVExWMzIwQUlDMjNfRk9SX0xKVVNUOworCQlicmVhazsKKwlkZWZhdWx0OgorCQlyZXR1
cm4gLUVJTlZBTDsKKworCX0KKworCXRsdjMyMGFpYzIzX3dyaXRlKGNvZGVjLCBUTFYzMjBBSUMy
M19ESUdUX0ZNVCwgaWZhY2VfcmVnKTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHRs
djMyMGFpYzIzX3NldF9kYWlfc3lzY2xrKHN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpLAor
CQkJCSAgICAgIGludCBjbGtfaWQsIHVuc2lnbmVkIGludCBmcmVxLCBpbnQgZGlyKQoreworCXN0
cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYyA9IGNvZGVjX2RhaS0+Y29kZWM7CisKKwlzd2l0Y2gg
KGZyZXEpIHsKKwljYXNlIDEyMDAwMDAwOgorCQlyZXR1cm4gMDsKKwl9CisJcmV0dXJuIC1FSU5W
QUw7Cit9CisKK3N0YXRpYyBpbnQgdGx2MzIwYWljMjNfc2V0X2JpYXNfbGV2ZWwoc3RydWN0IHNu
ZF9zb2NfY29kZWMgKmNvZGVjLAorCQkJCSAgICAgIGVudW0gc25kX3NvY19iaWFzX2xldmVsIGxl
dmVsKQoreworCXUxNiByZWcgPSB0bHYzMjBhaWMyM19yZWFkX3JlZ19jYWNoZShjb2RlYywgVExW
MzIwQUlDMjNfUFdSKSAmIDB4ZmY3ZjsKKworCXN3aXRjaCAobGV2ZWwpIHsKKwljYXNlIFNORF9T
T0NfQklBU19PTjoKKwkJLyogdnJlZi9taWQsIG9zYyBvbiwgZGFjIHVubXV0ZSAqLworCQl0bHYz
MjBhaWMyM193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfUFdSLCByZWcpOworCQlicmVhazsKKwlj
YXNlIFNORF9TT0NfQklBU19QUkVQQVJFOgorCQlicmVhazsKKwljYXNlIFNORF9TT0NfQklBU19T
VEFOREJZOgorCQkvKiBldmVyeXRoaW5nIG9mZiBleGNlcHQgdnJlZi92bWlkLCAqLworCQl0bHYz
MjBhaWMyM193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfUFdSLCByZWcgfCAweDAwNDApOworCQli
cmVhazsKKwljYXNlIFNORF9TT0NfQklBU19PRkY6CisJCS8qIGV2ZXJ5dGhpbmcgb2ZmLCBkYWMg
bXV0ZSwgaW5hY3RpdmUgKi8KKwkJdGx2MzIwYWljMjNfd3JpdGUoY29kZWMsIFRMVjMyMEFJQzIz
X0FDVElWRSwgMHgwKTsKKwkJdGx2MzIwYWljMjNfd3JpdGUoY29kZWMsIFRMVjMyMEFJQzIzX1BX
UiwgMHhmZmZmKTsKKwkJYnJlYWs7CisJfQorCWNvZGVjLT5iaWFzX2xldmVsID0gbGV2ZWw7CisJ
cmV0dXJuIDA7Cit9CisKKyNkZWZpbmUgQUlDMjNfUkFURVMJU05EUlZfUENNX1JBVEVfODAwMF85
NjAwMAorI2RlZmluZSBBSUMyM19GT1JNQVRTCShTTkRSVl9QQ01fRk1UQklUX1MxNl9MRSB8IFNO
RFJWX1BDTV9GTVRCSVRfUzIwXzNMRSB8IFwKKwkJCSBTTkRSVl9QQ01fRk1UQklUX1MyNF8zTEUg
fCBTTkRSVl9QQ01fRk1UQklUX1MzMl9MRSkKKworc3RydWN0IHNuZF9zb2NfZGFpIHRsdjMyMGFp
YzIzX2RhaSA9IHsKKwkubmFtZSA9ICJ0bHYzMjBhaWMyMyIsCisJLnBsYXliYWNrID0geworCQkg
ICAgIC5zdHJlYW1fbmFtZSA9ICJQbGF5YmFjayIsCisJCSAgICAgLmNoYW5uZWxzX21pbiA9IDIs
CisJCSAgICAgLmNoYW5uZWxzX21heCA9IDIsCisJCSAgICAgLnJhdGVzID0gQUlDMjNfUkFURVMs
CisJCSAgICAgLmZvcm1hdHMgPSBBSUMyM19GT1JNQVRTLH0sCisJLmNhcHR1cmUgPSB7CisJCSAg
ICAuc3RyZWFtX25hbWUgPSAiQ2FwdHVyZSIsCisJCSAgICAuY2hhbm5lbHNfbWluID0gMiwKKwkJ
ICAgIC5jaGFubmVsc19tYXggPSAyLAorCQkgICAgLnJhdGVzID0gQUlDMjNfUkFURVMsCisJCSAg
ICAuZm9ybWF0cyA9IEFJQzIzX0ZPUk1BVFMsfSwKKwkub3BzID0geworCQkucHJlcGFyZSA9IHRs
djMyMGFpYzIzX3BjbV9wcmVwYXJlLAorCQkuaHdfcGFyYW1zID0gdGx2MzIwYWljMjNfaHdfcGFy
YW1zLAorCQkuc2h1dGRvd24gPSB0bHYzMjBhaWMyM19zaHV0ZG93biwKKwkJfSwKKwkuZGFpX29w
cyA9IHsKKwkJICAgIC5kaWdpdGFsX211dGUgPSB0bHYzMjBhaWMyM19tdXRlLAorCQkgICAgLnNl
dF9mbXQgPSB0bHYzMjBhaWMyM19zZXRfZGFpX2ZtdCwKKwkJICAgIC5zZXRfc3lzY2xrID0gdGx2
MzIwYWljMjNfc2V0X2RhaV9zeXNjbGssCisJCSAgICB9Cit9OworRVhQT1JUX1NZTUJPTF9HUEwo
dGx2MzIwYWljMjNfZGFpKTsKKworc3RhdGljIGludCB0bHYzMjBhaWMyM19zdXNwZW5kKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCisJCQkgICAgICAgcG1fbWVzc2FnZV90IHN0YXRlKQor
eworCXN0cnVjdCBzbmRfc29jX2RldmljZSAqc29jZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cGRldik7CisJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gc29jZGV2LT5jb2RlYzsKKwor
CXRsdjMyMGFpYzIzX3dyaXRlKGNvZGVjLCBUTFYzMjBBSUMyM19BQ1RJVkUsIDB4MCk7CisJdGx2
MzIwYWljMjNfc2V0X2JpYXNfbGV2ZWwoY29kZWMsIFNORF9TT0NfQklBU19PRkYpOworCisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgdGx2MzIwYWljMjNfcmVzdW1lKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCit7CisJc3RydWN0IHNuZF9zb2NfZGV2aWNlICpzb2NkZXYgPSBwbGF0
Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBz
b2NkZXYtPmNvZGVjOworCWludCBpOworCXUxNiByZWc7CisKKwkvKiBTeW5jIHJlZ19jYWNoZSB3
aXRoIHRoZSBoYXJkd2FyZSAqLworCWZvciAocmVnID0gMDsgcmVnIDwgQVJSQVlfU0laRSh0bHYz
MjBhaWMyM19yZWcpOyBpKyspIHsKKwkJdTE2IHZhbCA9IHRsdjMyMGFpYzIzX3JlYWRfcmVnX2Nh
Y2hlKGNvZGVjLCByZWcpOworCQl0bHYzMjBhaWMyM193cml0ZShjb2RlYywgcmVnLCB2YWwpOwor
CX0KKworCXRsdjMyMGFpYzIzX3NldF9iaWFzX2xldmVsKGNvZGVjLCBTTkRfU09DX0JJQVNfU1RB
TkRCWSk7CisJdGx2MzIwYWljMjNfc2V0X2JpYXNfbGV2ZWwoY29kZWMsIGNvZGVjLT5zdXNwZW5k
X2JpYXNfbGV2ZWwpOworCisJcmV0dXJuIDA7Cit9CisKKy8qCisgKiBpbml0aWFsaXNlIHRoZSBB
SUMyMyBkcml2ZXIKKyAqIHJlZ2lzdGVyIHRoZSBtaXhlciBhbmQgZHNwIGludGVyZmFjZXMgd2l0
aCB0aGUga2VybmVsCisgKi8KK3N0YXRpYyBpbnQgdGx2MzIwYWljMjNfaW5pdChzdHJ1Y3Qgc25k
X3NvY19kZXZpY2UgKnNvY2RldikKK3sKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBz
b2NkZXYtPmNvZGVjOworCWludCByZXQgPSAwOworCXUxNiByZWc7CisKKwljb2RlYy0+bmFtZSA9
ICJ0bHYzMjBhaWMyMyI7CisJY29kZWMtPm93bmVyID0gVEhJU19NT0RVTEU7CisJY29kZWMtPnJl
YWQgPSB0bHYzMjBhaWMyM19yZWFkX3JlZ19jYWNoZTsKKwljb2RlYy0+d3JpdGUgPSB0bHYzMjBh
aWMyM193cml0ZTsKKwljb2RlYy0+c2V0X2JpYXNfbGV2ZWwgPSB0bHYzMjBhaWMyM19zZXRfYmlh
c19sZXZlbDsKKwljb2RlYy0+ZGFpID0gJnRsdjMyMGFpYzIzX2RhaTsKKwljb2RlYy0+bnVtX2Rh
aSA9IDE7CisJY29kZWMtPnJlZ19jYWNoZV9zaXplID0gQVJSQVlfU0laRSh0bHYzMjBhaWMyM19y
ZWcpOworCWNvZGVjLT5yZWdfY2FjaGUgPQorCSAgICBrbWVtZHVwKHRsdjMyMGFpYzIzX3JlZywg
c2l6ZW9mKHRsdjMyMGFpYzIzX3JlZyksIEdGUF9LRVJORUwpOworCWlmIChjb2RlYy0+cmVnX2Nh
Y2hlID09IE5VTEwpCisJCXJldHVybiAtRU5PTUVNOworCisJLyogUmVzZXQgY29kZWMgKi8KKwl0
bHYzMjBhaWMyM193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfUkVTRVQsIDApOworCisJLyogcmVn
aXN0ZXIgcGNtcyAqLworCXJldCA9IHNuZF9zb2NfbmV3X3BjbXMoc29jZGV2LCBTTkRSVl9ERUZB
VUxUX0lEWDEsIFNORFJWX0RFRkFVTFRfU1RSMSk7CisJaWYgKHJldCA8IDApIHsKKwkJcHJpbnRr
KEtFUk5fRVJSICJ0bHYzMjBhaWMyMzogZmFpbGVkIHRvIGNyZWF0ZSBwY21zXG4iKTsKKwkJZ290
byBwY21fZXJyOworCX0KKworCS8qIHBvd2VyIG9uIGRldmljZSAqLworCXRsdjMyMGFpYzIzX3Nl
dF9iaWFzX2xldmVsKGNvZGVjLCBTTkRfU09DX0JJQVNfU1RBTkRCWSk7CisKKwl0bHYzMjBhaWMy
M193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfRElHVCwgVExWMzIwQUlDMjNfREVFTVBfNDRLKTsK
KworCS8qIFVubXV0ZSBpbnB1dCAqLworCXJlZyA9IHRsdjMyMGFpYzIzX3JlYWRfcmVnX2NhY2hl
KGNvZGVjLCBUTFYzMjBBSUMyM19MSU5WT0wpOworCXRsdjMyMGFpYzIzX3dyaXRlKGNvZGVjLCBU
TFYzMjBBSUMyM19MSU5WT0wsCisJCQkgIChyZWcgJiAoflRMVjMyMEFJQzIzX0xJTV9NVVRFRCkp
IHwKKwkJCSAgKFRMVjMyMEFJQzIzX0xSU19FTkFCTEVEKSk7CisKKwlyZWcgPSB0bHYzMjBhaWMy
M19yZWFkX3JlZ19jYWNoZShjb2RlYywgVExWMzIwQUlDMjNfUklOVk9MKTsKKwl0bHYzMjBhaWMy
M193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfUklOVk9MLAorCQkJICAocmVnICYgKH5UTFYzMjBB
SUMyM19MSU1fTVVURUQpKSB8CisJCQkgIFRMVjMyMEFJQzIzX0xSU19FTkFCTEVEKTsKKworCXJl
ZyA9IHRsdjMyMGFpYzIzX3JlYWRfcmVnX2NhY2hlKGNvZGVjLCBUTFYzMjBBSUMyM19BTkxHKTsK
Kwl0bHYzMjBhaWMyM193cml0ZShjb2RlYywgVExWMzIwQUlDMjNfQU5MRywKKwkJCSAocmVnKSAm
ICh+VExWMzIwQUlDMjNfQllQQVNTX09OKSAmCisJCQkgKH5UTFYzMjBBSUMyM19NSUNNX01VVEVE
KSk7CisKKwkvKiBEZWZhdWx0IG91dHB1dCB2b2x1bWUgKi8KKwl0bHYzMjBhaWMyM193cml0ZShj
b2RlYywgVExWMzIwQUlDMjNfTENITlZPTCwKKwkJCSAgVExWMzIwQUlDMjNfREVGQVVMVF9PVVRf
Vk9MICYKKwkJCSAgVExWMzIwQUlDMjNfT1VUX1ZPTF9NQVNLKTsKKwl0bHYzMjBhaWMyM193cml0
ZShjb2RlYywgVExWMzIwQUlDMjNfUkNITlZPTCwKKwkJCSAgVExWMzIwQUlDMjNfREVGQVVMVF9P
VVRfVk9MICYKKwkJCSAgVExWMzIwQUlDMjNfT1VUX1ZPTF9NQVNLKTsKKworCXRsdjMyMGFpYzIz
X3dyaXRlKGNvZGVjLCBUTFYzMjBBSUMyM19BQ1RJVkUsIDB4MSk7CisKKwl0bHYzMjBhaWMyM19h
ZGRfY29udHJvbHMoY29kZWMpOworCXRsdjMyMGFpYzIzX2FkZF93aWRnZXRzKGNvZGVjKTsKKwly
ZXQgPSBzbmRfc29jX3JlZ2lzdGVyX2NhcmQoc29jZGV2KTsKKwlpZiAocmV0IDwgMCkgeworCQlw
cmludGsoS0VSTl9FUlIgInRsdjMyMGFpYzIzOiBmYWlsZWQgdG8gcmVnaXN0ZXIgY2FyZFxuIik7
CisJCWdvdG8gY2FyZF9lcnI7CisJfQorCisJcmV0dXJuIHJldDsKKworY2FyZF9lcnI6CisJc25k
X3NvY19mcmVlX3BjbXMoc29jZGV2KTsKKwlzbmRfc29jX2RhcG1fZnJlZShzb2NkZXYpOworcGNt
X2VycjoKKwlrZnJlZShjb2RlYy0+cmVnX2NhY2hlKTsKKwlyZXR1cm4gcmV0OworfQorc3RhdGlj
IHN0cnVjdCBzbmRfc29jX2RldmljZSAqdGx2MzIwYWljMjNfc29jZGV2OworCisjaWYgZGVmaW5l
ZChDT05GSUdfSTJDKSB8fCBkZWZpbmVkKENPTkZJR19JMkNfTU9EVUxFKQorLyoKKyAqIElmIHRo
ZSBpMmMgbGF5ZXIgd2VyZW4ndCBzbyBicm9rZW4sIHdlIGNvdWxkIHBhc3MgdGhpcyBraW5kIG9m
IGRhdGEKKyAqIGFyb3VuZAorICovCitzdGF0aWMgaW50IHRsdjMyMGFpYzIzX2NvZGVjX3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50ICppMmMsCisJCQkJICAgY29uc3Qgc3RydWN0IGkyY19kZXZpY2Vf
aWQgKmkyY19pZCkKK3sKKwlzdHJ1Y3Qgc25kX3NvY19kZXZpY2UgKnNvY2RldiA9IHRsdjMyMGFp
YzIzX3NvY2RldjsKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBzb2NkZXYtPmNvZGVj
OworCWludCByZXQ7CisKKwlpZiAoIWkyY19jaGVja19mdW5jdGlvbmFsaXR5KGkyYy0+YWRhcHRl
ciwgSTJDX0ZVTkNfU01CVVNfQllURV9EQVRBKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlpMmNf
c2V0X2NsaWVudGRhdGEoaTJjLCBjb2RlYyk7CisJY29kZWMtPmNvbnRyb2xfZGF0YSA9IGkyYzsK
KworCXJldCA9IHRsdjMyMGFpYzIzX2luaXQoc29jZGV2KTsKKwlpZiAocmV0IDwgMCkgeworCQlw
cmludGsoS0VSTl9FUlIgInRsdjMyMGFpYzIzOiBmYWlsZWQgdG8gaW5pdGlhbGlzZSBBSUMyM1xu
Iik7CisJCWdvdG8gZXJyOworCX0KKwlyZXR1cm4gcmV0OworCitlcnI6CisJa2ZyZWUoY29kZWMp
OworCWtmcmVlKGkyYyk7CisJcmV0dXJuIHJldDsKK30KK3N0YXRpYyBpbnQgX19leGl0IHRsdjMy
MGFpYzIzX2kyY19yZW1vdmUoc3RydWN0IGkyY19jbGllbnQgKmkyYykKK3sKKwlwdXRfZGV2aWNl
KCZpMmMtPmRldik7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2Rl
dmljZV9pZCB0bHYzMjBhaWMyM19pZFtdID0geworCXsidGx2MzIwYWljMjMiLCAwfSwKKwl7fQor
fTsKKworTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIHRsdjMyMGFpYzIzX2lkKTsKKworc3RhdGlj
IHN0cnVjdCBpMmNfZHJpdmVyIHRsdjMyMGFpYzIzX2kyY19kcml2ZXIgPSB7CisJLmRyaXZlciA9
IHsKKwkJICAgLm5hbWUgPSAidGx2MzIwYWljMjMiLAorCQkgICB9LAorCS5wcm9iZSA9IHRsdjMy
MGFpYzIzX2NvZGVjX3Byb2JlLAorCS5yZW1vdmUgPSBfX2V4aXRfcCh0bHYzMjBhaWMyM19pMmNf
cmVtb3ZlKSwKKwkuaWRfdGFibGUgPSB0bHYzMjBhaWMyM19pZCwKK307CisKKyNlbmRpZgorCitz
dGF0aWMgaW50IHRsdjMyMGFpYzIzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cit7CisJc3RydWN0IHNuZF9zb2NfZGV2aWNlICpzb2NkZXYgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShwZGV2KTsKKwlzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWM7CisJaW50IHJldCA9IDA7CisK
KwlwcmludGsoS0VSTl9JTkZPICJBSUMyMyBBdWRpbyBDb2RlYyAlc1xuIiwgQUlDMjNfVkVSU0lP
Tik7CisKKwljb2RlYyA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBzbmRfc29jX2NvZGVjKSwgR0ZQ
X0tFUk5FTCk7CisJaWYgKGNvZGVjID09IE5VTEwpCisJCXJldHVybiAtRU5PTUVNOworCisJc29j
ZGV2LT5jb2RlYyA9IGNvZGVjOworCW11dGV4X2luaXQoJmNvZGVjLT5tdXRleCk7CisJSU5JVF9M
SVNUX0hFQUQoJmNvZGVjLT5kYXBtX3dpZGdldHMpOworCUlOSVRfTElTVF9IRUFEKCZjb2RlYy0+
ZGFwbV9wYXRocyk7CisKKwl0bHYzMjBhaWMyM19zb2NkZXYgPSBzb2NkZXY7CisjaWYgZGVmaW5l
ZChDT05GSUdfSTJDKSB8fCBkZWZpbmVkKENPTkZJR19JMkNfTU9EVUxFKQorCWNvZGVjLT5od193
cml0ZSA9IChod193cml0ZV90KSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhOworCWNvZGVjLT5o
d19yZWFkID0gTlVMTDsKKwlyZXQgPSBpMmNfYWRkX2RyaXZlcigmdGx2MzIwYWljMjNfaTJjX2Ry
aXZlcik7CisJaWYgKHJldCAhPSAwKQorCQlwcmludGsoS0VSTl9FUlIgImNhbid0IGFkZCBpMmMg
ZHJpdmVyIik7CisjZW5kaWYKKwlyZXR1cm4gcmV0OworfQorCitzdGF0aWMgaW50IHRsdjMyMGFp
YzIzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQoreworCXN0cnVjdCBzbmRf
c29jX2RldmljZSAqc29jZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CisJc3RydWN0
IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gc29jZGV2LT5jb2RlYzsKKworCWlmIChjb2RlYy0+Y29u
dHJvbF9kYXRhKQorCQl0bHYzMjBhaWMyM19zZXRfYmlhc19sZXZlbChjb2RlYywgU05EX1NPQ19C
SUFTX09GRik7CisKKwlzbmRfc29jX2ZyZWVfcGNtcyhzb2NkZXYpOworCXNuZF9zb2NfZGFwbV9m
cmVlKHNvY2Rldik7CisjaWYgZGVmaW5lZChDT05GSUdfSTJDKSB8fCBkZWZpbmVkKENPTkZJR19J
MkNfTU9EVUxFKQorCWkyY19kZWxfZHJpdmVyKCZ0bHYzMjBhaWMyM19pMmNfZHJpdmVyKTsKKyNl
bmRpZgorCWtmcmVlKGNvZGVjLT5yZWdfY2FjaGUpOworCWtmcmVlKGNvZGVjKTsKKworCXJldHVy
biAwOworfQorc3RydWN0IHNuZF9zb2NfY29kZWNfZGV2aWNlIHNvY19jb2RlY19kZXZfdGx2MzIw
YWljMjMgPSB7CisJLnByb2JlID0gdGx2MzIwYWljMjNfcHJvYmUsCisJLnJlbW92ZSA9IHRsdjMy
MGFpYzIzX3JlbW92ZSwKKwkuc3VzcGVuZCA9IHRsdjMyMGFpYzIzX3N1c3BlbmQsCisJLnJlc3Vt
ZSA9IHRsdjMyMGFpYzIzX3Jlc3VtZSwKK307CitFWFBPUlRfU1lNQk9MX0dQTChzb2NfY29kZWNf
ZGV2X3RsdjMyMGFpYzIzKTsKKworTU9EVUxFX0RFU0NSSVBUSU9OKCJBU29DIFRMVjMyMEFJQzIz
IGNvZGVjIGRyaXZlciIpOworTU9EVUxFX0FVVEhPUigiQXJ1biBLUyA8YXJ1bmtzQG1pc3RyYWxz
b2x1dGlvbnMuY29tPiIpOworTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwpkaWZmIC0tZ2l0IGEvc291
bmQvc29jL2NvZGVjcy90bHYzMjBhaWMyMy5oIGIvc291bmQvc29jL2NvZGVjcy90bHYzMjBhaWMy
My5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjc5ZDFmYWYKLS0tIC9kZXYv
bnVsbAorKysgYi9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzIzLmgKQEAgLTAsMCArMSwxMjIg
QEAKKy8qCisgKiBBTFNBIFNvQyBUTFYzMjBBSUMyMyBjb2RlYyBkcml2ZXIKKyAqCisgKiBBdXRo
b3I6ICAgICAgQXJ1biBLUywgPGFydW5rc0BtaXN0cmFsc29sdXRpb25zLmNvbT4KKyAqIENvcHly
aWdodDogICAoQykgMjAwOCBNaXN0cmFsIFNvbHV0aW9ucyBQdnQgTHRkCisgKgorICogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyIGFzCisgKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyAqLworCisjaWZuZGVmIF9UTFYzMjBBSUMyM19ICisjZGVmaW5lIF9UTFYzMjBB
SUMyM19ICisKKy8qIENvZGVjIFRMVjMyMEFJQzIzICovCisjZGVmaW5lIFRMVjMyMEFJQzIzX0xJ
TlZPTAkJMHgwMAorI2RlZmluZSBUTFYzMjBBSUMyM19SSU5WT0wJCTB4MDEKKyNkZWZpbmUgVExW
MzIwQUlDMjNfTENITlZPTAkJMHgwMgorI2RlZmluZSBUTFYzMjBBSUMyM19SQ0hOVk9MCQkweDAz
CisjZGVmaW5lIFRMVjMyMEFJQzIzX0FOTEcJCTB4MDQKKyNkZWZpbmUgVExWMzIwQUlDMjNfRElH
VAkJMHgwNQorI2RlZmluZSBUTFYzMjBBSUMyM19QV1IJCQkweDA2CisjZGVmaW5lIFRMVjMyMEFJ
QzIzX0RJR1RfRk1UCQkweDA3CisjZGVmaW5lIFRMVjMyMEFJQzIzX1NSQVRFCQkweDA4CisjZGVm
aW5lIFRMVjMyMEFJQzIzX0FDVElWRQkJMHgwOQorI2RlZmluZSBUTFYzMjBBSUMyM19SRVNFVAkJ
MHgwRgorCisvKiBMZWZ0IChyaWdodCkgbGluZSBpbnB1dCB2b2x1bWUgY29udHJvbCByZWdpc3Rl
ciAqLworI2RlZmluZSBUTFYzMjBBSUMyM19MUlNfRU5BQkxFRAkJMHgwMTAwCisjZGVmaW5lIFRM
VjMyMEFJQzIzX0xJTV9NVVRFRAkJMHgwMDgwCisjZGVmaW5lIFRMVjMyMEFJQzIzX0xJVl9ERUZB
VUxUCQkweDAwMTcKKyNkZWZpbmUgVExWMzIwQUlDMjNfTElWX01BWAkJMHgwMDFmCisjZGVmaW5l
IFRMVjMyMEFJQzIzX0xJVl9NSU4JCTB4MDAwMAorCisvKiBMZWZ0IChyaWdodCkgY2hhbm5lbCBo
ZWFkcGhvbmUgdm9sdW1lIGNvbnRyb2wgcmVnaXN0ZXIgKi8KKyNkZWZpbmUgVExWMzIwQUlDMjNf
TFpDX09OCQkweDAwODAKKyNkZWZpbmUgVExWMzIwQUlDMjNfTEhWX0RFRkFVTFQJCTB4MDA3OQor
I2RlZmluZSBUTFYzMjBBSUMyM19MSFZfTUFYCQkweDAwN2YKKyNkZWZpbmUgVExWMzIwQUlDMjNf
TEhWX01JTgkJMHgwMDAwCisKKy8qIEFuYWxvZyBhdWRpbyBwYXRoIGNvbnRyb2wgcmVnaXN0ZXIg
Ki8KKyNkZWZpbmUgVExWMzIwQUlDMjNfU1RBX1JFRyh4KQkJKCh4KTw8NikKKyNkZWZpbmUgVExW
MzIwQUlDMjNfU1RFX0VOQUJMRUQJCTB4MDAyMAorI2RlZmluZSBUTFYzMjBBSUMyM19EQUNfU0VM
RUNURUQJMHgwMDEwCisjZGVmaW5lIFRMVjMyMEFJQzIzX0JZUEFTU19PTgkJMHgwMDA4CisjZGVm
aW5lIFRMVjMyMEFJQzIzX0lOU0VMX01JQwkJMHgwMDA0CisjZGVmaW5lIFRMVjMyMEFJQzIzX01J
Q01fTVVURUQJCTB4MDAwMgorI2RlZmluZSBUTFYzMjBBSUMyM19NSUNCXzIwREIJCTB4MDAwMQor
CisvKiBEaWdpdGFsIGF1ZGlvIHBhdGggY29udHJvbCByZWdpc3RlciAqLworI2RlZmluZSBUTFYz
MjBBSUMyM19EQUNNX01VVEUJCTB4MDAwOAorI2RlZmluZSBUTFYzMjBBSUMyM19ERUVNUF8zMksJ
CTB4MDAwMgorI2RlZmluZSBUTFYzMjBBSUMyM19ERUVNUF80NEsJCTB4MDAwNAorI2RlZmluZSBU
TFYzMjBBSUMyM19ERUVNUF80OEsJCTB4MDAwNgorI2RlZmluZSBUTFYzMjBBSUMyM19BRENIUF9P
TgkJMHgwMDAxCisKKy8qIFBvd2VyIGNvbnRyb2wgZG93biByZWdpc3RlciAqLworI2RlZmluZSBU
TFYzMjBBSUMyM19ERVZJQ0VfUFdSX09GRiAgCTB4MDA4MAorI2RlZmluZSBUTFYzMjBBSUMyM19D
TEtfT0ZGCQkweDAwNDAKKyNkZWZpbmUgVExWMzIwQUlDMjNfT1NDX09GRgkJMHgwMDIwCisjZGVm
aW5lIFRMVjMyMEFJQzIzX09VVF9PRkYJCTB4MDAxMAorI2RlZmluZSBUTFYzMjBBSUMyM19EQUNf
T0ZGCQkweDAwMDgKKyNkZWZpbmUgVExWMzIwQUlDMjNfQURDX09GRgkJMHgwMDA0CisjZGVmaW5l
IFRMVjMyMEFJQzIzX01JQ19PRkYJCTB4MDAwMgorI2RlZmluZSBUTFYzMjBBSUMyM19MSU5FX09G
RgkJMHgwMDAxCisKKy8qIERpZ2l0YWwgYXVkaW8gaW50ZXJmYWNlIHJlZ2lzdGVyICovCisjZGVm
aW5lIFRMVjMyMEFJQzIzX01TX01BU1RFUgkJMHgwMDQwCisjZGVmaW5lIFRMVjMyMEFJQzIzX0xS
U1dBUF9PTgkJMHgwMDIwCisjZGVmaW5lIFRMVjMyMEFJQzIzX0xSUF9PTgkJMHgwMDEwCisjZGVm
aW5lIFRMVjMyMEFJQzIzX0lXTF8xNgkJMHgwMDAwCisjZGVmaW5lIFRMVjMyMEFJQzIzX0lXTF8y
MAkJMHgwMDA0CisjZGVmaW5lIFRMVjMyMEFJQzIzX0lXTF8yNAkJMHgwMDA4CisjZGVmaW5lIFRM
VjMyMEFJQzIzX0lXTF8zMgkJMHgwMDBDCisjZGVmaW5lIFRMVjMyMEFJQzIzX0ZPUl9JMlMJCTB4
MDAwMgorI2RlZmluZSBUTFYzMjBBSUMyM19GT1JfRFNQCQkweDAwMDMKKyNkZWZpbmUgVExWMzIw
QUlDMjNfRk9SX0xKVVNUCQkweDAwMDEKKworLyogU2FtcGxlIHJhdGUgY29udHJvbCByZWdpc3Rl
ciAqLworI2RlZmluZSBUTFYzMjBBSUMyM19DTEtPVVRfSEFMRgkJMHgwMDgwCisjZGVmaW5lIFRM
VjMyMEFJQzIzX0NMS0lOX0hBTEYJCTB4MDA0MAorI2RlZmluZSBUTFYzMjBBSUMyM19CT1NSXzM4
NGZzCQkweDAwMDIJLyogQk9TUl8yNzJmcyBpbiBVU0IgbW9kZSAqLworI2RlZmluZSBUTFYzMjBB
SUMyM19VU0JfQ0xLX09OCQkweDAwMDEKKyNkZWZpbmUgVExWMzIwQUlDMjNfU1JfTUFTSyAgICAg
ICAgICAgICAweGYKKyNkZWZpbmUgVExWMzIwQUlDMjNfQ0xLT1VUX1NISUZUICAgICAgICA3Cisj
ZGVmaW5lIFRMVjMyMEFJQzIzX0NMS0lOX1NISUZUICAgICAgICAgNgorI2RlZmluZSBUTFYzMjBB
SUMyM19TUl9TSElGVCAgICAgICAgICAgIDIKKyNkZWZpbmUgVExWMzIwQUlDMjNfQk9TUl9TSElG
VCAgICAgICAgICAxCisKKy8qIERpZ2l0YWwgaW50ZXJmYWNlIHJlZ2lzdGVyICovCisjZGVmaW5l
IFRMVjMyMEFJQzIzX0FDVF9PTgkJMHgwMDAxCisKKy8qCisgKiBBVURJTyByZWxhdGVkIE1BQ1JP
UworICovCisKKyNkZWZpbmUgVExWMzIwQUlDMjNfREVGQVVMVF9PVVRfVk9MCTB4NzAKKyNkZWZp
bmUgVExWMzIwQUlDMjNfREVGQVVMVF9JTl9WT0xVTUUJMHgxMAorCisjZGVmaW5lIFRMVjMyMEFJ
QzIzX09VVF9WT0xfTUlOCQlUTFYzMjBBSUMyM19MSFZfTUlOCisjZGVmaW5lIFRMVjMyMEFJQzIz
X09VVF9WT0xfTUFYCQlUTFYzMjBBSUMyM19MSFZfTUFYCisjZGVmaW5lIFRMVjMyMEFJQzIzX09V
VF9WT19SQU5HRQkoVExWMzIwQUlDMjNfT1VUX1ZPTF9NQVggLSBcCisJCQkJCVRMVjMyMEFJQzIz
X09VVF9WT0xfTUlOKQorI2RlZmluZSBUTFYzMjBBSUMyM19PVVRfVk9MX01BU0sJVExWMzIwQUlD
MjNfT1VUX1ZPTF9NQVgKKworI2RlZmluZSBUTFYzMjBBSUMyM19JTl9WT0xfTUlOCQlUTFYzMjBB
SUMyM19MSVZfTUlOCisjZGVmaW5lIFRMVjMyMEFJQzIzX0lOX1ZPTF9NQVgJCVRMVjMyMEFJQzIz
X0xJVl9NQVgKKyNkZWZpbmUgVExWMzIwQUlDMjNfSU5fVk9MX1JBTkdFCShUTFYzMjBBSUMyM19J
Tl9WT0xfTUFYIC0gXAorCQkJCQlUTFYzMjBBSUMyM19JTl9WT0xfTUlOKQorI2RlZmluZSBUTFYz
MjBBSUMyM19JTl9WT0xfTUFTSwkJVExWMzIwQUlDMjNfSU5fVk9MX01BWAorCisjZGVmaW5lIFRM
VjMyMEFJQzIzX1NJREVUT05FX01BU0sJMHgxYzAKKyNkZWZpbmUgVExWMzIwQUlDMjNfU0lERVRP
TkVfMAkJMHgxMDAKKyNkZWZpbmUgVExWMzIwQUlDMjNfU0lERVRPTkVfNgkJMHgwMDAKKyNkZWZp
bmUgVExWMzIwQUlDMjNfU0lERVRPTkVfOQkJMHgwNDAKKyNkZWZpbmUgVExWMzIwQUlDMjNfU0lE
RVRPTkVfMTIJCTB4MDgwCisjZGVmaW5lIFRMVjMyMEFJQzIzX1NJREVUT05FXzE4CQkweDBjMAor
CitleHRlcm4gc3RydWN0IHNuZF9zb2NfZGFpIHRsdjMyMGFpYzIzX2RhaTsKK2V4dGVybiBzdHJ1
Y3Qgc25kX3NvY19jb2RlY19kZXZpY2Ugc29jX2NvZGVjX2Rldl90bHYzMjBhaWMyMzsKKworI2Vu
ZGlmIC8qIF9UTFYzMjBBSUMyM19IICovCi0tIAoxLjUuMy40Cgo=
------=_Part_68167_8509622.1222939527323
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_68167_8509622.1222939527323--
