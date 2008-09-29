From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 2/5] [RFC] ALSA ASOC Support for 5912 osk
Date: Mon, 29 Sep 2008 15:18:32 +0530
Message-ID: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:42605 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYI2Jsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:48:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2165006rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 02:48:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Adding ASOC machine driver for osk

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/Kconfig  |    8 ++
 sound/soc/omap/Makefile |    3 +-
 sound/soc/omap/osk.c    |  230 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/omap/osk.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index d7b8939..f2e6d01 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -22,3 +22,11 @@ config SND_OMAP_SOC_OVERO
 	help
 	  Say Y if you want to add support for SoC audio on the Gumstix Overo.

+config SND_OMAP_SOC_OSK
+	tristate "SoC Audio support for 5912 OSK"
+	depends on SND_OMAP_SOC && MACH_OMAP_OSK
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TLV320AIC23
+	help
+	  Say Y if you want to add support for SoC audio on 5912 OSK.
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index b96b97b..ccb3ddd 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
 snd-soc-overo-objs := overo.o
+snd-soc-osk-objs := osk.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
-
+obj-$(CONFIG_SND_OMAP_SOC_OSK) += snd-soc-osk.o
diff --git a/sound/soc/omap/osk.c b/sound/soc/omap/osk.c
new file mode 100644
index 0000000..f4dfe66
--- /dev/null
+++ b/sound/soc/omap/osk.c
@@ -0,0 +1,230 @@
+/*
+ * osk.c  --  SoC audio for 5912 OSK
+ *
+ * Copyright (C) 2008 Mistral Solutions
+ *
+ * Contact: Arun KS  <arunks@mistralsolutions.com>
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
+#include <linux/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/tlv320aic23.h"
+
+static struct clk *aic23_mclk;
+
+static int osk_startup(struct snd_pcm_substream *substream)
+{
+	return clk_enable(aic23_mclk);
+}
+
+static void osk_shutdown(struct snd_pcm_substream *substream)
+{
+	clk_disable(aic23_mclk);
+}
+
+static int osk_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int err;
+
+	/* Set codec DAI configuration */
+	err = snd_soc_dai_set_fmt(codec_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec DAI configuration\n");
+		return err;
+	}
+
+	/* Set cpu DAI configuration */
+	err = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_DSP_A |
+				  SND_SOC_DAIFMT_NB_IF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (err < 0) {
+		printk(KERN_ERR "can't set cpu DAI configuration\n");
+		return err;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000, SND_SOC_CLOCK_IN);
+
+	if (err < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return err;
+	}
+
+	return err;
+}
+
+static struct snd_soc_ops osk_ops = {
+	.startup = osk_startup,
+	.hw_params = osk_hw_params,
+	.shutdown = osk_shutdown,
+};
+
+static const struct snd_soc_dapm_widget aic23_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "LHPOUT"},
+	{"Headphone Jack", NULL, "RHPOUT"},
+
+	{"LLINEIN", NULL, "Line In"},
+	{"RLINEIN", NULL, "Line In"},
+
+	{"MICIN", NULL, "Mic Jack"},
+};
+
+static int osk_aic23_init(struct snd_soc_codec *codec)
+{
+
+	/* Add OSK specific widgets */
+	snd_soc_dapm_new_controls(codec, aic23_dapm_widgets,
+				  ARRAY_SIZE(aic23_dapm_widgets));
+
+	/* Set up OSK specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link osk_dai = {
+	.name = "TLV320AIC23",
+	.stream_name = "AIC23",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &aic23_dai,
+	.init = osk_aic23_init,
+	.ops = &osk_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_osk = {
+	.name = "5912OSK",
+	.dai_link = &osk_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device osk_snd_devdata = {
+	.machine = &snd_soc_machine_osk,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_aic23,
+};
+
+static struct platform_device *osk_snd_device;
+
+#define CODEC_CLOCK 	12000000
+
+static int __init osk_soc_init(void)
+{
+	int err;
+	u32 curRate;
+	struct device *dev;
+
+	if (!(machine_is_omap_osk()))
+		return -ENODEV;
+
+	osk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!osk_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(osk_snd_device, &osk_snd_devdata);
+	osk_snd_devdata.dev = &osk_snd_device->dev;
+	*(unsigned int *)osk_dai.cpu_dai->private_data = 0;	/* McBSP1 */
+	err = platform_device_add(osk_snd_device);
+	if (err)
+		goto err1;
+
+	dev = &osk_snd_device->dev;
+
+	aic23_mclk = clk_get(dev, "mclk");
+	if (IS_ERR(aic23_mclk)) {
+		printk(KERN_ERR "Could not get mclk clock\n");
+		return -ENODEV;
+	}
+
+	if (clk_get_usecount(aic23_mclk) > 0) {
+		/* MCLK is already in use */
+		printk(KERN_WARNING
+		       "MCLK in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(aic23_mclk), CODEC_CLOCK);
+	}
+
+	/*
+	 * Configure 12 MHz output on MCLK.
+	 */
+	curRate = (uint) clk_get_rate(aic23_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(aic23_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR "Cannot set MCLK for AIC23 CODEC\n");
+			return -ECANCELED;
+		}
+	}
+
+	printk(KERN_INFO "MCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(aic23_mclk), CODEC_CLOCK,
+	       clk_get_usecount(aic23_mclk));
+
+	return 0;
+err1:
+	clk_put(aic23_mclk);
+	platform_device_del(osk_snd_device);
+	platform_device_put(osk_snd_device);
+
+	return err;
+
+}
+
+static void __exit osk_soc_exit(void)
+{
+	platform_device_unregister(osk_snd_device);
+}
+
+module_init(osk_soc_init);
+module_exit(osk_soc_exit);
+
+MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
+MODULE_DESCRIPTION("ALSA SoC 5912 OSK");
+MODULE_LICENSE("GPL");
-- 
1.5.3.4
