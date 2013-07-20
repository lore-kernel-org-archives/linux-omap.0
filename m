From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: mcbsp.1 slave clkx ext problem
Date: Sat, 20 Jul 2013 19:13:16 +0200
Message-ID: <20130720171316.GA5729@panicking>
References: <20130719133317.GA21833@panicking>
 <51E95B68.4080501@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:46921 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3GTRNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Jul 2013 13:13:23 -0400
Received: by mail-ea0-f169.google.com with SMTP id h15so2999771eak.0
        for <linux-omap@vger.kernel.org>; Sat, 20 Jul 2013 10:13:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E95B68.4080501@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Peter

On Fri, Jul 19, 2013 at 05:29:44PM +0200, Michael Trimarchi wrote:
> Hi
> 
> On 07/19/2013 03:33 PM, Michael Trimarchi wrote:
> > Hi
> > 
> > I'm trying to understand what is wrong here with this small
> > driver.
> > 
> > /* McBSP1 */
> > OMAP4_MUX(ABE_MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> > OMAP4_MUX(ABE_MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
> > OMAP4_MUX(ABE_MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
> >           OMAP_PULL_ENA),
> > OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> > 
> > kernel 3.8.0
> > 
> 
> I have fixed my problem ;). I will send a description about it
> 
> Michael
> 

I will prepare a proper patch. But OMAP supports (both omap3/omap4) the
SND_SOC_DAIFMT_CBM_CFS format in this way. I have already tested it on
my devkit platform

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8d2defd..85dd415 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -435,6 +435,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* Sample rate generator drives the FS */
 		regs->srgr2	|= FSGM;
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* McBSP slave. FS clock as output */
+		regs->srgr2	|= FSGM;
+		regs->pcr0	|= FSXM;
+		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* McBSP slave */
 		break;


Best regards
Michael

> > [  107.276702] omap-mcbsp omap-mcbsp.1: Configuring McBSP1  phys_base: 0x40122000
> > [  107.283691] omap-mcbsp omap-mcbsp.1: **** McBSP1 regs ****
> > [  107.283721] omap-mcbsp omap-mcbsp.1: DRR2:  0x88260a09
> > [  107.283721] omap-mcbsp omap-mcbsp.1: DRR1:  0x0000
> > [  107.283752] omap-mcbsp omap-mcbsp.1: DXR2:  0x0000
> > [  107.283752] omap-mcbsp omap-mcbsp.1: DXR1:  0x0000
> > [  107.283752] omap-mcbsp omap-mcbsp.1: SPCR2: 0x0233
> > [  107.283782] omap-mcbsp omap-mcbsp.1: SPCR1: 0x0030
> > [  107.283782] omap-mcbsp omap-mcbsp.1: RCR2:  0x80a1
> > [  107.283813] omap-mcbsp omap-mcbsp.1: RCR1:  0x00a0
> > [  107.283813] omap-mcbsp omap-mcbsp.1: XCR2:  0x80a1
> > [  107.283813] omap-mcbsp omap-mcbsp.1: XCR1:  0x00a0
> > [  107.283843] omap-mcbsp omap-mcbsp.1: SRGR2: 0x203f
> > [  107.283843] omap-mcbsp omap-mcbsp.1: SRGR1: 0x1f00
> > [  107.283843] omap-mcbsp omap-mcbsp.1: PCR0:  0x008f
> > [  107.283874] omap-mcbsp omap-mcbsp.1: ***********************
> > [  119.926177] omap-dma-engine omap-dma-engine: freeing channel for 33
> > 
> > Well basically it doesn't start the transfer. The clock is provided
> > using the clkx pin. clkx is rate * channel * bitsxword and come from
> > the codec. 
> > 
> > What is wrong? (I know that how I register the card is deprecated)
> > 
> > Regards Michael
> > 
> > /*
> >  * dacmax.c  --  SoC audio for pandaboard demokit
> >  *
> >  * Author: Michael Trimarchi <michael@amarulasolutions.com>
> >  *
> >  * Based on:
> >  * Author: Misael Lopez Cruz <x0052729@ti.com>
> >  *
> >  * This program is free software; you can redistribute it and/or
> >  * modify it under the terms of the GNU General Public License
> >  * version 2 as published by the Free Software Foundation.
> >  *
> >  * This program is distributed in the hope that it will be useful, but
> >  * WITHOUT ANY WARRANTY; without even the implied warranty of
> >  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >  * General Public License for more details.
> >  *
> >  * You should have received a copy of the GNU General Public License
> >  * along with this program; if not, write to the Free Software
> >  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> >  * 02110-1301 USA
> >  *
> >  */
> > 
> > #include <linux/clk.h>
> > #include <linux/platform_device.h>
> > #include <sound/core.h>
> > #include <sound/pcm.h>
> > #include <sound/pcm_params.h>
> > #include <sound/soc.h>
> > 
> > #include <asm/mach-types.h>
> > #include <linux/gpio.h>
> > #include <linux/platform_data/asoc-ti-mcbsp.h>
> > 
> > #include <linux/module.h>
> > #include "omap-mcbsp.h"
> > 
> > static struct snd_soc_card snd_soc_dacmax;
> > 
> > static int dacmax_hw_params(struct snd_pcm_substream *substream,
> > 	struct snd_pcm_hw_params *params)
> > {
> > 	int ret;
> > 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > 
> > 	pr_info("%s: setting the params\n", __func__);
> > 
> > 	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKX_EXT, 0,
> >                                 SND_SOC_CLOCK_IN);
> > 	if (ret < 0) {
> > 		printk(KERN_ERR "can't set CPU system clock " \
> > 			        "OMAP_MCBSP_CLKR_SRC_CLKX\n");
> > 	}
> > 
> > 	return 0;
> > }
> > 
> > static struct snd_soc_ops dacmax_ops = {
> > 	.hw_params = dacmax_hw_params,
> > };
> > 
> > static int dacmax_init(struct snd_soc_pcm_runtime *rtd)
> > {
> > 	pr_info("%s: INIT\n", __func__);
> > 	return 0;
> > }
> > 
> > /* Digital audio interface glue - connects codec <--> CPU */
> > static struct snd_soc_dai_link dacmax_dai = {
> > 	.name = "DACMAX-I2S",
> > 	.stream_name = "DACMAX-Audio",
> > 	.cpu_dai_name = "omap-mcbsp.1",
> > 	.codec_dai_name = "pcm1792a-hifi",
> > 	.platform_name = "omap-pcm-audio",
> > 	.codec_name = "pcm1792a",
> > 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > 		   SND_SOC_DAIFMT_CBM_CFM,
> > 	.init = dacmax_init,
> > 	.ops = &dacmax_ops,
> > };
> > 
> > /* Audio machine driver */
> > static struct snd_soc_card snd_soc_dacmax = {
> > 	.name = "DACMAX",
> > 	.driver_name = "OMAP4",
> > 	.long_name = "TI OMAP4 Board",
> > 	.dai_link = &dacmax_dai,
> > 	.num_links = 1,
> > };
> > 
> > static struct platform_device *dacmax_snd_device;
> > 
> > static int __init dacmax_soc_init(void)
> > {
> > 	int ret;
> > 
> > 	printk(KERN_INFO "DACMAX SoC init\n");
> > 
> > 	dacmax_snd_device = platform_device_alloc("soc-audio", -1);
> > 	if (!dacmax_snd_device) {
> > 		printk(KERN_ERR "Platform device allocation failed\n");
> > 		return -ENOMEM;
> > 	}
> > 
> > 	platform_set_drvdata(dacmax_snd_device, &snd_soc_dacmax);
> > 
> > 	ret = platform_device_add(dacmax_snd_device);
> > 	if (ret)
> > 		goto err1;
> > 
> > 	return 0;
> > 
> > err1:
> > 	printk(KERN_ERR "Unable to add platform device\n");
> > 	platform_device_put(dacmax_snd_device);
> > 
> > 	return ret;
> > }
> > module_init(dacmax_soc_init);
> > 
> > static void __exit dacmax_soc_exit(void)
> > {
> > 	platform_device_unregister(dacmax_snd_device);
> > }
> > module_exit(dacmax_soc_exit);
> > 
> > MODULE_AUTHOR("Michael Trimarchi <michael@amurulasolutions.com>");
> > MODULE_DESCRIPTION("ALSA SoC DACMAX");
> > MODULE_LICENSE("GPL");
> > 
> 
> 
> -- 
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> 
> 
