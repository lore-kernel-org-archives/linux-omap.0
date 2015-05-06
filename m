From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
Date: Wed, 6 May 2015 08:36:56 -0700
Message-ID: <20150506153656.GJ21061@atomide.com>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
 <CACRpkdZqSEgaVOV1gCQvCLc1-x7eU3WZwAM2QT2HT21xqCHZ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49525 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbbEFPg7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 May 2015 11:36:59 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZqSEgaVOV1gCQvCLc1-x7eU3WZwAM2QT2HT21xqCHZ2Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

* Linus Walleij <linus.walleij@linaro.org> [150506 06:22]:
> On Fri, Apr 24, 2015 at 1:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > At some point with all the GPIO clean-up we've broken the
> > MPUIO interrupts. Those are just a little bit different from
> > the GPIO interrupts, so we can fix it up just by setting
> > different irqchip functions for it. And then we can just
> > remove all old code trying to do the same.
> >
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Javier Martinez Canillas <javier@dowhile0.org>
> > Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Patch applied for fixes with the ACKs etc,

Thanks. Yes this should go in during the -rc cycle as a regresion
fix. Sorry I could not exactly pinpoint where we've broken the
MPUIO interrupts with all the clean-up.

Also the omap1 SPARSE_IRQ changes I recently posted have a
dependency to this one so that's another reason to get this
one out of the way.

No rush with the other ones, those should be OK for v4.2.

Regards,

Tony
