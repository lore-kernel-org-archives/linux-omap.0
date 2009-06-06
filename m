From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [alsa-devel] Please help in adding ams-delta support to ASoC
Date: Sat, 6 Jun 2009 19:42:12 +0200
Message-ID: <200906061942.14276.jkrzyszt@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <200906060028.01600.jkrzyszt@tis.icnet.pl> <20090605224532.GA12995@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:41361 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbZFFRms convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jun 2009 13:42:48 -0400
In-Reply-To: <20090605224532.GA12995@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Hi Mark,

Saturday 06 June 2009 00:45:34 Mark Brown napisa=C5=82(a):
> On Sat, Jun 06, 2009 at 12:28:00AM +0200, Janusz Krzysztofik wrote:
> > On the codec frame sync output, I can see ~10kHz symmetric square w=
ave
> > (filled by 50%), the same on modem frame sync input, mcbsp1 status
> > unknown. This shape suggests I2S protocol, not DSP_B as we deduced =
from
> > the original driver code.
>
> Not that this seems like an unreasonable conclusion but it's worth
> pointing out that the DSP modes only require the leading edge of the
> frame clock and that the falling edge can occur at any point before t=
he
> next rising edge is due.

Right, thanks.

I'm not sure how that could happen, but I was wrong with some of those=20
figures. After looking at the scope several more times I can only confi=
rm=20
that master clock really runs at 2MHz (0,5=C2=B5s period). Frame sync i=
s rather=20
closer to 8kHz (~125=C2=B5s period) than previously estimated 10kHz, wi=
th the same=20
symmetric (50% fill) shape as before. But bit clock is very different f=
rom=20
what I have seen before. It runs at 2MHz in 9=C2=B5s long packets (18 p=
eriods),=20
those are repeated every half period of frame sync (~62=C2=B5s / 16kHz)=
, ie every=20
frame sync edge, both rising and falling. There is also a signal presen=
t on=20
codec data output: 4=C2=B5s long packets (8 bits each?) every ~62=C2=B5=
s (16 kHz).

Is it possible that the codec speeks I2S, with 8-bit word, 1 word per f=
rame, 2=20
channels at 8kHz each? Or 1 channel at 16 kHz? From what I can read in =
modem=20
documentation, this should rather be one 8-bit channel at 8kHz. Anyway,=
 can=20
the transmission format I have seen ont the oscilloscope be matched aga=
inst=20
any format that mcbsp can be set with current code?

I'm still far from understanding mcbsp, but I wonder what happens if th=
e bit=20
clock stops ater 18th bit while maybe mcbsp expects more. Perhaps this =
is the=20
cause of dma interrupts not being generated?

> > ... My last
> > idea was to create a generic test driver that would not use any ext=
ernal
> > clocks, ie configured with OMAP_MCBSP_SYSCLK_CLK and
> > SND_SOC_DAIFMT_CBS_CFS, right? That way, it should just work withou=
t any
> > hardware support except for mcbsp and maybe we could then definitel=
ly
> > verify if current mcbsp and dma code works on omap1510 or not. Tryi=
ng to
> > select a template driver to base the test driver on, I felt into th=
ese
> > troubles with more and more questions coming on mind...
>
> That approach is one I use all the time in driver development - isola=
te
> the device as much as possible and confirm that it can at least
> interoperate with itself.

Thanks, I'll follow that way as soon as I get a hint from mcbsp experts=
=2E

Cheers,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
