From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 09:24:39 +0200
Message-ID: <200906020925.58675.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527104711.GA1970@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090527104711.GA1970@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Wednesday 27 May 2009 12:47:11 Mark Brown wrote:
> On Tue, May 26, 2009 at 03:17:23PM +0200, Janusz Krzysztofik wrote:
> > +static int cx20442_soc_probe(struct platform_device *pdev)
> > +{
> > +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> > +	struct snd_soc_codec *codec;
> > +	int ret = 0;
> > +
> > +	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> > +	if (codec == NULL)
> > +		return -ENOMEM;
> > +	mutex_init(&codec->mutex);
> > +	codec->name = "CX20442";
> > +	codec->owner = THIS_MODULE;
> > +	codec->dai = &cx20442_dai;
> > +	codec->num_dai = 1;
>
> It'd be nice to switch this over to registering the CODEC as a platform
> device rather than using the old style ASoC probing - see something line
> WM8731 for a relatively simple example.

Tired with solving tha main problem of not getting any DMA interrupts, I have 
followed your advices and modified my codec driver. I have used your wm8400 
code as a template. The driver compiles and loads without errors, however I 
have no way to verify if and how it works as long as the DMA issue persists. 
I think the code is probably far from complete, but could you please have a 
look at it for possible problems?

I have choosen to register the codec device with 
platform_device_register_simple("cx20442-codec", ...) invoked form asoc 
machine driver, is this ok?

Thanks,
Janusz


Signed-off by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
-------------------------------
diff -Npru a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
--- a/sound/soc/codecs/Kconfig	2009-05-12 21:13:59.000000000 +0200
+++ b/sound/soc/codecs/Kconfig	2009-06-01 22:31:15.000000000 +0200
@@ -18,6 +18,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
 	select SND_SOC_CS4270 if I2C
+	select SND_SOC_CX20442
 	select SND_SOC_PCM3008
 	select SND_SOC_SSM2602 if I2C
 	select SND_SOC_TLV320AIC23 if I2C
@@ -84,6 +85,9 @@ config SND_SOC_AC97_CODEC
 	bool
 	depends on SND_SOC_CS4270
 
+config SND_SOC_CX20442
+	tristate
+
 config SND_SOC_L3
 	tristate
 
diff -Npru a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
--- a/sound/soc/codecs/Makefile	2009-05-12 21:13:59.000000000 +0200
+++ b/sound/soc/codecs/Makefile	2009-06-01 22:33:32.000000000 +0200
@@ -5,6 +5,7 @@
 snd-soc-ak4104-objs := ak4104.o
 snd-soc-ak4535-objs := ak4535.o
 snd-soc-cs4270-objs := cs4270.o
+snd-soc-cx20442-objs := cx20442.o
 snd-soc-l3-objs := l3.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-ssm2602-objs := ssm2602.o
@@ -37,6 +38,7 @@ snd-soc-wm9713-objs := wm9713.o
 obj-$(CONFIG_SND_SOC_AK4104)	+= snd-soc-ak4104.o
 obj-$(CONFIG_SND_SOC_AK4535)	+= snd-soc-ak4535.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
+obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
diff -Npru a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
--- a/sound/soc/codecs/cx20442.c	1970-01-01 01:00:00.000000000 +0100
+++ b/sound/soc/codecs/cx20442.c	2009-06-01 21:26:20.000000000 +0200
@@ -0,0 +1,224 @@
+/*
+ * cx20442.c  --  CX20442 ALSA Soc Audio driver
+ *
+ * Based on wm8400.c
+ * Copyright 2008, 2009 Wolfson Microelectronics PLC.
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * Copyright 2009 Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+
+#include "cx20442.h"
+
+struct cx20442_priv {
+	struct snd_soc_codec codec;
+	struct work_struct work;
+};
+
+static int cx20442_add_controls(struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static int cx20442_add_widgets(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_widgets(codec);
+	return 0;
+}
+
+static int cx20442_set_bias_level(struct snd_soc_codec *codec,
+				   enum snd_soc_bias_level level)
+{
+	codec->bias_level = level;
+	return 0;
+}
+
+#define CX20442_RATES SNDRV_PCM_RATE_8000
+
+#define CX20442_FORMATS SNDRV_PCM_FMTBIT_S16_LE
+
+struct snd_soc_dai cx20442_dai = {
+	.name = "CX20442",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CX20442_RATES,
+		.formats = CX20442_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = CX20442_RATES,
+		.formats = CX20442_FORMATS,
+	},
+};
+EXPORT_SYMBOL_GPL(cx20442_dai);
+
+static struct snd_soc_codec *cx20442_codec;
+
+static int cx20442_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret;
+
+	if(!cx20442_codec) {
+		dev_err(&pdev->dev, "cx20442 not yet discovered\n");
+		return -ENODEV;
+	}
+	codec = cx20442_codec;
+
+	socdev->card->codec = codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create pcms\n");
+		goto pcm_err;
+	}
+
+	cx20442_add_controls(codec);
+	cx20442_add_widgets(codec);
+
+	cx20442_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register card\n");
+		goto card_err;
+	}
+
+	return ret;
+
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
+	return ret;
+}
+
+/* power down chip */
+static int cx20442_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_cx20442 = {
+	.probe = 	cx20442_probe,
+	.remove = 	cx20442_remove,
+};
+
+static int cx20442_codec_probe(struct platform_device *dev)
+{
+	struct cx20442_priv *priv;
+	int ret;
+	struct snd_soc_codec *codec;
+
+	priv = kzalloc(sizeof(struct cx20442_priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	codec = &priv->codec;
+	codec->private_data = priv;
+	codec->control_data = dev->dev.driver_data;
+
+	codec->dev = &dev->dev;
+	cx20442_dai.dev = &dev->dev;
+
+	codec->name = "CX20442";
+	codec->owner = THIS_MODULE;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->set_bias_level = cx20442_set_bias_level;
+	codec->dai = &cx20442_dai;
+	codec->num_dai = 1;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	cx20442_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(&dev->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dai(&cx20442_dai);
+	if (ret != 0) {
+		dev_err(&dev->dev, "Failed to register DAI: %d\n", ret);
+		goto err_codec;
+	}
+
+	return 0;
+
+err_codec:
+	snd_soc_unregister_codec(codec);
+err:
+	cx20442_codec = NULL;
+	kfree(priv);
+	return ret;
+}
+
+static int __exit cx20442_codec_remove(struct platform_device *dev)
+{
+	struct cx20442_data *priv = cx20442_codec->private_data;
+
+	snd_soc_unregister_dai(&cx20442_dai);
+	snd_soc_unregister_codec(cx20442_codec);
+
+	kfree(priv);
+
+	cx20442_codec = NULL;
+
+	return 0;
+}
+
+static struct platform_driver cx20442_codec_driver = {
+	.driver = {
+		.name = "cx20442-codec",
+		.owner = THIS_MODULE,
+		},
+	.probe = cx20442_codec_probe,
+	.remove = __exit_p(cx20442_codec_remove),
+};
+
+static int __init cx20442_init(void)
+{
+	return platform_driver_register(&cx20442_codec_driver);
+}
+module_init(cx20442_init);
+
+static void __exit cx20442_exit(void)
+{
+	platform_driver_unregister(&cx20442_codec_driver);
+}
+module_exit(cx20442_exit);
+
+EXPORT_SYMBOL_GPL(soc_codec_dev_cx20442);
+
+MODULE_DESCRIPTION("ASoC CX20442 driver");
+MODULE_AUTHOR("Janusz Krzysztofik");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cx20442-codec");
diff -Npru a/sound/soc/codecs/cx20442.h b/sound/soc/codecs/cx20442.h
--- a/sound/soc/codecs/cx20442.h	1970-01-01 01:00:00.000000000 +0100
+++ b/sound/soc/codecs/cx20442.h	2009-06-01 21:25:46.000000000 +0200
@@ -0,0 +1,23 @@
+/*
+ * cx20442.h  --  audio driver for CX20442
+ *
+ * Based on wm8400.h
+ * Copyright 2008 Wolfson Microelectronics PLC.
+ * Author:Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * Copyright 2009 Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef _CX20442_CODEC_H
+#define _CX20442_CODEC_H
+
+extern struct snd_soc_dai cx20442_dai;
+extern struct snd_soc_codec_device soc_codec_dev_cx20442;
+
+#endif
