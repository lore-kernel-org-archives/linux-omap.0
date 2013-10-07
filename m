From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Mon, 7 Oct 2013 08:21:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310070807320.20589@utopia.booyaka.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com>
 <522F1BF9.5050006@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52736 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3JGIVR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 04:21:17 -0400
In-Reply-To: <522F1BF9.5050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>

On Tue, 10 Sep 2013, Tero Kristo wrote:

> In theory, DPLLs can also be used in their bypass mode to feed customer nodes
> clocks. I just think the check in the clkoutx2_recalc is wrong, and should be
> enhanced to actually check what is the target mode for the clock once it is
> enabled. Maybe something like this would work properly:
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index 3a0296c..ba218fb 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
> 
>         dd = pclk->dpll_data;
> 
> -       WARN_ON(!dd->enable_mask);
> -
> -       v = __raw_readl(dd->control_reg) & dd->enable_mask;
> -       v >>= __ffs(dd->enable_mask);
> -       if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
> +       if ((dd->flags & DPLL_J_TYPE) ||
> +           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk))
>                 rate = parent_rate;
>         else
>                 rate = parent_rate * 2;
> +
>         return rate;
>  }
> 

[...]

> Getting comment from someone like Paul would probably help here.

Looks like this is a regression from the CCF port.

Seems to me that the code above assumes that when the DPLL's rate is set 
to the same rate as the bypass clock's rate, we can assume that the DPLL 
is in bypass.  I wonder if that's valid in a case where a previous OS or 
bootloader may have programmed the DPLL.

Sounds to me like the best way to fix it would be to test whether this 
code is intended to return the "target rate" (when the struct clk 
representing the DPLL is disabled), versus the "current rate" (when the 
struct clk representing the DPLL is enabled).  If it's the target rate, 
then there's no point checking the current state of the hardware.  A check 
similar to the above would probably be fine.  Otherwise, seems best to use 
the existing code that does test the PLL state.



- Paul

