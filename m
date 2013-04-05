From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 08/18] ARM: OMAP5: PM: Add CPU power off in hotplug
 path
Date: Fri, 5 Apr 2013 14:34:43 +0530
Message-ID: <515E93AB.8000008@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-9-git-send-email-santosh.shilimkar@ti.com> <876203uypd.fsf@linaro.org> <515D7ECE.6040503@ti.com> <87vc82nqy3.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59264 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab3DEJCr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Apr 2013 05:02:47 -0400
In-Reply-To: <87vc82nqy3.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 11:01 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On Thursday 04 April 2013 02:19 AM, Kevin Hilman wrote:
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> Add power management code to handle the CPU off mode to enable CPUP hotplug
>>>> mode for OMAP5 devices. Separate suspend finisher is used for OMAP5(Cortex-A15)
>>>> because it doesn't use SCU power status register and external PL310 L2 cache
>>>> which makes code flow bit different.
>>>>
>>>> Acked-by: Nishanth Menon <nm@ti.com>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> [...]
>>>
>>>> @@ -436,14 +445,21 @@ int __init omap4_mpuss_init(void)
>>>>  
>>>>  	if (cpu_is_omap44xx()) {
>>>>  		omap_pm_ops.finish_suspend = omap4_finish_suspend;
>>>> +		omap_pm_ops.hotplug_restart = omap_secondary_startup;
>>>>  		omap_pm_ops.resume = omap4_cpu_resume;
>>>>  		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
>>>>  		cpu_context_offset = OMAP4_RM_CPU0_CPU0_CONTEXT_OFFSET;
>>>>  	} else if (soc_is_omap54xx()) {
>>>> +		omap_pm_ops.finish_suspend = omap5_finish_suspend;
>>>> +		omap_pm_ops.hotplug_restart = omap5_secondary_startup;
>>>>  		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
>>>>  		enable_mercury_retention_mode();
>>>>  	}
>>>>  
>>>> +	/* Over-write the OMAP4 hook to take care of ROM BUG */
>>>> +	if (cpu_is_omap446x())
>>>> +		omap_pm_ops.hotplug_restart = omap_secondary_startup_4460;
>>>
>>> A couple nits...
>>>
>>> I think this would go better at the end of the 'if omap44xx' block
>>> above.
>>>
>> Nishant commented on this as well. The indentation was looking ugly
>> and I thought its better to have this BUG hunk separate. I prefer
>> it this way though if you really insist, i have to change it.
> 
> I insist.
> 
Will update the patch accordingly then.

Regards,
Santosh

