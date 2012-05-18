From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 01/11] ASoC: OMAP: HDMI: Introduce codec
Date: Fri, 18 May 2012 01:42:33 -0500
Message-ID: <1337323363-11449-2-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47747 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab2ERGnV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 02:43:21 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Introduce codec for HDMI. At the moment, this is a dummy codec. In the
future it will parse the EDID to modify the supported parameters, such
as the number of channels and the sample rates. At the moment, it blindly
supports all the sample rates and audio channels described in the HDMI
1.4a specification.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/codecs/Kconfig     |    4 ++
 sound/soc/codecs/Makefile    |    2 +
 sound/soc/codecs/omap-hdmi.c |   69 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/Kconfig       |    1 +
 4 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/omap-hdmi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 59d8efa..7cac665 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -42,6 +42,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
+	select SND_SOC_OMAP_HDMI_CODEC if OMAP4_DSS_HDMI
 	select SND_SOC_PCM3008
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_SGTL5000 if I2C
@@ -226,6 +227,9 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX9850
 	tristate
 
+config SND_SOC_OMAP_HDMI_CODEC
+       tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6662eb0..7e475c9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -29,6 +29,7 @@ snd-soc-max9768-objs := max9768.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max9850-objs := max9850.o
+snd-soc-omap-hdmi-codec-objs := omap-hdmi.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-sgtl5000-objs := sgtl5000.o
@@ -135,6 +136,7 @@ obj-$(CONFIG_SND_SOC_MAX9768)	+= snd-soc-max9768.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
+obj-$(CONFIG_SND_SOC_OMAP_HDMI_CODEC) += snd-soc-omap-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
diff --git a/sound/soc/codecs/omap-hdmi.c b/sound/soc/codecs/omap-hdmi.c
new file mode 100644
index 0000000..1bf5c74
--- /dev/null
+++ b/sound/soc/codecs/omap-hdmi.c
@@ -0,0 +1,69 @@
+/*
+ * ALSA SoC codec driver for HDMI audio on OMAP processors.
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Ricardo Neri <ricardo.neri@ti.com>
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
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "hdmi-audio-codec"
+
+static struct snd_soc_codec_driver omap_hdmi_codec;
+
+static struct snd_soc_dai_driver omap_hdmi_codec_dai = {
+	.name = "omap-hdmi-hifi",
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE,
+	},
+};
+
+static __devinit int omap_hdmi_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &omap_hdmi_codec,
+			&omap_hdmi_codec_dai, 1);
+}
+
+static __devexit int omap_hdmi_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver omap_hdmi_codec_driver = {
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+
+	.probe		= omap_hdmi_codec_probe,
+	.remove		= __devexit_p(omap_hdmi_codec_remove),
+};
+
+module_platform_driver(omap_hdmi_codec_driver);
+
+MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
+MODULE_DESCRIPTION("ASoC OMAP HDMI codec driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index deafbfa..9ccfa5e 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -113,6 +113,7 @@ config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
 	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
 	select SND_OMAP_SOC_HDMI
+	select SND_SOC_OMAP_HDMI_CODEC
 	help
 	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
 	  OMAP4 chips
-- 
1.7.5.4

