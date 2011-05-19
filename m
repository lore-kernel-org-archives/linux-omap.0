From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Wed, 18 May 2011 18:06:16 -0700
Message-ID: <4DD46D08.9040607@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>	<201105130859.12477.peter.ujfalusi@ti.com>	<BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>	<201105161154.55850.peter.ujfalusi@ti.com>	<4DD167EC.2010007@gmail.com> <20110517093703.d0cd1e53.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:33014 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061Ab1ESBGU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 21:06:20 -0400
Received: by pxi16 with SMTP id 16so1445775pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 18:06:20 -0700 (PDT)
In-Reply-To: <20110517093703.d0cd1e53.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On 05/16/11 23:37, Jarkko Nikula wrote:
> Hi
> 
> On Mon, 16 May 2011 11:07:40 -0700
> Steve Calfee <stevecalfee@gmail.com> wrote:
> 
>> On 05/16/11 01:54, Peter Ujfalusi wrote:
>>> On Saturday 14 May 2011 05:47:33 Steve Calfee wrote:
>>>> I put in a few debug statements. It appears that my DMA never gets
>>>> started. I know it can work with a different machine and codec driver,
>>>> but not mine. I don't see any explicit DMA init, but that must be the
>>>> problem.  Any more ideas?
>>>
>>> You mean neither omap_pcm_hw_params nor omap_pcm_trigger got called?
>>> Could you post the output of dmesg related to ASoC? Does the connection 
>>> between the CPU and codec DAI correct?
>>> Does McBSP part got initialized (for example does omap_mcbsp_dai_hw_params, 
>>> omap_mcbsp_dai_trigger got called)?
>>>
>> No, they get called. I just don't get the clock on the bclk pin.
>>
>> I think I have the mcbsp1 set up correctly - I explictly set the MUX:
>>
>> static struct omap_board_mux board_mux[] __initdata = {
>> #if 1
>> 	/* McBSP 1 */
>> 	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>> 	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>> 	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>> 	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>> #endif
>> 	{ .reg_offset = OMAP_MUX_TERMINATOR },
>> };
>>
> Did you try to run OMAP as an I2S master like what omap3pandora.c is
> doing?
> 
> Missing clock in codec master configuration suggests that reason
> is in codec side and reversed roles during development makes easier to
> hunt it further as then OMAP can play data out independently of is the
> codec correctly configured or not.
> 
> You could run OMAP as a master by specifying SND_SOC_DAIFMT_CBS_CFS
> as a DAI format for both codec and OMAP and by setting McBSP to use
> internal 96 MHz clock as a master clock. Something like below might work
> for testing purposes:
> 
> snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
> 		       96000000, SND_SOC_CLOCK_IN);
> 
> snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV,
> 		       62); /* 96M / 48k*32 */
> 
Hi,

The hunt for clock continues. I redid my board-omap3beaglexm.c to as
closely match what board-omap3pandora.c is doing as I can. Like pandora,
I don't explicitly set the mux pin directions, I guess mcbsp master is
the default.

I also tried to get as close as I could to the soc/omap/omap3pandora.c
machine driver with my omap3beaglexm.c machine driver. Specifically in
the *_hw_params init routines.

But when I start things up (even with the codec disconnected from the
bclk line), I don't get any movement on the CLK and fsx. And of course
the dma doesn't send anything.

Thanks for the suggestion.

Regards, Steve

