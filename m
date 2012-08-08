From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] ASoC: omap-twl4030: Simple machine driver for TI SoC with twl4030 codec
Date: Wed,  8 Aug 2012 12:54:07 +0300
Message-ID: <1344419650-5389-2-git-send-email-peter.ujfalusi@ti.com>
References: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51368 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752609Ab2HHJy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 05:54:29 -0400
Received: by obbuo19 with SMTP id uo19so849721obb.11
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 02:54:28 -0700 (PDT)
In-Reply-To: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, devicetree-discuss@lists.ozlabs.org

Machine driver to handle simple devices using twl4030 as audio codec.
The driver supports the following boards:
- Beagleboard or Devkit8000
- Gumstix Overo or CompuLab CM-T35/CM-T3730
- IGEP v2
- OMAP3EVM

All of these boards can be switched to use this driver since their setup is
identical.
Devicetree support for the omap-twl4030 machine driver also implemented.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/omap-twl4030.txt     |   19 ++
 include/linux/platform_data/omap-twl4030.h         |   33 +++
 sound/soc/omap/Kconfig                             |   13 ++
 sound/soc/omap/Makefile                            |    2 +
 sound/soc/omap/omap-twl4030.c                      |  219 ++++++++++++++++++++
 5 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 include/linux/platform_data/omap-twl4030.h
 create mode 100644 sound/soc/omap/omap-twl4030.c

diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
new file mode 100644
index 0000000..02e4e4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
@@ -0,0 +1,19 @@
+* Texas Instruments SoC with twl4030 based audio setups
+
+Required properties:
+- compatible: "ti,omap-twl4030"
+- ti,model: Name of the sound card (for example "omap3beagle")
+- ti,codec_sysclk: Sysclk frequency of twl4030 codec
+- ti,mcbsp: phandle for the McBSP node
+- ti,codec: phandle for the twl4030 audio node
+
+Example:
+
+sound {
+	compatible = "ti,omap-twl4030";
+	ti,model = "omap3beagle";
+
+	ti,mcbsp = <&mcbsp2>;
+	ti,codec = <&twl_audio>;
+	ti,codec_sysclk = <26000000>;
+};
diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
new file mode 100644
index 0000000..ee68473
--- /dev/null
+++ b/include/linux/platform_data/omap-twl4030.h
@@ -0,0 +1,33 @@
+/**
+ * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl4030
+ *		    codec, header.
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * All rights reserved.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
+ */
+
+#ifndef _OMAP_TWL4030_H_
+#define _OMAP_TWL4030_H_
+
+struct omap_tw4030_pdata {
+	const char *card_name;
+	int codec_sysclk;
+};
+
+#endif /* _OMAP_TWL4030_H_ */
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 57a2fa7..fc83d74 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -95,6 +95,19 @@ config SND_OMAP_SOC_SDP3430
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP3430.
 
+config SND_OMAP_SOC_OMAP_TWL4030
+	tristate "SoC Audio support for TI SoC based boards with twl4030 codec"
+	depends on TWL4030_CORE && SND_OMAP_SOC
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on TI SoC based boards
+	  using twl4030 as c codec. This driver currently supports:
+	  - Beagleboard or Devkit8000
+	  - Gumstix Overo or CompuLab CM-T35/CM-T3730
+	  - IGEP v2
+	  - OMAP3EVM
+
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
 	depends on TWL6040_CORE && SND_OMAP_SOC && ARCH_OMAP4
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 0e14dd3..861e640 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -21,6 +21,7 @@ snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
+snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
@@ -37,6 +38,7 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
new file mode 100644
index 0000000..22ec08d
--- /dev/null
+++ b/sound/soc/omap/omap-twl4030.c
@@ -0,0 +1,219 @@
+/*
+ * omap-twl4030.c  --  SoC audio for TI SoC based boards with twl4030 codec
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * All rights reserved.
+ *
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ *
+ * This driver replaces the following machine drivers:
+ * omap3beagle (Author: Steve Sakoman <steve@sakoman.com>)
+ * omap3evm (Author: Anuj Aggarwal <anuj.aggarwal@ti.com>)
+ * overo (Author: Steve Sakoman <steve@sakoman.com>)
+ * igep0020 (Author: Enric Balletbo i Serra <eballetbo@iseebcn.com>)
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
+#include <linux/platform_device.h>
+#include <linux/platform_data/omap-twl4030.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+
+struct omap_twl4030_priv {
+	int	codec_sysclk;
+};
+
+static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct omap_twl4030_priv *priv = snd_soc_card_get_drvdata(card);
+	unsigned int fmt;
+	int ret;
+
+	switch (params_channels(params)) {
+	case 2: /* Stereo I2S mode */
+		fmt =	SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	case 4: /* Four channel TDM mode */
+		fmt =	SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, priv->codec_sysclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap_twl4030_ops = {
+	.hw_params = omap_twl4030_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
+	{
+		.name = "TWL4030",
+		.stream_name = "TWL4030",
+		.cpu_dai_name = "omap-mcbsp.2",
+		.codec_dai_name = "twl4030-hifi",
+		.platform_name = "omap-pcm-audio",
+		.codec_name = "twl4030-codec",
+		.ops = &omap_twl4030_ops,
+	},
+};
+
+/* Audio machine driver */
+static struct snd_soc_card omap_twl4030_card = {
+	.owner = THIS_MODULE,
+	.dai_link = omap_twl4030_dai_links,
+	.num_links = ARRAY_SIZE(omap_twl4030_dai_links),
+};
+
+static __devinit int omap_twl4030_probe(struct platform_device *pdev)
+{
+	struct omap_tw4030_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *node = pdev->dev.of_node;
+	struct snd_soc_card *card = &omap_twl4030_card;
+	struct omap_twl4030_priv *priv;
+	int ret = 0;
+
+	card->dev = &pdev->dev;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct omap_twl4030_priv),
+			    GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	if (node) {
+		struct device_node *dai_node;
+
+		if (snd_soc_of_parse_card_name(card, "ti,model")) {
+			dev_err(&pdev->dev, "Card name is not provided\n");
+			return -ENODEV;
+		}
+
+		dai_node = of_parse_phandle(node, "ti,mcbsp", 0);
+		if (!dai_node) {
+			dev_err(&pdev->dev, "McBSP node is not provided\n");
+			return -EINVAL;
+		}
+		omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
+		omap_twl4030_dai_links[0].cpu_of_node = dai_node;
+
+		of_property_read_u32(node, "ti,codec_sysclk",
+				     &priv->codec_sysclk);
+	} else if (pdata) {
+		if (pdata->card_name) {
+			card->name = pdata->card_name;
+		} else {
+			dev_err(&pdev->dev, "Card name is not provided\n");
+			return -ENODEV;
+		}
+
+		priv->codec_sysclk = pdata->codec_sysclk;
+	} else {
+		dev_err(&pdev->dev, "Missing pdata\n");
+		return -ENODEV;
+	}
+
+
+	if (!priv->codec_sysclk) {
+		dev_err(&pdev->dev, "Codec sysclk frequency missing\n");
+		return -ENODEV;
+	}
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit omap_twl4030_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static const struct of_device_id omap_twl4030_of_match[] = {
+	{.compatible = "ti,omap-twl4030", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap_twl4030_of_match);
+
+static struct platform_driver omap_twl4030_driver = {
+	.driver = {
+		.name = "omap-twl4030",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = omap_twl4030_of_match,
+	},
+	.probe = omap_twl4030_probe,
+	.remove = __devexit_p(omap_twl4030_remove),
+};
+
+module_platform_driver(omap_twl4030_driver);
+
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC for TI SoC based boards with twl4030 codec");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-twl4030");
-- 
1.7.8.6

