From: sakoman@gmail.com
Subject: [PATCH 4/5] SOUND: SOC: OMAP: Add support for Gumstix Overo
Date: Wed,  3 Sep 2008 22:01:59 -0700
Message-ID: <1220504520-6067-5-git-send-email-sakoman@gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
 <1220504520-6067-2-git-send-email-sakoman@gmail.com>
 <1220504520-6067-3-git-send-email-sakoman@gmail.com>
 <1220504520-6067-4-git-send-email-sakoman@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from static-74-41-60-154.dsl1.pco.ca.frontiernet.net ([74.41.60.154]:54662
	"EHLO tera.sakoman.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbYIDFCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 01:02:15 -0400
In-Reply-To: <1220504520-6067-4-git-send-email-sakoman@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Steve Sakoman <steve@sakoman.com>

From: Steve Sakoman <steve@sakoman.com>

---
 sound/soc/omap/Kconfig  |    9 +++
 sound/soc/omap/Makefile |    3 +
 sound/soc/omap/overo.c  |  149 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/overo.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index aea27e7..d7b8939 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -13,3 +13,12 @@ config SND_OMAP_SOC_N810
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on Nokia N810.
+
+config SND_OMAP_SOC_OVERO
+	tristate "SoC Audio support for Gumstix Overo"
+	depends on SND_OMAP_SOC && MACH_OVERO
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Gumstix Overo.
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index d8d8d58..b96b97b 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,5 +7,8 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-overo-objs := overo.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
new file mode 100644
index 0000000..542ff6b
--- /dev/null
+++ b/sound/soc/omap/overo.c
@@ -0,0 +1,149 @@
+/*
+ * overo.c  --  SoC audio for Gumstix Overo
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
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/mcbsp.h>
+
+#include "omap-mcbsp.h"
+#include "omap-pcm.h"
+#include "../codecs/twl4030.h"
+
+static int overo_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
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
+static struct snd_soc_ops overo_ops = {
+	.hw_params = overo_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link overo_dai = {
+	.name = "TWL4030",
+	.stream_name = "TWL4030",
+	.cpu_dai = &omap_mcbsp_dai[0],
+	.codec_dai = &twl4030_dai,
+	.ops = &overo_ops,
+};
+
+/* Audio machine driver */
+static struct snd_soc_machine snd_soc_machine_overo = {
+	.name = "overo",
+	.dai_link = &overo_dai,
+	.num_links = 1,
+};
+
+/* Audio subsystem */
+static struct snd_soc_device overo_snd_devdata = {
+	.machine = &snd_soc_machine_overo,
+	.platform = &omap_soc_platform,
+	.codec_dev = &soc_codec_dev_twl4030,
+};
+
+static struct platform_device *overo_snd_device;
+
+static int __init overo_soc_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "overo SoC init\n");
+	if (!machine_is_overo()) {
+		printk(KERN_ERR "Not Overo!\n");
+		return -ENODEV;
+	}
+
+	overo_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!overo_snd_device) {
+		printk(KERN_ERR "Platform device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(overo_snd_device, &overo_snd_devdata);
+	overo_snd_devdata.dev = &overo_snd_device->dev;
+	*(unsigned int *)overo_dai.cpu_dai->private_data = 1; /* McBSP2 */
+
+	ret = platform_device_add(overo_snd_device);
+	if (ret)
+		goto err1;
+
+	return 0;
+
+err1:
+	printk(KERN_ERR "Unable to add platform device\n");
+	platform_device_put(overo_snd_device);
+
+	return ret;
+}
+
+static void __exit overo_soc_exit(void)
+{
+	platform_device_unregister(overo_snd_device);
+}
+
+module_init(overo_soc_init);
+module_exit(overo_soc_exit);
+
+MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
+MODULE_DESCRIPTION("ALSA SoC overo");
+MODULE_LICENSE("GPL");
-- 
1.5.4.5

