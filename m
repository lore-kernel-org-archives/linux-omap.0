From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/4] OMAP: PM: use omap_device API for suspend/resume
Date: Mon, 21 Jun 2010 09:04:58 -0700
Message-ID: <87hbkw1idx.fsf@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
	<1274994799-30297-4-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032320719C@dbde02.ent.ti.com>
	<87mxvebrry.fsf@deeprootsystems.com>
	<alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59943 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab0FUQ3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 12:29:13 -0400
Received: by pvh11 with SMTP id 11so314496pvh.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Jun 2010 09:29:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006210911150.1550@utopia.booyaka.com> (Paul Walmsley's message of "Mon\, 21 Jun 2010 09\:18\:53 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 1 Jun 2010, Kevin Hilman wrote:
>
>> "Nayak, Rajendra" <rnayak@ti.com> writes:
>> 
>> [...]
>> 
>> >> diff --git a/arch/arm/mach-omap2/pm_bus.c 
>> >> b/arch/arm/mach-omap2/pm_bus.c
>> >> index 69acaa5..3787da8 100644
>> >> --- a/arch/arm/mach-omap2/pm_bus.c
>> >> +++ b/arch/arm/mach-omap2/pm_bus.c
>> >> @@ -70,3 +70,64 @@ int platform_pm_runtime_idle(struct device *dev)
>> >>  };
>> >>  #endif /* CONFIG_PM_RUNTIME */
>> >>  
>> >> +#ifdef CONFIG_SUSPEND
>> >> +int platform_pm_suspend_noirq(struct device *dev)
>> >> +{
>> >> +	struct device_driver *drv = dev->driver;
>> >> +	struct platform_device *pdev = to_platform_device(dev);
>> >> +	struct omap_device *odev = to_omap_device(pdev);
>> >> +	int ret = 0;
>> >> +
>> >> +	if (!drv)
>> >> +		return 0;
>> >> +
>> >> +	if (drv->pm) {
>> >> +		if (drv->pm->suspend_noirq)
>> >> +			ret = drv->pm->suspend_noirq(dev);
>> >> +	}
>> >> +
>> >> +	if (omap_device_is_valid(odev)) {
>> >> +		if (odev->flags & OMAP_DEVICE_NO_BUS_SUSPEND) {
>> >> +			dev_dbg(dev, "no automatic bus-level 
>> >> system resume.\n");
>> >> +			return 0;
>> >> +		}
>> >> +
>> >> +		dev_dbg(dev, "%s\n", __func__);
>> >> +		omap_device_idle(pdev);
>> >
>> > Is it expected that a device is always in enabled state at this point?
>> > If the device is already in idle a call to omap_device_idle unconditionally
>> > throws up warnings from the omap_device api.
>> 
>> Hmm, good point.  The device may already be idled (via runtime PM, or
>> maybe because it was never enabled.)
>> 
>> There are two options:
>> 
>> 1. fixup the warnings in the omap_device_idle() to allow multiple
>>    calls to _idle()
>> 
>> 2. Add an omap_device_is_idle() check before calling _idle()
>> 
>> I much prefer (1).  
>> 
>> Paul?
>
> As far as I can tell, it's not safe for upper-layer code to idle a device 
> like this.  The driver itself needs to be aware of the device's idle 
> state.  

The driver is made aware using the standard dev_pm_ops callback for
suspend and resume.

Note that this is not just any upper-layer code that is blindly idling
a device.  This is only happening at the system-suspend time, and in
particular this is happening using the _noirq() versions of the
dev_pm_ops hooks.

> For example, if the driver has exported some symbols, and some 
> other code is calling one of those functions, it's the driver code that 
> needs to be aware of its own idle-state and to return some kind of error 
> if the device is quiesced.  I don't think there's an easy way for 
> upper-layer code to do that.

Drivers already have to handle this today.  If they have been
suspended and their functions have been called, they have to return
errors.  This patch doesn't change that.

Kevin
