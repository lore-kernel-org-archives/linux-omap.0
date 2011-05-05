From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Module + offset calculations have to be signed in arch/arm/mach-omap2/pm-debug.c
Date: Thu, 05 May 2011 13:18:59 -0400
Message-ID: <4DC2DC03.4020200@gmail.com>
References: <4DC2CED3.80206@gmail.com> <87liyljcnd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44583 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab1EERSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 13:18:53 -0400
Received: by yia27 with SMTP id 27so837112yia.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 10:18:52 -0700 (PDT)
In-Reply-To: <87liyljcnd.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Peter Barada <peter.barada@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 05/05/2011 01:11 PM, Kevin Hilman wrote:
> Peter Barada<peter.barada@gmail.com>  writes:
>
>> I've been working on getting the TI OMAPPSP-03.00.01.06 kernel to
>> properly suspend/resume on my DM37x board and all was going well until
>> I added OTG support to the kernel and on suspend, the IVA2 and CORE
>> pwrdms would not properly go into suspend.  When comparing output from
>> /debug/pm-debug/registers/current to the TRM, I noticed the following:
>>
>> MOD: CM_IVA2 (48014000)
>>    04 =>  00000017  20 =>  00000001  24 =>  00000001  34 =>  00000001
>>    40 =>  00080a00  44 =>  00000001  48 =>  00000003
>> MOD: PRM_IVA2 (48316000)
>>    50 =>  00000007  e0 =>  00ff0f05  e4 =>  00000ff7  e8 =>  00000ff7
>>    f8 =>  00000001
>>
>> Looking at the TRM, the PRM_IVA2 registers are at 0x48306000, not
>> 0x48316000.  OMAP3430_IVA2_MOD is defined in prcm-common.h as -0x800
>> which means any module + reg_offset address calculation has to be
>> signed.  Once I corrected the "unsigned short offset" declaration in
>> pm_module_def, rebuilt and tested again, IVA2/core pwrdms go into
>> suspend correctly (and addresses look correct):
> Just to be clear, this should only affect the display of the registers,
> not whether or not the power domains actually suspend correctly, right?
>
> Or, did you actually notice via some other method that this powerdomain
> was not hitting retention/off?
Yes the change affects the registers displayed, but since the address 
calculation is incorrect with CONFIG_PM_DEBUG enabled, the PM_DEBUG code 
is reading the CM_IVA2/PRM_IVA2 registers at incorrect addresses.  On my 
DM37x board when I suspended with OTG enabled (and without the patch), I 
see the following on resume:

[  496.168151] Powerdomain (iva2_pwrdm) didn't enter target state 1 
(last power state 3)
[  496.176025] Powerdomain (core_pwrdm) didn't enter target state 1 
(last power state 3)
[  496.183898] Could not enter target state in pm_suspend

With the patch (and same kernel config) I see the following on resume:

[  234.867889] Successfully put all powerdomains to target state

Before enabling the OTG code all powerdomains went into suspend.

It could be that accessing registers at the incorrect addresses is 
causing DM37x to keep those domains out of retention...

> Kevin
>
>> Signed-off-by: Peter Barada<peter.barada@logicpd.com>
>>
>>
>> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
>> index 125f565..b731ef3 100644
>> --- a/arch/arm/mach-omap2/pm-debug.c
>> +++ b/arch/arm/mach-omap2/pm-debug.c
>> @@ -199,7 +199,7 @@ enum {
>>   struct pm_module_def {
>>       char name[8]; /* Name of the module */
>>       short type; /* CM or PRM */
>> -    unsigned short offset;
>> +    short offset;
>>       int low; /* First register address on this module */
>>       int high; /* Last register address on this module */
>>   };
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Peter Barada
peter.barada@gmail.com

