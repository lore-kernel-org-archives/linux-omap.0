From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 1/2] OMAP: omap_device: Add omap_device_[alloc|delete]
 for DT integration
Date: Mon, 19 Sep 2011 15:11:45 +0200
Message-ID: <4E773F91.3030704@ti.com>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com> <1316184199-12599-2-git-send-email-b-cousson@ti.com> <20110917160514.GU3523@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab1ISNLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 09:11:53 -0400
In-Reply-To: <20110917160514.GU3523@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 9/17/2011 6:05 PM, Grant Likely wrote:
> On Fri, Sep 16, 2011 at 04:43:18PM +0200, Benoit Cousson wrote:
>> Split the omap_device_build_ss into two smaller functions
>> that will allow to populate a platform_device already allocated by
>> device-tree.
>> The functionality of the omap_device_build_ss is still the same, but
>> the omap_device_alloc will be usable with devices already built by
>> device-tree.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Kevin Hilman<khilman@ti.com>
>
> Looks pretty good.  Comments below.
>
> g.
>
>> ---
>>   arch/arm/plat-omap/omap_device.c |  177 +++++++++++++++++++++++++------------
>>   1 files changed, 119 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> index 54bbe7b..cac7b9a 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -96,6 +96,11 @@
>>
>>   static int omap_device_register(struct platform_device *pdev);
>>   static int omap_early_device_register(struct platform_device *pdev);
>> +static struct omap_device *omap_device_alloc(struct platform_device *pdev,
>> +				      struct omap_hwmod **ohs, int oh_cnt,
>> +				      struct omap_device_pm_latency *pm_lats,
>> +				      int pm_lats_cnt);
>> +
>>
>>   static struct omap_device_pm_latency omap_default_latency[] = {
>>   	{
>> @@ -397,6 +402,110 @@ static int omap_device_fill_resources(struct omap_device *od,
>>   }
>>
>>   /**
>> + * omap_device_alloc - allocate an omap_device
>> + * @pdev: platform_device that will be included in this omap_device
>> + * @oh: ptr to the single omap_hwmod that backs this omap_device
>> + * @pdata: platform_data ptr to associate with the platform_device
>> + * @pdata_len: amount of memory pointed to by @pdata
>> + * @pm_lats: pointer to a omap_device_pm_latency array for this device
>> + * @pm_lats_cnt: ARRAY_SIZE() of @pm_lats
>> + *
>> + * Convenience function for allocating an omap_device structure and filling
>> + * hwmods, resources and pm_latency attributes.
>> + *
>> + * Returns an struct omap_device pointer or ERR_PTR() on error;
>> + */
>> +static struct omap_device *omap_device_alloc(struct platform_device *pdev,
>> +					struct omap_hwmod **ohs, int oh_cnt,
>> +					struct omap_device_pm_latency *pm_lats,
>> +					int pm_lats_cnt)
>> +{
>> +	int ret = -ENOMEM;
>> +	struct omap_device *od;
>> +	struct resource *res = NULL;
>> +	int i, res_count;
>> +	struct omap_hwmod **hwmods;
>> +
>> +	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
>
> possible enhancement:  devm_kzalloc() perhaps?  Would simplify the cleanup paths.
>
>> +	if (!od) {
>> +		ret = -ENOMEM;
>> +		goto oda_exit1;
>> +	}
>> +	od->hwmods_cnt = oh_cnt;
>> +
>> +	hwmods = kmemdup(ohs, sizeof(struct omap_hwmod *) * oh_cnt, GFP_KERNEL);
>
> Ditto here.  would require creation of devm_kmemdup()
>
>> +	if (!hwmods)
>> +		goto oda_exit2;
>> +
>> +	od->hwmods = hwmods;
>> +	od->pdev = pdev;
>> +
>> +	/*
>> +	 * HACK: Ideally the resources from DT should match, and hwmod
>> +	 * should just add the missing ones. Since the name is not
>> +	 * properly populated by DT, stick to hwmod resources only.
>> +	 */
>> +	if (pdev->num_resources&&  pdev->resource)
>> +		dev_warn(&pdev->dev, "%s(): resources already allocated %d\n",
>> +			__func__, pdev->num_resources);
>> +
>> +	res_count = omap_device_count_resources(od);
>> +	if (res_count>  0) {
>> +		dev_dbg(&pdev->dev, "%s(): resources allocated from hwmod %d\n",
>> +			__func__, res_count);
>> +		res = kzalloc(sizeof(struct resource) * res_count, GFP_KERNEL);
>> +		if (!res)
>> +			goto oda_exit3;
>> +
>> +		omap_device_fill_resources(od, res);
>> +
>> +		ret = platform_device_add_resources(pdev, res, res_count);
>> +		kfree(res);
>
> How big is res_count?  Struct resource isn't very big.  It can
> probably be on the stack.

It will depend of the number of entries in the hwmod DB that can vary 
from one address space to 10 addresses + a bunch of irqs + a bunch of 
dmas. To be honest, that code is just a cut&paste of the original one.
But since that number can vary based on another file content and 
considering that this code is supposed to disappear as soon as the 
resource will come from DT, I'm not 100% convince it worth the effort.

>> +
>> +		if (ret)
>> +			goto oda_exit3;
>> +	}
>> +
>> +	if (!pm_lats) {
>> +		pm_lats = omap_default_latency;
>> +		pm_lats_cnt = ARRAY_SIZE(omap_default_latency);
>> +	}
>> +
>> +	od->pm_lats_cnt = pm_lats_cnt;
>> +	od->pm_lats = kmemdup(pm_lats,
>> +			sizeof(struct omap_device_pm_latency) * pm_lats_cnt,
>> +			GFP_KERNEL);
>> +	if (!od->pm_lats)
>> +		goto oda_exit3;
>> +
>> +	pdev->archdata.od = od;
>> +
>> +	for (i = 0; i<  oh_cnt; i++) {
>> +		hwmods[i]->od = od;
>> +		_add_hwmod_clocks_clkdev(od, hwmods[i]);
>> +	}
>> +
>> +	return od;
>> +
>> +oda_exit3:
>> +	kfree(hwmods);
>> +oda_exit2:
>> +	kfree(od);
>> +oda_exit1:
>> +	dev_err(&pdev->dev, "omap_device: build failed (%d)\n", ret);
>> +
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +static void omap_device_delete(struct omap_device *od)
>> +{
>> +	od->pdev->archdata.od = NULL;
>> +	kfree(od->pm_lats);
>> +	kfree(od->hwmods);
>> +	kfree(od);
>> +}
>> +
>> +/**
>>    * omap_device_build - build and register an omap_device with one omap_hwmod
>>    * @pdev_name: name of the platform_device driver to use
>>    * @pdev_id: this platform_device's connection ID
>> @@ -455,9 +564,6 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>>   	int ret = -ENOMEM;
>>   	struct platform_device *pdev;
>>   	struct omap_device *od;
>> -	struct resource *res = NULL;
>> -	int i, res_count;
>> -	struct omap_hwmod **hwmods;
>>
>>   	if (!ohs || oh_cnt == 0 || !pdev_name)
>>   		return ERR_PTR(-EINVAL);
>> @@ -471,76 +577,31 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>>   		goto odbs_exit;
>>   	}
>>
>> -	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
>> -		 oh_cnt);
>> +	/* Set the dev_name early to allow dev_xxx in omap_device_alloc */
>> +	if (pdev->id != -1)
>> +		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
>> +	else
>> +		dev_set_name(&pdev->dev, "%s", pdev->name);
>
> This is duplicated from the core platform_device code.  What is the
> reasoning for doing it again here?

Well, it is written in the comment... But this is maybe not that obvious :-)
That part is only needed for the legacy path that will create a 
omap_device before having created the device, and thus at that time the 
dev_xxx will not give the device name. This is not a big deal, but that 
was painful for the debug.

That being said, by writing that, I'm now realizing that this is due to 
the way the legacy code was working, because I didn't try to change the 
sequence.
But maybe, I can easily avoid that by changing the original sequence.
In fact If I create the omap_device after the omap_device_register, the 
platform_device will already have the correct name...

That should work, I'll give it a try.

Thanks for the comments,
Benoit
