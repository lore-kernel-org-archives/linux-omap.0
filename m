From: Daniel Toussaint <daniel@dmhome.net>
Subject: [PATCH 2/3] Initial support for Technexion Thunderboard : Asoc sound
Date: Sun, 13 Dec 2009 14:33:54 +0100
Message-ID: <4B24ED42.1090706@dmhome.net>
Reply-To: daniel@dmhome.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090603090000020705050706"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33592 "HELO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751236AbZLMNd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 08:33:58 -0500
Received: by ewy19 with SMTP id 19so2526943ewy.21
        for <linux-omap@vger.kernel.org>; Sun, 13 Dec 2009 05:33:57 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090603090000020705050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

Patches reformatted for mainline.

Daniel Toussaint



--------------090603090000020705050706
Content-Type: text/x-patch;
 name="omap3thunder_mainline_asoc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap3thunder_mainline_asoc.diff"

Signed-off-by: Daniel Toussaint <daniel.toussaint@technexion.com>
diff -Nur linux-2.6.32-pristine/sound/soc/omap/Kconfig linux-2.6.32-patched/sound/soc/omap/Kconfig
--- linux-2.6.32-pristine/sound/soc/omap/Kconfig	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32-patched/sound/soc/omap/Kconfig	2009-12-11 12:56:11.000000000 +0100
@@ -98,4 +98,11 @@
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for Soc audio on Zoom2 board.
+config SND_OMAP_SOC_OMAP3_THUNDER
+         tristate "SoC Audio support for OMAP3 Thunder"
+         depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_THUNDER
+         select SND_OMAP_SOC_MCBSP
+         select SND_SOC_TWL4030
+         help
+           Say Y if you want to add support for SoC audio on the Thunder Board.

diff -Nur linux-2.6.32-pristine/sound/soc/omap/Makefile linux-2.6.32-patched/sound/soc/omap/Makefile
--- linux-2.6.32-pristine/sound/soc/omap/Makefile	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32-patched/sound/soc/omap/Makefile	2009-12-11 12:56:11.000000000 +0100
@@ -16,6 +16,8 @@
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
+snd-soc-omap3thunder-objs := omap3thunder.o
+

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
@@ -27,3 +29,4 @@
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
+
diff -Nur linux-2.6.32-pristine/sound/soc/omap/omap3thunder.c linux-2.6.32-patched/sound/soc/omap/omap3thunder.c
--- linux-2.6.32-pristine/sound/soc/omap/omap3thunder.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.32-patched/sound/soc/omap/omap3thunder.c	2009-12-13 13:46:58.000000000 +0100
@@ -0,0 +1,162 @@
+/*
+ * omap3 audio support for Technexion Thunder boards.
+ * Modified from omap3beagle.c
+ * Daniel Toussaint <daniel.toussaint@technexion.com>
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
+static int omap3thunder_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops omap3thunder_ops = {
+	.hw_params = omap3thunder_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3thunder_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.ops = &omap3thunder_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_omap3thunder = {
+	.name = "omap3thunder",
+	.platform = &omap_soc_platform,
+	.dai_link = &omap3thunder_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3thunder_snd_devdata = {
+	.card = &snd_soc_omap3thunder,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3thunder_snd_device;
+
+static int __init omap3thunder_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap3_thunder()) {
+		pr_debug("Not OMAP3 thunder!\n");
+		return -ENODEV;
+	}
+	pr_info("OMAP3 thunder SoC init\n");
+
+	omap3thunder_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap3thunder_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap3thunder_snd_device,
+			&omap3thunder_snd_devdata);
+	omap3thunder_snd_devdata.dev = &omap3thunder_snd_device->dev;
+	/* MCBSP1 */
+	*(unsigned int *)omap3thunder_dai.cpu_dai->private_data = 1;
+
+	ret = platform_device_add(omap3thunder_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap3thunder_snd_device);
+
+	return ret;
+}
+
+static void __exit omap3thunder_soc_exit(void)
+{
+	platform_device_unregister(omap3thunder_snd_device);
+}
+
+module_init(omap3thunder_soc_init);
+module_exit(omap3thunder_soc_exit);
+
+MODULE_AUTHOR("Daniel Toussaint <daniel.toussaint@technexion.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 thunder");
+MODULE_LICENSE("GPL");

--------------090603090000020705050706--
