From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Tue, 10 Sep 2013 15:12:55 +0300
Message-ID: <522F0CC7.50501@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46768 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab3IJMNA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Sep 2013 08:13:00 -0400
In-Reply-To: <522F0390.9050802@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>

On 09/10/2013 02:33 PM, Stefan Roese wrote:
> On 28.08.2013 13:40, Tero Kristo wrote:
>> On 08/28/2013 01:14 PM, Tomi Valkeinen wrote:
>>> On 28/08/13 12:48, Tero Kristo wrote:
>>>> On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> I'm seeing odd clock behavior with Beagle, booting with DT. I'm using
>>>>> v3.11-rc7 + DSS DT patches.
>>>>
>>>> I guess you are not using the clock DT patches? Just making sure I
>>>> didn't break anything. :)
>>>
>>> No, plain rc7 with my DSS DT patches.
>>>
>>>>> So, for some reason, the first clk_set_rate goes wrong. Any ideas?
>>>>
>>>> Hmm, strange. I am not seeing similar behavior, but I am calling
>>>> clk_set_rate in different location.... also I am using clock DT patches
>>>> (don't try the current version though, as I am reworking them.)
>>>>
>>>> [    0.000000] dpll4_ck: 432000000
>>>> [    0.000000] dpll4_m4_ck: 72000000
>>>> [    0.000000] dpll4_m4x2_ck: 144000000
>>>> [    0.000000] dss1_alwon_fck_3430es2: 144000000
>>>> [    0.000000] dpll4_ck: 432000000
>>>> [    0.000000] dpll4_m4_ck: 86400000
>>>> [    0.000000] dpll4_m4x2_ck: 172800000
>>>> [    0.000000] dss1_alwon_fck_3430es2: 172800000
>>>>
>>>> Do you see the error only when setting to some specific rate (86400000)
>>>> or it doesn't matter?
>>>
>>> I also tried setting to 72000000, with the same result.
>>>
>>> Do you know if I can somehow easily get debug prints from the clock
>>> framework, that could lighten up the issue?
>>
>> There isn't any good config option for that, I would suggest add prints
>> to the clk_set_rate and then for the clocks you are interested in, print
>> results for the recalc_rate / set_rate ops also.
>
> I debugged this a bit and found that this issue (dpll4_m4x2_ck clock is
> not 2 times dpll4_m4_ck) results from this code:
>
> arch/arm/mach-omap2/dpll3xxx.c:
>
> unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
> 				    unsigned long parent_rate)
> {
> 	...
> 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		rate = parent_rate;
> 	else
> 		rate = parent_rate * 2;
> 	return rate;
> }
>
> As marked above, v is at that early time 0x1 (unmasked value of this
> register is 0x38310037). So the DPLL4 is not locked but in low power top
> mode (OMAP3XXX_EN_DPLL_LOCKED = 0x7).
>
> Any hint whats missing here?

If it claims it is not locked, it means the DPLL itself is disabled. You 
could try clk_enable for the clock before doing clk_set_rate.

-Tero

