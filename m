From: Tony Lindgren <tony@atomide.com>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 12:03:03 -0700
Message-ID: <20120926190302.GH4840@atomide.com>
References: <1348568474.2342.35.camel@deskari>
 <20120925153806.GC4840@atomide.com>
 <1348592700.2342.49.camel@deskari>
 <CACRpkdYdZFr=XvsZUwY6dLN6uOj7fN_7StPgCNZNKU46UtMCaA@mail.gmail.com>
 <1348664205.2376.34.camel@deskari>
 <CACRpkdZN8MnoFvj3yjs=yy7=HqWAp4Dgs8hS9RqR0hmmSe4QJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:46206 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756979Ab2IZTDG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 15:03:06 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdZN8MnoFvj3yjs=yy7=HqWAp4Dgs8hS9RqR0hmmSe4QJw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Linus Walleij <linus.walleij@linaro.org> [120926 06:28]:
> On Wed, Sep 26, 2012 at 2:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > [Me]
> >> You can very well do clocks and regulators in these functions as well.
> >
> > That's not really what I mean. The regulators in question are OMAP
> > version specific, so the driver shouldn't know which regulators are
> > needed.
> 
> So then it can't be done in generic code atleast, and it becomes a
> matter for the OMAP driver, I guess you're referring to
> Tony's pinctrl-single?

Yes the pins are muxed with pinctrl-single. Then for the SoC specific
regulator handling I suggest you use regulator names that make sense
from the driver point of view that can be mapped in SoC specific way
in the .dts files.

If you need SoC specific more complicated handling, you may want
to have SoC specific glue driver to the DSS core driver, like
dss-44xx.c etc. Then you can select the appropriate glue layer
based on the compatible flag.

Regards,

Tony
