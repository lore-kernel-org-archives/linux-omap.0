From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Remove support for omap2evm (Re: Updated mach-types
 update)
Date: Fri, 13 May 2011 07:40:32 -0700
Message-ID: <20110513144031.GV31483@atomide.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
 <20110320114137.GD16646@n2100.arm.linux.org.uk>
 <20110324175945.GV2811@atomide.com>
 <20110513115406.GQ31483@atomide.com>
 <20110513151916.77eba011.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33550 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752272Ab1EMOkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 10:40:43 -0400
Content-Disposition: inline
In-Reply-To: <20110513151916.77eba011.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Subhasish Ghosh <subhasish@mistralsolutions.com>, Srinath <srinath@mistralsolutions.com>, Arun C <arunedarath@mistralsolutions.com>, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Paul Mundt <lethal@linux-sh.org>

* Jarkko Nikula <jhnikula@gmail.com> [110513 05:15]:
> On Fri, 13 May 2011 04:54:07 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [110324 10:57]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
> > > > On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
> > > > 
> > > > Note that OMAP references machine_is_omap2evm() yet this has never been
> > > > merged.
> > > > 
> > > > arch/arm/plat-omap/include/plat/uncompress.h:
> > > > 
> > > >                 DEBUG_LL_OMAP2(1, omap2evm);
> > > > 
> > > > so this entry needs to be removed.
> > > 
> > > Hmm looks like we have LCD support and ASoC support for it, but no
> > > board :)
> > > 
> > > Anybody working with this board?
> > > 
> > > If so, please send patches for the related board-*.c support ASAP.
> > > Otherwise let's plan on deleting the related support.
> > 
> > No patches, so let's remove it. Here's the patch to do that,
> > I'm planning to add this to my devel-cleanup branch.
> > 
> Remove also from sound/soc/omap/Kconfig as well. You could put my
> ack for sound/soc/omap part but remember cc also Mark and Liam.

Thanks, here's the updated patch.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Fri, 13 May 2011 04:41:32 -0700
Subject: [PATCH] omap: Remove support for omap2evm

The board support has never been merged for it as noticed
by Russell King <linux@arm.linux.org.uk>. So let's remove the
related dead code.

Cc: linux-fbdev@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 30b891c..2b576f1 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -129,7 +129,6 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP1(3, sx1);
 
 		/* omap2 based boards using UART1 */
-		DEBUG_LL_OMAP2(1, omap2evm);
 		DEBUG_LL_OMAP2(1, omap_2430sdp);
 		DEBUG_LL_OMAP2(1, omap_apollon);
 		DEBUG_LL_OMAP2(1, omap_h4);
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 49226a1..25db556 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -30,7 +30,6 @@ objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
 objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
-objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
deleted file mode 100644
index 7e7a65c..0000000
--- a/drivers/video/omap/lcd_omap2evm.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * LCD panel support for the MISTRAL OMAP2EVM board
- *
- * Author: Arun C <arunedarath@mistralsolutions.com>
- *
- * Derived from drivers/video/omap/lcd_omap3evm.c
- * Derived from drivers/video/omap/lcd-apollon.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/i2c/twl.h>
-
-#include <plat/mux.h>
-#include <asm/mach-types.h>
-
-#include "omapfb.h"
-
-#define LCD_PANEL_ENABLE_GPIO	154
-#define LCD_PANEL_LR		128
-#define LCD_PANEL_UD		129
-#define LCD_PANEL_INI		152
-#define LCD_PANEL_QVGA		148
-#define LCD_PANEL_RESB		153
-
-#define TWL_LED_LEDEN		0x00
-#define TWL_PWMA_PWMAON		0x00
-#define TWL_PWMA_PWMAOFF	0x01
-
-static unsigned int bklight_level;
-
-static int omap2evm_panel_init(struct lcd_panel *panel,
-				struct omapfb_device *fbdev)
-{
-	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
-	gpio_request(LCD_PANEL_LR, "LCD lr");
-	gpio_request(LCD_PANEL_UD, "LCD ud");
-	gpio_request(LCD_PANEL_INI, "LCD ini");
-	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
-	gpio_request(LCD_PANEL_RESB, "LCD resb");
-
-	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
-	gpio_direction_output(LCD_PANEL_RESB, 1);
-	gpio_direction_output(LCD_PANEL_INI, 1);
-	gpio_direction_output(LCD_PANEL_QVGA, 0);
-	gpio_direction_output(LCD_PANEL_LR, 1);
-	gpio_direction_output(LCD_PANEL_UD, 1);
-
-	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
-	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
-	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
-	bklight_level = 100;
-
-	return 0;
-}
-
-static void omap2evm_panel_cleanup(struct lcd_panel *panel)
-{
-	gpio_free(LCD_PANEL_RESB);
-	gpio_free(LCD_PANEL_QVGA);
-	gpio_free(LCD_PANEL_INI);
-	gpio_free(LCD_PANEL_UD);
-	gpio_free(LCD_PANEL_LR);
-	gpio_free(LCD_PANEL_ENABLE_GPIO);
-}
-
-static int omap2evm_panel_enable(struct lcd_panel *panel)
-{
-	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
-	return 0;
-}
-
-static void omap2evm_panel_disable(struct lcd_panel *panel)
-{
-	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
-}
-
-static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
-						unsigned int level)
-{
-	u8 c;
-	if ((level >= 0) && (level <= 100)) {
-		c = (125 * (100 - level)) / 100 + 2;
-		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
-		bklight_level = level;
-	}
-	return 0;
-}
-
-static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
-{
-	return bklight_level;
-}
-
-static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
-{
-	return 100;
-}
-
-struct lcd_panel omap2evm_panel = {
-	.name		= "omap2evm",
-	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
-			  OMAP_LCDC_INV_HSYNC,
-
-	.bpp		= 16,
-	.data_lines	= 18,
-	.x_res		= 480,
-	.y_res		= 640,
-	.hsw		= 3,
-	.hfp		= 0,
-	.hbp		= 28,
-	.vsw		= 2,
-	.vfp		= 1,
-	.vbp		= 0,
-
-	.pixel_clock	= 20000,
-
-	.init		= omap2evm_panel_init,
-	.cleanup	= omap2evm_panel_cleanup,
-	.enable		= omap2evm_panel_enable,
-	.disable	= omap2evm_panel_disable,
-	.get_caps	= omap2evm_panel_get_caps,
-	.set_bklight_level      = omap2evm_bklight_setlevel,
-	.get_bklight_level      = omap2evm_bklight_getlevel,
-	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
-};
-
-static int omap2evm_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&omap2evm_panel);
-	return 0;
-}
-
-static int omap2evm_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int omap2evm_panel_suspend(struct platform_device *pdev,
-				   pm_message_t mesg)
-{
-	return 0;
-}
-
-static int omap2evm_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-struct platform_driver omap2evm_panel_driver = {
-	.probe		= omap2evm_panel_probe,
-	.remove		= omap2evm_panel_remove,
-	.suspend	= omap2evm_panel_suspend,
-	.resume		= omap2evm_panel_resume,
-	.driver		= {
-		.name	= "omap2evm_lcd",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init omap2evm_panel_drv_init(void)
-{
-	return platform_driver_register(&omap2evm_panel_driver);
-}
-
-static void __exit omap2evm_panel_drv_exit(void)
-{
-	platform_driver_unregister(&omap2evm_panel_driver);
-}
-
-module_init(omap2evm_panel_drv_init);
-module_exit(omap2evm_panel_drv_exit);
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index b592298..99054cf 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -65,14 +65,6 @@ config SND_OMAP_SOC_OVERO
 	  Say Y if you want to add support for SoC audio on the
 	  Gumstix Overo or CompuLab CM-T35
 
-config SND_OMAP_SOC_OMAP2EVM
-	tristate "SoC Audio support for OMAP2EVM board"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP2EVM
-	select SND_OMAP_SOC_MCBSP
-	select SND_SOC_TWL4030
-	help
-	  Say Y if you want to add support for SoC audio on the omap2evm board.
-
 config SND_OMAP_SOC_OMAP3EVM
 	tristate "SoC Audio support for OMAP3EVM board"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3EVM
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index ba9fc65..6c2c87e 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -13,7 +13,6 @@ snd-soc-rx51-objs := rx51.o
 snd-soc-ams-delta-objs := ams-delta.o
 snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
-snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
deleted file mode 100644
index 29b60d6..0000000
--- a/sound/soc/omap/omap2evm.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * omap2evm.c  --  SoC audio machine driver for omap2evm board
- *
- * Author: Arun KS <arunks@mistralsolutions.com>
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
-static int omap2evm_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret;
-
-	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return ret;
-	}
-
-	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return ret;
-	}
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
-static struct snd_soc_ops omap2evm_ops = {
-	.hw_params = omap2evm_hw_params,
-};
-
-/* Digital audio interface glue - connects codec <--> CPU */
-static struct snd_soc_dai_link omap2evm_dai = {
-	.name = "TWL4030",
-	.stream_name = "TWL4030",
-	.cpu_dai_name = "omap-mcbsp-dai.1",
-	.codec_dai_name = "twl4030-hifi",
-	.platform_name = "omap-pcm-audio",
-	.codec_name = "twl4030-codec",
-	.ops = &omap2evm_ops,
-};
-
-/* Audio machine driver */
-static struct snd_soc_card snd_soc_omap2evm = {
-	.name = "omap2evm",
-	.dai_link = &omap2evm_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *omap2evm_snd_device;
-
-static int __init omap2evm_soc_init(void)
-{
-	int ret;
-
-	if (!machine_is_omap2evm())
-		return -ENODEV;
-	printk(KERN_INFO "omap2evm SoC init\n");
-
-	omap2evm_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!omap2evm_snd_device) {
-		printk(KERN_ERR "Platform device allocation failed\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(omap2evm_snd_device, &snd_soc_omap2evm);
-
-	ret = platform_device_add(omap2evm_snd_device);
-	if (ret)
-		goto err1;
-
-	return 0;
-
-err1:
-	printk(KERN_ERR "Unable to add platform device\n");
-	platform_device_put(omap2evm_snd_device);
-
-	return ret;
-}
-module_init(omap2evm_soc_init);
-
-static void __exit omap2evm_soc_exit(void)
-{
-	platform_device_unregister(omap2evm_snd_device);
-}
-module_exit(omap2evm_soc_exit);
-
-MODULE_AUTHOR("Arun KS <arunks@mistralsolutions.com>");
-MODULE_DESCRIPTION("ALSA SoC omap2evm");
-MODULE_LICENSE("GPL");
