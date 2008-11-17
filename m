From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] ALSA: ASoC: Add support for OMAP3 EVM
Date: Mon, 17 Nov 2008 12:25:49 +0530
Message-ID: <1226904949-32255-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYKQGz7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2008 01:55:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAH6tq9H032449
	for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2008 00:55:58 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>


Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/Kconfig    |    8 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3evm.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 8b7766b..9255c6a 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -21,3 +21,11 @@ config SND_OMAP_SOC_OSK5912
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
+
+config SND_OMAP_SOC_OMAP3EVM
+	tristate "SoC Audio support for OMAP3 EVM"
+	depends on SND_OMAP_SOC && MACH_OMAP3EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP3 EVM.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index e09d1f2..8633c3a 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -8,6 +8,8 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
+snd-soc-omap3evm-objs := omap3evm.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
new file mode 100644
index 0000000..6bef466
--- /dev/null
+++ b/sound/soc/omap/omap3evm.c
@@ -0,0 +1,147 @@
+/*
+ * omap3evm.c
+ *
+ * ALSA SoC support for OMAP3 EVM.
+ *
+ * Author: Anuj Aggarwal <anuj.aggarwal@ti.com>
+ *
+ * Copyright (C) 2008 Texas Instruments, Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
+ * whether express or implied; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
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
+static int omap3evm_hw_params(struct snd_pcm_substream *substream,
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
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops omap3evm_ops = {
+	.hw_params = omap3evm_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link omap3evm_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &omap3evm_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_omap3evm = {
+	.name = "omap3evm",
+	.dai_link = &omap3evm_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3evm_snd_devdata = {
+	.machine = &snd_soc_machine_omap3evm,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *omap3evm_snd_device;
+
+static int __init omap3evm_soc_init(void)
+{
+	int ret;
+
+	if (!machine_is_omap3evm()) {
+		pr_debug("Not OMAP3 EVM!\n");
+		return -ENODEV;
+	}
+	pr_info("OMAP3 EVM SoC init\n");
+
+	omap3evm_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!omap3evm_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(omap3evm_snd_device, &omap3evm_snd_devdata);
+	omap3evm_snd_devdata.dev = &omap3evm_snd_device->dev;
+	*(unsigned int *)omap3evm_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(omap3evm_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(omap3evm_snd_device);
+
+	return ret;
+}
+
+static void __exit omap3evm_soc_exit(void)
+{
+	platform_device_unregister(omap3evm_snd_device);
+}
+
+module_init(omap3evm_soc_init);
+module_exit(omap3evm_soc_exit);
+
+MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
+MODULE_DESCRIPTION("ALSA SoC OMAP3 EVM");
+MODULE_LICENSE("GPL");
-- 
1.5.6

