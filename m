From: Kim Botherway <kbotherway@djdvant.com>
Subject: [PATCH 4/4] Add ASoC support for DEVKIT8000
Date: Thu, 12 Nov 2009 21:24:43 +1100
Message-ID: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out3.iinet.net.au ([203.59.1.148]:12921
	"EHLO outbound.icp-qv1-irony-out3.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528AbZKLKYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Nov 2009 05:24:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@vger.kernel.org
Cc: linux-omap@vger.kernel.org

This patch add support for DEVKIT8000, it is a copy of Beagleboard sound
driver

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 653a362..8cdcfe9 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -91,6 +91,14 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
 	help
 	  Say Y if you want to add support for SoC audio on the Beagleboard.
 
+config SND_OMAP_SOC_OMAP3_DEVKIT8000
+        tristate "SoC Audio support for OMAP3 DEVKIT8000"
+        depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_DEVKIT8000
+        select SND_OMAP_SOC_MCBSP
+        select SND_SOC_TWL4030
+        help
+          Say Y if you want to add support for SoC audio on the
DEVKIT8000.
+
 config SND_OMAP_SOC_ZOOM2
 	tristate "SoC Audio support for Zoom2"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2

diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..7239737 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -15,6 +15,7 @@ snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
+snd-soc-omap3devkit8000-objs := omap3devkit8000.o
 snd-soc-zoom2-objs := zoom2.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_DEVKIT8000) += snd-soc-omap3devkit8000.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o

diff --git a/sound/soc/omap/omap3devkit8000.c
b/sound/soc/omap/omap3devkit8000.c
new file mode 100644
index 0000000..6a975d4
--- /dev/null
+++ b/sound/soc/omap/omap3devkit8000.c
@@ -0,0 +1,154 @@
+/*
+ * omap3devkit8000.c  --  SoC audio for OMAP3 Beagle
+ *
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
+#include <plat/hardware.h>
+#include <plat/gpio.h>
+#include <plat/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int omap3devkit8000_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
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
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap3devkit8000_ops = {
+	.hw_params = omap3devkit8000_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3devkit8000_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.ops = &omap3devkit8000_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_omap3devkit8000 = {
+	.name = "omap3devkit8000",
+	.platform = &omap_soc_platform,
+	.dai_link = &omap3devkit8000_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3devkit8000_snd_devdata = {
+	.card = &snd_soc_omap3devkit8000,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3devkit8000_snd_device;
+
+static int __init omap3devkit8000_soc_init(void)
+{
+	int ret;
+	pr_info("OMAP3 omap3devkit8000 SoC init\n");
+
+	omap3devkit8000_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap3devkit8000_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap3devkit8000_snd_device,
&omap3devkit8000_snd_devdata);
+	omap3devkit8000_snd_devdata.dev = &omap3devkit8000_snd_device->dev;
+	*(unsigned int *)omap3devkit8000_dai.cpu_dai->private_data = 1; /* McBSP2
*/
+
+	ret = platform_device_add(omap3devkit8000_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap3devkit8000_snd_device);
+
+	return ret;
+}
+
+static void __exit omap3devkit8000_soc_exit(void)
+{
+	platform_device_unregister(omap3devkit8000_snd_device);
+}
+
+module_init(omap3devkit8000_soc_init);
+module_exit(omap3devkit8000_soc_exit);
+
+MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 DEVKIT8000");
+MODULE_LICENSE("GPL");
