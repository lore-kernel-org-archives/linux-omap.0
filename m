From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 11:21:51 +0000
Message-ID: <5661774F.4030604@arm.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com> <56608B72.1040101@ti.com>
 <20151203213715.GA23396@atomide.com> <56616E74.9000604@ti.com>
 <566170D5.2070309@arm.com> <566176A2.3010101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <566176A2.3010101@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 04/12/15 11:18, Grygorii Strashko wrote:
> On 12/04/2015 12:54 PM, Sudeep Holla wrote:
>> Hi Grygorii,
>>
>> On 04/12/15 10:44, Grygorii Strashko wrote:
>>> On 12/03/2015 11:37 PM, Tony Lindgren wrote:
>>
>> [...]
>>
>>>> And these both need to be applied together when we have a fix for the
>>>> above
>>>> as otherwise we'll get the lock recursion Sudeep mentioned in patch 2/2.
>>>>
>>>
>>> Most probably below diff will fix above issue:
>>>
>>> diff --git a/arch/arm/mach-omap2/prm_common.c
>>> b/arch/arm/mach-omap2/prm_common.c
>>> index 3fc2cbe..69cde67 100644
>>> --- a/arch/arm/mach-omap2/prm_common.c
>>> +++ b/arch/arm/mach-omap2/prm_common.c
>>> @@ -338,6 +338,7 @@ int omap_prcm_register_chain_handler(struct
>>> omap_prcm_irq_setup *irq_setup)
>>>                   ct->chip.irq_ack = irq_gc_ack_set_bit;
>>>                   ct->chip.irq_mask = irq_gc_mask_clr_bit;
>>>                   ct->chip.irq_unmask = irq_gc_mask_set_bit;
>>> +               ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;
>>
>> Thanks for testing.
>
> Sry, I've not tested it yet - it's just fast assumption :(
>

OK, no worries.

>> In that case without this hunk, we should get error
>> from pcs_irq_set_wake in the suspend path. No ? May be driver is not
>> checking the error value and entering suspend.
>>
>
> Yep. Noone is checking return result from enable_irq_wake() in suspend path
> (see dev_pm_arm_wake_irq()).
>

True, but one possible reason for the warning Tony posted.

> Actually, return result of  enable_irq_wake()  is checked only in ~30% of
> cases in kernel now :)
>

That's bad, but I admit that even I failed to add check in some of the
patches I posted earlier.

-- 
Regards,
Sudeep
