From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 2/5 v1] Adds ASOC Support for 5912osk
Date: Tue, 30 Sep 2008 15:31:47 +0530
Message-ID: <dfeb90390809300301x464d9411r5fabb9b9b64e73a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:36953 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYI3KBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:01:49 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2787751rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 03:01:49 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Adding ASOC machine driver for 5912osk

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/5912osk.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/Kconfig   |    8 ++
 sound/soc/omap/Makefile  |    2 +
 3 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/5912osk.c

diff --git a/sound/soc/omap/5912osk.c b/sound/soc/omap/5912osk.c
new file mode 100644
index 0000000..30932a1
--- /dev/null
+++ b/sound/soc/omap/5912osk.c
@@ -0,0 +1,232 @@
+/*
+ * 5912osk.c  --  SoC audio for 5912 OSK
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
+#define CODEC_CLOCK 	12000000
+
+static struct clk *tlv320aic23_mclk;
+
+static int osk_startup(struct snd_pcm_substream *substream)
+{
+	return clk_enable(tlv320aic23_mclk);
+}
+
+static void osk_shutdown(struct snd_pcm_substream *substream)
+{
+	clk_disable(tlv320aic23_mclk);
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
+	err =
+	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
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
+static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
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
+static int osk_tlv320aic23_init(struct snd_soc_codec *codec)
+{
+
+	/* Add 5912osk specific widgets */
+	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
+				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
+
+	/* Set up 5912osk specific audio path audio_map */
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
+	.codec_dai = &tlv320aic23_dai,
+	.init = osk_tlv320aic23_init,
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
+	.codec_dev = &soc_codec_dev_tlv320aic23,
+};
+
+static struct platform_device *osk_snd_device;
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
+	tlv320aic23_mclk = clk_get(dev, "mclk");
+	if (IS_ERR(tlv320aic23_mclk)) {
+		printk(KERN_ERR "Could not get mclk clock\n");
+		return -ENODEV;
+	}
+
+	if (clk_get_usecount(tlv320aic23_mclk) > 0) {
+		/* MCLK is already in use */
+		printk(KERN_WARNING
+		       "MCLK in use at %d Hz. We change it to %d Hz\n",
+		       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK);
+	}
+
+	/*
+	 * Configure 12 MHz output on MCLK.
+	 */
+	curRate = (uint) clk_get_rate(tlv320aic23_mclk);
+	if (curRate != CODEC_CLOCK) {
+		if (clk_set_rate(tlv320aic23_mclk, CODEC_CLOCK)) {
+			printk(KERN_ERR "Cannot set MCLK for AIC23 CODEC\n");
+			err = -ECANCELED;
+			goto err1;
+		}
+	}
+
+	printk(KERN_INFO "MCLK = %d [%d], usecount = %d\n",
+	       (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK,
+	       clk_get_usecount(tlv320aic23_mclk));
+
+	return 0;
+err1:
+	clk_put(tlv320aic23_mclk);
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
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index aea27e7..fc946bc 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -13,3 +13,11 @@ config SND_OMAP_SOC_N810
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
+
+config SND_OMAP_SOC_5912OSK
+	tristate "SoC Audio support for omap 5912osk"
+	depends on SND_OMAP_SOC && MACH_OMAP_OSK
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TLV320AIC23
+	help
+	  Say Y if you want to add support for SoC audio on 5912osk.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index d8d8d58..d4f62fc 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,5 +7,7 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o

 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-5912osk-objs := 5912osk.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_5912OSK) += snd-soc-5912osk.o
-- 
1.5.3.4
