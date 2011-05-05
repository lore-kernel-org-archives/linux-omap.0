From: Kevin Hilman <khilman@ti.com>
Subject: Re: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Thu, 05 May 2011 13:11:37 -0700
Message-ID: <8739ksgb5y.fsf@ti.com>
References: <4DC2CED3.80206@gmail.com> <87liyljcnd.fsf@ti.com>
	<4DC2DC03.4020200@gmail.com> <87oc3hf1wk.fsf@ti.com>
	<4DC2FADB.2050208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36439 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580Ab1EEULm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 16:11:42 -0400
Received: by pzk37 with SMTP id 37so2052193pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 13:11:40 -0700 (PDT)
In-Reply-To: <4DC2FADB.2050208@gmail.com> (Peter Barada's message of "Thu, 05
	May 2011 15:30:35 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Peter Barada <peter.barada@gmail.com> writes:

> On 05/05/2011 02:16 PM, Kevin Hilman wrote:
>> Peter Barada<peter.barada@gmail.com>  writes:
>>
>>> On 05/05/2011 01:11 PM, Kevin Hilman wrote:
>>>> Peter Barada<peter.barada@gmail.com>   writes:
>>>>
>>>>> I've been working on getting the TI OMAPPSP-03.00.01.06 kernel to
>>>>> properly suspend/resume on my DM37x board and all was going well until
>>>>> I added OTG support to the kernel and on suspend, the IVA2 and CORE
>>>>> pwrdms would not properly go into suspend.  When comparing output from
>>>>> /debug/pm-debug/registers/current to the TRM, I noticed the following:
>>>>>
>>>>> MOD: CM_IVA2 (48014000)
>>>>>     04 =>   00000017  20 =>   00000001  24 =>   00000001  34 =>   00000001
>>>>>     40 =>   00080a00  44 =>   00000001  48 =>   00000003
>>>>> MOD: PRM_IVA2 (48316000)
>>>>>     50 =>   00000007  e0 =>   00ff0f05  e4 =>   00000ff7  e8 =>   00000ff7
>>>>>     f8 =>   00000001
>>>>>
>>>>> Looking at the TRM, the PRM_IVA2 registers are at 0x48306000, not
>>>>> 0x48316000.  OMAP3430_IVA2_MOD is defined in prcm-common.h as -0x800
>>>>> which means any module + reg_offset address calculation has to be
>>>>> signed.  Once I corrected the "unsigned short offset" declaration in
>>>>> pm_module_def, rebuilt and tested again, IVA2/core pwrdms go into
>>>>> suspend correctly (and addresses look correct):
>>>> Just to be clear, this should only affect the display of the registers,
>>>> not whether or not the power domains actually suspend correctly, right?
>>>>
>>>> Or, did you actually notice via some other method that this powerdomain
>>>> was not hitting retention/off?
>>> Yes the change affects the registers displayed, but since the address
>>> calculation is incorrect with CONFIG_PM_DEBUG enabled, the PM_DEBUG
>>> code is reading the CM_IVA2/PRM_IVA2 registers at incorrect addresses.
>>> On my DM37x board when I suspended with OTG enabled (and without the
>>> patch), I see the following on resume:
>>>
>>> [  496.168151] Powerdomain (iva2_pwrdm) didn't enter target state 1
>>> (last power state 3)
>>> [  496.176025] Powerdomain (core_pwrdm) didn't enter target state 1
>>> (last power state 3)
>> Hmm, this 'last power state' printk isn't in mainline, so it appears
>> there are some other local modifications to this code.
> Yes, I added it to the printk to help figure out what state the domain
> was in:
>
>     list_for_each_entry(pwrst, &pwrst_list, node) {
>         state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
>         if (state > pwrst->next_state) {
>             printk(KERN_INFO "Powerdomain (%s) didn't enter "
>                    "target state %d (last power state %d)\n",
>                 pwrst->pwrdm->name, pwrst->next_state, state);
>             ret = -1;
>         }
>         set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>     }
>
>>> [  496.183898] Could not enter target state in pm_suspend
>>>
>>> With the patch (and same kernel config) I see the following on resume:
>>>
>>> [  234.867889] Successfully put all powerdomains to target state
>>>
>>> Before enabling the OTG code all powerdomains went into suspend.
>>>
>>> It could be that accessing registers at the incorrect addresses is
>>> causing DM37x to keep those domains out of retention...
>> Hmm, very strange.  The PM debug code only ever reads registers, never
>> writes, so I can't imagine how that should prevent those power domains
>> from hitting retention.  Are there any other out-of-tree patches to the
>> pm-debug code in your kernel?
> Yes there are, but I've kept it to just reading PRM/CM registers (and
> store them into SRAM to print out on resume).  Still, I don't
> understand how just changing the address where to read the IVA2
> registers can make it break/work, unless some side-effect of hte read
> make's life happy.  I'll have to retry w/o PM_DEBUG enabled to see if
> the effect changes.

Rather than disable PM_DEBUG...

Does your kernel do any pm_dbg_regset_save() calls in the suspend/idle
path?  If so, it would suffice to comment those out and see if that
makes it work again (without your patch.)  Would be interesting.

>> In any case, you've found a real bug, and your patch is valid.  However,
>> it doesn't currently apply to mainline, and it looks like it's because
>> your patch is using spaces and the code being patched is using tabs.
> Hmm, could be Thunderbird munching it...
>> Also, you can simplify the changelog to to just describe the fix needed
>> due to using negative offsets in some PRM modules.
> I'll rework the patch and send it back.  I'm also comparing the list
> of registers you read with what the TRM lists (for the AM3730), and I
> see that you read entire ranges even if the range is sparsely
> populated, eg:
>
>     { "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0x00, 0x04 },
>     { "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0x20, 0x24 },
>     { "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0x34, 0x34 },
>     { "IVA2", MOD_CM, OMAP3430_IVA2_MOD, 0x40, 0x4c },
>
> and code to detect that its still looking at a pm_module_def entry
> that has the same type/offset as the previous to prevent the headers
> from being repeatedly printed.

Yes, admittedly this code is really awful and doesn't even belong in the
kernel.  It also doesn't scale well for OMAP4.  Don't be surprised if
this register snapshot/display code is dropped all together in the future.

Kevin
