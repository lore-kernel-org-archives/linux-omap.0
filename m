From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH] ASoC: Added OMAP3 EVM support in ASoC.
Date: Thu, 14 May 2009 13:59:19 +0530
Message-ID: <1242289759-6577-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>
List-Id: linux-omap@vger.kernel.org

Resending the patch after fixing the minor issues.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/Kconfig    |    8 +++
 sound/soc/omap/Makefile   |    2 +
 sound/soc/omap/omap3evm.c |  147 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap3evm.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 675732e..b771238 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -39,6 +39,14 @@ config SND_OMAP_SOC_OMAP2EVM
 	help
 	  Say Y if you want to add support for SoC audio on the omap2evm board.
 
+config SND_OMAP_SOC_OMAP3EVM
+	tristate "SoC Audio support for OMAP3EVM board"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the omap3evm board.
+
 config SND_OMAP_SOC_SDP3430
 	tristate "SoC Audio support for Texas Instruments SDP3430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 0c9e4ac..a37f498 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -10,6 +10,7 @@ snd-soc-n810-objs := n810.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
+snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
@@ -18,6 +19,7 @@ obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
+obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
new file mode 100644
index 0000000..9114c26
--- /dev/null
+++ b/sound/soc/omap/omap3evm.c
@@ -0,0 +1,147 @@
+/*
+ * omap3evm.c  -- ALSA SoC support for OMAP3 EVM
+ *
+ * Author: Anuj Aggarwal <anuj.aggarwal@ti.com>
+ *
+ * Based on sound/soc/omap/beagle.c by Steve Sakoman
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
+		printk(KERN_ERR "Can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai,
+				  SND_SOC_DAIFMT_I2S |
+				  SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0) {
+		printk(KERN_ERR "Can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "Can't set codec system clock\n");
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
+	.name 		= "TWL4030",
+	.stream_name 	= "TWL4030",
+	.cpu_dai 	= &omap_mcbsp_dai[0],
+	.codec_dai 	= &twl4030_dai[TWL4030_DAI_HIFI],
+	.ops 		= &omap3evm_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_card snd_soc_omap3evm = {
+	.name = "omap3evm",
+	.platform = &omap_soc_platform,
+	.dai_link = &omap3evm_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device omap3evm_snd_devdata = {
+	.card = &snd_soc_omap3evm,
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
+		pr_err("Not OMAP3 EVM!\n");
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
+	*(unsigned int *)omap3evm_dai.cpu_dai->private_data = 1;
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
+MODULE_LICENSE("GPLv2");
-- 
1.6.2.4
