From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP: PM: use omap_device API for suspend/resume
Date: Thu, 24 Jun 2010 10:34:52 -0700
Message-ID: <87bpb0gwqr.fsf@deeprootsystems.com>
References: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
	<1277336224-24826-3-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232128390.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35391 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab0FXRe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:34:56 -0400
Received: by pvg2 with SMTP id 2so457481pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:34:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006232128390.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 24 Jun 2010 00:30:37 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> aside from these comments:
>
>    http://marc.info/?l=linux-omap&m=127735008820992&w=2
>
> one other minor issue -
>
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> Hook into the platform bus methods for suspend and resume and
>> use the omap_device API to automatically idle and enable the
>> device on suspend and resume.
>> 
>> This allows device drivers to get rid of direct management of their
>> clocks in their suspend/resume paths, and let omap_device do it for
>> them.
>> 
>> We currently use the _noirq (late suspend, early resume) versions of
>> the suspend/resume methods to ensure that the device is not disabled
>> too early for any drivers also using the _noirq methods.
>> 
>> NOTE: only works for devices with omap_hwmod support.
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>>  arch/arm/mach-omap2/pm_bus.c |   61 ++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 61 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
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
>> +			dev_dbg(dev, "no automatic bus-level system resume.\n");
>
> I guess this should read "suspend" above?
>

Yup, thanks.

Kevin
