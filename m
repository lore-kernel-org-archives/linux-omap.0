From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/7] OMAP: PM: omap_device: add omap_hwmod_name_get_odev
Date: Thu, 1 Sep 2011 13:48:48 +0200
Message-ID: <4E5F7120.8040907@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com> <1314026347-21623-2-git-send-email-b-cousson@ti.com> <87zkip8bpu.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757241Ab1IALsz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Sep 2011 07:48:55 -0400
In-Reply-To: <87zkip8bpu.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>

On 9/1/2011 12:20 AM, Hilman, Kevin wrote:
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> From: Nishanth Menon<nm@ti.com>
>>
>> An API which translates a standard hwmod name to corresponding
>> omap_device is useful for drivers when they need to look up the
>> device associated with a hwmod name to map back into the device
>> structure pointers. These ideally should be used by drivers in
>> mach directory. Using a generic hwmod name like "gpu" instead of
>> the actual device name which could change in the future, allows
>> us to:
>> a) Could in effect help replace apis such as omap2_get_mpuss_device,
>> omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device,
>> etc..
>> b) Scale to more devices rather than be restricted to named functions
>> c) Simplify driver's platform_data from passing additional fields
>> all doing the same thing with different function pointer names
>> just for accessing a different device name.
>>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> [b-cousson@ti.com: rebased on top of Kevin's changes]
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>
> OK, I cerainly like this better than the omap2_get_*_device APIs, but
> I don't see the point in returning an omap_device pointer.

That's a good point.

Nishanth,
Do you have any objection to replace that API with omap_hwmod_name_get_pdev?

> In my series, I tried to make all the OMAP device APIs return/use a
> platform_device pointer instead of an omap_device pointer, so I'd rather
> just see this return the platform_device pointer directly.

It make sense to me.

Thanks,
Benoit

>
> Kevin
>
>> ---
>>   arch/arm/plat-omap/include/plat/omap_device.h |    1 +
>>   arch/arm/plat-omap/omap_device.c              |   32 +++++++++++++++++++++++++
>>   2 files changed, 33 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
>> index d4d9b96..bdc2804 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -101,6 +101,7 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>>   					 int pm_lats_cnt, int is_early_device);
>>
>>   void __iomem *omap_device_get_rt_va(struct omap_device *od);
>> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name);
>>
>>   /* OMAP PM interface */
>>   int omap_device_align_pm_lat(struct platform_device *pdev,
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>> index d8f2299..455594a 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -840,6 +840,38 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od)
>>   	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
>>   }
>>
>> +/**
>> + * omap_hwmod_name_get_odev() - convert a hwmod name to omap_device pointer
>> + * @oh_name: name of the hwmod device
>> + *
>> + * returns back a struct omap_device * pointer associated with a hwmod
>> + * device represented by a hwmod_name
>> + */
>> +struct omap_device *omap_hwmod_name_get_odev(const char *oh_name)
>> +{
>> +	struct omap_hwmod *oh;
>> +
>> +	if (!oh_name) {
>> +		WARN(1, "%s: no hwmod name!\n", __func__);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	oh = omap_hwmod_lookup(oh_name);
>> +	if (IS_ERR_OR_NULL(oh)) {
>> +		WARN(1, "%s: no hwmod for %s\n", __func__,
>> +			oh_name);
>> +		return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
>> +	}
>> +	if (IS_ERR_OR_NULL(oh->od)) {
>> +		WARN(1, "%s: no omap_device for %s\n", __func__,
>> +			oh_name);
>> +		return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
>> +	}
>> +
>> +	return oh->od;
>> +}
>> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);
>> +
>>   /*
>>    * Public functions intended for use in omap_device_pm_latency
>>    * .activate_func and .deactivate_func function pointers

