From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/8] clk: divider: fix rate calculation for fractional rates
Date: Wed, 26 Feb 2014 18:25:24 -0800
Message-ID: <20140227022524.12081.32368@quantum>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <1392285846-13199-2-git-send-email-tomi.valkeinen@ti.com>
 <52FE1DF2.2040707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48545 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbaB0CZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 21:25:28 -0500
Received: by mail-pb0-f42.google.com with SMTP id rr13so1869669pbb.1
        for <linux-omap@vger.kernel.org>; Wed, 26 Feb 2014 18:25:28 -0800 (PST)
In-Reply-To: <52FE1DF2.2040707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Quoting Tero Kristo (2014-02-14 05:45:22)
> On 02/13/2014 12:03 PM, Tomi Valkeinen wrote:
> > clk-divider.c does not calculate the rates consistently at the moment.
> >
> > As an example, on OMAP3 we have a clock divider with a source clock of
> > 864000000 Hz. With dividers 6, 7 and 8 the theoretical rates are:
> >
> > 6: 144000000
> > 7: 123428571.428571...
> > 8: 108000000
> >
> > Calling clk_round_rate() with the rate in the first column will give the
> > rate in the second column:
> >
> > 144000000 -> 144000000
> > 143999999 -> 123428571
> > 123428572 -> 123428571
> > 123428571 -> 108000000
> >
> > Note how clk_round_rate() returns 123428571 for rates from 123428572 to
> > 143999999, which is mathematically correct, but when clk_round_rate() is
> > called with 123428571, the returned value is surprisingly 108000000.
> >
> > This means that the following code works a bit oddly:
> >
> > rate = clk_round_rate(clk, 123428572);
> > clk_set_rate(clk, rate);
> >
> > As clk_set_rate() also does clock rate rounding, the result is that the
> > clock is set to the rate of 108000000, not 123428571 returned by the
> > clk_round_rate.
> >
> > This patch changes the clk-divider.c to use DIV_ROUND_UP when
> > calculating the rate. This gives the following behavior which fixes the
> > inconsistency:
> >
> > 144000000 -> 144000000
> > 143999999 -> 123428572
> > 123428572 -> 123428572
> > 123428571 -> 108000000
> >
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > ---
> >   drivers/clk/clk-divider.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 5543b7df8e16..ec22112e569f 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -24,7 +24,7 @@
> >    * Traits of this clock:
> >    * prepare - clk_prepare only ensures that parents are prepared
> >    * enable - clk_enable only ensures that parents are enabled
> > - * rate - rate is adjustable.  clk->rate = parent->rate / divisor
> > + * rate - rate is adjustable.  clk->rate = DIV_ROUND_UP(parent->rate / divisor)
> >    * parent - fixed parent.  No clk_set_parent support
> >    */
> >
> > @@ -115,7 +115,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >               return parent_rate;
> >       }
> >
> > -     return parent_rate / div;
> > +     return DIV_ROUND_UP(parent_rate, div);
> >   }
> >
> >   /*
> > @@ -185,7 +185,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
> >               }
> >               parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> >                               MULT_ROUND_UP(rate, i));
> > -             now = parent_rate / i;
> > +             now = DIV_ROUND_UP(parent_rate, i);
> >               if (now <= rate && now > best) {
> >                       bestdiv = i;
> >                       best = now;
> > @@ -207,7 +207,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
> >       int div;
> >       div = clk_divider_bestdiv(hw, rate, prate);
> >
> > -     return *prate / div;
> > +     return DIV_ROUND_UP(*prate, div);
> >   }
> >
> >   static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> > @@ -218,7 +218,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> >       unsigned long flags = 0;
> >       u32 val;
> >
> > -     div = parent_rate / rate;
> > +     div = DIV_ROUND_UP(parent_rate, rate);
> >       value = _get_val(divider, div);
> >
> >       if (value > div_mask(divider))
> >
> 
> Basically the patch looks good to me, but it might be good to have a 
> testing round of sort with this. It can potentially cause regressions on 
> multiple boards if the drivers happen to rely on the "broken" clock 
> rates. Same for patch #2 which is a copy paste of this one, but only 
> impacts TI boards.

Agreed. I've taken patches #1 & #2 into clk-next. Let's let them stew in
-next for a while and see if anyone's board catches on fire.

Regards,
Mike

> 
> -Tero
> 
