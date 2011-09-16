From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 10/11] regulator: Implement consumer regulator mapping
 from device tree
Date: Fri, 16 Sep 2011 12:51:06 +0530
Message-ID: <4E72F8E2.3020200@ti.com>
References: <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <1316085727-15023-5-git-send-email-rnayak@ti.com> <1316085727-15023-6-git-send-email-rnayak@ti.com> <1316085727-15023-7-git-send-email-rnayak@ti.com> <1316085727-15023-8-git-send-email-rnayak@ti.com> <1316085727-15023-9-git-send-email-rnayak@ti.com> <1316085727-15023-10-git-send-email-rnayak@ti.com> <1316085727-15023-11-git-send-email-rnayak@ti.com> <20110915135939.GO7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:51777 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753469Ab1IPHVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:21:14 -0400
Received: by mail-gy0-f170.google.com with SMTP id 11so4897574gyb.1
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:21:12 -0700 (PDT)
In-Reply-To: <20110915135939.GO7988@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Thursday 15 September 2011 07:29 PM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:52:06PM +0530, Rajendra Nayak wrote:
>
>> +#ifdef CONFIG_OF
>> +	struct device_node *node;
>> +	node = of_get_regulator(dev, id);
>> +	if (!node)
>> +		goto out;
>> +	list_for_each_entry(rdev, &regulator_list, list)
>> +		if (node == rdev->node)
>> +			goto found;
>> +#else
>>   	list_for_each_entry(map,&regulator_map_list, list) {
>>   		/* If the mapping has a device set up it must match */
>>   		if (map->dev_name &&
>> @@ -1178,6 +1189,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>>   			goto found;
>>   		}
>>   	}
>> +#endif
>
> This forces all machines to use device tree when CONFIG_OF is enabled.
> I'd expect to see both mechanisms supported simultaneously, for example
> by falling back to the current code if the device tree lookup fails.

agree, will change this to fall back if the dt lookup fails.

>
>> @@ -1216,6 +1228,15 @@ found:
>>   	if (!try_module_get(rdev->owner))
>>   		goto out;
>>
>> +#ifdef CONFIG_OF
>> +	ret = set_consumer_device_supply(rdev, dev, devname, id);
>> +	if (ret <  0) {
>> +		dev_err(dev, "Failed to set supply %d\n", ret);
>> +		unset_regulator_supplies(rdev);
>> +		goto out;
>> +	}
>> +#endif
>> +
>
> This seems wrong, why are we adding things to the regulator_map which is
> really only there for lookups when we already did the lookup using the
> device tree?

I did this only so the mappings show up in sysfs.

>
>> @@ -2619,6 +2640,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
>>   	rdev->reg_data = driver_data;
>>   	rdev->owner = regulator_desc->owner;
>>   	rdev->desc = regulator_desc;
>> +	if (dev &&  dev->of_node)
>> +		rdev->node = dev->of_node;
>
> dev is mandatory.

ok

