From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Wed, 14 May 2014 23:08:34 -0700
Message-ID: <20140515060834.3084.5199@quantum>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com>
 <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54268 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaEOGIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2014 02:08:42 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so646295pbc.37
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 23:08:41 -0700 (PDT)
In-Reply-To: <5370BAFF.9070501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

Quoting Tomi Valkeinen (2014-05-12 05:13:51)
> On 12/05/14 15:02, Tero Kristo wrote:
> > On 05/08/2014 12:06 PM, Tomi Valkeinen wrote:
> >> The current DPLL code does not try to round the clock rate, and instead
> >> returns an error if the requested clock rate cannot be produced exactly
> >> by the DPLL.
> >>
> >> It could be argued that this is a bug, but as the current drivers may
> >> depend on that behavior, a new flag 'ti,round-rate' is added which
> >> enables clock rate rounding.
> > 
> > Someone could probably argue that this flag is not a hardware feature,
> 
> I fully agree.
> 
> > but instead is used to describe linux-kernel behavior, and would
> > probably be frowned upon by the DT enthusiasts. Othen than that, I like
> > this approach better than a global setting, but would like second
> > opinions here.
> 
> I think the dpll code should always do rounding. That's what
> round_rate() is supposed to do, afaik. The current behavior of not
> rounding and returning an error is a bug in my opinion.

>From include/linux/clk.h:

/**
 * clk_round_rate - adjust a rate to the exact rate a clock can provide
 * @clk: clock source
 * @rate: desired clock rate in Hz
 *
 * Returns rounded clock rate in Hz, or negative errno.
 */
long clk_round_rate(struct clk *clk, unsigned long rate);

Definitely not rounding the rate is a bug, with respect to the API
definition. Has anyone tried making the new flag as the default behavior
and seeing if anything breaks?

For those users of the omapconf tool I enjoy doing something like the
following:

<boot current, buggy behavior>
omapconf dump prcm > old

<boot with Tomi's flag enabled for all DPLLs by default>
omapconf dump prcm > new

diff -u old new

This should reveal any deltas, assuming the board boots and doesn't let
magic smoke out.

Regards,
Mike

> 
> So, if you ask me, the whole flag is just for the purpose of keeping the
> current drivers working, which could depend on the broken behavior. But
> I think we cannot have such drivers (functional, at least) in any case,
> as the clk-divider driver is broken and doesn't handle the errors the
> dpll code currently returns for non-exact rates.
> 
>  Tomi
> 
> 
