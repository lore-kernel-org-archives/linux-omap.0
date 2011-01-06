From: David Lambert <dlambert@ti.com>
Subject: [PATCH v2 2/4] ASoC: DMIC codec: Adding a generic DMIC codec
Date: Thu,  6 Jan 2011 08:00:37 -0600
Message-ID: <1294322439-16305-3-git-send-email-dlambert@ti.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46856 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1AFOA5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 09:00:57 -0500
In-Reply-To: <1294322439-16305-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Lambert <dlambert@ti.com>

This codec is to be used by the DMIC driver to
control the DMIC codec.  This driver will be used on future
implementations of the DMIC driver to support codec specific
features.

At this time, the codec driver just registers the codec DAI.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 sound/soc/codecs/Kconfig  |    3 ++
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/dmic.c   |   81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/dmic.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f33db2..f6c6d31 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -166,6 +166,9 @@ config SND_SOC_L3
 config SND_SOC_DA7210
         tristate
 
+config SND_SOC_DMIC
+	tristate
+
 config SND_SOC_MAX98088
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 10e5e09..9139cf9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -14,6 +14,7 @@ snd-soc-cs42l51-objs := cs42l51.o
 snd-soc-cs4270-objs := cs4270.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-da7210-objs := da7210.o
+snd-soc-dmic-objs := dmic.o
 snd-soc-l3-objs := l3.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -91,6 +92,7 @@ obj-$(CONFIG_SND_SOC_CS42L51)	+= snd-soc-cs42l51.o
 obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
+obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
new file mode 100644
index 0000000..57e9dac
--- /dev/null
+++ b/sound/soc/codecs/dmic.c
@@ -0,0 +1,81 @@
+/*
+ * dmic.c  --  SoC audio for Generic Digital MICs
+ *
+ * Author: Liam Girdwood <lrg@slimlogic.co.uk>
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
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+static struct snd_soc_dai_driver dmic_dai = {
+	.name = "dmic-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE
+			| SNDRV_PCM_FMTBIT_S24_LE
+			| SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static struct snd_soc_codec_driver soc_dmic = {};
+
+static int __devinit dmic_dev_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_dmic, &dmic_dai, 1);
+}
+
+static int __devexit dmic_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+MODULE_ALIAS("platform:dmic-codec");
+
+static struct platform_driver dmic_driver = {
+	.driver = {
+		.name = "dmic-codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = dmic_dev_probe,
+	.remove = __devexit_p(dmic_dev_remove),
+};
+
+static int __init dmic_init(void)
+{
+	return platform_driver_register(&dmic_driver);
+}
+module_init(dmic_init);
+
+static void __exit dmic_exit(void)
+{
+	platform_driver_unregister(&dmic_driver);
+}
+module_exit(dmic_exit);
+
+MODULE_DESCRIPTION("Generic DMIC driver");
+MODULE_AUTHOR("Liam Girdwood <lrg@slimlogic.co.uk>");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4

