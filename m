From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 04/33] CLK: omap: move part of the machine specific
 clock header contents to driver
Date: Thu, 1 Aug 2013 10:21:34 -0500
Message-ID: <51FA7CFE.8050507@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-5-git-send-email-t-kristo@ti.com> <51F8045C.6020603@ti.com> <51F8E00E.7070506@ti.com> <51FA6B06.3000904@ti.com> <51FA7AD0.8010000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46020 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719Ab3HAPV7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Aug 2013 11:21:59 -0400
In-Reply-To: <51FA7AD0.8010000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/01/2013 10:12 AM, Tero Kristo wrote:
> On 08/01/2013 05:04 PM, Nishanth Menon wrote:
>> On 07/31/2013 04:59 AM, Tero Kristo wrote:
>>> On 07/30/2013 09:22 PM, Nishanth Menon wrote:
>>>> this patch should be 3/33 to allow dpll.c to build.
>>>>
>>>> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>>>>> Some of the clock.h contents are needed by the new OMAP clock driver,
>>>>> including dpll_data and clk_hw_omap. Thus, move these to the generic
>>>>> omap header file which can be accessed by the driver.
>>>>>
>>>> Looking at the change, I wonder what the rules are for the movement?
>>>> commit message was not clear.
>>>
>>> This is kind of a merge of almost everything that is needed by clock
>>> drivers at some point. I can move the changes along to the patches that
>>> actually need the exports for clarity and to keep compilation clean.
>>
>> I think it is better to do in stages (while ensuring compilation is
>> clean) - it is a bit hard to understand need and context of movement
>> when a singular movement is done :(
>
> Yep, will do the change for this.
>
>> [..]
>>>>> @@ -356,28 +230,13 @@ unsigned long omap_fixed_divisor_recalc(struct
>>>>> clk_hw *hw,
>>>>>   /* DPLL Type and DCO Selection Flags */
>>>>>   #define DPLL_J_TYPE        0x1
>>>>>
>>>>> -long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long
>>>>> target_rate,
>>>>> -            unsigned long *parent_rate);
>>>>> -unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long
>>>>> parent_rate);
>>>>> -int omap3_noncore_dpll_enable(struct clk_hw *hw);
>>>>> -void omap3_noncore_dpll_disable(struct clk_hw *hw);
>>>>> -int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long
>>>>> rate,
>>>>> -                unsigned long parent_rate);
>>>>
>>>> Why are these being moved to generic?
>>>
>>> These are used from the dpll.c by the ops.
>>
>> The ops should probably move as well from mach-omap2. No reason to keep
>> it around in mach-omap2 then.
>
> There is reason.... I don't want to move _everything_ from mach-omap2 in
> the first phase. But after initial support is in, yes, they can be moved.

I will re-iterate my suggestion again - DPLL enable/disable stuff is 
going to be a series of steps, which would not change if we do DT or 
non-DT. currently those steps reside inside mach-omap2. having a driver 
call into mach-omap2 is counter-intutive, at least to me. if we want to 
have a cleanup in the future, mach-omap2 should depend on drivers/clk 
rather than the other way around. This is the reason of requesting files 
in drivers/clk to be as isolated as possible - dpll operations (the 
actual steps) of doing dpll configuration does sound isolated enough to 
move into drivers/clk and not have reverse dependencies.

Any reverse dependencies should be clearly mentioned with reasoning why 
it cannot be moved in the respective patches, it was a little hard for 
me to indicate precisely which functions make absolutely no sense and 
which not.

I am not saying this is an easy step to do, but for our future cleanups, 
it does sound reasonable to expect from this series.

-- 
Regards,
Nishanth Menon
