From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Mon, 02 Feb 2015 12:45:50 -0800
Message-ID: <54CFE1FE.7040404@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150201212432.22722.70917@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com, cocci@systeme.lip6.fr
List-Id: linux-omap@vger.kernel.org

On 02/01/15 13:24, Mike Turquette wrote:
> Quoting Tomeu Vizoso (2015-01-23 03:03:30)
>> Moves clock state to struct clk_core, but takes care to change as little API as
>> possible.
>>
>> struct clk_hw still has a pointer to a struct clk, which is the
>> implementation's per-user clk instance, for backwards compatibility.
>>
>> The struct clk that clk_get_parent() returns isn't owned by the caller, but by
>> the clock implementation, so the former shouldn't call clk_put() on it.
>>
>> Because some boards in mach-omap2 still register clocks statically, their clock
>> registration had to be updated to take into account that the clock information
>> is stored in struct clk_core now.
> Tero, Paul & Tony,
>
> Tomeu's patch unveils a problem with omap3_noncore_dpll_enable and
> struct dpll_data, namely this snippet from
> arch/arm/mach-omap2/dpll3xxx.c:
>
>         parent = __clk_get_parent(hw->clk);
>
>         if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
>                 WARN(parent != dd->clk_bypass,
>                                 "here0, parent name is %s, bypass name is %s\n",
>                                 __clk_get_name(parent), __clk_get_name(dd->clk_bypass));
>                 r = _omap3_noncore_dpll_bypass(clk);
>         } else {
>                 WARN(parent != dd->clk_ref,
>                                 "here1, parent name is %s, ref name is %s\n",
>                                 __clk_get_name(parent), __clk_get_name(dd->clk_ref));
>                 r = _omap3_noncore_dpll_lock(clk);
>         }
>
> struct dpll_data has members clk_ref and clk_bypass which are struct clk
> pointers. This was always a bit of a violation of the clk.h contract
> since drivers are not supposed to deref struct clk pointers. 

Julia,

Is there a way we can write a coccinelle script to check for this? The
goal being to find all drivers that are comparing struct clk pointers or
attempting to dereference them. There are probably other frameworks that
could use the same type of check (regulator, gpiod, reset, pwm, etc.).
Probably anything that has a get/put API.

-Stephen

> Now that we
> generate unique pointers for each call to clk_get (clk_ref & clk_bypass
> are populated by of_clk_get in ti_clk_register_dpll) then the pointer
> comparisons above will never be equal (even if they resolve down to the
> same struct clk_core). I added the verbose traces to the WARNs above to
> illustrate the point: the names are always the same but the pointers
> differ.
>
> AFAICT this doesn't break anything, but booting on OMAP3+ results in
> noisy WARNs.
>
> I think the correct fix is to replace clk_bypass and clk_ref pointers
> with a simple integer parent_index. In fact we already have this index.
> See how the pointers are populated in ti_clk_register_dpll:
>
>
>         dd->clk_ref = of_clk_get(node, 0);
>         dd->clk_bypass = of_clk_get(node, 1);
>
> Tony, the same problem affects the FAPLL code which copy/pastes some of
> the DPLL code.
>
> Thoughts?
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
