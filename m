From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/4] ASoC: Remove obsolete OMAP3 machine drivers
Date: Tue, 14 Aug 2012 12:07:59 +0300
Message-ID: <1344935279-32364-5-git-send-email-peter.ujfalusi@ti.com>
References: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:56698 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755456Ab2HNJIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 05:08:01 -0400
Received: by obbwc20 with SMTP id wc20so295537obb.31
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 02:08:00 -0700 (PDT)
In-Reply-To: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Steve Sakoman <steve@sakoman.com>, Anuj Aggarwal <anuj.aggarwal@ti.com>, Benoit Cousson <b-cousson@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The new omap-twl4030 handles the boards used the following drivers:
igep0020, omap3beagle, omap3evm and overo.
Remove these drivers since they are mostly identical and we already have
drop in replacement for all of them.

Note: Earlier patch added the needed code for the board files to retain the
audio support for boards I can identify that used one of the removed
drivers.
If I missed something please take a look at for example:
arch/arm/mach-omap2/board-omap3beagle.c on how add support for omap-twl4030
audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig       |   35 ----------
 sound/soc/omap/Makefile      |    8 --
 sound/soc/omap/igep0020.c    |  120 ---------------------------------
 sound/soc/omap/omap3beagle.c |  150 ------------------------------------------
 sound/soc/omap/omap3evm.c    |  118 ---------------------------------
 sound/soc/omap/overo.c       |  122 ----------------------------------
 6 files changed, 0 insertions(+), 553 deletions(-)
 delete mode 100644 sound/soc/omap/igep0020.c
 delete mode 100644 sound/soc/omap/omap3beagle.c
 delete mode 100644 sound/soc/omap/omap3evm.c
 delete mode 100644 sound/soc/omap/overo.c

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fc83d74..2c484a5 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -60,23 +60,6 @@ config SND_OMAP_SOC_OSK5912
 	help
 	  Say Y if you want to add support for SoC audio on osk5912.
 
-config SND_OMAP_SOC_OVERO
-	tristate "SoC Audio support for Gumstix Overo and CompuLab CM-T35"
-	depends on TWL4030_CORE && SND_OMAP_SOC && (MACH_OVERO || MACH_CM_T35)
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on the
-	  Gumstix Overo or CompuLab CM-T35
-
-config SND_OMAP_SOC_OMAP3EVM
-	tristate "SoC Audio support for OMAP3EVM board"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on the omap3evm board.
-
 config SND_OMAP_SOC_AM3517EVM
 	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
 	depends on SND_OMAP_SOC && MACH_OMAP3517EVM && I2C
@@ -140,16 +123,6 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
 
-config SND_OMAP_SOC_OMAP3_BEAGLE
-	tristate "SoC Audio support for OMAP3 Beagle and Devkit8000"
-	depends on TWL4030_CORE && SND_OMAP_SOC
-	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000)
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on the Beagleboard or
-	  the clone Devkit8000.
-
 config SND_OMAP_SOC_ZOOM2
 	tristate "SoC Audio support for Zoom2"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2
@@ -157,11 +130,3 @@ config SND_OMAP_SOC_ZOOM2
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for Soc audio on Zoom2 board.
-
-config SND_OMAP_SOC_IGEP0020
-	tristate "SoC Audio support for IGEP v2"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_IGEP0020
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for Soc audio on IGEP v2 board.
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 861e640..19637e5 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -16,31 +16,23 @@ snd-soc-n810-objs := n810.o
 snd-soc-rx51-objs := rx51.o
 snd-soc-ams-delta-objs := ams-delta.o
 snd-soc-osk5912-objs := osk5912.o
-snd-soc-overo-objs := overo.o
-snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
 snd-soc-omap-twl4030-objs := omap-twl4030.o
 snd-soc-omap3pandora-objs := omap3pandora.o
-snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
-snd-soc-igep0020-objs := igep0020.o
 snd-soc-omap-hdmi-card-objs := omap-hdmi-card.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
 obj-$(CONFIG_SND_OMAP_SOC_AMS_DELTA) += snd-soc-ams-delta.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
-obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_TWL4030) += snd-soc-omap-twl4030.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
-obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap-hdmi-card.o
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
deleted file mode 100644
index e835781..0000000
--- a/sound/soc/omap/igep0020.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * igep0020.c  --  SoC audio for IGEP v2
- *
- * Based on sound/soc/omap/overo.c by Steve Sakoman
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-#include <plat/mcbsp.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static int igep2_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops igep2_ops = {
-	.hw_params = igep2_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link igep2_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.codec_dai_name = "twl4030-hifi",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "twl4030-codec",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		   SND_SOC_DAIFMT_CBM_CFM,
-	.ops = &igep2_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_card_igep2 = {
-	.name = "igep2",
-	.owner = THIS_MODULE,
-	.dai_link = &igep2_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *igep2_snd_device;
-
-static int __init igep2_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_igep0020())
-		return -ENODEV;
-	printk(KERN_INFO "IGEP v2 SoC init\n");
-
-	igep2_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!igep2_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(igep2_snd_device, &snd_soc_card_igep2);
-
-	ret = platform_device_add(igep2_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(igep2_snd_device);
-
-	return ret;
-}
-module_init(igep2_soc_init);
-
-static void __exit igep2_soc_exit(void)
-{
-	platform_device_unregister(igep2_snd_device);
-}
-module_exit(igep2_soc_exit);
-
-MODULE_AUTHOR("Enric Balletbo i Serra <eballetbo@iseebcn.com>");
-MODULE_DESCRIPTION("ALSA SoC IGEP v2");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
deleted file mode 100644
index 2830dfd..0000000
--- a/sound/soc/omap/omap3beagle.c
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * omap3beagle.c  --  SoC audio for OMAP3 Beagle
- *
- * Author: Steve Sakoman <steve@sakoman.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-#include <plat/mcbsp.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	unsigned int fmt;
-	int ret;
-
-	switch (params_channels(params)) {
-	case 2: /* Stereo I2S mode */
-		fmt =	SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBM_CFM;
-		break;
-	case 4: /* Four channel TDM mode */
-		fmt =	SND_SOC_DAIFMT_DSP_A |
-			SND_SOC_DAIFMT_IB_NF |
-			SND_SOC_DAIFMT_CBM_CFM;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops omap3beagle_ops = {
-	.hw_params = omap3beagle_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link omap3beagle_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.platform_name = "omap-pcm-audio",
-	.codec_dai_name = "twl4030-hifi",
-	.codec_name = "twl4030-codec",
-	.ops = &omap3beagle_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_omap3beagle = {
-	.name = "omap3beagle",
-	.owner = THIS_MODULE,
-	.dai_link = &omap3beagle_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *omap3beagle_snd_device;
-
-static int __init omap3beagle_soc_init(void)
-{
-	int ret;
-
-	if (!(machine_is_omap3_beagle() || machine_is_devkit8000()))
-		return -ENODEV;
-	pr_info("OMAP3 Beagle/Devkit8000 SoC init\n");
-
-	omap3beagle_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!omap3beagle_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(omap3beagle_snd_device, &snd_soc_omap3beagle);
-
-	ret = platform_device_add(omap3beagle_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(omap3beagle_snd_device);
-
-	return ret;
-}
-
-static void __exit omap3beagle_soc_exit(void)
-{
-	platform_device_unregister(omap3beagle_snd_device);
-}
-
-module_init(omap3beagle_soc_init);
-module_exit(omap3beagle_soc_exit);
-
-MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
-MODULE_DESCRIPTION("ALSA SoC OMAP3 Beagle");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
deleted file mode 100644
index 3d468c9..0000000
--- a/sound/soc/omap/omap3evm.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * omap3evm.c  -- ALSA SoC support for OMAP3 EVM
- *
- * Author: Anuj Aggarwal <anuj.aggarwal@ti.com>
- *
- * Based on sound/soc/omap/beagle.c by Steve Sakoman
- *
- * Copyright (C) 2008 Texas Instruments, Incorporated
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-#include <plat/mcbsp.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static int omap3evm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-				     SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "Can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops omap3evm_ops = {
-	.hw_params = omap3evm_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link omap3evm_dai = {
-	.name 		= "TWL4030",
-	.stream_name 	= "TWL4030",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.codec_dai_name = "twl4030-hifi",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "twl4030-codec",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		   SND_SOC_DAIFMT_CBM_CFM,
-	.ops 		= &omap3evm_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_omap3evm = {
-	.name = "omap3evm",
-	.owner = THIS_MODULE,
-	.dai_link = &omap3evm_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *omap3evm_snd_device;
-
-static int __init omap3evm_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap3evm())
-		return -ENODEV;
-	pr_info("OMAP3 EVM SoC init\n");
-
-	omap3evm_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!omap3evm_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(omap3evm_snd_device, &snd_soc_omap3evm);
-	ret = platform_device_add(omap3evm_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(omap3evm_snd_device);
-
-	return ret;
-}
-
-static void __exit omap3evm_soc_exit(void)
-{
-	platform_device_unregister(omap3evm_snd_device);
-}
-
-module_init(omap3evm_soc_init);
-module_exit(omap3evm_soc_exit);
-
-MODULE_AUTHOR("Anuj Aggarwal <anuj.aggarwal@ti.com>");
-MODULE_DESCRIPTION("ALSA SoC OMAP3 EVM");
-MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
deleted file mode 100644
index 6ac3e0c..0000000
--- a/sound/soc/omap/overo.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * overo.c  --  SoC audio for Gumstix Overo
- *
- * Author: Steve Sakoman <steve@sakoman.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/clk.h>
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-
-#include <asm/mach-types.h>
-#include <mach/hardware.h>
-#include <mach/gpio.h>
-#include <plat/mcbsp.h>
-
-#include "omap-mcbsp.h"
-#include "omap-pcm.h"
-
-static int overo_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	/* Set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
-					    SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec system clock\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct snd_soc_ops overo_ops = {
-	.hw_params = overo_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link overo_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp.2",
-	.codec_dai_name = "twl4030-hifi",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "twl4030-codec",
-	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-		   SND_SOC_DAIFMT_CBM_CFM,
-	.ops = &overo_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_card_overo = {
-	.name = "overo",
-	.owner = THIS_MODULE,
-	.dai_link = &overo_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *overo_snd_device;
-
-static int __init overo_soc_init(void)
-{
-	int ret;
-
-	if (!(machine_is_overo() || machine_is_cm_t35())) {
-		pr_debug("Incomatible machine!\n");
-		return -ENODEV;
-	}
-	printk(KERN_INFO "overo SoC init\n");
-
-	overo_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!overo_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(overo_snd_device, &snd_soc_card_overo);
-
-	ret = platform_device_add(overo_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(overo_snd_device);
-
-	return ret;
-}
-module_init(overo_soc_init);
-
-static void __exit overo_soc_exit(void)
-{
-	platform_device_unregister(overo_snd_device);
-}
-module_exit(overo_soc_exit);
-
-MODULE_AUTHOR("Steve Sakoman <steve@sakoman.com>");
-MODULE_DESCRIPTION("ALSA SoC overo");
-MODULE_LICENSE("GPL");
-- 
1.7.8.6

