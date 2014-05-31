From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Fri, 30 May 2014 17:02:07 -0700
Message-ID: <20140531000207.10062.55946@quantum>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
 <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com>
 <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:42989 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699AbaEaACM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 May 2014 20:02:12 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so2249784pbb.13
        for <linux-omap@vger.kernel.org>; Fri, 30 May 2014 17:02:11 -0700 (PDT)
In-Reply-To: <5374B241.9010201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Quoting Tomi Valkeinen (2014-05-15 05:25:37)
> On 15/05/14 09:08, Mike Turquette wrote:
> > Quoting Tomi Valkeinen (2014-05-12 05:13:51)
> >> On 12/05/14 15:02, Tero Kristo wrote:
> >>> On 05/08/2014 12:06 PM, Tomi Valkeinen wrote:
> >>>> The current DPLL code does not try to round the clock rate, and instead
> >>>> returns an error if the requested clock rate cannot be produced exactly
> >>>> by the DPLL.
> >>>>
> >>>> It could be argued that this is a bug, but as the current drivers may
> >>>> depend on that behavior, a new flag 'ti,round-rate' is added which
> >>>> enables clock rate rounding.
> >>>
> >>> Someone could probably argue that this flag is not a hardware feature,
> >>
> >> I fully agree.
> >>
> >>> but instead is used to describe linux-kernel behavior, and would
> >>> probably be frowned upon by the DT enthusiasts. Othen than that, I like
> >>> this approach better than a global setting, but would like second
> >>> opinions here.
> >>
> >> I think the dpll code should always do rounding. That's what
> >> round_rate() is supposed to do, afaik. The current behavior of not
> >> rounding and returning an error is a bug in my opinion.
> > 
> > From include/linux/clk.h:
> > 
> > /**
> >  * clk_round_rate - adjust a rate to the exact rate a clock can provide
> >  * @clk: clock source
> >  * @rate: desired clock rate in Hz
> >  *
> >  * Returns rounded clock rate in Hz, or negative errno.
> >  */
> > long clk_round_rate(struct clk *clk, unsigned long rate);
> > 
> > Definitely not rounding the rate is a bug, with respect to the API
> > definition. Has anyone tried making the new flag as the default behavior
> > and seeing if anything breaks?
> 
> The v1 of the patch fixed the rounding unconditionally:
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/295077
> 
> Paul wanted it optional so that existing drivers would not break. No one
> knows if there is such a driver, or what would the driver's code look
> like that would cause an issue.
> 
> And, as I've pointed out in the above thread, as clk-divider driver
> doesn't an error code from the dpll driver, my opinion is that such
> drivers would not work even now.
> 
> I like v1 more.
> 
> In any case, I hope we'd get something merged ASAP so that we fix the
> display AM3xxx boards and we'd still have time to possibly find out if
> some other driver breaks.

Resurrecting this thread. Can we reach a consensus? I prefer V1 as well
for the reasons stated above, and also since ti,round-rate isn't really
describing the hardware at all in DT.

We can always see how it goes and fix it up afterwards when everything
explodes.

Regards,
Mike

> 
>  Tomi
> 
> 
