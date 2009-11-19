From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 6/8] AI TB: Audio driver of Always Innovating OMAP3-based
 Touch Book
Date: Wed, 18 Nov 2009 18:57:59 -0800
Message-ID: <1258599479.8001.37.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-PeKNApWMNzEFfot32AT+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:57673 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758016AbZKSC54 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 21:57:56 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so1677303gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 18:58:02 -0800 (PST)
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


--=-PeKNApWMNzEFfot32AT+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
sound/soc/omap/Kconfig          |    8 ++
sound/soc/omap/Makefile         |    2 +
sound/soc/omap/omap3touchbook.c |  211
+++++++++++++++++++++++++++++++++++++++
3 files changed, 221 insertions(+), 0 deletions(-)
create mode 100644 sound/soc/omap/omap3touchbook.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 653a362..c590252 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -83,6 +83,14 @@ config SND_OMAP_SOC_OMAP3_PANDORA
help
  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.

+config SND_OMAP_SOC_OMAP3_TOUCHBOOK
+ tristate "SoC Audio support for OMAP3 Touch Book"
+ depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_TOUCHBOOK
+ select SND_OMAP_SOC_MCBSP
+ select SND_SOC_TWL4030
+ help
+   Say Y if you want to add support for SoC audio on the OMAP3 Touch
Book.
+
config SND_OMAP_SOC_OMAP3_BEAGLE
tristate "SoC Audio support for OMAP3 Beagle"
depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..f360b82 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -15,6 +15,7 @@ snd-soc-omap3evm-objs := omap3evm.o
snd-soc-sdp3430-objs := sdp3430.o
snd-soc-omap3pandora-objs := omap3pandora.o
snd-soc-omap3beagle-objs := omap3beagle.o
+snd-soc-omap3touchbook-objs := omap3touchbook.o
snd-soc-zoom2-objs := zoom2.o

obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_TOUCHBOOK) += snd-soc-omap3touchbook.o
obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/omap3touchbook.c
b/sound/soc/omap/omap3touchbook.c
new file mode 100644
index 0000000..584f07d
--- /dev/null
+++ b/sound/soc/omap/omap3touchbook.c
@@ -0,0 +1,211 @@
+/*
+ * omap3touchbook.c  --  SoC audio for OMAP3 Touch Book
+ *
+ * Author: Gregoire Gentil <gregoire@gentil.com>
+ *
+ * Derived from sound/soc/omap/omap3beagle.c
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
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
+#define TB_HEADPHONE_GPIO 56
+#define TB_HEADPHONE_IRQ  OMAP_GPIO_IRQ(TB_HEADPHONE_GPIO)
+
+static int omap3touchbook_hw_params(struct snd_pcm_substream
*substream,
+ struct snd_pcm_hw_params *params)
+{
+ struct snd_soc_pcm_runtime *rtd = substream->private_data;
+ struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+ struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+ unsigned int fmt;
+ int ret;
+
+ switch (params_channels(params)) {
+ case 2: /* Stereo I2S mode */
+ fmt = SND_SOC_DAIFMT_I2S |
+ SND_SOC_DAIFMT_NB_NF |
+ SND_SOC_DAIFMT_CBM_CFM;
+ break;
+ case 4: /* Four channel TDM mode */
+ fmt = SND_SOC_DAIFMT_DSP_A |
+ SND_SOC_DAIFMT_IB_NF |
+ SND_SOC_DAIFMT_CBM_CFM;
+ break;
+ default:
+ return -EINVAL;
+ }
+
+ /* Set codec DAI configuration */
+ ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+ if (ret < 0) {
+ printk(KERN_ERR "can't set codec DAI configuration\n");
+ return ret;
+ }
+
+ /* Set cpu DAI configuration */
+ ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+ if (ret < 0) {
+ printk(KERN_ERR "can't set cpu DAI configuration\n");
+ return ret;
+ }
+
+ /* Set the codec system clock for DAC and ADC */
+ ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+      SND_SOC_CLOCK_IN);
+ if (ret < 0) {
+ printk(KERN_ERR "can't set codec system clock\n");
+ return ret;
+ }
+
+ return 0;
+}
+
+static struct snd_soc_ops omap3touchbook_ops = {
+ .hw_params = omap3touchbook_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3touchbook_dai = {
+ .name = "TWL4030",
+ .stream_name = "TWL4030",
+ .cpu_dai = &omap_mcbsp_dai[0],
+ .codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+ .ops = &omap3touchbook_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_omap3touchbook = {
+ .name = "omap3touchbook",
+ .platform = &omap_soc_platform,
+ .dai_link = &omap3touchbook_dai,
+ .num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3touchbook_snd_devdata = {
+ .card = &snd_soc_omap3touchbook,
+ .codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3touchbook_snd_device;
+
+static void jack_work_func(struct work_struct *wq)
+{
+ struct snd_soc_device *socdev = platform_get_drvdata(
+ omap3touchbook_snd_device);
+ struct snd_soc_codec *codec = socdev->card->codec;
+
+ snd_soc_dapm_sync(codec);
+}
+DECLARE_WORK(jack_work, jack_work_func);
+
+static irqreturn_t touchbook_headphone_event(int irq, void *snd)
+{
+ int status = gpio_get_value(TB_HEADPHONE_GPIO);
+ struct snd_soc_device *socdev = platform_get_drvdata(
+ omap3touchbook_snd_device);
+ struct snd_soc_codec *codec = socdev->card->codec;
+
+ if (status) {
+ snd_soc_dapm_disable_pin(codec, "HFL");
+ snd_soc_dapm_disable_pin(codec, "HFR");
+ } else {
+ snd_soc_dapm_enable_pin(codec, "HFL");
+ snd_soc_dapm_enable_pin(codec, "HFR");
+ }
+
+ schedule_work(&jack_work);
+ return IRQ_HANDLED;
+}
+
+static int __init omap3touchbook_soc_init(void)
+{
+ int ret;
+
+ if (!machine_is_touchbook()) {
+ pr_debug("Not OMAP3 Touch Book!\n");
+ return -ENODEV;
+ }
+ pr_info("OMAP3 Touch Book SoC init\n");
+
+ omap3touchbook_snd_device = platform_device_alloc("soc-audio", -1);
+ if (!omap3touchbook_snd_device) {
+ printk(KERN_ERR "Platform device allocation failed\n");
+ return -ENOMEM;
+ }
+
+ platform_set_drvdata(omap3touchbook_snd_device,
+ &omap3touchbook_snd_devdata);
+ omap3touchbook_snd_devdata.dev = &omap3touchbook_snd_device->dev;
+ *(unsigned int *)omap3touchbook_dai.cpu_dai->private_data = 1;
+
+ /* Touch Book -- headphone jack sensor */
+ omap_set_gpio_debounce(TB_HEADPHONE_GPIO, 1);
+ omap_set_gpio_debounce_time(TB_HEADPHONE_GPIO, 0xff);
+
+ ret = request_irq(TB_HEADPHONE_IRQ, touchbook_headphone_event,
+ IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+ "touchbook_headphone",
+ omap3touchbook_snd_device);
+ if (ret < 0)
+ goto err1;
+
+ ret = platform_device_add(omap3touchbook_snd_device);
+ if (ret)
+ goto err1;
+
+ /* Detect headphone status */
+ touchbook_headphone_event(0, omap3touchbook_snd_device);
+
+ return 0;
+
+err1:
+ printk(KERN_ERR "Unable to add platform device\n");
+ platform_device_put(omap3touchbook_snd_device);
+
+ return ret;
+}
+
+static void __exit omap3touchbook_soc_exit(void)
+{
+ platform_device_unregister(omap3touchbook_snd_device);
+}
+
+module_init(omap3touchbook_soc_init);
+module_exit(omap3touchbook_soc_exit);
+
+MODULE_AUTHOR("Gregoire Gentil <gregoire@gentil.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 Touch Book");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4



--=-PeKNApWMNzEFfot32AT+
Content-Disposition: attachment; filename*0=0006-Audio-driver-of-Always-Innovating-OMAP3-based-Touch.patc; filename*1=h
Content-Type: text/x-patch; name="0006-Audio-driver-of-Always-Innovating-OMAP3-based-Touch.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 6fdbeddabe5d368071fbc0c272302afe98580f55 Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:33:55 -0800
Subject: [PATCH] Audio driver of Always Innovating OMAP3-based Touch Book


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 sound/soc/omap/Kconfig          |    8 ++
 sound/soc/omap/Makefile         |    2 +
 sound/soc/omap/omap3touchbook.c |  211 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3touchbook.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 653a362..c590252 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -83,6 +83,14 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
 
+config SND_OMAP_SOC_OMAP3_TOUCHBOOK
+	tristate "SoC Audio support for OMAP3 Touch Book"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_TOUCHBOOK
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP3 Touch Book.
+
 config SND_OMAP_SOC_OMAP3_BEAGLE
 	tristate "SoC Audio support for OMAP3 Beagle"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..f360b82 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -15,6 +15,7 @@ snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
+snd-soc-omap3touchbook-objs := omap3touchbook.o
 snd-soc-zoom2-objs := zoom2.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
@@ -26,4 +27,5 @@ obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_TOUCHBOOK) += snd-soc-omap3touchbook.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/omap3touchbook.c b/sound/soc/omap/omap3touchbook.c
new file mode 100644
index 0000000..584f07d
--- /dev/null
+++ b/sound/soc/omap/omap3touchbook.c
@@ -0,0 +1,211 @@
+/*
+ * omap3touchbook.c  --  SoC audio for OMAP3 Touch Book
+ *
+ * Author: Gregoire Gentil <gregoire@gentil.com>
+ *
+ * Derived from sound/soc/omap/omap3beagle.c
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
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
+#define TB_HEADPHONE_GPIO 56
+#define TB_HEADPHONE_IRQ  OMAP_GPIO_IRQ(TB_HEADPHONE_GPIO)
+
+static int omap3touchbook_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops omap3touchbook_ops = {
+	.hw_params = omap3touchbook_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3touchbook_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai[TWL4030_DAI_HIFI],
+	.ops = &omap3touchbook_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_omap3touchbook = {
+	.name = "omap3touchbook",
+	.platform = &omap_soc_platform,
+	.dai_link = &omap3touchbook_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3touchbook_snd_devdata = {
+	.card = &snd_soc_omap3touchbook,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3touchbook_snd_device;
+
+static void jack_work_func(struct work_struct *wq)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(
+						omap3touchbook_snd_device);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	snd_soc_dapm_sync(codec);
+}
+DECLARE_WORK(jack_work, jack_work_func);
+
+static irqreturn_t touchbook_headphone_event(int irq, void *snd)
+{
+	int status = gpio_get_value(TB_HEADPHONE_GPIO);
+	struct snd_soc_device *socdev = platform_get_drvdata(
+						omap3touchbook_snd_device);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	if (status) {
+		snd_soc_dapm_disable_pin(codec, "HFL");
+		snd_soc_dapm_disable_pin(codec, "HFR");
+	} else {
+		snd_soc_dapm_enable_pin(codec, "HFL");
+		snd_soc_dapm_enable_pin(codec, "HFR");
+	}
+
+	schedule_work(&jack_work);
+	return IRQ_HANDLED;
+}
+
+static int __init omap3touchbook_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_touchbook()) {
+		pr_debug("Not OMAP3 Touch Book!\n");
+		return -ENODEV;
+	}
+	pr_info("OMAP3 Touch Book SoC init\n");
+
+	omap3touchbook_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap3touchbook_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap3touchbook_snd_device,
+				&omap3touchbook_snd_devdata);
+	omap3touchbook_snd_devdata.dev = &omap3touchbook_snd_device->dev;
+	*(unsigned int *)omap3touchbook_dai.cpu_dai->private_data = 1;
+
+	/* Touch Book -- headphone jack sensor */
+	omap_set_gpio_debounce(TB_HEADPHONE_GPIO, 1);
+	omap_set_gpio_debounce_time(TB_HEADPHONE_GPIO, 0xff);
+
+	ret = request_irq(TB_HEADPHONE_IRQ, touchbook_headphone_event,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"touchbook_headphone",
+				omap3touchbook_snd_device);
+	if (ret < 0)
+		goto err1;
+
+	ret = platform_device_add(omap3touchbook_snd_device);
+	if (ret)
+		goto err1;
+
+	/* Detect headphone status */
+	touchbook_headphone_event(0, omap3touchbook_snd_device);
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap3touchbook_snd_device);
+
+	return ret;
+}
+
+static void __exit omap3touchbook_soc_exit(void)
+{
+	platform_device_unregister(omap3touchbook_snd_device);
+}
+
+module_init(omap3touchbook_soc_init);
+module_exit(omap3touchbook_soc_exit);
+
+MODULE_AUTHOR("Gregoire Gentil <gregoire@gentil.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 Touch Book");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4


--=-PeKNApWMNzEFfot32AT+
Content-Disposition: attachment; filename*0=0006-Audio-driver-of-Always-Innovating-OMAP3-based-Touch.patc; filename*1=h.zip
Content-Type: application/zip; name*0=0006-Audio-driver-of-Always-Innovating-OMAP3-based-Touch.patch.zi; name*1=p
Content-Transfer-Encoding: base64

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


--=-PeKNApWMNzEFfot32AT+--

