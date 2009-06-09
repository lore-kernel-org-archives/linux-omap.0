From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 09 Jun 2009 17:00:49 +0200
Message-ID: <4A2E7921.7090200@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl> <20090608094028.415e6ec3.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:38614 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZFIPAv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jun 2009 11:00:51 -0400
In-Reply-To: <20090608094028.415e6ec3.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Jarkko Nikula wrote:
> On Sat, 6 Jun 2009 00:28:00 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>> My last idea was to create a generic test driver that would not use
>> any external clocks, ie configured with OMAP_MCBSP_SYSCLK_CLK and
>> SND_SOC_DAIFMT_CBS_CFS, right? That way, it should just work without
>> any hardware support except for mcbsp and maybe we could then
>> definitelly verify if current mcbsp and dma code works on omap1510 or
>> not.
>>
> This could be a bit risky and can damage your HW since both OMAP and
> codec are then driving the bit-clock and FS signals but you could try
> to configure McBSP as a master and use the internal clock source as its
> input.

I found that in OMAP5910, CLKR and FSR signals are not connected to any 
pins, so I can safely set them as output. To make use of this feature, I 
have modified sound/soc/omap/omap-mcbsp.c slightly:

diff -Npru linux-2.6.29/sound/soc/omap/omap-msbsp.c.orig 
linux-2.6.29/sound/soc/omap/omap-mcbsp.c
--- linux-2.6.29/sound/soc/omap/omap-mcbsp.c.orig       2009-06-09 
02:16:32.000000000 +0200
+++ linux-2.6.29/sound/soc/omap/omap-mcbsp.c    2009-06-09 
02:25:50.000000000 +0200
@@ -341,8 +341,8 @@ static int omap_mcbsp_dai_set_dai_fmt(st
         switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
         case SND_SOC_DAIFMT_CBS_CFS:
                 /* McBSP master. Set FS and bit clocks as outputs */
-               regs->pcr0      |= FSXM | FSRM |
-                                  CLKXM | CLKRM;
+               regs->pcr0      |= FSRM |
+                                  CLKRM;
                 /* Sample rate generator drives the FS */
                 regs->srgr2     |= FSGM;
                 break;

> Basically it goes with current driver by passing SND_SOC_DAIFMT_CBS_CFS
> to snd_soc_dai_set_fmt(cpu_dai, ...) and by setting SRG source clock
> and divider:
> 
> snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLK, ...);
> snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, divider);

So I restored all that 12MHz mclk stuff that I had already removed as 
redundant, then set up the following in oder to get internally generated 
~256kHz CLKR and ~8kHz FSR:

+       /* Set cpu DAI configuration */
+       err = snd_soc_dai_set_fmt(cpu_dai,
+                                 SND_SOC_DAIFMT_I2S |
+                                 SND_SOC_DAIFMT_IB_IF |
+                                 SND_SOC_DAIFMT_CBS_CFS);
+       if (err < 0) {
+               printk(KERN_ERR "can't set cpu DAI configuration\n");
+               return err;
+       }
+
+       /* Set cpu DAI master clock source */
+       err =
+           snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLK,
+                                       0, SND_SOC_CLOCK_IN);
+
+       if (err < 0) {
+               printk(KERN_ERR "can't set cpu DAI clock source\n");
+               return err;
+       }
+
+       /* Set cpu DAI master clock divisor */
+       err =
+           snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 47);
+
+       if (err < 0) {
+               printk(KERN_ERR "can't set cpu DAI clock divisor\n");
+               return err;
+       }

Tried with both arecord and </dev/dsp, it looks like the problem still 
persists, even with mcbsp internally generated clocking. I have also 
tested a similiar mcbsp configuration with old driver for reference - it 
works.

Importand or not, I have to fine down my provious reports on what works 
and what does not:

- original patch applied with other ams-delta related patches
   on linux-omap-2.6.16, as it was designed for:
   - playback: works, with both aplay and >/dev/dsp,
   - capture: works with </dev/dsp, gives null output with arecord

- original patch ported to the last l-o commit supporting omap-alsa:
   - playback: works as before,
   - capture: both </dev/dsp and arecord give null output,
     but DMA interrupts still work.

- new driver on l-o: total hangup

- new driver on mainline 2.6.30-rc5: no DMA interrupts.

Thanks,
Janusz
