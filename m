From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk instances
Date: Mon, 02 Feb 2015 14:48:09 -0800
Message-ID: <20150202224809.421.95878@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFD0B1.2000003@ti.com>
 <20150202204402.GG9418@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:41476 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273AbbBBWsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2015 17:48:14 -0500
Received: by mail-ig0-f170.google.com with SMTP id l13so20597302iga.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Feb 2015 14:48:13 -0800 (PST)
In-Reply-To: <20150202204402.GG9418@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Quoting Tony Lindgren (2015-02-02 12:44:02)
> * Tero Kristo <t-kristo@ti.com> [150202 11:35]:
> > On 02/01/2015 11:24 PM, Mike Turquette wrote:
> > >Quoting Tomeu Vizoso (2015-01-23 03:03:30)
> > >
> > >AFAICT this doesn't break anything, but booting on OMAP3+ results in
> > >noisy WARNs.
> > >
> > >I think the correct fix is to replace clk_bypass and clk_ref pointers
> > >with a simple integer parent_index. In fact we already have this index.
> > >See how the pointers are populated in ti_clk_register_dpll:
> > 
> > The problem is we still need to be able to get runtime parent clock rates
> > (the parent rate may change also), so simple index value is not sufficient.
> > We need a handle of some sort to the bypass/ref clocks. The DPLL code
> > generally requires knowledge of the bypass + reference clock rates to work
> > properly, as it calculates the M/N values based on these.
> > 
> > Shall I change the DPLL code to check against clk_hw pointers or what is the
> > preferred approach here? The patch at the end does this and fixes the dpll
> > related warnings.
> > 
> > Btw, the rate constraints patch broke boot for me completely, but sounds
> > like you reverted it already.
> 
> Thanks Tero, looks like your fix fixes all the issues I'm seeing with
> commit 59cf3fcf9baf. That is noisy dmesg, dpll_abe_ck not locking
> on 4430sdp, and off-idle not working for omap3.
> 
> I could not get the patch to apply, below is what I applied manually.
> 
> Mike, If possible, maybe fold this into 59cf3fcf9baf? It applies with
> some fuzz on that too. And inn that case, please feel also to add the
> following for Tomeu's patch:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

Done and done. Things look good in my testing. I've pushed another
branch out to the mirrors and hopefully the autobuild/autoboot testing
will give us the green light.

This implementation can be revisited probably after 3.19 comes out if
Tero doesn't like using clk_hw directly, or if we provide a better
interface.

Thanks,
Mike

> 
> 8<------------
> From: Tero Kristo <t-kristo@ti.com>
> Date: Mon, 2 Feb 2015 12:17:00 -0800
> Subject: [PATCH] ARM: OMAP3+: clock: dpll: fix logic for comparing parent clocks
> 
> DPLL code uses reference and bypass clock pointers for determining runtime
> properties for these clocks, like parent clock rates.
> As clock API now returns per-user clock structs, using a global handle
> in the clock driver code does not work properly anymore. Fix this by
> using the clk_hw instead, and comparing this against the parents.
> 
> Fixes: 59cf3fcf9baf ("clk: Make clk API return per-user struct clk instances")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> [tony@atomide.com: updated to apply]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
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
> @@ -549,7 +549,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (!dd)
>                 return -EINVAL;
>  
> -       if (__clk_get_parent(hw->clk) != dd->clk_ref)
> +       if (__clk_get_hw(__clk_get_parent(hw->clk)) !=
> +           __clk_get_hw(dd->clk_ref))
>                 return -EINVAL;
>  
>         if (dd->last_rounded_rate == 0)
