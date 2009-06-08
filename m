From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 8 Jun 2009 09:40:28 +0300
Message-ID: <20090608094028.415e6ec3.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200906030924.14230.jkrzyszt@tis.icnet.pl>
	<20090605165531.7d0c4522.jhnikula@gmail.com>
	<200906060028.01600.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:62141 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZFHGkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 02:40:08 -0400
In-Reply-To: <200906060028.01600.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

On Sat, 6 Jun 2009 00:28:00 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Reviewing the code of different asoc omap drivers and mcbsp
> documentation again and again, several questions comes on mind, like:
> 
> 1. What is the default setting for mcbsp master clock source?
> Assuming that default register bit values are 0,
> OMAP_MCBSP_SYSCLK_CLKS_EXT would be default for omap1, and there
> would be no default for others. Sources other than
> OMAP_MCBSP_SYSCLK_CLKS_EXT or OMAP_MCBSP_SYSCLK_CLKS_FCLK require
> setting of CLKSM and/or SCLKME to 1, and both
> OMAP_MCBSP_SYSCLK_CLKS_EXT and OMAP_MCBSP_SYSCLK_CLKS_FCLK require
> additional omap_ctrl_writel() calls on omap2 and higher. Am I missing
> anything?
> 
Actually there is no master in such but transfers are operated from
internal bit-clock and frame sync signals which can be delivered either
from outside (this is the typical McBSP slave configuration) or from
internal sample rate generator (SRG) which can use multiple clock
sources.

CLKXM and CLKRM selects the SRG for transfer bit-clock source and FSXM
and FSRM selects the SRG for frame sync source respectively.

Now if above bits are set and McBSP is used in master configuration,
then CLKSM and SCLKME are used to select the SRG input clock. CLKS is
one of those options and OMAP2 and later can use internal FCLK or
external CLKS pin as a CLKS source.

These are best explained in figures 6 and 7 in OMAP5912 McBSP
documentation [1]. It applies to later omaps and IRCC it applies to
1510 as well.

> 2. Why omap asoc drivers, except for omap3pandora, do not call 
> snd_soc_dai_set_sysclk(cpu_dai, ...)? Does it mean that osk9512 uses
> default OMAP_MCBSP_SYSCLK_CLKS_EXT? What does it mean for others
> without default?
> 
It is used to select SRG input clock when McBSP is master, i.e. when
DAI is configured with SND_SOC_DAIFMT_CBS_CFS so it's null op for
others since they don't use SRG.

> Anyway, we still have at least two potential reasons for my driver
> not working: wrong mcbsp clocks setup or broken mcbsp dma handling.
> My last idea was to create a generic test driver that would not use
> any external clocks, ie configured with OMAP_MCBSP_SYSCLK_CLK and
> SND_SOC_DAIFMT_CBS_CFS, right? That way, it should just work without
> any hardware support except for mcbsp and maybe we could then
> definitelly verify if current mcbsp and dma code works on omap1510 or
> not. Trying to select a template driver to base the test driver on, I
> felt into these troubles with more and more questions coming on mind.
> If you think my idea is worth of trying, could you please look at
> this and give me some hints?
> 
This could be a bit risky and can damage your HW since both OMAP and
codec are then driving the bit-clock and FS signals but you could try
to configure McBSP as a master and use the internal clock source as its
input.

Basically it goes with current driver by passing SND_SOC_DAIFMT_CBS_CFS
to snd_soc_dai_set_fmt(cpu_dai, ...) and by setting SRG source clock
and divider:

snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLK, ...);
snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, divider);

I think internal clock source is the same than CPU clock on 1510 but
this is and exact divider value are not so important here since we only
want to verify is the DMA operating.

If you want to play safe you could try to find out how to mux those
bit-clock and FS pins into GPIO inputs (if this is possible) so then it
should not matter if also McBSP is the DAI master.

So remember, this can be dangerous to your HW :-)


-- 
Jarkko

1.
http://focus.ti.com/general/docs/litabsmultiplefilelist.tsp?literatureNumber=spru762c
