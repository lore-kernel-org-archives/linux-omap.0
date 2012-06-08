From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 01/10] ARM: PMU: Add runtime PM Support
Date: Fri, 8 Jun 2012 09:17:24 -0500
Message-ID: <4FD20974.4060301@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-2-git-send-email-jon-hunter@ti.com> <20120608094708.GC19062@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45276 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933086Ab2FHORf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 10:17:35 -0400
In-Reply-To: <20120608094708.GC19062@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

Hi Will,

On 06/08/2012 04:47 AM, Will Deacon wrote:
> Hi Jon,
> 
> On Thu, Jun 07, 2012 at 10:22:03PM +0100, Jon Hunter wrote:
>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index 186c8cb..00adb98 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/pm_runtime.h>
>>  
>>  #include <asm/cputype.h>
>>  #include <asm/irq.h>
>> @@ -367,8 +368,6 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>>  {
>>  	int i, irq, irqs;
>>  	struct platform_device *pmu_device = armpmu->plat_device;
>> -	struct arm_pmu_platdata *plat =
>> -		dev_get_platdata(&pmu_device->dev);
>>  
>>  	irqs = min(pmu_device->num_resources, num_possible_cpus());
>>  
>> @@ -376,14 +375,12 @@ armpmu_release_hardware(struct arm_pmu *armpmu)
>>  		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
>>  			continue;
>>  		irq = platform_get_irq(pmu_device, i);
>> -		if (irq >= 0) {
>> -			if (plat && plat->disable_irq)
>> -				plat->disable_irq(irq);
>> +		if (irq >= 0)
>>  			free_irq(irq, armpmu);
>> -		}
>>  	}
>>  
>>  	release_pmu(armpmu->type);
>> +	pm_runtime_put_sync(&armpmu->plat_device->dev);
> 
> We probably want to suspend the device before releasing it, otherwise we
> could race against somebody else trying to initialise the PMU again.

Good point, will change that.

>>  
>>  static int
>> @@ -403,6 +400,8 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>>  		return err;
>>  	}
>>  
>> +	pm_runtime_get_sync(&armpmu->plat_device->dev);
> 
> Better pass &pmu_device->dev instead (similarly in release).

Ok.

>> +
>>  	plat = dev_get_platdata(&pmu_device->dev);
>>  	if (plat && plat->handle_irq)
>>  		handle_irq = armpmu_platform_irq;
>> @@ -440,8 +439,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>>  				irq);
>>  			armpmu_release_hardware(armpmu);
>>  			return err;
>> -		} else if (plat && plat->enable_irq)
>> -			plat->enable_irq(irq);
>> +		}
>>  
>>  		cpumask_set_cpu(i, &armpmu->active_irqs);
>>  	}
>> @@ -584,6 +582,28 @@ static void armpmu_disable(struct pmu *pmu)
>>  	armpmu->stop();
>>  }
> 
> There are potential failure paths in the reservation code here where we
> don't `put' the PMU back. Can you move the pm_runtime_get_sync call later in
> the function, or does it have to called before we enable the IRQ line?

Yes we can move that. It does not need to be before we enable the IRQ line.

>> +#ifdef CONFIG_PM_RUNTIME
>> +static int armpmu_runtime_resume(struct device *dev)
>> +{
>> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
>> +
>> +	if (plat->runtime_resume)
> 
> I think you need to check plat too since it may be NULL on other platforms.

Ah, good point. I will add that.

>> +		return plat->runtime_resume(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int armpmu_runtime_suspend(struct device *dev)
>> +{
>> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
>> +
>> +	if (plat->runtime_suspend)
> 
> Same here.

Ok, yes. Thanks for the feedback!

Cheers
Jon
