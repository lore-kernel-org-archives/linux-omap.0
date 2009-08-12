From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Ensure MUSB is accessible before we attempt to reset it
Date: Wed, 12 Aug 2009 16:28:03 -0700
Message-ID: <87ljlor4sc.fsf@deeprootsystems.com>
References: <1249938943-22329-1-git-send-email-jon-hunter@ti.com>
	<87ocql14qc.fsf@deeprootsystems.com> <4A834E88.3060502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:50534 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZHLX2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 19:28:04 -0400
Received: by wf-out-1314.google.com with SMTP id 26so113951wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 16:28:05 -0700 (PDT)
In-Reply-To: <4A834E88.3060502@ti.com> (Jon Hunter's message of "Wed\, 12 Aug 2009 18\:21\:44 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Jon Hunter <jon-hunter@ti.com> writes:

> Kevin Hilman wrote:
>> Thanks for this fix.
>>
>> I'll consider this another vote for switching to omap_hwmod.
>
> To be honest, I am not too familiar with omap_hwmod. Only what I have
> seen here:
>
> http://patchwork.kernel.org/patch/28171/
>
> Anyway, sounds like a good idea. I am not a fan of the current code as
> it does appear a little random but I can see that it is necessary.

Yes, it's a bit random and similar things are needed for other blocks
as well.  Based on the amount of time spent and headaches had due to
debugging init/reset/idle issues of various IP blocks, I will be happy
to see these various reset hacks disappear and let hwmod handle them.

>> In general, musb_pm_init() is a hack until the omap_hwmod suport
>> for the OTG module is in place.  Using hwmod, this reset stuff will
>> be done by hwmod, and all the clocks will be taken care of.
>>
>> All that to say, for the PM branch, I'd rather see USBOTG module
>> implemented in hwmod than to continue to hack a hack.
>
> Agree. Although I am concerned that this could cause problems for
> someone that chooses to use a boot mode that does not attempt to boot
> from USB before booting from their preferred non-volatile memory.
>
>> However, since hwmod doesn't exist in pm-2.6.29, I'm willing to
>> carry this fix in pm-2.6.29.
>>
>> To that end, some comments inlined below...
>
> Ok, I will clean up and then should I then rebase the patch of the
> current pm-2.6.29 branch?

Against the current PM branch is preferred and I'll rebase to
pm-2.6.29.  I'll also carry in current PM branch until OTG hwmod is in
place.

Kevin

>>> ---
>>>  arch/arm/mach-omap2/usb-musb.c |   30 ++++++++++++++++++++++++++++--
>>>  1 files changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
>>> index 3efa19c..7cfe9bb 100644
>>> --- a/arch/arm/mach-omap2/usb-musb.c
>>> +++ b/arch/arm/mach-omap2/usb-musb.c
>>> @@ -32,25 +32,51 @@
>>>  #include <mach/irqs.h>
>>>  #include <mach/mux.h>
>>>  #include <mach/usb.h>
>>> +#include "cm.h"
>>>   #define OTG_SYSCONFIG	   0x404
>>>  #define OTG_SYSC_SOFTRESET BIT(1)
>>> +#define OTG_SYSSTATUS	   0x408
>>> +#define OTG_SYSS_RESETDONE BIT(0)
>>>   static void __init usb_musb_pm_init(void)
>>>  {
>>> -	void __iomem *otg_base;
>>> +	void __iomem *cm_base, *otg_base;
>>> +	unsigned int cm_iclken_core;
>>>   	if (!cpu_is_omap34xx())
>>>  		return;
>>>  +	cm_base = ioremap(OMAP3430_CM_BASE, SZ_4K);
>>> +	if (WARN_ON(!cm_base))
>>> +		return;
>>> +
>>>  	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
>>> -	if (WARN_ON(!otg_base))
>>> +	if (WARN_ON(!otg_base)) {
>>> +		iounmap(cm_base);
>>>  		return;
>>> +	}
>>> +
>>> +	/* Ensure the inferface clock for MUSB is enabled */
>>> +	cm_iclken_core = __raw_readl(OMAP34XX_CM_REGADDR(CORE_MOD,
>>> +					CM_ICLKEN1));
>>> +	__raw_writel((cm_iclken_core |
>>> +			(1 << OMAP3430_EN_HSOTGUSB_SHIFT)),
>>> +			OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1));
>>
>> Any reason to no use the clock API for this?
>>
>>         otg_clk = clk_get(dev, "ick")
>>         clk_enable(otg_clk);
>
> No, I just could not see any easy way to do this as I had assumed I
> needed to use the musb_device structure which may not be defined
> depending on the kernel config. Hence, my crude hack. However, I agree
> that this would be preferred.
>
>> You'll have to create a dummy 'struct device' and pass it to clk_get()
>> for this to work right.
>>
>> See commit 917fa280e5e99edcae44a34feab295a59922d16c in linux-omap
>> master for how I did this for MMC (but also note that this is now
>> removed in the current PM branch because hwmod takes care of this.)
>
> Thanks, this should work!
>
> Cheers
> Jon
