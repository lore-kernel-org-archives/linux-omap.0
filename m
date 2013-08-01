From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 04/33] CLK: omap: move part of the machine specific
 clock header contents to driver
Date: Thu, 1 Aug 2013 18:12:16 +0300
Message-ID: <51FA7AD0.8010000@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-5-git-send-email-t-kristo@ti.com> <51F8045C.6020603@ti.com> <51F8E00E.7070506@ti.com> <51FA6B06.3000904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab3HAPMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 11:12:43 -0400
In-Reply-To: <51FA6B06.3000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/01/2013 05:04 PM, Nishanth Menon wrote:
> On 07/31/2013 04:59 AM, Tero Kristo wrote:
>> On 07/30/2013 09:22 PM, Nishanth Menon wrote:
>>> this patch should be 3/33 to allow dpll.c to build.
>>>
>>> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>>>> Some of the clock.h contents are needed by the new OMAP clock driver,
>>>> including dpll_data and clk_hw_omap. Thus, move these to the generic
>>>> omap header file which can be accessed by the driver.
>>>>
>>> Looking at the change, I wonder what the rules are for the movement?
>>> commit message was not clear.
>>
>> This is kind of a merge of almost everything that is needed by clock
>> drivers at some point. I can move the changes along to the patches that
>> actually need the exports for clarity and to keep compilation clean.
>
> I think it is better to do in stages (while ensuring compilation is
> clean) - it is a bit hard to understand need and context of movement
> when a singular movement is done :(

Yep, will do the change for this.

> [..]
>>>> @@ -356,28 +230,13 @@ unsigned long omap_fixed_divisor_recalc(struct
>>>> clk_hw *hw,
>>>>   /* DPLL Type and DCO Selection Flags */
>>>>   #define DPLL_J_TYPE        0x1
>>>>
>>>> -long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long
>>>> target_rate,
>>>> -            unsigned long *parent_rate);
>>>> -unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long
>>>> parent_rate);
>>>> -int omap3_noncore_dpll_enable(struct clk_hw *hw);
>>>> -void omap3_noncore_dpll_disable(struct clk_hw *hw);
>>>> -int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>>>> -                unsigned long parent_rate);
>>>
>>> Why are these being moved to generic?
>>
>> These are used from the dpll.c by the ops.
>
> The ops should probably move as well from mach-omap2. No reason to keep
> it around in mach-omap2 then.

There is reason.... I don't want to move _everything_ from mach-omap2 in 
the first phase. But after initial support is in, yes, they can be moved.

> [...]
>
>>>> diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
>>>> index 647f02f..cba892a 100644
>>>> --- a/include/linux/clk/omap.h
>>>> +++ b/include/linux/clk/omap.h
>>>> @@ -19,6 +19,161 @@
>>>>   #ifndef __LINUX_CLK_OMAP_H_
>>>>   #define __LINUX_CLK_OMAP_H_
>>>>
>>>> -int __init dt_omap_clk_init(void);
>>>> +/**
>>>> + * struct dpll_data - DPLL registers and integration data
>>>> + * @mult_div1_reg: register containing the DPLL M and N bitfields
>>>> + * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
>>>> + * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
>>>> + * @clk_bypass: struct clk pointer to the clock's bypass clock input
>>>> + * @clk_ref: struct clk pointer to the clock's reference clock input
>>>> + * @control_reg: register containing the DPLL mode bitfield
>>>> + * @enable_mask: mask of the DPLL mode bitfield in @control_reg
>>>> + * @last_rounded_rate: cache of the last rate result of
>>>> omap2_dpll_round_rate()
>>>> + * @last_rounded_m: cache of the last M result of
>>>> omap2_dpll_round_rate()
>>>> + * @last_rounded_m4xen: cache of the last M4X result of
>>>> + *                     omap4_dpll_regm4xen_round_rate()
>>>> + * @last_rounded_lpmode: cache of the last lpmode result of
>>>> + *                      omap4_dpll_lpmode_recalc()
>>>> + * @max_multiplier: maximum valid non-bypass multiplier value (actual)
>>>> + * @last_rounded_n: cache of the last N result of
>>>> omap2_dpll_round_rate()
>>>> + * @min_divider: minimum valid non-bypass divider value (actual)
>>>> + * @max_divider: maximum valid non-bypass divider value (actual)
>>>> + * @modes: possible values of @enable_mask
>>>> + * @autoidle_reg: register containing the DPLL autoidle mode bitfield
>>>> + * @idlest_reg: register containing the DPLL idle status bitfield
>>>> + * @autoidle_mask: mask of the DPLL autoidle mode bitfield in
>>>> @autoidle_reg
>>>> + * @freqsel_mask: mask of the DPLL jitter correction bitfield in
>>>> @control_reg
>>>> + * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
>>>> + * @lpmode_mask: mask of the DPLL low-power mode bitfield in
>>>> @control_reg
>>>> + * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in
>>>> @control_reg
>>>> + * @auto_recal_bit: bitshift of the driftguard enable bit in
>>>> @control_reg
>>>> + * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for
>>>> recalibration IRQs
>>>> + * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for
>>>> recalibration IRQs
>>>> + * @flags: DPLL type/features (see below)
>>>> + *
>>>> + * Possible values for @flags:
>>>> + * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
>>> but the flag is in arch/arm/mach-omap2/clock.h ?
>>
>> I'll look at this and probably move the flag also.
>>
>>>
>>>> + *
>>>> + * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
>>>> + *
>>>> + * XXX Some DPLLs have multiple bypass inputs, so it's not technically
>>>> + * correct to only have one @clk_bypass pointer.
>>>> + *
>>>> + * XXX The runtime-variable fields (@last_rounded_rate,
>>>> @last_rounded_m,
>>>> + * @last_rounded_n) should be separated from the runtime-fixed fields
>>>> + * and placed into a different structure, so that the runtime-fixed
>>>> data
>>>> + * can be placed into read-only space.
>>>> + */
>>>> +struct dpll_data {
>>>
>>> is it necessary to export this? usage is limited to dpll.c and could be
>>> made private to it alone, no?
>>
>> No, unfortunately dpll_data is used both by the dpll.c and the support
>> code under mach-omap2. This is some sort of intermediate solution, so
>> get DT clocks working first, then move the support code also under
>> drivers/clk/omap.
>
> looks like a case for omap_dpll.h instead of a single mega header with
> everything in it?

Well, I am not sure we want to do that, as some stuff will be in 
clk/omap.h and it will be removed once these are moved inside the clk 
driver. The end result should be a header with minimal contents, but it 
is going to be rather large during the intermediate evolution phase.

-Tero
