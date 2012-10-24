From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: PMU: fix runtime PM enable
Date: Wed, 24 Oct 2012 09:16:43 -0500
Message-ID: <5087F84B.9070705@ti.com>
References: <1351024268-26734-1-git-send-email-jon-hunter@ti.com> <20121024093150.GA23775@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44502 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934843Ab2JXOQv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 10:16:51 -0400
In-Reply-To: <20121024093150.GA23775@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Will,

On 10/24/2012 04:31 AM, Will Deacon wrote:
> Hi Jon,
> 
> On Tue, Oct 23, 2012 at 09:31:08PM +0100, Jon Hunter wrote:
>> Commit 7be2958 (ARM: PMU: Add runtime PM Support) updated the ARM PMU code to
>> use runtime PM which was prototyped and validated on the OMAP devices. In this
>> commit, there is no call pm_runtime_enable() and for OMAP devices
>> pm_runtime_enable() is currently being called from the OMAP PMU code when the
>> PMU device is created. However, there are two problems with this:
>>
>> 1. For any other ARM device wishing to use runtime PM for PMU they will need
>>    to call pm_runtime_enable() for runtime PM to work.
>> 2. When booting with device-tree and using device-tree to create the PMU
>>    device, pm_runtime_enable() needs to be called from within the ARM PERF
>>    driver as we are no longer calling any device specific code to create the
>>    device. Hence, PMU does not work on OMAP devices that use the runtime PM
>>    callbacks when using device-tree to create the PMU device.
>>
>> Therefore, add a new platform data variable to indicate whether runtime PM is
>> used and if so call pm_runtime_enable() when the PMU device is registered. Note
>> that devices using runtime PM may not use the runtime_resume/suspend callbacks
>> and so we cannot use the presence of these handlers in the platform data to
>> determine whether we should call pm_runtime_enable().
> 
> [...]
> 
>> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
>> index a26170d..50a6c3b 100644
>> --- a/arch/arm/include/asm/pmu.h
>> +++ b/arch/arm/include/asm/pmu.h
>> @@ -36,6 +36,7 @@
>>  struct arm_pmu_platdata {
>>  	irqreturn_t (*handle_irq)(int irq, void *dev,
>>  				  irq_handler_t pmu_handler);
>> +	bool use_runtime_pm;
>>  	int (*runtime_resume)(struct device *dev);
>>  	int (*runtime_suspend)(struct device *dev);
> 
> Can we not just use the presence of the resume/suspend function pointers to
> indicate whether we should enable runtime pm or not? i.e. if they're not
> NULL, then enable the thing?

I wondered if you would ask that :-)

Unfortunately, we can't. For example, OMAP3430 and OMAP4460 both require
runtime_pm to be enabled to turn on the debug sub-system in OMAP for PMU
to work. However, neither of these devices are using the suspend/resume
callbacks because the HWMOD framework is doing this for us behind the
scenes.

So then you ask, why do we need the resume/suspend callbacks, well we
will need them for OMAP4430 where in addition to turning on the debug
sub-system we need to configure the CTI module. Therefore, I had to add
another plat data variable.

By the way, I did add a comment in the above changelog about this. See
the last paragraph, not sure if this is 100% clear.

One alternative I had thought about was always calling
pm_runtime_enable() on registering the PMU device and avoid having a
use_runtime_pm variable. For ARM platforms that don't use runtime PM the
pm_runtime_enable() function does nothing. However, I was more concerned
about adding unnecessary overhead for ARM platforms that are using
runtime PM but don't need runtime PM for PMU. I don't see any side
affects on our OMAP2 platform that does not need runtime PM for PMU.
However, was not sure what is best here.

Cheers
Jon
