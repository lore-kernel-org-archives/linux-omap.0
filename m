From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 01 Jun 2009 14:41:59 +0200
Message-ID: <4A23CC97.1020209@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <20090527095949.51ed4b83.jhnikula@gmail.com> <200905272058.55404.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:36938 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZFAMmB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jun 2009 08:42:01 -0400
In-Reply-To: <200905272058.55404.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: alsa-devel@vger.kernel.org

Janusz Krzysztofik wrote:
> So I am going to restart with checking if the original patch still works with 
> the latest kernel version supporting omap-alsa.

The original patch ported to linux-omap-2.6.27, the last omap release 
with omap-alsa support, gives me a working sound driver on ams-delta.

Jarkko Nikula wrote:
> Looks like McBSP is not getting bit-clock and frame-sync signals from
> the codec. ...
> Another possibility are the OMAP pins muxed for McBSP? I assume they
> are if the bootloader is still the same but worth to find check was
> previous kernel doing any runtime remuxing for those pins with
> omap_cfg_reg calls.

Peter Ujfalusi wrote:
> This means that the McBSP module is not transmitting/receiving any data.
> Which suggests that the clocking is not working in your setup. Check the slave 
> master mode for the codec.
> Also worth checking the PIN configuration for the McBSP1 module, just in case 
> it is correct.

My port of the original driver is still very generic. There are no mux 
setups. It containes only two simple hardware pin setup calls that make 
it working, those are invoked from two callback functions, 
omap_alsa_codec_config.codec_clock_on() and 
omap_alsa_codec_config.codec_clock_off(), as below:

-----------------------------------
int vc_clock_on(void)
{
         if (clk_get_usecount(vc_mclk) > 0) {
                 /* MCLK is already in use */
                 printk(KERN_WARNING
                        "MCLK in use at %d Hz. We change it to %d Hz\n",
                        (uint) clk_get_rate(vc_mclk),
                        CODEC_CLOCK);
         }
         clk_enable(vc_mclk);

         printk(KERN_DEBUG
                 "MCLK = %d [%d], usecount = %d\n",
                (uint) clk_get_rate(vc_mclk), CODEC_CLOCK,
                clk_get_usecount(vc_mclk));

         /* Now turn the audio on */
         ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_NRESET |
                         AMS_DELTA_LATCH2_MODEM_CODEC,
                         AMS_DELTA_LATCH2_MODEM_NRESET);
         return 0;
}


int vc_clock_off(void)
{
         if  (clk_get_usecount(vc_mclk) > 0) {
                 if (clk_get_rate(vc_mclk) != CODEC_CLOCK) {
                         printk(KERN_WARNING
                                "MCLK for audio should be %d Hz. But is 
%d Hz\n",
                                (uint) clk_get_rate(vc_mclk),
                                CODEC_CLOCK);
                 }

                 clk_disable(vc_mclk);
         }

         ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
                         AMS_DELTA_LATCH2_MODEM_CODEC);
         return 0;
}
...
static int __init snd_omap_alsa_vc_probe(struct platform_device *pdev)
{
...
         struct  omap_alsa_codec_config *codec_cfg;
...
                 codec_cfg->codec_clock_on       = vc_clock_on;
                 codec_cfg->codec_clock_off      = vc_clock_off;
...
}

static struct platform_driver omap_alsa_driver = {
         .probe          = snd_omap_alsa_vc_probe,
...
};

static int __init omap_alsa_vc_init(void)
{
         int err;

         err = platform_driver_register(&omap_alsa_driver);
         return err;
}
----------------------------------

Jarkko Nikula wrote:
> OMAP1510 doesn't support DMA chaining so there are few
> cpu_is_omap1510() code snippets in sound/soc/omap/omap-pcm.c which I
> think I have only simulated using OMAP2420.

To make the original driver work stable, I had to patch the omap-alsa 
framework to restore the original way that lack of dma chaining problem 
had been solved in the original patch (see below), so maybe there is a 
similiar issue in the currect ASoC McBSP framework?

----------------------------------
diff -uprN linux-2.6.27/sound/arm/omap/omap-alsa.c 
linux-2.6.27-sound/sound/arm/omap/omap-alsa.c
--- linux-2.6.27/sound/arm/omap/omap-alsa.c     2009-05-30 
21:27:09.000000000 +0000
+++ linux-2.6.27-sound/sound/arm/omap/omap-alsa.c       2009-05-30 
22:12:12.000000000 +0000
@@ -52,6 +52,8 @@
  #include <mach/omap-alsa.h>
  #include "omap-alsa-dma.h"

+#include <asm/mach-types.h>
+
  MODULE_AUTHOR("Mika Laitio");
  MODULE_AUTHOR("Daniel Petrini");
  MODULE_AUTHOR("David Cohen");
@@ -210,7 +212,7 @@ static int audio_start_dma_chain(struct
                  * irq from DMA after the first transfered/played buffer.
                  * (invocation of callback_omap_alsa_sound_dma() method).
                  */
-               if (cpu_is_omap1510())
+               if (cpu_is_omap1510() && !machine_is_ams_delta())
                         omap_stop_alsa_sound_dma(s);

                 dma_start_pos = (dma_addr_t)runtime->dma_area + offset;
diff -uprN linux-2.6.27/sound/arm/omap/omap-alsa-dma.c 
linux-2.6.27-sound/sound/arm/omap/omap-alsa-dma.c
--- linux-2.6.27/sound/arm/omap/omap-alsa-dma.c 2009-05-30 
21:27:09.000000000 +0000
+++ linux-2.6.27-sound/sound/arm/omap/omap-alsa-dma.c   2009-05-30 
22:12:12.000000000 +0000
@@ -70,6 +70,8 @@

  #include <asm/arch/omap-alsa.h>

+#include <asm/mach-types.h>
+
  #undef DEBUG

  #define ERR(ARGS...) printk(KERN_ERR "{%s}-ERROR: ", 
__FUNCTION__);printk(ARGS);
@@ -350,7 +352,7 @@ static int audio_start_dma_chain(struct
                 omap_start_dma(channel);
                 s->started = 1;
                 s->hw_start();     /* start McBSP interface */
-       } else if (cpu_is_omap310())
+       } else if (cpu_is_omap310() || machine_is_ams_delta())
                 omap_start_dma(channel);
         /* else the dma itself will progress forward with out our help */
         FN_OUT(0);
----------------------------------

My asoc based patch is also very generic and contains no more that the 
same two ams_delta_latch2_write() hardware related operations, called 
from inside snd_soc_dai_link.ops.startup() and 
snd_soc_dai_link.ops.shutdown() callback functions:

----------------------------------
static int ams_delta_startup(struct snd_pcm_substream *substream)
{
         ams_delta_latch2_write(AMS_DELTA_LATCH_MODEM_NRESET |
                         AMS_DELTA_LATCH2_MODEM_CODEC,
                         AMS_DELTA_LATCH_MODEM_NRESET);
         return clk_enable(cx20442_mclk);
}

static void ams_delta_shutdown(struct snd_pcm_substream *substream)
{
         clk_disable(cx20442_mclk);
         ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC,
                         AMS_DELTA_LATCH2_MODEM_CODEC);
}
...
static struct snd_soc_ops ams_delta_ops = {
         .startup = ams_delta_startup,
         .hw_params = ams_delta_hw_params,
         .shutdown = ams_delta_shutdown,
};
...
/* Digital audio interface glue - connects codec <--> CPU */
static struct snd_soc_dai_link ams_delta_dai = {
...
         .ops = &ams_delta_ops,
};

/* Audio machine driver */
static struct snd_soc_card snd_soc_card_ams_delta = {
         .name = "AMS_DELTA",
         .platform = &omap_soc_platform,
         .dai_link = &ams_delta_dai,
         .num_links = 1,
};

/* Audio subsystem */
static struct snd_soc_device ams_delta_snd_devdata = {
         .card = &snd_soc_card_ams_delta,
         .codec_dev = &soc_codec_dev_cx20442,
};
-----------------------------------------------------

When applied on top of linux-2.6.27, omap or mainline, my patch causes 
system hangup on sound device first access, exactly as I have already 
reported it for linux-omap.git revision 
90e758af52ba803cba233fabee81176d99589f09.

However, when applied on top of linux-2.6.30-rc5, I still get a working 
system with non-functional sound device. DMA interrupt counters stay at 0.

My conclusuions so far:

1. If the new OMAP McBSP ASoC framework provides all the functionality 
of the depreciated OMAP Alsa under a different API, the only reason of 
my driver not working I can imagine is that I have put these two lines 
of hardware related code in wrong places. If this is the case, could 
someone please point me into the right direction?

2. Maybe the original ams-delta sound driver should not in theory work 
as is? Maybe Mark Underwood was just lucky enough to get it working 
without any real hardware setup?

3. Otherwise, there must be a significant difference in (alsa) MsBSP 
handling code that I am not able to identify and resolve myself. I can 
only say that I have seen much more mcbsp_...() stuff in the old 
omap-alsa framework than in the current one. The differece can be 
significant for OMAP15XX, or OMAP5910, or even ams-delta only.

4. Base (not alsa related) McBSP framework did not change since 2.6.16 
(the original patch base) up to 2.6.27 in a way that could break the 
original patch. If my problem was related to base McBSP handling, 
changes should be looked for after 2.6.27, if any.

Jarkko Nikula wrote:
> It would be nice to get
> this working since it would be the first OMAP5910 == OMAP1510 based
> machine driver.

I am personally interested in this, as I have bought two E3's recently 
in hope I can make use of them as IP phones. But for now, I have no idea 
what else I could try. I have noticed that Andrew de Quincey is going to 
fix sound on Nokia 770, maybe he finds something related.

Cheers,
Janusz

