From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 04/14] OMAP: Introduce API to register a device with
 a voltagedomain
Date: Mon, 15 Nov 2010 16:39:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4E7A@dbde02.ent.ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-5-git-send-email-thara@ti.com>
 <87sjz8y99l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895Ab0KOLJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 06:09:13 -0500
In-Reply-To: <87sjz8y99l.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, November 11, 2010 6:19 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v2 04/14] OMAP: Introduce API to register a device with a
>>voltagedomain
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds an API in the voltage layer that
>>> can be used  during omap_device_build to register the built
>>> device with the voltage domain. This API is to be typically called
>>> only once per device during the device registeration. This approach
>>> makes it easy during dvfs to scale all the devices associated with
>>> a voltage domain and then scale the voltage domain.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>[...]
>>
>>>  /* Generic voltage init functions */
>>> @@ -1240,6 +1251,40 @@ int omap_voltage_add_request(struct voltagedomain
>>*voltdm, struct device *dev,
>>>  	return 0;
>>>  }
>>>
>>> +int omap_voltage_add_dev(struct voltagedomain *voltdm, struct device *dev)
>>
>>minor nit: I prefer this be a 'register' function,
>>e.g. omap_voltage_register (or _register_dev)

_register_dev. Will rename.

>>
>>[...]
>>
>>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
>>omap/omap_device.c
>>> index abe933c..7c902a6 100644
>>> --- a/arch/arm/plat-omap/omap_device.c
>>> +++ b/arch/arm/plat-omap/omap_device.c
>>> @@ -86,6 +86,7 @@
>>>
>>>  #include <plat/omap_device.h>
>>>  #include <plat/omap_hwmod.h>
>>> +#include <plat/voltage.h>
>>>
>>>  /* These parameters are passed to _omap_device_{de,}activate() */
>>>  #define USE_WAKEUP_LAT			0
>>> @@ -453,6 +454,17 @@ struct omap_device *omap_device_build_ss(const char
>>*pdev_name, int pdev_id,
>>>  	for (i = 0; i < oh_cnt; i++) {
>>>  		hwmods[i]->od = od;
>>>  		_add_optional_clock_alias(od, hwmods[i]);
>>> +		if (hwmods[i]->vdd_name) {
>>
>>Use:
>>
>>                if (!is_early_device && hwmods[i]->vdd_name)
>>
>>> +			struct omap_hwmod *oh = hwmods[i];
>>> +			struct voltagedomain *voltdm;
>>> +
>>> +			if (is_early_device)
>>> +				continue;
>>
>>and drop this check

Ok

>>
>>
>>> +			voltdm = omap_voltage_domain_lookup(oh->vdd_name);
>>> +			if (!omap_voltage_add_dev(voltdm, &od->pdev.dev))
>>> +				oh->voltdm = voltdm;
>>> +		}
>>>  	}
>>>
>>>  	if (ret)
>>
>>Kevin

