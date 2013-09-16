From: Mike Turquette <mturquette@linaro.org>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Mon, 16 Sep 2013 12:45:05 -0700
Message-ID: <20130916194505.27384.1874@quantum>
References: <521DC143.2010506@ti.com> <522F0390.9050802@gmail.com>
 <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com>
 <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com>
 <523019EE.5000508@ti.com> <5232C413.8010207@gmail.com>
 <5232F85E.7050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63071 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab3IPTpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 15:45:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so4469588pbc.25
        for <linux-omap@vger.kernel.org>; Mon, 16 Sep 2013 12:45:10 -0700 (PDT)
In-Reply-To: <5232F85E.7050502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Stefan Roese <stefan.roese@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Quoting Tero Kristo (2013-09-13 04:34:54)
> On 09/13/2013 10:51 AM, Stefan Roese wrote:
> > On 11.09.2013 09:21, Tomi Valkeinen wrote:
> >> On 10/09/13 16:17, Tero Kristo wrote:
> >>
> >>> In theory, DPLLs can also be used in their bypass mode to feed customer
> >>> nodes clocks. I just think the check in the clkoutx2_recalc is wrong,
> >>> and should be enhanced to actually check what is the target mode for the
> >>> clock once it is enabled. Maybe something like this would work properly:
> >>>
> >>> diff --git a/arch/arm/mach-omap2/dpll3xxx.c
> >>> b/arch/arm/mach-omap2/dpll3xxx.c
> >>> index 3a0296c..ba218fb 100644
> >>> --- a/arch/arm/mach-omap2/dpll3xxx.c
> >>> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> >>> @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw
> >>> *hw,
> >>>
> >>>          dd = pclk->dpll_data;
> >>>
> >>> -       WARN_ON(!dd->enable_mask);
> >>> -
> >>> -       v = __raw_readl(dd->control_reg) & dd->enable_mask;
> >>> -       v >>= __ffs(dd->enable_mask);
> >>> -       if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
> >>> +       if ((dd->flags & DPLL_J_TYPE) ||
> >>> +           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk))
> >>>                  rate = parent_rate;
> >>>          else
> >>>                  rate = parent_rate * 2;
> >>> +
> >>>          return rate;
> >>>   }
> >>
> >> Stefan, are you able to test the above?
> >>
> >> I'd rather have a proper fix for this, than hack omapdss =).
> >
> > Okay, I finally found some time to test this. The patch above generates
> > this warning:
> >
> > arch/arm/mach-omap2/dpll3xxx.c: In function 'omap3_clkoutx2_recalc':
> > arch/arm/mach-omap2/dpll3xxx.c:663:6: warning: passing argument 1 of '__clk_get_rate' from incompatible pointer type [enabled by default]
> > include/linux/clk-provider.h:423:15: note: expected 'struct clk *' but argument is of type 'struct clk_hw_omap *'
> 
> Yea sorry about that, I just quickly hacked the patch together without 
> testing it at all. :P
> 
> >
> > I then changed it (not 100% sure if correctly) to this version:
> >
> > +       if ((dd->flags & DPLL_J_TYPE) ||
> > +           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk->hw.clk))
> >
> > And this seems to work. At least the clock rate mismatch warning does not
> > appear with this patch applied (and without the clk_enable) in the
> > bootlog any more.
> 
> Yea, looks good to me, however I guess I would like second opinion on 
> this also.

Looks right to me.

Regards,
Mike

> 
> -Tero
