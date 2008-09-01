From: sakoman@gmail.com
Subject: [PATCH 3/4] SOUND: SOC: OMAP: Add support for Gumstix
	Overo
Date: Mon,  1 Sep 2008 14:57:58 -0700
Message-ID: <1220306279-27977-4-git-send-email-sakoman@gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<1220306279-27977-3-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220306279-27977-3-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 sound/soc/omap/Kconfig  |    9 +++
 sound/soc/omap/Makefile |    5 ++
 sound/soc/omap/overo.c  |  141 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 0 deletions(-)
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
index d8d8d58..159f7a0 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -7,5 +7,10 @@ obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
+snd-soc-omap3evm-objs := omap3evm.o
+snd-soc-omap3beagle-objs := omap3beagle.o
+snd-soc-overo-objs := overo.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
+obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
+
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
new file mode 100644
index 0000000..d660dc8
--- /dev/null
+++ b/sound/soc/omap/overo.c
@@ -0,0 +1,141 @@
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
