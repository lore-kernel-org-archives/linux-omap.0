From: mesak82@gmail.com
Subject: [PATCH] ALSA: SoC: Add support for TI SDP3430
Date: Mon, 24 Nov 2008 13:18:53 -0600
Message-ID: <1227554333-12384-1-git-send-email-mesak82@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55991 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbYKXTTE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 14:19:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: pandita@ti.com, Misael Lopez Cruz <mesak82@gmail.com>

From: Misael Lopez Cruz <mesak82@gmail.com>

This patch add ASoC support for TI SDP3430. It's based on Gumstix
Overo SoC code by Steve Sakoman.

Signed-off-by: Misael Lopez Cruz <mesak82@gmail.com>
---
 sound/soc/omap/Kconfig   |    7 ++
 sound/soc/omap/Makefile  |    2 +
 sound/soc/omap/sdp3430.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/sdp3430.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 0daeee4..e816fa4 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -38,4 +38,11 @@ config SND_OMAP_SOC_OVERO
 	help
 	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
 
+config SND_OMAP_SOC_SDP3430
+	tristate "SoC Audio support for Texas Instruments SDP3430"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on Texas Instruments SDP3430.
 
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 4bae404..64e560b 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -10,9 +10,11 @@ snd-soc-n810-objs := n810.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
+snd-soc-sdp3430-objs := sdp3430.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
new file mode 100644
index 0000000..85fd160
--- /dev/null
+++ b/sound/soc/omap/sdp3430.c
@@ -0,0 +1,152 @@
+/*
+ * sdp3430.c  --  SoC audio for TI OMAP3430 SDP
+ *
+ * Author: Misael Lopez Cruz <x0052729@ti.com>
+ *
+ * Based on:
+ * Author: Steve Sakoman <steve@sakoman.com>
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
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int sdp3430_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops sdp3430_ops = {
+	.hw_params = sdp3430_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sdp3430_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &sdp3430_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_sdp3430 = {
+	.name = "SDP3430",
+	.dai_link = &sdp3430_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device sdp3430_snd_devdata = {
+	.machine = &snd_soc_machine_sdp3430,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *sdp3430_snd_device;
+
+static int __init sdp3430_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap_3430sdp()) {
+		pr_debug("Not SDP3430!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "SDP3430 SoC init\n");
+
+	sdp3430_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!sdp3430_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(sdp3430_snd_device, &sdp3430_snd_devdata);
+	sdp3430_snd_devdata.dev = &sdp3430_snd_device->dev;
+	*(unsigned int *)sdp3430_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(sdp3430_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(sdp3430_snd_device);
+
+	return ret;
+}
+module_init(sdp3430_soc_init);
+
+static void __exit sdp3430_soc_exit(void)
+{
+	platform_device_unregister(sdp3430_snd_device);
+}
+module_exit(sdp3430_soc_exit);
+
+MODULE_AUTHOR("Misael Lopez Cruz <x0052729@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC SDP3430");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.3

