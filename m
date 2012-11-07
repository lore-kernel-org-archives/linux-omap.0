From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 07/11] ARM: OMAP: Move omap-pm-noop.c local to mach-omap2
Date: Wed, 7 Nov 2012 16:04:51 -0600
Message-ID: <509ADB03.2050909@ti.com>
References: <20121030234852.25936.12482.stgit@muffinssi.local> <20121030235255.25936.36727.stgit@muffinssi.local> <20121031205850.GO12739@atomide.com> <1654531.W5JISgHidu@avalon> <20121031231115.GG15766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57658 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2KGWFE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 17:05:04 -0500
In-Reply-To: <20121031231115.GG15766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>


On 10/31/2012 06:11 PM, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [121031 16:03]:
>> Hi Tony,
>>
>> On Wednesday 31 October 2012 13:58:50 Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [121030 16:55]:
>>>> This code should be private to mach-omap2.
>>>>
>>>> The only use for it in for omap1 has been in dmtimer.c
>>>> to check for context loss. However, omap1 does not
>>>> lose context during idle, so the code is not needed.
>>>> Further, omap1 timer has OMAP_TIMER_ALWON set, so omap1
>>>> was not hitting omap_pm_get_dev_context_loss_count()
>>>> test.
>>>
>>> Noticed one issue with my test compiles in the
>>> omap-for-v3.8/cleanup-headers branch that can be
>>> fixed along with this patch.
>>>
>>> --- a/drivers/media/platform/omap3isp/ispvideo.c
>>> +++ b/drivers/media/platform/omap3isp/ispvideo.c
>>> @@ -36,7 +36,6 @@
>>>  #include <media/v4l2-ioctl.h>
>>>  #include <plat/iommu.h>
>>>  #include <plat/iovmm.h>
>>> -#include <plat/omap-pm.h>
>>
>> The reason this was included was to call omap_pm_set_min_bus_tput() in earlier 
>> versions of the driver. We'll have to discuss what to replace that with, but 
>> that's another topic.
> 
> OK thanks.
> 
>>>> @@ -730,6 +732,7 @@ static int __devinit omap_dm_timer_probe(struct
>>>> platform_device *pdev)> 
>>>>  	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
>>>>  	timer->pdev = pdev;
>>>>  	timer->capability = pdata->timer_capability;
>>>>
>>>> +	timer->get_context_loss_count = pdata->get_context_loss_count;
>>>>
>>>>  	/* Skip pm_runtime_enable for OMAP1 */
>>>>  	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
>>>>
>>>> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h
>>>> b/arch/arm/plat-omap/include/plat/dmtimer.h index 85868e9..3f5b9cf 100644
>>>> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
>>>> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
>>>> @@ -94,6 +94,7 @@ struct dmtimer_platform_data {
>>>>
>>>>  	/* set_timer_src - Only used for OMAP1 devices */
>>>>  	int (*set_timer_src)(struct platform_device *pdev, int source);
>>>>  	u32 timer_capability;
>>>>
>>>> +	int (*get_context_loss_count)(struct device *);
>>
>> That's a step forward for the common zImage, but one step backward for DT 
>> support :-) I'm fine with this for now, but do you already have an idea on how 
>> to solve that ?
> 
> When it's converted to be a device driver, it can do it
> using runtime PM calls.

I am not sure if you are referring to runtime pm callbacks here, but if
so I am not sure I follow. Drivers such as dmtimer and gpio that are
using runtime pm are still dependent on OMAP specific APIs (such as
omap_pm_get_dev_context_loss_count()) for determining if the context was
lost between suspending and resuming the device. So I am not sure how
runtime pm solves this.

Speaking with Rob Herring, one solution for DT would be using bus
notifiers to populate such function pointers when a device is added.
Given that there are a few devices using this architecture specific API
for context loss I am wondering if we can do something generic in
omap_device.c for DT.

Cheers
Jon


