From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 05/14] OMAP: Introduce device specific set rate and
 get rate in omap_device structure
Date: Mon, 15 Nov 2010 16:44:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E80@dbde02.ent.ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-6-git-send-email-thara@ti.com>
 <87eiarv54f.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735Ab0KOLOR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 06:14:17 -0500
In-Reply-To: <87eiarv54f.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, November 12, 2010 4:29 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v2 05/14] OMAP: Introduce device specific set rate and
>>get rate in omap_device structure
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch extends the omap_device structure to contain
>>> pointers to scale the operating rate of the
>>> device and to retrieve the operating rate of the device.
>>> This patch also adds the three new APIs in the omap device layer
>>> namely omap_device_set_rate that can be called to set a new operating
>>> rate for a device, omap_device_get_rate that can be called to retrieve
>>> the operating frequency for a device and omap_device_populate_rate_fns
>>> to populte the device specific set_rate and get_rate API's.
>>> The omap_device_set_rate and omap_device_get_rate does some routine error
>>> checks and finally calls into the device specific set_rate
>>> and get_rate APIs populated through omap_device_populate_rate_fns.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/plat-omap/include/plat/omap_device.h |    9 +++++
>>>  arch/arm/plat-omap/omap_device.c              |   49
>>+++++++++++++++++++++++++
>>>  2 files changed, 58 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-
>>omap/include/plat/omap_device.h
>>> index 28e2d1a..2a37345 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>>> @@ -50,6 +50,8 @@ extern struct device omap_device_parent;
>>>   * @hwmods: (one .. many per omap_device)
>>>   * @hwmods_cnt: ARRAY_SIZE() of @hwmods
>>>   * @pm_lats: ptr to an omap_device_pm_latency table
>>> + * @set_rate: fn ptr to change the operating rate.
>>> + * @get_rate: fn ptr to retrieve the current operating rate.
>>>   * @pm_lats_cnt: ARRAY_SIZE() of what is passed to @pm_lats
>>>   * @pm_lat_level: array index of the last odpl entry executed - -1 if
>>never
>>>   * @dev_wakeup_lat: dev wakeup latency in nanoseconds
>>> @@ -67,6 +69,8 @@ struct omap_device {
>>>  	struct platform_device		pdev;
>>>  	struct omap_hwmod		**hwmods;
>>>  	struct omap_device_pm_latency	*pm_lats;
>>> +	int (*set_rate)(struct device *dev, unsigned long rate);
>>> +	unsigned long (*get_rate) (struct device *dev);
>>
>>minor nit, but I prefer the function pointers at the end.

Ok

>>
>>>  	u32				dev_wakeup_lat;
>>>  	u32				_dev_wakeup_lat_limit;
>>>  	u8				pm_lats_cnt;
>>> @@ -107,6 +111,11 @@ void __iomem *omap_device_get_rt_va(struct omap_device
>>*od);
>>>  int omap_device_align_pm_lat(struct platform_device *pdev,
>>>  			     u32 new_wakeup_lat_limit);
>>>  struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
>>> +int omap_device_set_rate(struct device *dev, unsigned long freq);
>>> +unsigned long omap_device_get_rate(struct device *dev);
>>> +void omap_device_populate_rate_fns(struct device *dev,
>>> +		int (*set_rate)(struct device *dev, unsigned long rate),
>>> +		unsigned long (*get_rate) (struct device *dev));
>>
>>how about omap_device_register_callbacks()

I am ok. But then the name will not specify what kind of
callbacks.

>>
>>>  /* Other */
>>>
>>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
>>omap/omap_device.c
>>> index 7c902a6..ffe06eb 100644
>>> --- a/arch/arm/plat-omap/omap_device.c
>>> +++ b/arch/arm/plat-omap/omap_device.c
>>> @@ -785,6 +785,55 @@ int omap_device_enable_clocks(struct omap_device *od)
>>>  	return 0;
>>>  }
>>>
>>> +int omap_device_set_rate(struct device *dev, unsigned long freq)
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct omap_device *od;
>>> +
>>> +	pdev = container_of(dev, struct platform_device, dev);
>>
>>        pdev = to_platform_device(dev)
>>
>>This helper is already defined in platform_device.h.

Ok

>>
>>> +	od = _find_by_pdev(pdev);
>>> +
>>> +	if (!od->set_rate) {
>>> +		dev_err(dev, "%s: No set_rate API for scaling device\n",
>>> +			__func__);
>>> +		return -ENODATA;
>>> +	}
>>> +
>>> +	return od->set_rate(dev, freq);
>>> +}
>>> +
>>> +unsigned long omap_device_get_rate(struct device *dev)
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct omap_device *od;
>>> +
>>> +	pdev = container_of(dev, struct platform_device, dev);
>>
>>        pdev = to_platform_device(dev)
>>
>>> +	od = _find_by_pdev(pdev);
>>> +
>>> +
>>> +	if (!od->get_rate) {
>>> +		dev_err(dev, "%s: No get rate API for the device\n",
>>> +			__func__);
>>> +		return 0;
>>> +	}
>>> +
>>> +	return od->get_rate(dev);
>>> +}
>>> +
>>> +void omap_device_populate_rate_fns(struct device *dev,
>>> +		int (*set_rate)(struct device *dev, unsigned long rate),
>>> +		unsigned long (*get_rate) (struct device *dev))
>>> +{
>>> +	struct platform_device *pdev;
>>> +	struct omap_device *od;
>>> +
>>> +	pdev = container_of(dev, struct platform_device, dev);
>>
>>        pdev = to_platform_device(dev)

Ok

>>
>>> +	od = _find_by_pdev(pdev);
>>> +
>>> +	od->set_rate = set_rate;
>>> +	od->get_rate = get_rate;
>>> +}
>>> +
>>>  struct device omap_device_parent = {
>>>  	.init_name	= "omap",
>>>  	.parent         = &platform_bus,
>>
>>Kevin
