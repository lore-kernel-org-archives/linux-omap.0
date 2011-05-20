From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Fri, 20 May 2011 09:29:11 +0300
Message-ID: <20110520092911.d725b9c4.jhnikula@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
	<201105130859.12477.peter.ujfalusi@ti.com>
	<BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com>
	<201105161154.55850.peter.ujfalusi@ti.com>
	<4DD167EC.2010007@gmail.com>
	<20110517093703.d0cd1e53.jhnikula@gmail.com>
	<4DD46D08.9040607@gmail.com>
	<4DD5BCD0.6040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38444 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933024Ab1ETG1t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 02:27:49 -0400
Received: by ewy4 with SMTP id 4so1074632ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 23:27:48 -0700 (PDT)
In-Reply-To: <4DD5BCD0.6040009@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On Thu, 19 May 2011 17:58:56 -0700
Steve Calfee <stevecalfee@gmail.com> wrote:

> > I also tried to get as close as I could to the soc/omap/omap3pandora.c
> > machine driver with my omap3beaglexm.c machine driver. Specifically in
> > the *_hw_params init routines.
> > 
> > But when I start things up (even with the codec disconnected from the
> > bclk line), I don't get any movement on the CLK and fsx. And of course
> > the dma doesn't send anything.
> > 
> 
> I have gotten mcbsp1 to work as a slave (sort-of) with Peter's help. I
> havent been able to get it to clock as a master. So now I try with
> mcbsp3, still no luck.
> 
This very likely sounds that in master mode the master clock to McBSP is
missing if there is no DMA running. Did you try to use internal 96 MHz
from my example or did you try to use external CLKS what Pandora is
using? That CLKS setup in Pandora requires that there is a clock coming
to McBSP CLKS pin.

But as you got codec slave mode working it seems that pin multiplexing
is ok so there is no need to try with master mode. In problematic cases
the master mode is a good start since then only McBSP clock setup and
pin multiplexing can affect if there are no clock and data signals
visible.

> And with the mcbsp 4 pins not connected to anything but the scope, I
> don't see any bitclock movement. I think others used u-boot to setup the
> mcbspx, but has anyone successfully used linux to set up the pins?
> 
Yep, in a couple omap boards. Remember that for kernel based
multiplexing the CONFIG_OMAP_MUX=y must be set.

-- 
Jarkko
