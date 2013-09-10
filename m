From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 14:25:19 +0200
Message-ID: <522F0FAF.3040000@gmail.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:61208 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3IJMZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 08:25:31 -0400
In-Reply-To: <522F0CC7.50501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On 10.09.2013 14:12, Tero Kristo wrote:
>> I debugged this a bit and found that this issue (dpll4_m4x2_ck clock is
>> not 2 times dpll4_m4_ck) results from this code:
>>
>> arch/arm/mach-omap2/dpll3xxx.c:
>>
>> unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
>> 				    unsigned long parent_rate)
>> {
>> 	...
>> 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 		rate = parent_rate;
>> 	else
>> 		rate = parent_rate * 2;
>> 	return rate;
>> }
>>
>> As marked above, v is at that early time 0x1 (unmasked value of this
>> register is 0x38310037). So the DPLL4 is not locked but in low power top
>> mode (OMAP3XXX_EN_DPLL_LOCKED = 0x7).
>>
>> Any hint whats missing here?
> 
> If it claims it is not locked, it means the DPLL itself is disabled. You 
> could try clk_enable for the clock before doing clk_set_rate.

Yes, of course. This solves this issue. Thanks.

Tomi, most likely some clk_enable() / clk_disable() calls are missing
from the PM functions as well?

Cheers,
Stefan

