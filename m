From: Stefan Roese <sr@denx.de>
Subject: [PATCH 3/5] ASoC: omap: Add HA (HEAD acoustics) DSP add-on card audio driver for TAO3530
Date: Mon, 28 Apr 2014 14:17:54 +0200
Message-ID: <1398687476-10829-3-git-send-email-sr@denx.de>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:62213 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbaD1MYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 08:24:13 -0400
In-Reply-To: <1398687476-10829-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>

From: Jarkko Nikula <jarkko.nikula@bitmer.com>

HA DSP card which features a HA DSP audio codec is intended to be connected
to TAO-3530 (or BeagleBoard) using McBSP3 for digital audio and I2C bus for
codec control. A GPIO signal from CPU to codec is used to request clock
signals active.

This machine driver has a special feature to support linked streams where
playback and capture can be triggered HW simultaneously. This is implemented
for linked streams by activating/deactivating the clock request signal to
codec only after both streams are ready to start/stop. For non-linked streams
the request signal is active whenever there is a stream active.

Updates from Stefan Roese, 2014-04-28:
Port the HA DSP add-on card audio driver to Linux v3.15-rc. This
includes support for DT based probing. No platform-data code is
needed any more, DT nodes are sufficient.

The GPIO used to synchronize the clock for playback and record
is now configured via the DT as well (no #define any more). When
this GPIO is not configured in the DT, the sync clock feature is
disabled.

The slave mode #define was also moved to a DT configuration
property (ha_dsp_codec_slave). If this property is set in the DT
sound card device node, then this testing slave mode is used.
Otherwise the "normal" operation is selected.

Also the now recommended card registration via snd_soc_register_card()
is used instead of platform_device_add().

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
---
 sound/soc/omap/Kconfig       |  11 ++
 sound/soc/omap/Makefile      |   2 +
 sound/soc/omap/ha-dsp-card.c | 307 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 sound/soc/omap/ha-dsp-card.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index e006593..86cc869 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -117,3 +117,14 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
+
+config SND_OMAP_SOC_HA_DSP_CARD
+	tristate "SoC Audio support for HA DSP add-on card"
+	depends on TWL4030_CORE && SND_OMAP_SOC
+	depends on SND_OMAP_SOC_OMAP_TWL4030
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	select SND_SOC_HA_DSP
+	help
+	  Say Y if you want to add support for Soc audio on HA DSP add-on card
+	  for TAO-3530/Thunder or BeagleBoard
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index a725905..02c0094 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -21,6 +21,7 @@ snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
 snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap-hdmi-card-objs := omap-hdmi-card.o
+snd-soc-ha-dsp-card-objs := ha-dsp-card.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
@@ -31,3 +32,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap-hdmi-card.o
+obj-$(CONFIG_SND_OMAP_SOC_HA_DSP_CARD) += snd-soc-ha-dsp-card.o
diff --git a/sound/soc/omap/ha-dsp-card.c b/sound/soc/omap/ha-dsp-card.c
new file mode 100644
index 0000000..d2656ff
--- /dev/null
+++ b/sound/soc/omap/ha-dsp-card.c
@@ -0,0 +1,307 @@
+/*
+ * ha-dsp-card.c  --  SoC audio HA-DSP add-on card for TAO-3530
+ *
+ * Author: Jarkko Nikula <jarkko.nikula@bitmer.com>
+ *
+ * Additional changes by:
+ *   Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
+ *   Stefan Roese <sr@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+
+#include "omap-mcbsp.h"
+
+struct ha_dsp_card {
+	int slave;
+	int gpio;
+	int play_act;
+	int rec_act;
+};
+
+static int ha_dsp_card_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct ha_dsp_card *priv = snd_soc_card_get_drvdata(card);
+	unsigned int fmt;
+	int ret;
+	int div;
+
+	switch (params_channels(params)) {
+	case 2:
+	case 4:
+	case 8:
+	case 16:
+		fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (priv->slave)
+		fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	else
+		fmt |= SND_SOC_DAIFMT_CBM_CFM;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_err("can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_err("can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	if (priv->slave) {
+		ret = snd_soc_dai_set_sysclk(cpu_dai,
+					     OMAP_MCBSP_SYSCLK_CLKS_FCLK,
+					     96000000, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("can't set McBSP sysclk\n");
+			return ret;
+		}
+
+		/*
+		 * Calculate McBSP SRG divisor in McBSP master mode
+		 */
+		div = 96000000 / params_rate(params) / params_channels(params);
+		switch (params_format(params)) {
+		case SNDRV_PCM_FORMAT_S16_LE:
+			div /= 16;
+			break;
+		case SNDRV_PCM_FORMAT_S24_LE:
+		case SNDRV_PCM_FORMAT_S32_LE:
+			div /= 32;
+			break;
+		};
+
+		/*
+		 * Round to maximum divisor if needed. This means that extra
+		 * bit-clock cycles are transmitted when sample rate and number
+		 * of bits in frame (channels * sample bits) are low.
+		 */
+		if (div >= 256)
+			div = 256;
+
+		ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
+		if (ret < 0) {
+			pr_err("can't set SRG clock divider\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ha_dsp_card_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct ha_dsp_card *priv = snd_soc_card_get_drvdata(card);
+	int start;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		start = 1;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		start = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (priv->gpio != -1) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			priv->play_act = start;
+		else
+			priv->rec_act = start;
+
+		if (snd_pcm_stream_linked(substream)) {
+			/*
+			 * Set/clear the clock request gpio only after both
+			 * streams have started/stopped in streams are linked
+			 * case
+			 */
+			if (priv->play_act == priv->rec_act)
+				gpio_set_value(priv->gpio, start);
+		} else {
+			/*
+			 * Keep clock request gpio active as long as there is
+			 * either playback or capture active in non-linked
+			 * stream case
+			 */
+			gpio_set_value(priv->gpio,
+				       (priv->play_act || priv->rec_act));
+		}
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops ha_dsp_card_ops = {
+	.hw_params = ha_dsp_card_hw_params,
+	.trigger = ha_dsp_card_trigger,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link ha_dsp_card_dai = {
+	.name = "HA-DSP",
+	.stream_name = "HA-DSP",
+	.cpu_dai_name = "omap-mcbsp-dai.2",
+	.platform_name = "omap-pcm-audio",
+	.codec_dai_name = "ha-dsp-hifi",
+	.codec_name = "ha-dsp-codec.2-0020",
+	.ops = &ha_dsp_card_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_ha_dsp_card = {
+	.name = "tao3530-ha-dsp",
+	.owner = THIS_MODULE,
+	.dai_link = &ha_dsp_card_dai,
+	.num_links = 1,
+};
+
+static int ha_dsp_card_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_ha_dsp_card;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *dai_node;
+	struct ha_dsp_card *priv;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	if (!node) {
+		dev_err(&pdev->dev, "No DT node provided\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	ret = of_get_gpio(node, 0);
+	if (ret < 0) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		/* No GPIO provided, don't enable GPIO sync */
+		priv->gpio = -1;
+		goto cont_no_gpio;
+	}
+
+	/* GPIO setup */
+	priv->gpio = ret;
+	ret = devm_gpio_request(&pdev->dev, priv->gpio,	"HA-DSP clock request");
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request GPIO %u\n", priv->gpio);
+		return ret;
+	}
+
+	ret = gpio_direction_output(priv->gpio, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set pin direction\n");
+		return -EINVAL;
+	}
+	dev_info(&pdev->dev, "Using GPIO %d as sync clock\n", priv->gpio);
+
+cont_no_gpio:
+	priv->slave = of_property_read_bool(node, "ha_dsp_codec_slave");
+	if (priv->slave)
+		dev_info(&pdev->dev, "Using slave mode for testing!\n");
+
+	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+		dev_err(&pdev->dev, "Card name is not provided\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
+	if (!dai_node) {
+		dev_err(&pdev->dev, "McBSP node is not provided\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	ha_dsp_card_dai.cpu_dai_name  = NULL;
+	ha_dsp_card_dai.cpu_of_node = dai_node;
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static int ha_dsp_card_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static const struct of_device_id ha_dsp_card_of_match[] = {
+	{ .compatible = "ha,ha-dsp-card", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ha_dsp_card_of_match);
+
+static struct platform_driver ha_dsp_card_driver = {
+	.driver = {
+		.name = "ha-dsp-card",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = ha_dsp_card_of_match,
+	},
+	.probe = ha_dsp_card_probe,
+	.remove = ha_dsp_card_remove,
+};
+
+module_platform_driver(ha_dsp_card_driver);
+
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
+MODULE_DESCRIPTION("ALSA SoC TAO3530-HA-DSP");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ha-dsp-card");
-- 
1.9.1

