From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 20 May 2011 17:55:38 -0700
Message-ID: <4DD70D8A.2090807@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>	<201105130859.12477.peter.ujfalusi@ti.com>	<BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>	<201105161154.55850.peter.ujfalusi@ti.com>	<4DD167EC.2010007@gmail.com>	<20110517093703.d0cd1e53.jhnikula@gmail.com>	<4DD46D08.9040607@gmail.com>	<4DD5BCD0.6040009@gmail.com> <20110520092911.d725b9c4.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41724 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1EUAzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 20:55:41 -0400
Received: by pvg12 with SMTP id 12so1876921pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 17:55:41 -0700 (PDT)
In-Reply-To: <20110520092911.d725b9c4.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On 05/19/11 23:29, Jarkko Nikula wrote:
> On Thu, 19 May 2011 17:58:56 -0700
> Steve Calfee <stevecalfee@gmail.com> wrote:
> 
...
>>
> This very likely sounds that in master mode the master clock to McBSP is
> missing if there is no DMA running. Did you try to use internal 96 MHz
> from my example or did you try to use external CLKS what Pandora is
> using? That CLKS setup in Pandora requires that there is a clock coming
> to McBSP CLKS pin.
> 
> But as you got codec slave mode working it seems that pin multiplexing
> is ok so there is no need to try with master mode. In problematic cases
> the master mode is a good start since then only McBSP clock setup and
> pin multiplexing can affect if there are no clock and data signals
> visible.
> 

OK, you called this correctly. Apparently the beagle does not by default
have a clock on the clks pin. When I correctly followed your suggestion
and changed to the internal 96,000,000 clock I do get transitions on the
mcbsp1 clk and fsx pins.

The problem is 96M is pretty big. the only divisor I see is 8 bits, your
suggested division (else where of 62) only brings the bit clock rate to
about 15Mhz. the frame clock did get set very near the 8Khz for the
sample playback. So about 1900 bit clocks are sent per frame.

This would be ok, but since the mcbsp does not respect the l/r clock
(FSX) for shifting out data, I am back to getting audio on only one ear.
I was hoping that in master mode I could configure the mcbsp to only
send 16 bit clocks per frame. It looks like the clocks are not that
configurable.

The external clks pin is supposed to be connect to an external TPS65950
chip which divides down the source 26Mhz clock by 256. I'll have to
investigate why I was not seeing that clock.

Regards, Steve
