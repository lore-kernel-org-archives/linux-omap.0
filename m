From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk instances
Date: Mon, 02 Feb 2015 14:41:39 -0800
Message-ID: <20150202224139.421.84094@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFD0B1.2000003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:42020 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965378AbbBBWlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 17:41:44 -0500
Received: by mail-ie0-f182.google.com with SMTP id ar1so21008528iec.13
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2015 14:41:43 -0800 (PST)
In-Reply-To: <54CFD0B1.2000003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Tero Kristo (2015-02-02 11:32:01)
> On 02/01/2015 11:24 PM, Mike Turquette wrote:
> > Quoting Tomeu Vizoso (2015-01-23 03:03:30)
> >> Moves clock state to struct clk_core, but takes care to change as little API as
> >> possible.
> >>
> >> struct clk_hw still has a pointer to a struct clk, which is the
> >> implementation's per-user clk instance, for backwards compatibility.
> >>
> >> The struct clk that clk_get_parent() returns isn't owned by the caller, but by
> >> the clock implementation, so the former shouldn't call clk_put() on it.
> >>
> >> Because some boards in mach-omap2 still register clocks statically, their clock
> >> registration had to be updated to take into account that the clock information
> >> is stored in struct clk_core now.
> >
> > Tero, Paul & Tony,
> >
> > Tomeu's patch unveils a problem with omap3_noncore_dpll_enable and
> > struct dpll_data, namely this snippet from
> > arch/arm/mach-omap2/dpll3xxx.c:
> >
> >          parent = __clk_get_parent(hw->clk);
> >
> >          if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
> >                  WARN(parent != dd->clk_bypass,
> >                                  "here0, parent name is %s, bypass name is %s\n",
> >                                  __clk_get_name(parent), __clk_get_name(dd->clk_bypass));
> >                  r = _omap3_noncore_dpll_bypass(clk);
> >          } else {
> >                  WARN(parent != dd->clk_ref,
> >                                  "here1, parent name is %s, ref name is %s\n",
> >                                  __clk_get_name(parent), __clk_get_name(dd->clk_ref));
> >                  r = _omap3_noncore_dpll_lock(clk);
> >          }
> >
> > struct dpll_data has members clk_ref and clk_bypass which are struct clk
> > pointers. This was always a bit of a violation of the clk.h contract
> > since drivers are not supposed to deref struct clk pointers. Now that we
> > generate unique pointers for each call to clk_get (clk_ref & clk_bypass
> > are populated by of_clk_get in ti_clk_register_dpll) then the pointer
> > comparisons above will never be equal (even if they resolve down to the
> > same struct clk_core). I added the verbose traces to the WARNs above to
> > illustrate the point: the names are always the same but the pointers
> > differ.
> >
> > AFAICT this doesn't break anything, but booting on OMAP3+ results in
> > noisy WARNs.
> >
> > I think the correct fix is to replace clk_bypass and clk_ref pointers
> > with a simple integer parent_index. In fact we already have this index.
> > See how the pointers are populated in ti_clk_register_dpll:
> 
> The problem is we still need to be able to get runtime parent clock 
> rates (the parent rate may change also), so simple index value is not 
> sufficient. We need a handle of some sort to the bypass/ref clocks. The 
> DPLL code generally requires knowledge of the bypass + reference clock 
> rates to work properly, as it calculates the M/N values based on these.

We can maybe introduce something like of_clk_get_parent_rate, as we have
analogous stuff for getting parent names and indexes. Without
introducing a new helper you could probably just do:

	clk_ref = clk_get_parent_by_index(dpll_clk, 0);
	ref_rate = clk_get_rate(clk_ref);

	clk_bypass = clk_get_parent_by_index(dpll_clk, 1);
	bypass_rate = clk_get_rate(clk_bypass);

Currently the semantics around this call are weird. It seems like it
would create a new struct clk pointer but it does not. So don't call
clk_put on clk_ref and clk_bypass yet. That might change in the future
as we iron out this brave new world that we all live in. Probably best
to leave a FIXME in there.

Stephen & Tomeu, let me know if I got any of that wrong.

> 
> Shall I change the DPLL code to check against clk_hw pointers or what is 
> the preferred approach here? The patch at the end does this and fixes 
> the dpll related warnings.

Yes, for now that is fine, but feels a bit hacky to me. I don't know
honestly, let me sleep on it. Anyways for 3.20 that is perfectly fine
but we might want to switch to something like the scheme above.

> 
> Btw, the rate constraints patch broke boot for me completely, but sounds 
> like you reverted it already.

Fixed with Stephen's patch from last week. Thanks for dealing with all
the breakage so promptly. It has helped a lot!

Regards,
Mike

> 
> -Tero
> 
> --------------------
> 
> Author: Tero Kristo <t-kristo@ti.com>
> Date:   Mon Feb 2 17:19:17 2015 +0200
> 
>      ARM: OMAP3+: clock: dpll: fix logic for comparing parent clocks
> 
>      DPLL code uses reference and bypass clock pointers for determining 
> runtime
>      properties for these clocks, like parent clock rates.
> 
>      As clock API now returns per-user clock structs, using a global handle
>      in the clock driver code does not work properly anymore. Fix this by
>      using the clk_hw instead, and comparing this against the parents.
> 
>      Signed-off-by: Tero Kristo <t-kristo@ti.com>
>      Fixes: 59cf3fcf9baf ("clk: Make clk API return per-user struct clk 
> instances")
> 
> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> index c2da2a0..49752d7 100644
> --- a/arch/arm/mach-omap2/dpll3xxx.c
> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> @@ -410,7 +410,7 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
>         struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>         int r;
>         struct dpll_data *dd;
> -       struct clk *parent;
> +       struct clk_hw *parent;
> 
>         dd = clk->dpll_data;
>         if (!dd)
> @@ -427,13 +427,13 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
>                 }
>         }
> 
> -       parent = __clk_get_parent(hw->clk);
> +       parent = __clk_get_hw(__clk_get_parent(hw->clk));
> 
>         if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
> -               WARN_ON(parent != dd->clk_bypass);
> +               WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
>                 r = _omap3_noncore_dpll_bypass(clk);
>         } else {
> -               WARN_ON(parent != dd->clk_ref);
> +               WARN_ON(parent != __clk_get_hw(dd->clk_ref));
>                 r = _omap3_noncore_dpll_lock(clk);
>         }
> 
> @@ -549,7 +549,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, 
> unsigned long rate,
>         if (!dd)
>                 return -EINVAL;
> 
> -       if (__clk_get_parent(hw->clk) != dd->clk_ref)
> +       if (__clk_get_hw(__clk_get_parent(hw->clk)) !=
> +           __clk_get_hw(dd->clk_ref))
>                 return -EINVAL;
> 
>         if (dd->last_rounded_rate == 0)
> 
> 
