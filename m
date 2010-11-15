From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 06/14] OMAP: Voltage layer changes to support DVFS.
Date: Mon, 15 Nov 2010 19:42:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4F54@dbde02.ent.ti.com>
References: <1288366708-32302-1-git-send-email-thara@ti.com>
	<1288366708-32302-7-git-send-email-thara@ti.com>
 <87wrojtoyc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab0KOONG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 09:13:06 -0500
In-Reply-To: <87wrojtoyc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Friday, November 12, 2010 5:04 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v2 06/14] OMAP: Voltage layer changes to support DVFS.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch introduces an API to take in the voltage domain and the
>>> new voltage as parameter and to scale all the scalable devices
>>> associated with the the voltage domain to the rate corresponding to the
>>> new voltage and scale the voltage domain to the new voltage.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/voltage.c             |   72
>>+++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/plat/voltage.h |    7 +++
>>>  2 files changed, 79 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>> index 6c2e4ef..458f8c1 100644
>>> --- a/arch/arm/mach-omap2/voltage.c
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -27,9 +27,11 @@
>>>  #include <linux/spinlock.h>
>>>  #include <linux/plist.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/opp.h>
>>>
>>>  #include <plat/common.h>
>>>  #include <plat/voltage.h>
>>> +#include <plat/omap_device.h>
>>>
>>>  #include "prm-regbits-34xx.h"
>>>  #include "prm44xx.h"
>>> @@ -1678,6 +1680,76 @@ struct voltagedomain
>>*omap_voltage_domain_lookup(char *name)
>>>  }
>>>
>>>  /**
>>> + * omap_voltage_scale : API to scale the devices associated with a
>>> + *			voltage domain vdd voltage.
>>> + * @volt_domain : the voltage domain to be scaled
>>> + * @volt : the new voltage for the voltage domain
>>> + *
>>> + * This API runs through the list of devices associated with the
>>> + * voltage domain and scales the device rates to those corresponding
>>> + * to the new voltage of the voltage domain. This API also scales
>>> + * the voltage domain voltage to the new value. Returns 0 on success
>>> + * else the error value.
>>> + */
>>> +int omap_voltage_scale(struct voltagedomain *voltdm, unsigned long volt)
>>> +{
>>> +	unsigned long curr_volt;
>>> +	int is_volt_scaled = 0;
>>> +	struct omap_vdd_info *vdd;
>>> +	struct omap_vdd_dev_list *temp_dev;
>>> +
>>> +	if (!voltdm || IS_ERR(voltdm)) {
>>> +		pr_warning("%s: VDD specified does not exist!\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
>>> +
>>> +	mutex_lock(&vdd->scaling_mutex);
>>> +
>>> +	curr_volt = omap_voltage_get_nom_volt(voltdm);
>>> +
>>> +	if (curr_volt == volt) {
>>> +		is_volt_scaled = 1;
>>> +	} else if (curr_volt < volt) {
>>> +		omap_voltage_scale_vdd(voltdm, volt);
>>> +		is_volt_scaled = 1;
>>> +	}
>>> +
>>> +	list_for_each_entry(temp_dev, &vdd->dev_list, node) {
>>> +		struct device *dev;
>>> +		struct opp *opp;
>>> +		unsigned long freq;
>>> +
>>> +		dev = temp_dev->dev;
>>> +
>>> +		opp = opp_find_voltage(dev, volt);
>>> +		if (IS_ERR(opp)) {
>>> +			dev_err(dev, "%s: Unable to find OPP for"
>>> +				"volt%ld\n", __func__, volt);
>>> +			continue;
>>> +		}
>>> +
>>> +		freq = opp_get_freq(opp);
>>> +
>>> +		if (freq == omap_device_get_rate(dev)) {
>>> +			dev_warn(dev, "%s: Already at the requested"
>>> +				"rate %ld\n", __func__, freq);
>>
>>Does this need to be a warning?  This happens relatively often and is normal.
>>This should probably just be removed in favor of
>>
>>		if (freq != omap_device_get_rate(dev))
>>                        omap_device_set_rate(dev, freq);

Yes. There are other warnings also in the dvfs code
which could be removed. Will remove them all in the next
version

Regards
Thara
