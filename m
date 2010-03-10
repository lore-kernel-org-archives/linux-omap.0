From: ambresh <a0393775@ti.com>
Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Wed, 10 Mar 2010 12:38:16 +0530
Message-ID: <4B974560.5070704@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com> <4B94CC12.3000104@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB3DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43419 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0CJHIY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 02:08:24 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321DCB3DC@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gurav , Pramod" <pramod.gurav@ti.com>
Cc: "K, Ambresh" <ambresh@ti.com>, "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Kandasamy, Rajkumar" <rajkumark@ti.com>

Gurav , Pramod wrote:
> Hi Ambresh,
> 
>>> +	clk_sel_regval = cm_read_mod_reg(PLL_MOD, CM_CLKSEL);
>> *clk already as reference to CM_CLKSEL:
>>
>>   static struct clk dpll3_m2_ck = {
>> [...]
>>          .clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
>>          .clksel_mask    = OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
>> [...]
>>
>> so please use .clksel_reg to read the register content.
>>
> 
> This will be done.
> 
>>> +	sys_clk_rate = clk_get_rate(clk_get(NULL, "osc_sys_ck"));
>> Should it be "sys_ck" instead of "osc_sys_ck"?
>>
>> According to my understanding from trm, I guess CLKINP represents DPLL3
>> reference clock (DPLL3_ALWON_FCLK) which is nothing but "sys_ck".
>>
>> Should not make a difference when the sys_clk divisor is 1, but if it is
>> 2, then sys_ck=osc_sys_ck/2.
> 
> 
> Yes, it has to be sys_ck and it will be taken care.
> 
>>> +	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
>>> +	nr1 = (4 * (core_dpll_div_n + 1) * 2 * core_dpll_clkoutdiv_m2 *
>>> +							 core_dpll_mul_m);
>>> +	nr2 = 8 * (core_dpll_div_n + 1);
>>> +	nr = nr1 + nr2;
>>> +
>>> +	dr = 2 * sys_clk_rate * core_dpll_mul_m * core_dpll_clkoutdiv_m2;
>>> +
>> I am not able to understand the calculations completely for
>> (nr1 + nr2) / dr. and I guess you could simplify the calculation a bit
>> by removing the redundant multiplications and divisions.
>> And also may be you can use m, n & m2 instead of core_dpll_xxx_xx, to
>> make code more readable.
>>

We can get ride of the steps used to calculate CLKOUTX2, by simply 
calling parent's (dpll3_ck) clk->recalc function pointer.

recalc function will return CLKOUT, so CLKOUTX2 = CLKOUT * 2.

pseudo code
------------
struct clk *parent = clk->parent;
clkout = parent->recalc();
clkoutx2 = clkout * 2;

To derive REFCLK. the only unknown parameter will be N, which can be 
read from .clksel_reg.

Why can't we use do_div() api to calculate REFCLK, instead of manual 
calculation?


Regards,
Ambresh




> 
> I am restructuring the formula with appropriate variable names.
> 
> 
> Thank you for your comments.
> 
> Regards,
> Pramod

