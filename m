From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH (for-next 2)] ASoC: Add support for IGEP v2
Date: Wed, 18 Nov 2009 10:35:29 +0100
Message-ID: <1258536929-2392-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:64339 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738AbZKRJfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 04:35:18 -0500
Received: by fxm21 with SMTP id 21so931950fxm.21
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 01:35:22 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 sound/soc/omap/Kconfig    |    7 ++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/igep0020.c |  148 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/igep0020.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 653a362..5cc8a63 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -99,3 +99,10 @@ config SND_OMAP_SOC_ZOOM2
 	help
 	  Say Y if you want to add support for Soc audio on Zoom2 board.
 
+config SND_OMAP_SOC_IGEP0020
+	tristate "SoC Audio support for IGEP v2"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_IGEP0020
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for Soc audio on IGEP v2 board.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..d4ed23a 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -16,6 +16,7 @@ snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
+snd-soc-igep0020-objs := igep0020.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
@@ -27,3 +28,4 @@ obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
+obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
new file mode 100644
index 0000000..3583c42
--- /dev/null
+++ b/sound/soc/omap/igep0020.c
@@ -0,0 +1,148 @@
+/*
+ * igep0020.c  --  SoC audio for IGEP v2
+ *
+ * Based on sound/soc/omap/overo.c by Steve Sakoman
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
+#include <mach/gpio.h>
+#include <plat/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int igep2_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops igep2_ops = {
+	.hw_params = igep2_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link igep2_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.ops = &igep2_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_card_igep2 = {
+	.name = "igep2",
+	.platform = &omap_soc_platform,
+	.dai_link = &igep2_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device igep2_snd_devdata = {
+	.card = &snd_soc_card_igep2,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *igep2_snd_device;
+
+static int __init igep2_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_igep0020()) {
+		pr_debug("Not IGEP v2!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "IGEP v2 SoC init\n");
+
+	igep2_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!igep2_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(igep2_snd_device, &igep2_snd_devdata);
+	igep2_snd_devdata.dev = &igep2_snd_device->dev;
+	*(unsigned int *)igep2_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(igep2_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(igep2_snd_device);
+
+	return ret;
+}
+module_init(igep2_soc_init);
+
+static void __exit igep2_soc_exit(void)
+{
+	platform_device_unregister(igep2_snd_device);
+}
+module_exit(igep2_soc_exit);
+
+MODULE_AUTHOR("Enric Balletbo i Serra <eballetbo@iseebcn.com>");
+MODULE_DESCRIPTION("ALSA SoC IGEP v2");
+MODULE_LICENSE("GPL");
-- 
1.5.4.3

