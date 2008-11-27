From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [alsa-devel][PATCHv2 1/1] OMAP_TWL4030 SoC Audio driver.
Date: Thu, 27 Nov 2008 20:50:57 +0800
Message-ID: <1227790257-14221-2-git-send-email-stanley.miao@windriver.com>
References: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41930 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbYK0Mou (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2008 07:44:50 -0500
In-Reply-To: <1227790257-14221-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@sirena.org.uk

Add a shared omap_twl4030 driver to avoid reduplicate code among omap drivers.
This drive also provides a extended interface for some board specific features.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 sound/soc/omap/Kconfig        |   33 ++++++++-
 sound/soc/omap/Makefile       |   16 +++--
 sound/soc/omap/omap_twl4030.c |  155 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap_twl4030.h |   48 +++++++++++++
 4 files changed, 244 insertions(+), 8 deletions(-)
 create mode 100644 sound/soc/omap/omap_twl4030.c
 create mode 100644 sound/soc/omap/omap_twl4030.h

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 1cd0176..35a17f4 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -6,6 +6,10 @@ config SND_OMAP_SOC_MCBSP
 	tristate
 	select OMAP_MCBSP
 
+config SND_OMAP_TWL4030_SPECIFIC
+	bool
+	default n
+
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810
@@ -14,6 +18,14 @@ config SND_OMAP_SOC_N810
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
 
+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
 config SND_OMAP_SOC_OSK5912
 	tristate "SoC Audio support for omap osk5912"
 	depends on SND_OMAP_SOC && MACH_OMAP_OSK
@@ -38,12 +50,27 @@ config SND_OMAP_SOC_OMAP2EVM
 	help
 	  Say Y if you want to add support for SoC audio on the omap2evm board.
 
-config SND_OMAP_SOC_SDP3430
-	tristate "SoC Audio support for Texas Instruments SDP3430"
+config SND_OMAP_SOC_OMAP3EVM
+	tristate "SoC Audio support for OMAP3EVM"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the omap3evm board.
+config SND_OMAP_SOC_3430SDP
+	tristate "SoC Audio support for OMAP 3430SDP"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
-	  Say Y if you want to add support for SoC audio on Texas Instruments SDP3430.
+	  Say Y if you want to add support for SoC audio on TI OMAP 3430SDP.
+
+config SND_OMAP_SOC_LDP
+	tristate "SoC Audio support for OMAP ZOOM SDK"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_LDP
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP ZOOM MDK.
 
 
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 29cf3a8..66785cb 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,13 +7,19 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-omap3beagle-objs := omap_twl4030.o
 snd-soc-osk5912-objs := osk5912.o
-snd-soc-overo-objs := overo.o
-snd-soc-omap2evm-objs := omap2evm.o
-snd-soc-sdp3430-objs := sdp3430.o
+snd-soc-overo-objs := omap_twl4030.o
+snd-soc-3430sdp-objs := omap_twl4030.o
+snd-soc-ldp-objs := omap_twl4030.o
+snd-soc-omap2evm-objs := omap_twl4030.o
+snd-soc-omap3evm-objs := omap_twl4030.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
-obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
-obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
+obj-$(CONFIG_SND_OMAP_SOC_3430SDP) += snd-soc-3430sdp.o
+obj-$(CONFIG_SND_OMAP_SOC_LDP) += snd-soc-ldp.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
diff --git a/sound/soc/omap/omap_twl4030.c b/sound/soc/omap/omap_twl4030.c
new file mode 100644
index 0000000..4d60217
--- /dev/null
+++ b/sound/soc/omap/omap_twl4030.c
@@ -0,0 +1,155 @@
+/*
+ * omap_twl4030.c  --  OMAP_TWL4030 SoC Audio board driver.
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
+#include "omap_twl4030.h"
+#include "../codecs/twl4030.h"
+
+static int omap_twl4030_hw_params(struct snd_pcm_substream *substream,
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
+static struct snd_soc_ops omap_twl4030_ops = {
+	.hw_params = omap_twl4030_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap_twl4030_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &omap_twl4030_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_omap_omap_twl4030 = {
+	.name = "omap_twl4030",
+	.dai_link = &omap_twl4030_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap_twl4030_snd_devdata = {
+	.machine = &snd_soc_omap_omap_twl4030,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap_twl4030_snd_device;
+struct omap_twl4030_platform_data *omap_twl4030_data;
+
+static int __init omap_twl4030_soc_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "OMAP_TWL4030 SoC audio driver init\n");
+
+	omap_twl4030_specific_init(&omap_twl4030_snd_devdata);
+	omap_twl4030_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap_twl4030_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap_twl4030_snd_device, &omap_twl4030_snd_devdata);
+	omap_twl4030_snd_devdata.dev = &omap_twl4030_snd_device->dev;
+	if(omap_twl4030_data)
+		omap_twl4030_snd_device->dev.platform_data = omap_twl4030_data->data;
+
+	ret = platform_device_add(omap_twl4030_snd_device);
+	if (ret)
+		goto err1;
+
+	if(omap_twl4030_data && omap_twl4030_data->board_init) {
+		ret = omap_twl4030_data->board_init(omap_twl4030_snd_device);
+		if (ret)
+			goto err1;
+	}
+
+	return 0;
+
+err1:
+	platform_device_put(omap_twl4030_snd_device);
+
+	return ret;
+}
+module_init(omap_twl4030_soc_init);
+
+static void __exit omap_twl4030_soc_exit(void)
+{
+	if(omap_twl4030_data && omap_twl4030_data->board_init)
+		omap_twl4030_data->board_exit();
+	platform_device_unregister(omap_twl4030_snd_device);
+}
+module_exit(omap_twl4030_soc_exit);
+
+MODULE_AUTHOR("Stanley Miao <stanley.miao@windriver.com>");
+MODULE_DESCRIPTION("OMAP_TWL4030 ALSA SoC audio driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap_twl4030.h b/sound/soc/omap/omap_twl4030.h
new file mode 100644
index 0000000..358ee42
--- /dev/null
+++ b/sound/soc/omap/omap_twl4030.h
@@ -0,0 +1,48 @@
+/*
+ * omap_twl4030.h
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
+#ifndef __OMAP_TWL4030_H__
+#define __OMAP_TWL4030_H__
+
+struct omap_twl4030_platform_data {
+	int (*board_init)(struct platform_device *);
+	void (*board_exit)(void);
+	void *data;
+};
+
+extern struct omap_twl4030_platform_data *omap_twl4030_data;
+
+#ifdef CONFIG_SND_OMAP_TWL4030_SPECIFIC
+extern void omap_twl4030_specific_init(struct snd_soc_device *);
+#else
+static inline void omap_twl4030_specific_init(struct snd_soc_device *snd_dev)
+{
+	if(snd_dev == NULL)
+		return;
+	/* McBSP2 */
+	*(unsigned int *)snd_dev->machine->dai_link->cpu_dai->private_data = 1;
+	omap_twl4030_data = NULL;
+}
+#endif
+
+#endif
-- 
1.5.6.3

