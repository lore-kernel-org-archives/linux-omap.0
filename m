From: Kevin Hilman <khilman@ti.com>
Subject: Re: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Thu, 05 May 2011 11:16:59 -0700
Message-ID: <87oc3hf1wk.fsf@ti.com>
References: <4DC2CED3.80206@gmail.com> <87liyljcnd.fsf@ti.com>
	<4DC2DC03.4020200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49560 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755722Ab1EESRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 14:17:03 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so1077129pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 11:17:02 -0700 (PDT)
In-Reply-To: <4DC2DC03.4020200@gmail.com> (Peter Barada's message of "Thu, 05
	May 2011 13:18:59 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Peter Barada <peter.barada@gmail.com> writes:

> On 05/05/2011 01:11 PM, Kevin Hilman wrote:
>> Peter Barada<peter.barada@gmail.com>  writes:
>>
>>> I've been working on getting the TI OMAPPSP-03.00.01.06 kernel to
>>> properly suspend/resume on my DM37x board and all was going well until
>>> I added OTG support to the kernel and on suspend, the IVA2 and CORE
>>> pwrdms would not properly go into suspend.  When comparing output from
>>> /debug/pm-debug/registers/current to the TRM, I noticed the following:
>>>
>>> MOD: CM_IVA2 (48014000)
>>>    04 =>  00000017  20 =>  00000001  24 =>  00000001  34 =>  00000001
>>>    40 =>  00080a00  44 =>  00000001  48 =>  00000003
>>> MOD: PRM_IVA2 (48316000)
>>>    50 =>  00000007  e0 =>  00ff0f05  e4 =>  00000ff7  e8 =>  00000ff7
>>>    f8 =>  00000001
>>>
>>> Looking at the TRM, the PRM_IVA2 registers are at 0x48306000, not
>>> 0x48316000.  OMAP3430_IVA2_MOD is defined in prcm-common.h as -0x800
>>> which means any module + reg_offset address calculation has to be
>>> signed.  Once I corrected the "unsigned short offset" declaration in
>>> pm_module_def, rebuilt and tested again, IVA2/core pwrdms go into
>>> suspend correctly (and addresses look correct):
>> Just to be clear, this should only affect the display of the registers,
>> not whether or not the power domains actually suspend correctly, right?
>>
>> Or, did you actually notice via some other method that this powerdomain
>> was not hitting retention/off?
> Yes the change affects the registers displayed, but since the address
> calculation is incorrect with CONFIG_PM_DEBUG enabled, the PM_DEBUG
> code is reading the CM_IVA2/PRM_IVA2 registers at incorrect addresses.
> On my DM37x board when I suspended with OTG enabled (and without the
> patch), I see the following on resume:
>
> [  496.168151] Powerdomain (iva2_pwrdm) didn't enter target state 1
> (last power state 3)
> [  496.176025] Powerdomain (core_pwrdm) didn't enter target state 1
> (last power state 3)

Hmm, this 'last power state' printk isn't in mainline, so it appears
there are some other local modifications to this code.

> [  496.183898] Could not enter target state in pm_suspend
>
> With the patch (and same kernel config) I see the following on resume:
>
> [  234.867889] Successfully put all powerdomains to target state
>
> Before enabling the OTG code all powerdomains went into suspend.
>
> It could be that accessing registers at the incorrect addresses is
> causing DM37x to keep those domains out of retention...

Hmm, very strange.  The PM debug code only ever reads registers, never
writes, so I can't imagine how that should prevent those power domains
from hitting retention.  Are there any other out-of-tree patches to the
pm-debug code in your kernel?

In any case, you've found a real bug, and your patch is valid.  However,
it doesn't currently apply to mainline, and it looks like it's because
your patch is using spaces and the code being patched is using tabs.

Also, you can simplify the changelog to to just describe the fix needed
due to using negative offsets in some PRM modules.

Kevin

>
>> Kevin
>>
>>> Signed-off-by: Peter Barada<peter.barada@logicpd.com>
>>>
>>>
>>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>>> index 125f565..b731ef3 100644
>>> --- a/arch/arm/mach-omap2/pm-debug.c
>>> +++ b/arch/arm/mach-omap2/pm-debug.c
>>> @@ -199,7 +199,7 @@ enum {
>>>   struct pm_module_def {
>>>       char name[8]; /* Name of the module */
>>>       short type; /* CM or PRM */
>>> -    unsigned short offset;
>>> +    short offset;
>>>       int low; /* First register address on this module */
>>>       int high; /* Last register address on this module */
>>>   };
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
