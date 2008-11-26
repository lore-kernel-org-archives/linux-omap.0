From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH] OMAP general SOC driver.
Date: Wed, 26 Nov 2008 18:47:58 +0800
Message-ID: <1227696478-8354-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45469 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbYKZKl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 05:41:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk

Add a shared omap SoC driver to avoid reduplicate code among omap soc drivers.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 sound/soc/omap/Kconfig        |   49 +++++++++++++
 sound/soc/omap/Makefile       |   13 ++++
 sound/soc/omap/omap-general.c |  155 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-general.h |   70 ++++++++++++++++++
 4 files changed, 287 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap-general.c
 create mode 100644 sound/soc/omap/omap-general.h

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 8b7766b..92a557f 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -14,6 +14,14 @@ config SND_OMAP_SOC_N810
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
 
+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
 	depends on SND_OMAP_SOC && MACH_OMAP_OSK
@@ -21,3 +29,44 @@ config SND_OMAP_SOC_OSK5912
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
+
+config SND_OMAP_SOC_OVERO
+	tristate "SoC Audio support for Gumstix Overo"
+	depends on SND_OMAP_SOC && MACH_OVERO
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
+
+config SND_OMAP_SOC_3430SDP
+	tristate "SoC Audio support for OMAP 3430SDP"
+	depends on SND_OMAP_SOC && MACH_OMAP_3430SDP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP 3430SDP.
+
+config SND_OMAP_SOC_LDP
+	tristate "SoC Audio support for OMAP ZOOM SDK"
+	depends on SND_OMAP_SOC && MACH_OMAP_LDP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP ZOOM MDK.
+
+config SND_OMAP_SOC_OMAP2EVM
+	tristate "SoC Audio support for OMAP2EVM"
+	depends on SND_OMAP_SOC && MACH_OMAP2EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP2EVM.
+
+config SND_OMAP_SOC_OMAP3EVM
+	tristate "SoC Audio support for OMAP3EVM"
+	depends on SND_OMAP_SOC && MACH_OMAP3EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP3EVM.
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index e09d1f2..de9163b 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,7 +7,20 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-omap3beagle-objs := omap-general.o
 snd-soc-osk5912-objs := osk5912.o
+snd-soc-overo-objs := omap-general.o
+snd-soc-3430sdp-objs := omap-general.o
+snd-soc-ldp-objs := omap-general.o
+snd-soc-omap2evm-objs := omap-general.o
+snd-soc-omap3evm-objs := omap-general.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
+obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+obj-$(CONFIG_SND_OMAP_SOC_3430SDP) += snd-soc-3430sdp.o
+obj-$(CONFIG_SND_OMAP_SOC_LDP) += snd-soc-ldp.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
+
diff --git a/sound/soc/omap/omap-general.c b/sound/soc/omap/omap-general.c
new file mode 100644
index 0000000..a3fa647
--- /dev/null
+++ b/sound/soc/omap/omap-general.c
@@ -0,0 +1,155 @@
+/*
+ * omap-general.c  --  OMAP SoC general machine file.
+ *
+ * Author: Stanley Miao <stanley.miao@windriver.com>
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
+#include "omap-general.h"
+
+static int general_hw_params(struct snd_pcm_substream *substream,
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
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_SYS_CLOCK,
+					    SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops general_ops = {
+	.startup = SOC_OPS_STARTUP,
+	.shutdown = SOC_OPS_SHUTDOWN,
+	.hw_params = general_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link general_dai = {
+	.name = CODEC_NAME,
+	.stream_name = STREAM_NAME,
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = CODEC_DAI,
+	.ops = &general_ops,
+	.init = DAI_LINK_INIT,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_omap_general = {
+	.name = "omap_general",
+	.dai_link = &general_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device general_snd_devdata = {
+	.machine = &snd_soc_omap_general,
+	.platform = &omap_soc_platform,
+	.codec_dev = CODEC_DEV,
+	.codec_data = CODEC_SETUP_DATA,
+};
+
+static struct platform_device *general_snd_device;
+
+static int __init general_soc_init(void)
+{
+	int ret;
+
+	if (!MACHINE_IS_OMAP_GENERAL) {
+		pr_debug("Not supported board!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "OMAP General SoC init\n");
+
+	general_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!general_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(general_snd_device, &general_snd_devdata);
+	general_snd_devdata.dev = &general_snd_device->dev;
+	*(unsigned int *)general_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(general_snd_device);
+	if (ret)
+		goto err1;
+	ret = omap_board_soc_init(general_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	platform_device_put(general_snd_device);
+
+	return ret;
+}
+module_init(general_soc_init);
+
+static void __exit general_soc_exit(void)
+{
+	omap_board_soc_exit(general_snd_device);
+	platform_device_unregister(general_snd_device);
+}
+module_exit(general_soc_exit);
+
+MODULE_AUTHOR("Stanley Miao <stanley.miao@windriver.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP GENERAL");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-general.h b/sound/soc/omap/omap-general.h
new file mode 100644
index 0000000..8b9515c
--- /dev/null
+++ b/sound/soc/omap/omap-general.h
@@ -0,0 +1,70 @@
+/*
+ * omap-general.h
+ *
+ * Copyright (C) 2008 Wind River Systems, Inc.
+ *
+ * Author: Stanley Miao <stanley.miao@windriver.com>
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
+#ifdef CONFIG_SND_OMAP_SOC_N810
+#include "../codecs/tlv320aic3x.h"
+#define CODEC_SYS_CLOCK		12000000
+#define CODEC_NAME		"TLV320AIC33"
+#define STREAM_NAME		"AIC33"
+#define CODEC_DEV		(&soc_codec_dev_aic3x)
+#define CODEC_DAI		(&aic3x_dai)
+#define CODEC_SETUP_DATA	(&&n810_aic33_setup)
+#define DAI_LINK_INIT		(n810_aic33_init)
+#define SOC_OPS_STARTUP		(n810_startup)
+#define SOC_OPS_SHUTDOWN	(n810_shutdown)
+#else
+#include "../codecs/twl4030.h"
+#define CODEC_SYS_CLOCK		26000000
+#define CODEC_NAME		"TWL4030"
+#define STREAM_NAME		"TWL4030"
+#define CODEC_DEV		(&soc_codec_dev_twl4030)
+#define CODEC_DAI		(&twl4030_dai)
+#define CODEC_SETUP_DATA 	NULL
+#define DAI_LINK_INIT		NULL
+#define SOC_OPS_STARTUP		NULL
+#define SOC_OPS_SHUTDOWN	NULL
+#endif /* CONFIG_SND_OMAP_SOC_N810 */
+
+#ifdef CONFIG_SND_OMAP_SOC_N810
+#define MACHINE_IS_OMAP_GENERAL (machine_is_nokia_n810() || machine_is_nokia_n810_wimax())
+#elif defined(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE)
+#define MACHINE_IS_OMAP_GENERAL machine_is_omap3_beagle()
+#elif defined(CONFIG_SND_OMAP_SOC_OVERO)
+#define MACHINE_IS_OMAP_GENERAL machine_is_overo()
+#elif defined(CONFIG_SND_OMAP_SOC_3430SDP)
+#define MACHINE_IS_OMAP_GENERAL machine_is_omap_3430sdp()
+#elif defined(CONFIG_SND_OMAP_SOC_LDP)
+#define MACHINE_IS_OMAP_GENERAL machine_is_omap_ldp()
+#elif defined(CONFIG_SND_OMAP_SOC_OMAP2EVM)
+#define MACHINE_IS_OMAP_GENERAL machine_is_omap2evm()
+#elif defined(CONFIG_SND_OMAP_SOC_OMAP3EVM)
+#define MACHINE_IS_OMAP_GENERAL machine_is_omapevm()
+#endif
+
+#ifndef omap_board_soc_init
+#define omap_board_soc_init(x) 0
+#endif
+#ifndef omap_board_soc_exit
+#define omap_board_soc_exit
+#endif
+
-- 
1.5.6.3

