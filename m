From: Tony Lindgren <tony@atomide.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 16:47:53 -0700
Message-ID: <20140422234753.GC12204@atomide.com>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
 <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
 <CABxcv==aaBKO0Mos1=RuGhF8X6pVAki748vnzH7ADYraTpBxRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28362 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaDVXr7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 19:47:59 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv==aaBKO0Mos1=RuGhF8X6pVAki748vnzH7ADYraTpBxRQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

* Javier Martinez Canillas <javier@dowhile0.org> [140422 16:03]:
> Hello Linus,
> 
> On Wed, Apr 23, 2014 at 12:00 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
> > <javier@dowhile0.org> wrote:
> >
> >> I've revised the patch again and I couldn't find the reason why
> >> certain boards are failing to boot.
> >>
> >> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
> >> which boots fine but I should have access to an AM3354 IGEP Aquila
> >> board which is similar to the am335x-evmsk so I may be able to debug
> >> it.
> >
> > It would really REALLY appreciate if some of the people maintaining
> > and using OMAP1 would help Javier out in this refactoring operation.
> >
> 
> The board that is failing to boot with this patch-set is not an OMAP1
> based board but the Sitara AM335x Starter Kit
> (arch/arm/boot/dts/am335x-evmsk.dts).

This does not happen to have anything to do with the ti,no-reset-on-init
hack for &gpio0 on the am335x-evmsk.dts that's needed to keep DDR
powered? See the am43x thread for more info.
 
> Now, other boards using the same SoC like the Beagle Bone Black are
> booting correctly and also am335x-evm which is very similar to
> am335x-evmsk.dts.

Except for the gpio0 hack..
 
> Nishanth has access to this board and his helping now with the debugging.
> 
> > I'd really *hate* to have to drop his patches because of a lack of
> > boards. This refactoring is necessary to handle the exploding
> > multitude of GPIO drivers moving forward.
> >
> 
> Yeah, I'm doing my best to keep this driver up-to-date with the latest
> changes in gpiolib but it seems that is very hard to change the OMAP
> GPIO driver without breaking one of the gazillion TI platforms out
> there...
> 
> > We even tried to get an Innovator to boot just to be able to refactor
> > OMAP stuff but fell short on some special JTAG reflash snag so
> > we are dependent on maintainers to help out here :-/

I got it to the point where some relatively recent u-boot was loading
fine over JTAG but the first stage did not boot properly from NOR for
some reason.

Regards,

Tony
