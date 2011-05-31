From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 31 May 2011 00:52:22 -0700
Message-ID: <20110531075222.GM11352@atomide.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com>
 <20110517152954.477365e6.jhnikula@gmail.com>
 <20110517125700.GY5323@atomide.com>
 <201105180852.08264.peter.ujfalusi@ti.com>
 <20110518105923.ed6a87e9.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48750 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754397Ab1EaHw0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 03:52:26 -0400
Content-Disposition: inline
In-Reply-To: <20110518105923.ed6a87e9.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

* Jarkko Nikula <jhnikula@gmail.com> [110518 00:54]:
> On Wed, 18 May 2011 08:52:07 +0300
> Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > On Tuesday 17 May 2011 15:57:00 Tony Lindgren wrote:
> > > This file should be under drivers/ somewhere, can you
> > > guys please take care of that?
> > 
> > Yeah, this has been discussed several times, and we have not reached agreement 
> > where to move this very OMAP specific code.
> > One option was to move it under sound/soc/omap/ , since currently the only 
> > user for mcbsp is audio.
> > But McBSP is really versatile beast, it can be used for other things (for 
> > example it can handle SPI bus as well), so if we move it under ASoC, we are 
> > going to limit/block other use of these pins.
> > We can not just cp arc/arm/plat-omap/mcbsp.c drivers/wherever...
> > If we do that, we need to move it under some framework, or create a new one 
> > (bus driver?), which might be a bit tricky since we have special use of McBSP 
> > from audio side, this does not really fit the bus mode. Other uses of McBSP 
> > might be happy with the bus driver conversion, but we just do not have those.
> > 
> > IMHO the only place we can move this is under sound/soc/omap/ , but who can 
> > decide, that the McBSP can only be used for audio??
> > 
> I think we would need some higher level abstraction for this McBSP use
> model where the lowest level driver (here OMAP McBSP) is just used to
> configure the serial interface and a layer on top of that takes care of
> DMA transfer and protocol like SPI, I2S, etc.
> 
> Why higher level abstraction? It's not only OMAP that has a general
> purpose serial interface. Also TI DaVinci has similar called McBSP/ASP
> and how about other SoCs, probably? What I looked once the DaVinci
> McBSP/ASP it wasn't compatible with OMAP McBSP but made me thinking
> that if these differences can be handled by a generic API.

Yeah I think this is the way to go.

Tony
