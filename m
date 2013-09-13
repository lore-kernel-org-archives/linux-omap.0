From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Fri, 13 Sep 2013 09:51:47 +0200
Message-ID: <5232C413.8010207@gmail.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com> <523019EE.5000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:43244 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab3IMHwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Sep 2013 03:52:01 -0400
In-Reply-To: <523019EE.5000508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On 11.09.2013 09:21, Tomi Valkeinen wrote:
> On 10/09/13 16:17, Tero Kristo wrote:
> 
>> In theory, DPLLs can also be used in their bypass mode to feed customer
>> nodes clocks. I just think the check in the clkoutx2_recalc is wrong,
>> and should be enhanced to actually check what is the target mode for the
>> clock once it is enabled. Maybe something like this would work properly:
>>
>> diff --git a/arch/arm/mach-omap2/dpll3xxx.c
>> b/arch/arm/mach-omap2/dpll3xxx.c
>> index 3a0296c..ba218fb 100644
>> --- a/arch/arm/mach-omap2/dpll3xxx.c
>> +++ b/arch/arm/mach-omap2/dpll3xxx.c
>> @@ -658,14 +658,12 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw
>> *hw,
>>
>>         dd = pclk->dpll_data;
>>
>> -       WARN_ON(!dd->enable_mask);
>> -
>> -       v = __raw_readl(dd->control_reg) & dd->enable_mask;
>> -       v >>= __ffs(dd->enable_mask);
>> -       if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
>> +       if ((dd->flags & DPLL_J_TYPE) ||
>> +           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk))
>>                 rate = parent_rate;
>>         else
>>                 rate = parent_rate * 2;
>> +
>>         return rate;
>>  }
> 
> Stefan, are you able to test the above?
> 
> I'd rather have a proper fix for this, than hack omapdss =).

Okay, I finally found some time to test this. The patch above generates
this warning:

arch/arm/mach-omap2/dpll3xxx.c: In function 'omap3_clkoutx2_recalc':
arch/arm/mach-omap2/dpll3xxx.c:663:6: warning: passing argument 1 of '__clk_get_rate' from incompatible pointer type [enabled by default]
include/linux/clk-provider.h:423:15: note: expected 'struct clk *' but argument is of type 'struct clk_hw_omap *'

I then changed it (not 100% sure if correctly) to this version:

+       if ((dd->flags & DPLL_J_TYPE) ||
+           __clk_get_rate(dd->clk_bypass) == __clk_get_rate(pclk->hw.clk))

And this seems to work. At least the clock rate mismatch warning does not
appear with this patch applied (and without the clk_enable) in the
bootlog any more.

Thanks,
Stefan

