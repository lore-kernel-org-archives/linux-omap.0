From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Mon, 2 Feb 2015 21:32:01 +0200
Message-ID: <54CFD0B1.2000003@ti.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50328 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222AbbBBTcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Feb 2015 14:32:20 -0500
In-Reply-To: <20150201212432.22722.70917@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/01/2015 11:24 PM, Mike Turquette wrote:
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
>
> Tero, Paul & Tony,
>
> Tomeu's patch unveils a problem with omap3_noncore_dpll_enable and
> struct dpll_data, namely this snippet from
> arch/arm/mach-omap2/dpll3xxx.c:
>
>          parent = __clk_get_parent(hw->clk);
>
>          if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
>                  WARN(parent != dd->clk_bypass,
>                                  "here0, parent name is %s, bypass name is %s\n",
>                                  __clk_get_name(parent), __clk_get_name(dd->clk_bypass));
>                  r = _omap3_noncore_dpll_bypass(clk);
>          } else {
>                  WARN(parent != dd->clk_ref,
>                                  "here1, parent name is %s, ref name is %s\n",
>                                  __clk_get_name(parent), __clk_get_name(dd->clk_ref));
>                  r = _omap3_noncore_dpll_lock(clk);
>          }
>
> struct dpll_data has members clk_ref and clk_bypass which are struct clk
> pointers. This was always a bit of a violation of the clk.h contract
> since drivers are not supposed to deref struct clk pointers. Now that we
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

The problem is we still need to be able to get runtime parent clock 
rates (the parent rate may change also), so simple index value is not 
sufficient. We need a handle of some sort to the bypass/ref clocks. The 
DPLL code generally requires knowledge of the bypass + reference clock 
rates to work properly, as it calculates the M/N values based on these.

Shall I change the DPLL code to check against clk_hw pointers or what is 
the preferred approach here? The patch at the end does this and fixes 
the dpll related warnings.

Btw, the rate constraints patch broke boot for me completely, but sounds 
like you reverted it already.

-Tero

--------------------

Author: Tero Kristo <t-kristo@ti.com>
Date:   Mon Feb 2 17:19:17 2015 +0200

     ARM: OMAP3+: clock: dpll: fix logic for comparing parent clocks

     DPLL code uses reference and bypass clock pointers for determining 
runtime
     properties for these clocks, like parent clock rates.

     As clock API now returns per-user clock structs, using a global handle
     in the clock driver code does not work properly anymore. Fix this by
     using the clk_hw instead, and comparing this against the parents.

     Signed-off-by: Tero Kristo <t-kristo@ti.com>
     Fixes: 59cf3fcf9baf ("clk: Make clk API return per-user struct clk 
instances")

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index c2da2a0..49752d7 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -410,7 +410,7 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
  	int r;
  	struct dpll_data *dd;
-	struct clk *parent;
+	struct clk_hw *parent;

  	dd = clk->dpll_data;
  	if (!dd)
@@ -427,13 +427,13 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
  		}
  	}

-	parent = __clk_get_parent(hw->clk);
+	parent = __clk_get_hw(__clk_get_parent(hw->clk));

  	if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
-		WARN_ON(parent != dd->clk_bypass);
+		WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
  		r = _omap3_noncore_dpll_bypass(clk);
  	} else {
-		WARN_ON(parent != dd->clk_ref);
+		WARN_ON(parent != __clk_get_hw(dd->clk_ref));
  		r = _omap3_noncore_dpll_lock(clk);
  	}

@@ -549,7 +549,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, 
unsigned long rate,
  	if (!dd)
  		return -EINVAL;

-	if (__clk_get_parent(hw->clk) != dd->clk_ref)
+	if (__clk_get_hw(__clk_get_parent(hw->clk)) !=
+	    __clk_get_hw(dd->clk_ref))
  		return -EINVAL;

  	if (dd->last_rounded_rate == 0)


