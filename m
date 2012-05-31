From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Thu, 31 May 2012 13:42:58 -0700
Message-ID: <87r4u0ytd9.fsf@ti.com>
References: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
	<87wr3uelgp.fsf@ti.com> <4FC548A3.2040906@ti.com>
	<4FC54D3B.10301@ti.com> <87pq9l7306.fsf@ti.com>
	<20120531012923.GB8506@mudshark.cambridge.arm.com>
	<4FC7B465.60703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:50409 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751951Ab2EaUnB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 16:43:01 -0400
Received: by pbbrq8 with SMTP id rq8so2337294pbb.21
        for <linux-omap@vger.kernel.org>; Thu, 31 May 2012 13:42:58 -0700 (PDT)
In-Reply-To: <4FC7B465.60703@ti.com> (Jon Hunter's message of "Thu, 31 May
	2012 13:11:49 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, Ming Lei <ming.lei@canonical.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Jon Hunter <jon-hunter@ti.com> writes:

> Hi Kevin, Will,
>
> On 05/30/2012 08:29 PM, Will Deacon wrote:
>> Hi Kevin,
>> 
>> On Wed, May 30, 2012 at 10:50:01PM +0100, Kevin Hilman wrote:
>>> Basically, I don't like the result when we have to hack around missing
>>> runtime PM support for a driver, so IMO, the driver should be updated.
>>>
>>> IOW, it looks to me like the armpmu driver should grow runtime PM
>>> support.  The current armpmu_release|reserve should probably be replaced
>>> with runtime PM get/put, and the functionality in those functions would
>>> be the runtime PM callbacks instead.
>>>
>>> Will, any objections to armpmu growing runtime PM support?
>> 
>> My plan for the armpmu reservation is to kill the global reservation scheme
>> that we currently have and push those function pointers into the arm_pmu,
>> so that fits with what you'd like.
>> 
>> The only concern I have is that we need the mutual exclusion even when we
>> don't have support for runtime PM. If we can solve that then I'm fine with
>> the approach.
>
> To add a bit more food for thought, I had implemented a quick patch to
> add runtime PM support for PMU. You will notice that I have been
> conservative on where I have placed the pm_runtime_get/put calls,
> because I am not too familiar with the PMU driver to know exactly
> where we need to maintain the PMU context. So right now these are just
> around the reserve_hardware/release_hardware calls. This works on OMAP
> for some quick testing. However, I would need to make sure this does
> not break compilation without runtime PM enabled.
>
> Let me know your thoughts.

That looks good, but I'm curious what would be done in the new
plat->runtime_* hooks.  Maybe the irq enable/disable stuff in the pmu
driver needs to be moved into the runtime PM hooks?

Kevin

> Cheers
> Jon
>
> From b111bcb24737e070ee1ce7ea3d1deb60a4d6f266 Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Thu, 31 May 2012 13:05:20 -0500
> Subject: [PATCH] ARM: PMU: Add runtime PM Support
>
> ---
>  arch/arm/include/asm/pmu.h   |    2 ++
>  arch/arm/kernel/perf_event.c |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
> index 90114fa..db9f20c 100644
> --- a/arch/arm/include/asm/pmu.h
> +++ b/arch/arm/include/asm/pmu.h
> @@ -43,6 +43,8 @@ struct arm_pmu_platdata {
>  				  irq_handler_t pmu_handler);
>  	void (*enable_irq)(int irq);
>  	void (*disable_irq)(int irq);
> +	int (*runtime_resume)(struct device *dev);
> +	int (*runtime_suspend)(struct device *dev);
>  };
>  
>  #ifdef CONFIG_CPU_HAS_PMU
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 186c8cb..3b2b016 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/uaccess.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <asm/cputype.h>
>  #include <asm/irq.h>
> @@ -460,6 +461,8 @@ hw_perf_event_destroy(struct perf_event *event)
>  		armpmu_release_hardware(armpmu);
>  		mutex_unlock(pmu_reserve_mutex);
>  	}
> +
> +	pm_runtime_put_sync(&armpmu->plat_device->dev);
>  }
>  
>  static int
> @@ -546,6 +549,8 @@ static int armpmu_event_init(struct perf_event *event)
>  	if (armpmu->map_event(event) == -ENOENT)
>  		return -ENOENT;
>  
> +	pm_runtime_get_sync(&armpmu->plat_device->dev);
> +
>  	event->destroy = hw_perf_event_destroy;
>  
>  	if (!atomic_inc_not_zero(active_events)) {
> @@ -584,6 +589,26 @@ static void armpmu_disable(struct pmu *pmu)
>  	armpmu->stop();
>  }
>  
> +static int armpmu_runtime_resume(struct device *dev)
> +{
> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
> +
> +	if (plat->runtime_resume)
> +		return plat->runtime_resume(dev);
> +
> +	return 0;
> +}
> +
> +static int armpmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_pmu_platdata *plat = dev_get_platdata(dev);
> +
> +	if (plat->runtime_suspend)
> +		return plat->runtime_suspend(dev);
> +
> +	return 0;
> +}
> +
>  static void __init armpmu_init(struct arm_pmu *armpmu)
>  {
>  	atomic_set(&armpmu->active_events, 0);
> @@ -650,9 +675,14 @@ static int __devinit armpmu_device_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct dev_pm_ops armpmu_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(armpmu_runtime_suspend, armpmu_runtime_resume, NULL)
> +};
> +
>  static struct platform_driver armpmu_driver = {
>  	.driver		= {
>  		.name	= "arm-pmu",
> +		.pm	= &armpmu_dev_pm_ops,
>  		.of_match_table = armpmu_of_device_ids,
>  	},
>  	.probe		= armpmu_device_probe,
