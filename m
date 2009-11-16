From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 5/5] AI TB: Additional modifications for the Always
 Innovating OMAP3-based Touch Book, including video and sound.
Date: Sun, 15 Nov 2009 20:30:50 -0800
Message-ID: <1258345850.9089.21.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52290 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbZKPEap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Nov 2009 23:30:45 -0500
Received: by mail-pw0-f42.google.com with SMTP id 3so3039846pwi.21
        for <linux-omap@vger.kernel.org>; Sun, 15 Nov 2009 20:30:51 -0800 (PST)
In-Reply-To: <1258228079.16065.17.camel@runt>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>

Additional modifications for the Always Innovating OMAP3-based Touch
Book, including video and sound.




Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
arch/arm/mach-omap2/Kconfig             |    5 +
arch/arm/mach-omap2/Makefile            |    2 +
drivers/video/omap/lcd_omap3touchbook.c |  130 +++++++++++++++++++
sound/soc/omap/Kconfig                  |    8 ++
sound/soc/omap/Makefile                 |    2 +
sound/soc/omap/omap3touchbook.c         |  211
+++++++++++++++++++++++++++++++
6 files changed, 358 insertions(+), 0 deletions(-)
create mode 100644 drivers/video/omap/lcd_omap3touchbook.c
create mode 100644 sound/soc/omap/omap3touchbook.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b25af76..f271383 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,11 @@ config MACH_OMAP3_PANDORA
bool "OMAP3 Pandora"
depends on ARCH_OMAP3 && ARCH_OMAP34XX

+config MACH_OMAP3_TOUCHBOOK
+ bool "OMAP3 Touch Book"
+ depends on ARCH_OMAP3 && ARCH_OMAP34XX
+ select BACKLIGHT_CLASS_DEVICE
+
config MACH_OMAP_3430SDP
bool "OMAP 3430 SDP board"
depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59b0ccc..b6b5c7f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -90,6 +90,8 @@ obj-$(CONFIG_MACH_CM_T35) += board-cm-t35.o \
   mmc-twl4030.o
obj-$(CONFIG_MACH_IGEP0020) += board-igep0020.o \
   mmc-twl4030.o
+obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK) += board-omap3touchbook.o \
+    mmc-twl4030.o

obj-$(CONFIG_MACH_OMAP_4430SDP) += board-4430sdp.o

diff --git a/drivers/video/omap/lcd_omap3touchbook.c
b/drivers/video/omap/lcd_omap3touchbook.c
new file mode 100644
index 0000000..5b58703
--- /dev/null
+++ b/drivers/video/omap/lcd_omap3touchbook.c
@@ -0,0 +1,130 @@
+/*
+ * LCD panel support for the Touch Book
+ *
+ * Author: Gregoire Gentil <gregoire@gentil.com>
+ *
+ * Derived from drivers/video/omap/lcd-omap3beagle.c
+ *
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the
+ * Free Software Foundation; either version 2 of the License, or (at
your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
along
+ * with this program; if not, write to the Free Software Foundation,
Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/i2c/twl4030.h>
+
+#include <plat/mux.h>
+#include <plat/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_PANEL_ENABLE_GPIO       176
+
+static int omap3beagle_panel_init(struct lcd_panel *panel,
+ struct omapfb_device *fbdev)
+{
+ gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+ return 0;
+}
+
+static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
+{
+ gpio_free(LCD_PANEL_ENABLE_GPIO);
+}
+
+static int omap3beagle_panel_enable(struct lcd_panel *panel)
+{
+ gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+ return 0;
+}
+
+static void omap3beagle_panel_disable(struct lcd_panel *panel)
+{
+ gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static unsigned long omap3beagle_panel_get_caps(struct lcd_panel
*panel)
+{
+ return 0;
+}
+
+struct lcd_panel omap3beagle_panel = {
+ .name = "omap3beagle",
+ .config = OMAP_LCDC_PANEL_TFT,
+
+ .bpp = 16,
+ .data_lines = 24,
+ .x_res = 1024,
+ .y_res = 600,
+ .hsw = 3,
+ .hfp = 3,
+ .hbp = 39,
+ .vsw = 1,
+ .vfp = 2,
+ .vbp = 7,
+
+ .pixel_clock = 64000,
+
+ .init = omap3touchbook_panel_init,
+ .cleanup = omap3touchbook_panel_cleanup,
+ .enable = omap3touchbook_panel_enable,
+ .disable = omap3touchbook_panel_disable,
+ .get_caps = omap3touchbook_panel_get_caps,
+};
+
+static int omap3touchbook_panel_probe(struct platform_device *pdev)
+{
+ omapfb_register_panel(&omap3beagle_panel);
+ return 0;
+}
+
+static int omap3touchbook_panel_remove(struct platform_device *pdev)
+{
+ return 0;
+}
+
+static int omap3touchbook_panel_suspend(struct platform_device *pdev,
+    pm_message_t mesg)
+{
+ return 0;
+}
+
+static int omap3touchbook_panel_resume(struct platform_device *pdev)
+{
+ return 0;
+}
+
+struct platform_driver omap3touchbook_panel_driver = {
+ .probe = omap3touchbook_panel_probe,
+ .remove = omap3touchbook_panel_remove,
+ .suspend = omap3touchbook_panel_suspend,
+ .resume = omap3touchbook_panel_resume,
+ .driver = {
+ .name = "omap3touchbook_lcd",
+ .owner = THIS_MODULE,
+ },
+};
+
+static int __init omap3touchbook_panel_drv_init(void)
+{
+ return platform_driver_register(&omap3beagle_panel_driver);
+}
+
+static void __exit omap3touchbook_panel_drv_exit(void)
+{
+ platform_driver_unregister(&omap3touchbook_panel_driver);
+}
+
+module_init(omap3touchbook_panel_drv_init);
+module_exit(omap3touchbook_panel_drv_exit);
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



