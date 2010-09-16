From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 04/13] OMAP: Introduce API to return a device list
 associated with a voltage domain
Date: Thu, 16 Sep 2010 15:40:45 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03294424CB@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-5-git-send-email-thara@ti.com>
 <87d3sxdlwl.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44052 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab0IPKKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 06:10:52 -0400
In-Reply-To: <87d3sxdlwl.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 02, 2010 6:04 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage
>>domain
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds an API in the opp layer that
>>> can be used by the voltage layer to get a list of all the
>>> scalable devices belonging to a particular voltage domain.
>>> This API is to be typically called only once by the voltage
>>> layer per voltage domain instance and the device list should
>>> be stored. This approach makes it easy during dvfs to scale
>>> all the devices associated with a voltage domain and then
>>> scale the voltage domain.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>I don't think the OPP layer is the right place for this after all.
>>
>>How about something like this in the voltage layer:
>>
>>  omap_voltage_add_device(struct voltagedomain *voltdm, struct device *dev)
>>
>>During omap_device_build(), if the hwmod has a voltage domain, it
>>calls this function to register it with the voltage layer.

This mandates voltage layer to be initialized before the first omap_device_build
has happened. I think that is going to be a very confusing sequencing. Also today
voltage layer init happens later in the system.

>>
>>This function then creates a list (internal to voltage layer) of all the
>>devices in a voltage domain rather than having to query the OPP layer
>>for it.
>>
>>Kevin
>>
>>> ---
>>>  arch/arm/plat-omap/include/plat/opp.h |    9 +++++++++
>>>  arch/arm/plat-omap/opp.c              |   28 ++++++++++++++++++++++++++++
>>>  2 files changed, 37 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
>>> index 0e580ed..a4c1669 100644
>>> --- a/arch/arm/plat-omap/include/plat/opp.h
>>> +++ b/arch/arm/plat-omap/include/plat/opp.h
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/cpufreq.h>
>>>
>>>  #include <plat/common.h>
>>> +#include <plat/voltage.h>
>>>
>>>  /**
>>>   * struct omap_opp_def - OMAP OPP Definition
>>> @@ -86,6 +87,9 @@ int opp_disable(struct omap_opp *opp);
>>>
>>>  void opp_init_cpufreq_table(struct device *dev,
>>>  			    struct cpufreq_frequency_table **table);
>>> +
>>> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
>>> +					int *dev_count);
>>>  #else
>>>  static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
>>>  {
>>> @@ -149,5 +153,10 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
>>>  {
>>>  }
>>>
>>> +static inline struct device **opp_init_voltage_params(
>>> +			struct voltagedomain *voltdm, int *dev_count)
>>> +{
>>> +}
>>> +
>>>  #endif		/* CONFIG_PM */
>>>  #endif		/* __ASM_ARM_OMAP_OPP_H */
>>> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
>>> index a3dea82..72dd62a 100644
>>> --- a/arch/arm/plat-omap/opp.c
>>> +++ b/arch/arm/plat-omap/opp.c
>>> @@ -502,3 +502,31 @@ void opp_init_cpufreq_table(struct device *dev,
>>>
>>>  	*table = &freq_table[0];
>>>  }
>>> +
>>> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
>>> +					int *dev_count)
>>> +{
>>> +	struct device_opp *dev_opp;
>>> +	struct device **dev_list;
>>> +	int count = 0, i = 0;
>>> +
>>> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
>>> +		if (!dev_opp->oh->vdd_name)
>>> +			continue;
>>> +
>>> +		if (!strcmp(dev_opp->oh->vdd_name, voltdm->name)) {
>>> +			dev_opp->oh->voltdm = voltdm;
>>> +			count++;
>>> +		}
>>> +	}
>>> +
>>> +	dev_list = kzalloc(sizeof(struct device *) * count, GFP_KERNEL);
>>> +
>>> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
>>> +		if (dev_opp->oh->voltdm == voltdm)
>>> +			dev_list[i++] = dev_opp->dev;
>>> +	}
>>> +
>>> +	*dev_count = count;
>>> +	return dev_list;
>>> +}
