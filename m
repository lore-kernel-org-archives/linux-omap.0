From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/2 v2] ASoC: omap: Add HA (HEAD acoustics) DSP add-on card audio driver for TAO3530
Date: Tue,  6 May 2014 12:36:36 +0200
Message-ID: <1399372596-10744-2-git-send-email-sr@denx.de>
References: <1399372596-10744-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.182]:60728 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934594AbaEFKg1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 06:36:27 -0400
In-Reply-To: <1399372596-10744-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>

HA DSP card which features a HA DSP audio codec is intended to be connected
to TAO-3530 (or BeagleBoard) using McBSP3 for digital audio and I2C bus for
codec control. A GPIO signal from CPU to codec is used to request clock
signals active.

This machine driver has a special feature to support linked streams where
playback and capture can be triggered HW simultaneously. This is implemented
for linked streams by activating/deactivating the clock request signal to
codec only after both streams are ready to start/stop. For non-linked streams
the request signal is active whenever there is a stream active.

The GPIO used to synchronize the clock for playback and record
is now configured via the DT as well (no #define any more). When
this GPIO is not configured in the DT, the sync clock feature is
disabled.

Slave mode is not supported any more (was never really tested). So
this version has the slave mode removed.

Also the now recommended card registration via
devm_snd_soc_register_card() is used instead of platform_device_add().

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
- Moved DT bindings documention into this patch
- ha_dsp_codec_slave removed as its currently not used
- devm_snd_soc_register_card() used

 .../devicetree/bindings/sound/omap3-ha.txt         |  27 +++
 sound/soc/omap/Kconfig                             |  11 +
 sound/soc/omap/Makefile                            |   2 +
 sound/soc/omap/ha-dsp-card.c                       | 250 +++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/omap3-ha.txt
 create mode 100644 sound/soc/omap/ha-dsp-card.c

diff --git a/Documentation/devicetree/bindings/sound/omap3-ha.txt b/Documentation/devicetree/bindings/sound/omap3-ha.txt
new file mode 100644
index 0000000..09eccda
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap3-ha.txt
@@ -0,0 +1,27 @@
+OMAP3 HA (HEAD acoustics) audio controller
+
+Required properties:
+- compatible: "ha,ha-dsp-card" for OMAP3-HA board (TAO3530 based)
+- ti,model: Name of the sound card (for example "omap3-ha")
+- ti,mcbsp: phandle for the McBSP node
+- ti,codec: phandle for the twl4030 audio node
+- gpios: GPIO used to sync the clock for playback and record
+
+Example:
+sound2 {
+	compatible = "ha,ha-dsp-card";
+	ti,model = "omap3-ha";
+
+	/* McBSP3 is used for HA-DSP */
+	ti,mcbsp = <&mcbsp3>;
+	ti,codec = <&soc_audio>;
+
+	/* GPIO to sync the clock for playback and record */
+	gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;	/* GPIO 44 */
+};
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
index 0000000..36821ca
--- /dev/null
+++ b/sound/soc/omap/ha-dsp-card.c
@@ -0,0 +1,250 @@
+/*
+ * ha-dsp-card.c  --  SoC audio HA-DSP add-on card for TAO-3530
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
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+
+#include "omap-mcbsp.h"
+
+struct ha_dsp_card {
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
+	unsigned int fmt;
+	int ret;
+
+	/* Check for allowed channel count */
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
+	/* Set CODEC as master */
+	fmt |= SND_SOC_DAIFMT_CBM_CFM;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_err("Can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_err("Can't set cpu DAI configuration\n");
+		return ret;
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
+		dev_err(&pdev->dev, "Failed to request GPIO %u\n", priv->gpio);
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
+	if (snd_soc_of_parse_card_name(card, "ti,model")) {
+		dev_err(&pdev->dev, "Card name is not provided\n");
+		return -ENODEV;
+	}
+
+	dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
+	if (!dai_node) {
+		dev_err(&pdev->dev, "McBSP node is not provided\n");
+		return -EINVAL;
+	}
+	ha_dsp_card_dai.cpu_dai_name  = NULL;
+	ha_dsp_card_dai.cpu_of_node = dai_node;
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card() failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ha_dsp_card_remove(struct platform_device *pdev)
+{
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
1.9.2

