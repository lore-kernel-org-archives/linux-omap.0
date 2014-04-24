From: Tony Lindgren <tony@atomide.com>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 08:40:31 -0700
Message-ID: <20140424154031.GA22987@atomide.com>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
 <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
 <7hr44mpxk6.fsf@paris.lan>
 <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23023 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaDXPki (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 11:40:38 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

* Nishanth Menon <nm@ti.com> [140424 08:25]:
> On Thu, Apr 24, 2014 at 10:16 AM, Kevin Hilman <khilman@linaro.org> wrote:
> > Linus Walleij <linus.walleij@linaro.org> writes:
> >
> >> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
> >> <javier@dowhile0.org> wrote:
> >>
> >>> I've revised the patch again and I couldn't find the reason why
> >>> certain boards are failing to boot.
> >>>
> >>> I can't reproduce this issue since I only have a DM3730 IGEPv2 board
> >>> which boots fine but I should have access to an AM3354 IGEP Aquila
> >>> board which is similar to the am335x-evmsk so I may be able to debug
> >>> it.
> >>
> >> It would really REALLY appreciate if some of the people maintaining
> >> and using OMAP1 would help Javier out in this refactoring operation.
> >>
> >> I'd really *hate* to have to drop his patches because of a lack of
> >> boards. This refactoring is necessary to handle the exploding
> >> multitude of GPIO drivers moving forward.
> >>
> >> We even tried to get an Innovator to boot just to be able to refactor
> >> OMAP stuff but fell short on some special JTAG reflash snag so
> >> we are dependent on maintainers to help out here :-/
> >
> > Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
> > able to get it booting again.  I wonder if Spectrum Digital still has
> > these available?  Their websites[1] says "call for price."
> >
> > Kevin
> >
> > [1] http://www.spectrumdigital.com/product_info.php?products_id=39
> 
> 
> Perhaps dumb question: but are there folks who really care about omap1
> boot anymore in upstream? should it be time to deprecate it - say for
> 3.17 or so?

Why? There are people still using omap1 and it works just fine. And
in general the maintenance work needed for omap1 is really minimal.

And in the GPIO case the issue was also discovered on new TI boards.

Regards,

Tony
