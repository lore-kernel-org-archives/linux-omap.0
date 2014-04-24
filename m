From: Tony Lindgren <tony@atomide.com>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 09:17:13 -0700
Message-ID: <20140424161711.GC22987@atomide.com>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
 <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
 <7hr44mpxk6.fsf@paris.lan>
 <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
 <20140424154031.GA22987@atomide.com>
 <535931F3.10805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10144 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758353AbaDXQRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 12:17:33 -0400
Content-Disposition: inline
In-Reply-To: <535931F3.10805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

* Nishanth Menon <nm@ti.com> [140424 08:47]:
> On 04/24/2014 10:40 AM, Tony Lindgren wrote:
> > * Nishanth Menon <nm@ti.com> [140424 08:25]:
> >> On Thu, Apr 24, 2014 at 10:16 AM, Kevin Hilman <khilman@linaro.org> wrote:
> >>> Linus Walleij <linus.walleij@linaro.org> writes:
> >>>
> >>>> On Tue, Apr 22, 2014 at 5:52 PM, Javier Martinez Canillas
> >>>> <javier@dowhile0.org> wrote:
> [...]
> >>>> We even tried to get an Innovator to boot just to be able to refactor
> >>>> OMAP stuff but fell short on some special JTAG reflash snag so
> >>>> we are dependent on maintainers to help out here :-/
> >>>
> >>> Unfortunately, my OMAP1 (omap5912/OSK[1]) died last year and I haven't been
> >>> able to get it booting again.  I wonder if Spectrum Digital still has
> >>> these available?  Their websites[1] says "call for price."
> >>>
> >>> Kevin
> >>>
> >>> [1] http://www.spectrumdigital.com/product_info.php?products_id=39
> >>
> >>
> >> Perhaps dumb question: but are there folks who really care about omap1
> >> boot anymore in upstream? should it be time to deprecate it - say for
> >> 3.17 or so?
> > 
> > Why? There are people still using omap1 and it works just fine. And
> > in general the maintenance work needed for omap1 is really minimal.
> > 
> > And in the GPIO case the issue was also discovered on new TI boards.
> > 
> 
> I mean, yeah - hobby usage is nice.. but there is maintenance burden
> when it comes to ensuring generic drivers such as timers, gpio etc.. I
> am not saying we cannot maintain it, but if there are no strong
> reasons why to keep it alive, it kinda reduces the scope of
> modifications as kernel frameworks evolve to be generic. The OMAP1
> generation of processors based boards are so hard to get and go
> running that developer access to these boards slow things down as well.

It's not a burden by any means like I said. And like I said, the
drivers should work just fine no matter what the data source.

Having the platform_data around actually forces us to fix up the
drivers so they work in the standard Linux way. So it's really the
mixed state of drivers that are the issue here.

> I understand that "strong reasons to keep it alive" is pretty
> subjective in nature.. but just throwing the thought out here.

Strong reasons as in people are using it. There just isn't any
stronger reason available in Linux land.

Or what do you think is a "stronger reason" then? Merging random
corporate snapshots of kernel code upstream from some hacked up
kernel tree where the code has never even been even tested with
the mainline kernel and is not usable for any available product?
I don't think so :)

Regards,

Tony

