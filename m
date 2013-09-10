From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 16:17:45 +0300
Message-ID: <522F1BF9.5050006@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49538 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208Ab3IJNSA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 09:18:00 -0400
In-Reply-To: <522F1346.3020206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On 09/10/2013 03:40 PM, Tomi Valkeinen wrote:
> On 10/09/13 15:24, Tero Kristo wrote:
>> On 09/10/2013 03:19 PM, Tomi Valkeinen wrote:
>>> On 10/09/13 15:12, Tero Kristo wrote:
>>>
>>>> If it claims it is not locked, it means the DPLL itself is disabled. You
>>>> could try clk_enable for the clock before doing clk_set_rate.
>>>
>>> Hmm, so is it required to enable the clock before setting the rate? If
>>> so, I think I'm using the clocks wrong in all the places =).
>>
>> In generic case, it is not. But DPLLs behave strangely if they go to low
>> power stop mode. If there is any downstream clock enabled for a specific
>> DPLL it is enabled and things work okay.
>>
>> One could also argue that the API behavior in OMAP is wrong currently,
>> as the bypass rate is something you are most likely never actually going
>> to use for anything....
>>
>> Just try the change and check the results.
>
> Ok, so as Stefan said, enabling the clock fixes the issue.
>
> How do you suggest we fix this? Changing omapdss to enable the clock
> before changing its rate is not very difficult, so it can be used as a
> quick fix. But it doesn't sound like a proper fix if this is not
> normally required.

The quick fix sounds good to me.

> And, maybe I'm missing something as I don't have good understanding of
> the PRCM's PLLs, but the current behavior sounds odd. So the DPLL is
> off, and in bypass mode. When we try to change the rate of the clock
> provided by the PLL, shouldn't it fail, as bypass mode's rate cannot be
> changed? Or better, change the non-bypass rate.

In theory, DPLLs can also be used in their bypass mode to feed customer 
nodes clocks. I just think the check in the clkoutx2_recalc is wrong, 
and should be enhanced to actually check what is the target mode for the 
clock once it is enabled. Maybe something like this would work properly:

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3a0296c..ba218fb 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,

         dd = pclk->dpll_data;

-       WARN_ON(!dd->enable_mask);
-
-       v = __raw_readl(dd->control_reg) & dd->enable_mask;
-       v >>= __ffs(dd->enable_mask);
-       if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
+       if ((dd->flags & DPLL_J_TYPE) ||
+           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk))
                 rate = parent_rate;
         else
                 rate = parent_rate * 2;
+
         return rate;
  }


>
> How is the DPLL4's clock rate 432000000 anyway in bypass mode. Isn't
> bypass mode usually plain sys-clock, or such?

This again reflects the rate that the clock has once it is enabled, the 
clkoutx2 does not.

Getting comment from someone like Paul would probably help here.

-Tero

