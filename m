From: Mike Turquette <mturquette@linaro.org>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Mon, 07 Oct 2013 18:35:37 -0700
Message-ID: <20131008013537.7445.35847@quantum>
References: <521DC143.2010506@ti.com> <521DCD80.1060600@ti.com>
 <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com>
 <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com>
 <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com>
 <alpine.DEB.2.02.1310070807320.20589@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36771 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3JHBfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 21:35:45 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so7923324pdj.32
        for <linux-omap@vger.kernel.org>; Mon, 07 Oct 2013 18:35:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1310070807320.20589@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Quoting Paul Walmsley (2013-10-07 01:21:16)
> On Tue, 10 Sep 2013, Tero Kristo wrote:
> 
> > In theory, DPLLs can also be used in their bypass mode to feed customer nodes
> > clocks. I just think the check in the clkoutx2_recalc is wrong, and should be
> > enhanced to actually check what is the target mode for the clock once it is
> > enabled. Maybe something like this would work properly:
> > 
> > diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> > index 3a0296c..ba218fb 100644
> > --- a/arch/arm/mach-omap2/dpll3xxx.c
> > +++ b/arch/arm/mach-omap2/dpll3xxx.c
> > @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
> > 
> >         dd = pclk->dpll_data;
> > 
> > -       WARN_ON(!dd->enable_mask);
> > -
> > -       v = __raw_readl(dd->control_reg) & dd->enable_mask;
> > -       v >>= __ffs(dd->enable_mask);
> > -       if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
> > +       if ((dd->flags & DPLL_J_TYPE) ||
> > +           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk))
> >                 rate = parent_rate;
> >         else
> >                 rate = parent_rate * 2;
> > +
> >         return rate;
> >  }
> > 
> 
> [...]
> 
> > Getting comment from someone like Paul would probably help here.
> 
> Looks like this is a regression from the CCF port.
> 
> Seems to me that the code above assumes that when the DPLL's rate is set 
> to the same rate as the bypass clock's rate, we can assume that the DPLL 
> is in bypass.  I wonder if that's valid in a case where a previous OS or 
> bootloader may have programmed the DPLL.

Well it used to be that calling clk_set_rate(dpll, bypass_rate) would
put it in bypass, I don't know if that is still the case. But you are
right that having the implicit assumption that 'bypass rate' == 'DPLL in
bypass' is not safe since a bootloader could lock this PLL to the same
rate as it's bypass rate.

I hope that the bypass rate stuff does not get swept away in the changes
since it is an interesting way to save a little power.

Regards,
Mike

> 
> Sounds to me like the best way to fix it would be to test whether this 
> code is intended to return the "target rate" (when the struct clk 
> representing the DPLL is disabled), versus the "current rate" (when the 
> struct clk representing the DPLL is enabled).  If it's the target rate, 
> then there's no point checking the current state of the hardware.  A check 
> similar to the above would probably be fine.  Otherwise, seems best to use 
> the existing code that does test the PLL state.
> 
> 
> 
> - Paul
