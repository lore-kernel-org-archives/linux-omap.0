From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 08/18] ARM: OMAP5: PM: Add CPU power off in hotplug path
Date: Thu, 04 Apr 2013 10:31:00 -0700
Message-ID: <87vc82nqy3.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-9-git-send-email-santosh.shilimkar@ti.com>
	<876203uypd.fsf@linaro.org> <515D7ECE.6040503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36865 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763998Ab3DDRbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 13:31:03 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so1555547pbc.0
        for <linux-omap@vger.kernel.org>; Thu, 04 Apr 2013 10:31:03 -0700 (PDT)
In-Reply-To: <515D7ECE.6040503@ti.com> (Santosh Shilimkar's message of "Thu, 4
	Apr 2013 18:53:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On Thursday 04 April 2013 02:19 AM, Kevin Hilman wrote:
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>> 
>>> Add power management code to handle the CPU off mode to enable CPUP hotplug
>>> mode for OMAP5 devices. Separate suspend finisher is used for OMAP5(Cortex-A15)
>>> because it doesn't use SCU power status register and external PL310 L2 cache
>>> which makes code flow bit different.
>>>
>>> Acked-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> 
>> [...]
>> 
>>> @@ -436,14 +445,21 @@ int __init omap4_mpuss_init(void)
>>>  
>>>  	if (cpu_is_omap44xx()) {
>>>  		omap_pm_ops.finish_suspend = omap4_finish_suspend;
>>> +		omap_pm_ops.hotplug_restart = omap_secondary_startup;
>>>  		omap_pm_ops.resume = omap4_cpu_resume;
>>>  		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
>>>  		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
>>>  	} else if (soc_is_omap54xx()) {
>>> +		omap_pm_ops.finish_suspend = omap5_finish_suspend;
>>> +		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
>>>  		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
>>>  		enable_mercury_retention_mode();
>>>  	}
>>>  
>>> +	/* Over-write the OMAP4 hook to take care of ROM BUG */
>>> +	if (cpu_is_omap446x())
>>> +		omap_pm_ops.hotplug_restart = omap_secondary_startup_4460;
>> 
>> A couple nits...
>> 
>> I think this would go better at the end of the 'if omap44xx' block
>> above.
>> 
> Nishant commented on this as well. The indentation was looking ugly
> and I thought its better to have this BUG hunk separate. I prefer
> it this way though if you really insist, i have to change it.

I insist.

>> Also, while you're hear, maybe it's time to rename the current secondary 
>> startup functions to match the new one.  IOW omap4_..., omap4460_... and omap5_...
>> 
> Good idea. Will do it in a separate patch since these have been there in few
> files.

OK.

Thanks,

Kevin
