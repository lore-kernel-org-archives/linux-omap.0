From: Tony Lindgren <tony@atomide.com>
Subject: Re: regressions in linux-next?
Date: Thu, 24 Apr 2014 09:47:45 -0700
Message-ID: <20140424164744.GF22987@atomide.com>
References: <53566C20.6000208@ti.com>
 <53566EBA.808@ti.com>
 <CABxcv=mu=xvt7cM7Q8vBP2hQH124=CL9Yuox8WWcVGeKJ+NSjA@mail.gmail.com>
 <CACRpkdbhzmn4WOVi6nJiFmWX29z8MMScipn=UHZULZ3mrPrbFg@mail.gmail.com>
 <7hr44mpxk6.fsf@paris.lan>
 <CAGo_u6r79StfHwf8t8OB5vyhByfusi3EF=PZA186piiAci_wjw@mail.gmail.com>
 <CABxcv==7bisHnock37_Ai-k-n+u57Mk6YoAFvBV-XA+cEj+x+Q@mail.gmail.com>
 <20140424154248.GB22987@atomide.com>
 <CABxcv=kLOD7OQxPBxSaEBPzVW7bN2qRj09S=yozUg8OUL+7wCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53652 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757599AbaDXQrx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 12:47:53 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=kLOD7OQxPBxSaEBPzVW7bN2qRj09S=yozUg8OUL+7wCQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

* Javier Martinez Canillas <javier@dowhile0.org> [140424 09:33]:
> On Thu, Apr 24, 2014 at 5:42 PM, Tony Lindgren <tony@atomide.com> wrote:
> > It really should not matter what the configuration data for the
> > drivers is. Both platform_data and DT data should be easily supported.
> 
> Yes, I think I expressed myself badly. I actually meant platforms that
> keep evolving vs platforms that nobody is active developing on them
> and is unlikely that will ever use the newer
> infrastructure/API/whatever that is added on the different subsystems.
> 
> In the GPIO OMAP driver example we have a lot of #ifdefery to separate
> OMAP1 and OMAP2+ code since OMAP1 does not support sparse IRQ (and
> probably never will) so it can't dynamically allocate IRQ numbers and
> I've seen similar things in other OMAP drivers.
> 
> But yes, the maintenance burden is not that much either, I was just
> thinking aloud if splitting these drivers would make sense or not.

OK. Doing the omap1 sparse IRQ conversion has been on my todo list
for quite a while. That should be quite easy to do. Sounds getting
rid of the ifdeffery in the shared drivers is a good reason to do it.

The tricky part with omap1 from multiarch point of view is the clock
framework conversion for multi arch support, at this rate it will be
years before we get there :)

Regards,

Tony
