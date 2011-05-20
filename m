From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Thu, 19 May 2011 17:58:56 -0700
Message-ID: <4DD5BCD0.6040009@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>	<201105130859.12477.peter.ujfalusi@ti.com>	<BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>	<201105161154.55850.peter.ujfalusi@ti.com>	<4DD167EC.2010007@gmail.com> <20110517093703.d0cd1e53.jhnikula@gmail.com> <4DD46D08.9040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63829 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827Ab1ETA7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 May 2011 20:59:00 -0400
Received: by pvg12 with SMTP id 12so1435349pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 17:59:00 -0700 (PDT)
In-Reply-To: <4DD46D08.9040607@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On 05/18/11 18:06, Steve Calfee wrote:
> On 05/16/11 23:37, Jarkko Nikula wrote:
>>>
>> Did you try to run OMAP as an I2S master like what omap3pandora.c is
>> doing?
>>
>> Missing clock in codec master configuration suggests that reason
>> is in codec side and reversed roles during development makes easier to
>> hunt it further as then OMAP can play data out independently of is the
>> codec correctly configured or not.
>>
>> You could run OMAP as a master by specifying SND_SOC_DAIFMT_CBS_CFS
>> as a DAI format for both codec and OMAP and by setting McBSP to use
>> internal 96 MHz clock as a master clock. Something like below might work
>> for testing purposes:
>>
>> snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
>> 		       96000000, SND_SOC_CLOCK_IN);
>>
>> snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV,
>> 		       62); /* 96M / 48k*32 */
>>
> Hi,
> 
> The hunt for clock continues. I redid my board-omap3beaglexm.c to as
> closely match what board-omap3pandora.c is doing as I can. Like pandora,
> I don't explicitly set the mux pin directions, I guess mcbsp master is
> the default.
> 
> I also tried to get as close as I could to the soc/omap/omap3pandora.c
> machine driver with my omap3beaglexm.c machine driver. Specifically in
> the *_hw_params init routines.
> 
> But when I start things up (even with the codec disconnected from the
> bclk line), I don't get any movement on the CLK and fsx. And of course
> the dma doesn't send anything.
> 

I have gotten mcbsp1 to work as a slave (sort-of) with Peter's help. I
havent been able to get it to clock as a master. So now I try with
mcbsp3, still no luck.

More missing mcbsp bit clock. I am trying on mcbsp3. I am trying to get
master mode working. Here is the register dump from the console (I have
some debug printouts on).

[   30.039978] snd_pcm_do_start: state 3
[   30.043823] omap_pcm_trigger: cmd 1
[   30.047760] omap_start_dma: lch 0
[   30.051696] omap-mcbsp omap-mcbsp.3: **** McBSP3 regs ****
[   30.057464] omap-mcbsp omap-mcbsp.3: DRR2:  0x2820d81
[   30.062774] omap-mcbsp omap-mcbsp.3: DRR1:  0x0000
[   30.067779] omap-mcbsp omap-mcbsp.3: DXR2:  0x0000
[   30.072814] omap-mcbsp omap-mcbsp.3: DXR1:  0x0000
[   30.077850] omap-mcbsp omap-mcbsp.3: SPCR2: 0x02f5
[   30.082885] omap-mcbsp omap-mcbsp.3: SPCR1: 0x0030
[   30.087890] omap-mcbsp omap-mcbsp.3: RCR2:  0x80a1
[   30.092926] omap-mcbsp omap-mcbsp.3: RCR1:  0x00a0
[   30.097961] omap-mcbsp omap-mcbsp.3: XCR2:  0x80a1
[   30.102966] omap-mcbsp omap-mcbsp.3: XCR1:  0x00a0
[   30.108001] omap-mcbsp omap-mcbsp.3: SRGR2: 0x10c0
[   30.113037] omap-mcbsp omap-mcbsp.3: SRGR1: 0x5f3d
[   30.118041] omap-mcbsp omap-mcbsp.3: PCR0:  0x0f0f
[   30.123077] omap-mcbsp omap-mcbsp.3: ***********************




My BSP sets up the mux for mcbsp3:

#ifdef CONFIG_OMAP_MUX
static struct omap_board_mux board_mux[] __initdata = {
#if 1
	/* McBSP 1 slave */
	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#else
	/* McBSP 1 master */
	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#endif
	/* McBSP 3 master */
	OMAP3_MUX(MCBSP3_FSX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP3_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	OMAP3_MUX(MCBSP3_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP3_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
	{ .reg_offset = OMAP_MUX_TERMINATOR },
};
#endif

And with the mcbsp 4 pins not connected to anything but the scope, I
don't see any bitclock movement. I think others used u-boot to setup the
mcbspx, but has anyone successfully used linux to set up the pins?

Thanks, Steve
