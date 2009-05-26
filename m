From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Please help in adding ams-delta support to ASoC
Date: Tue, 26 May 2009 15:17:23 +0200
Message-ID: <4A1BEBE3.8010306@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030401020308010505050707"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49349 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbZEZNTZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2009 09:19:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401020308010505050707
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am trying to add sound support for ams-delta omap machine, yet without 
much success.

Three years ago, Mark Underwood created an omap-alsa compatible driver 
that basically worked[1]. It was derieved from similiar driver for aic23 
codec found on omap osk machine. It looks like Mark has never managed to 
finish his work. It's not clear for me if he has found that getting a 
working fullduplex sound is technically impossible on a voice modem 
codec, shared among modem and cpu, controlable only from modem side 
afaik, but I have decided to give it a try.

Since Mark's initial work, omap-alsa framework has been depreciated in 
favour of soc-omap. API changes are so significant that Mark's code is 
rather not useable directly any more. However, I am trying to use it as 
a starting point, by comparing it against it's prototype osk/aic23 code.

Following Mark, I am trying to derieve the new ams-delta sound driver 
from current asoc driver for omap osk9512. For codec part, I decided to 
base my work on much more simple ad73311 rather that tlv320aic23.

Comparing Mark's code agaist it's osk/aic23 prototype, I can see the 
folowing significant changes:
1. rate tables/bitmaps found in hw_constraint_rates, 
snd_omap_alsa_playback and snd_omap_alsa_capture structures limited to 8kHz,
2. hardware related code found in codec_configure_dev(), 
codec_clock_on() and codec_clock_off() callback functions replaced with 
ams-delta hardware specific code that switches the codec DAI pins from 
modem chip to mcbsp cpu interface and back,
3. codec_set_samplerate() and all mixer related functions replaced with 
stubs.
4. the following McBSP register settings changes:

-	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
-	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),

-	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr1 = CLKGDV(0),

-	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+       .srgr2 = GSYNC,

-	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */

I have found points 1. to 3. rather trivial to implement in new 
framework. Regarding point 4., it looks like detailed register settings 
are now done inside omap-mcbsp.c, based on machine specified format, so 
I have to find out what format should be specified for ams-delta. Please 
correct me if I am missing something.

There was one more modification in Mark's code, addressing dma chaining 
problem on omap15xx hardware, but as far as I could see, the problem was 
already solved in the asoc omap framework.

Initially, I based my work on ompenembedded provided linux-omap.git 
revision 90e758af52ba803cba233fabee81176d99589f09. The results were 
rather poor - total system hangup after first device access, with no 
single message. So I have switched to linux-2.6.30-rc5 and now I can 
safely access the device, however it does not work as expected. aplay 
and arecord wait forever, cat to/from /dev/dsp breaks with hardware 
error messgae. DMA interrput counters stay at 0. However, codec 
switching that I do from machine->ops->startup/shutdown seems working, 
as modem stops producing any sounds while the alsa device is in use and 
gets back thereafter.

First of all, I'd like to make sure if my problem is related to my code 
only. As I am new in these areas, I would like to ask you if the omap 
asoc framework is stable enough to relay on. If yes, could you please 
look at my dirty code (attached) an give me some hints? I can provide 
you with more information if necessary.

Regards,
Janusz

[1] http://www.earth.li/pipermail/e3-hacking/2006-April/000481.html

--------------030401020308010505050707
Content-Type: text/x-patch;
 name="ams-delta-sound.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ams-delta-sound.patch"

diff -Npru git/sound/soc/codecs/Kconfig git/sound/soc/codecs/Kconfig
--- git/sound/soc/codecs/Kconfig	2009-05-12 21:13:59.000000000 +0200
+++ git/sound/soc/codecs/Kconfig	2009-05-18 22:31:15.000000000 +0200
@@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
+	select SND_SOC_CX20442
 	select SND_SOC_AD73311 if I2C
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_CS4270 if I2C
@@ -55,6 +56,9 @@ config SND_SOC_AC97_CODEC
 config SND_SOC_AD1980
 	tristate
 
+config SND_SOC_CX20442
+	tristate
+
 config SND_SOC_AD73311
 	tristate
 
diff -Npru git/sound/soc/codecs/Makefile git/sound/soc/codecs/Makefile
--- git/sound/soc/codecs/Makefile	2009-05-12 21:13:59.000000000 +0200
+++ git/sound/soc/codecs/Makefile	2009-05-18 22:33:32.000000000 +0200
@@ -1,5 +1,6 @@
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1980-objs := ad1980.o
+snd-soc-cx20442-objs := cx20442.o
 snd-soc-ad73311-objs := ad73311.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
@@ -28,6 +29,7 @@ snd-soc-wm9713-objs := wm9713.o
 
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
+obj-$(CONFIG_SND_SOC_CX20442) += snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
diff -Npru git/sound/soc/codecs/cx20442.c git/sound/soc/codecs/cx20442.c
--- git/sound/soc/codecs/cx20442.c	1970-01-01 01:00:00.000000000 +0100
+++ git/sound/soc/codecs/cx20442.c	2009-05-18 21:26:20.000000000 +0200
@@ -0,0 +1,117 @@
+/*
+ * cx20442.c  --  ALSA Soc cx20442 codec support
+ *
+ * based on ad73311.c
+ *
+ * Copyright:	Analog Device Inc.
+ * Author:	Cliff Cai <cliff.cai@analog.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include "cx20442.h"
+
+struct snd_soc_dai cx20442_dai = {
+	.name = "CX20442",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
+};
+EXPORT_SYMBOL_GPL(cx20442_dai);
+
+static int cx20442_soc_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
+	mutex_init(&codec->mutex);
+	codec->name = "CX20442";
+	codec->owner = THIS_MODULE;
+	codec->dai = &cx20442_dai;
+	codec->num_dai = 1;
+	socdev->card->codec = codec;
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "cx20442: failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "cx20442: failed to register card\n");
+		goto register_err;
+	}
+
+	return ret;
+
+register_err:
+	snd_soc_free_pcms(socdev);
+pcm_err:
+	kfree(socdev->card->codec);
+	socdev->card->codec = NULL;
+	return ret;
+}
+
+static int cx20442_soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	if (codec == NULL)
+		return 0;
+	snd_soc_free_pcms(socdev);
+	kfree(codec);
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_cx20442 = {
+	.probe = 	cx20442_soc_probe,
+	.remove = 	cx20442_soc_remove,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_cx20442);
+
+static int __init cx20442_init(void)
+{
+	return snd_soc_register_dai(&cx20442_dai);
+}
+module_init(cx20442_init);
+
+static void __exit cx20442_exit(void)
+{
+	snd_soc_unregister_dai(&cx20442_dai);
+}
+module_exit(cx20442_exit);
+
+MODULE_DESCRIPTION("ASoC cx20442 driver");
+MODULE_AUTHOR("Cliff Cai ");
+MODULE_LICENSE("GPL");
diff -Npru git/sound/soc/codecs/cx20442.h git/sound/soc/codecs/cx20442.h
--- git/sound/soc/codecs/cx20442.h	1970-01-01 01:00:00.000000000 +0100
+++ git/sound/soc/codecs/cx20442.h	2009-05-18 21:25:46.000000000 +0200
@@ -0,0 +1,90 @@
+/*
+ * File:         sound/soc/codec/cx20442.h
+ * Based on:     sound/soc/codec/ad73311.h
+ * Author:       Cliff Cai <cliff.cai@analog.com>
+ *
+ * Created:      Thur Sep 25, 2008
+ * Description:  definitions for cx20442 registers
+ *
+ *
+ * Modified:
+ *               Copyright 2006 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __CX20442_H__
+#define __CX20442_H__
+
+#define AD_CONTROL	0x8000
+#define AD_DATA		0x0000
+#define AD_READ		0x4000
+#define AD_WRITE	0x0000
+
+/* Control register A */
+#define CTRL_REG_A	(0 << 8)
+
+#define REGA_MODE_PRO	0x00
+#define REGA_MODE_DATA	0x01
+#define REGA_MODE_MIXED	0x03
+#define REGA_DLB		0x04
+#define REGA_SLB		0x08
+#define REGA_DEVC(x)		((x & 0x7) << 4)
+#define REGA_RESET		0x80
+
+/* Control register B */
+#define CTRL_REG_B	(1 << 8)
+
+#define REGB_DIRATE(x)	(x & 0x3)
+#define REGB_SCDIV(x)	((x & 0x3) << 2)
+#define REGB_MCDIV(x)	((x & 0x7) << 4)
+#define REGB_CEE		(1 << 7)
+
+/* Control register C */
+#define CTRL_REG_C	(2 << 8)
+
+#define REGC_PUDEV		(1 << 0)
+#define REGC_PUADC		(1 << 3)
+#define REGC_PUDAC		(1 << 4)
+#define REGC_PUREF		(1 << 5)
+#define REGC_REFUSE		(1 << 6)
+
+/* Control register D */
+#define CTRL_REG_D	(3 << 8)
+
+#define REGD_IGS(x)		(x & 0x7)
+#define REGD_RMOD		(1 << 3)
+#define REGD_OGS(x)		((x & 0x7) << 4)
+#define REGD_MUTE		(x << 7)
+
+/* Control register E */
+#define CTRL_REG_E	(4 << 8)
+
+#define REGE_DA(x)		(x & 0x1f)
+#define REGE_IBYP		(1 << 5)
+
+/* Control register F */
+#define CTRL_REG_F	(5 << 8)
+
+#define REGF_SEEN		(1 << 5)
+#define REGF_INV		(1 << 6)
+#define REGF_ALB		(1 << 7)
+
+extern struct snd_soc_dai cx20442_dai;
+extern struct snd_soc_codec_device soc_codec_dev_cx20442;
+#endif
diff -Npru git/sound/soc/omap/Kconfig git/sound/soc/omap/Kconfig
--- git/sound/soc/omap/Kconfig	2009-05-12 21:13:59.000000000 +0200
+++ git/sound/soc/omap/Kconfig	2009-05-18 22:29:16.000000000 +0200
@@ -15,6 +15,14 @@ config SND_OMAP_SOC_N810
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
 
+config SND_OMAP_SOC_AMS_DELTA
+	tristate "SoC Audio support for Amstrad Delta"
+	depends on SND_OMAP_SOC && MACH_AMS_DELTA
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_CX20442
+	help
+	  Say Y if you want to add support for SoC audio on ams-delta.
+
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
 	depends on SND_OMAP_SOC && MACH_OMAP_OSK
diff -Npru git/sound/soc/omap/Makefile git/sound/soc/omap/Makefile
--- git/sound/soc/omap/Makefile	2009-05-12 21:13:59.000000000 +0200
+++ git/sound/soc/omap/Makefile	2009-05-18 22:32:31.000000000 +0200
@@ -7,6 +7,7 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-ams-delta-objs := ams-delta.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
@@ -14,6 +15,7 @@ snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
diff -Npru git/sound/soc/omap/ams-delta.c git/sound/soc/omap/ams-delta.c
--- git/sound/soc/omap/ams-delta.c	1970-01-01 01:00:00.000000000 +0100
+++ git/sound/soc/omap/ams-delta.c	2009-05-19 10:11:51.000000000 +0200
@@ -0,0 +1,236 @@
+/*
+ * ams-delta.c  --  SoC audio for Amstrad Delta (E3)
+ *
+ * based on osk5912.c
+ *
+ * Copyright (C) 2008 Mistral Solutions
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <linux/gpio.h>
+#include <mach/mcbsp.h>
+#include <mach/board-ams-delta.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/cx20442.h"
+
+#define CODEC_CLOCK 	12000000
+
+static struct clk *cx20442_mclk;
+
+static int ams_delta_startup(struct snd_pcm_substream *substream)
+{
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
+	return clk_enable(cx20442_mclk);
+}
+
+static void ams_delta_shutdown(struct snd_pcm_substream *substream)
+{
+	clk_disable(cx20442_mclk);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, AMS_DELTA_LATCH2_MODEM_CODEC);
+}
+
+static int ams_delta_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	/* Set codec DAI configuration */
+	/* err = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return err;
+	} */
+
+	/* Set cpu DAI configuration */
+	err = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_DSP_B |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return err;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	/* err =
+	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
+
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return err;
+	} */
+
+	return err;
+}
+
+static struct snd_soc_ops ams_delta_ops = {
+	.startup = ams_delta_startup,
+	.hw_params = ams_delta_hw_params,
+	.shutdown = ams_delta_shutdown,
+};
+
+#if 0
+static const struct snd_soc_dapm_widget cx20442_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+#endif
+
+static int ams_delta_cx20442_init(struct snd_soc_codec *codec)
+{
+
+#if 0
+	/* Add osk5912 specific widgets */
+	snd_soc_dapm_new_controls(codec, cx20442_dapm_widgets,
+				  ARRAY_SIZE(cx20442_dapm_widgets));
+
+	/* Set up osk5912 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	snd_soc_dapm_sync(codec);
+#endif
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
+
+	return 0;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link ams_delta_dai = {
+	.name = "CX20442",
+	.stream_name = "CX20442",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &cx20442_dai,
+	// .init = ams_delta_cx20442_init,
+	.ops = &ams_delta_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_card_ams_delta = {
+	.name = "AMS_DELTA",
+	.platform = &omap_soc_platform,
+	.dai_link = &ams_delta_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device ams_delta_snd_devdata = {
+	.card = &snd_soc_card_ams_delta,
+	.codec_dev = &soc_codec_dev_cx20442,
+};
+
+static struct platform_device *ams_delta_snd_device;
+
+static int __init ams_delta_soc_init(void)
+{
+	int err;
+	u32 curRate;
+	struct device *dev;
+
+	if (!(machine_is_ams_delta()))
+		return -ENODEV;
+
+	ams_delta_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!ams_delta_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(ams_delta_snd_device, &ams_delta_snd_devdata);
+	ams_delta_snd_devdata.dev = &ams_delta_snd_device->dev;
+	*(unsigned int *)ams_delta_dai.cpu_dai->private_data = 0;	/* McBSP1 */
+	err = platform_device_add(ams_delta_snd_device);
+	if (err)
+		goto err1;
+
+	dev = &ams_delta_snd_device->dev;
+
+	cx20442_mclk = clk_get(dev, "mclk");
+	if (IS_ERR(cx20442_mclk)) {
+		printk(KERN_ERR "Could not get mclk clock\n");
+		err = PTR_ERR(cx20442_mclk);
+		goto err2;
+	}
+
+	/*
+	 * Configure 12 MHz output on MCLK.
+	 */
+	curRate = (uint) clk_get_rate(cx20442_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(cx20442_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR "Cannot set MCLK for CX20442 CODEC\n");
+			err = -ECANCELED;
+			goto err3;
+		}
+	}
+
+	printk(KERN_INFO "MCLK = %d [%d]\n",
+	       (uint) clk_get_rate(cx20442_mclk), CODEC_CLOCK);
+
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
+	return 0;
+err3:
+	clk_put(cx20442_mclk);
+err2:
+	platform_device_del(ams_delta_snd_device);
+err1:
+	platform_device_put(ams_delta_snd_device);
+
+	return err;
+
+}
+
+static void __exit ams_delta_soc_exit(void)
+{
+	platform_device_unregister(ams_delta_snd_device);
+}
+
+module_init(ams_delta_soc_init);
+module_exit(ams_delta_soc_exit);
+
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_DESCRIPTION("ALSA SoC Amstrad Delta");
+MODULE_LICENSE("GPL");

--------------030401020308010505050707--
