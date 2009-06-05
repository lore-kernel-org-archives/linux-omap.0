From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Sat, 6 Jun 2009 00:28:00 +0200
Message-ID: <200906060028.01600.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906030924.14230.jkrzyszt@tis.icnet.pl> <20090605165531.7d0c4522.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:42496 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbZFEW2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 18:28:38 -0400
In-Reply-To: <20090605165531.7d0c4522.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Hi Jarkko,

Thank you for still trying to support my efforts.

=46riday 05 June 2009 15:55:31 Jarkko Nikula napisa=C5=82(a):
> Optimize out one needless clock :-)

:-)

> Ok, so looks that McBSP settings have nothing to do.

That was what I was suggesting before as well, but now I'm back not so =
sure.

> While I don't believe that call order has something to do on 1510
> versus other omaps, it's easy to try by changing call order in
> arch/arm/plat-omap/dma.c: omap_set_dma_params.
>
> Of course you could try to also copy transfer setup from
> audio_set_dma_params_play into omap_pcm_prepare... That should make t=
he
> DMA setup same than older implementation.
>
> Hopefully these speculations would help you to find out at least one =
DMA
> interrupt.

Tried this all, and guess what? Still no signle dma interrupt :(.


I disassembled my device and got with osscilloscope probe inside.=20
Unfortunatelly, it was not possible to check what was going on on omap =
pins,=20
as those were hidden. However, I was able to look at codec and modem pi=
ns.

The codec master clock input has ~2MHz square wave applied. The same wa=
veform=20
can be found on the modem master clock output, so I think we can be sur=
e that=20
the codec gets its master clock from the modem. I am not able to verify=
 If=20
the same signal is applied on mcbsp1 master clock input.

There is ~330kHz square wave on the codec bit clock output. I was not a=
ble to=20
verify if this signal appears on modem or mcbsp1 pins, as it should.

On the codec frame sync output, I can see ~10kHz symmetric square wave =
(filled=20
by 50%), the same on modem frame sync input, mcbsp1 status unknown. Thi=
s=20
shape suggests I2S protocol, not DSP_B as we deduced from the original =
driver=20
code.


Reviewing the code of different asoc omap drivers and mcbsp documentati=
on=20
again and again, several questions comes on mind, like:

1. What is the default setting for mcbsp master clock source? Assuming =
that=20
default register bit values are 0, OMAP_MCBSP_SYSCLK_CLKS_EXT would be=20
default for omap1, and there would be no default for others. Sources ot=
her=20
than OMAP_MCBSP_SYSCLK_CLKS_EXT or OMAP_MCBSP_SYSCLK_CLKS_FCLK require=20
setting of CLKSM and/or SCLKME to 1, and both OMAP_MCBSP_SYSCLK_CLKS_EX=
T and=20
OMAP_MCBSP_SYSCLK_CLKS_FCLK require additional omap_ctrl_writel() calls=
 on=20
omap2 and higher. Am I missing anything?

2. Why omap asoc drivers, except for omap3pandora, do not call=20
snd_soc_dai_set_sysclk(cpu_dai, ...)? Does it mean that osk9512 uses de=
fault=20
OMAP_MCBSP_SYSCLK_CLKS_EXT? What does it mean for others without defaul=
t?

and more.


Anyway, we still have at least two potential reasons for my driver not=20
working: wrong mcbsp clocks setup or broken mcbsp dma handling. My last=
 idea=20
was to create a generic test driver that would not use any external clo=
cks,=20
ie configured with OMAP_MCBSP_SYSCLK_CLK and SND_SOC_DAIFMT_CBS_CFS, ri=
ght?=20
That way, it should just work without any hardware support except for m=
cbsp=20
and maybe we could then definitelly verify if current mcbsp and dma cod=
e=20
works on omap1510 or not. Trying to select a template driver to base th=
e test=20
driver on, I felt into these troubles with more and more questions comi=
ng on=20
mind. If you think my idea is worth of trying, could you please look at=
 this=20
and give me some hints?

Cheers,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
