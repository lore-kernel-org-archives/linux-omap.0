From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Tue, 01 Jun 2010 10:13:05 -0700
Message-ID: <87mxvebrry.fsf@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
	<1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35567 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab0FARNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 13:13:10 -0400
Received: by pxi18 with SMTP id 18so2036027pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 10:13:08 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com> (Rajendra Nayak's message of "Tue\, 1 Jun 2010 11\:41\:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

[...]

>> diff --git a/arch/arm/mach-omap2/pm_bus.c 
>> b/arch/arm/mach-omap2/pm_bus.c
>> index 69acaa5..3787da8 100644
>> --- a/arch/arm/mach-omap2/pm_bus.c
>> +++ b/arch/arm/mach-omap2/pm_bus.c
>> @@ -70,3 +70,64 @@ int platform_pm_runtime_idle(struct device *dev)
>>  };
>>  #endif /* CONFIG_PM_RUNTIME */
>>  
>> +#ifdef CONFIG_SUSPEND
>> +int platform_pm_suspend_noirq(struct device *dev)
>> +{
>> +	struct device_driver *drv = dev->driver;
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct omap_device *odev = to_omap_device(pdev);
>> +	int ret = 0;
>> +
>> +	if (!drv)
>> +		return 0;
>> +
>> +	if (drv->pm) {
>> +		if (drv->pm->suspend_noirq)
>> +			ret = drv->pm->suspend_noirq(dev);
>> +	}
>> +
>> +	if (omap_device_is_valid(odev)) {
>> +		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
>> +			dev_dbg(dev, "no automatic bus-level 
>> system resume.\n");
>> +			return 0;
>> +		}
>> +
>> +		dev_dbg(dev, "%s\n", __func__);
>> +		omap_device_idle(pdev);
>
> Is it expected that a device is always in enabled state at this point?
> If the device is already in idle a call to omap_device_idle unconditionally
> throws up warnings from the omap_device api.

Hmm, good point.  The device may already be idled (via runtime PM, or
maybe because it was never enabled.)

There are two options:

1. fixup the warnings in the omap_device_idle() to allow multiple
   calls to _idle()

2. Add an omap_device_is_idle() check before calling _idle()

I much prefer (1).  

Paul?

Kevin
