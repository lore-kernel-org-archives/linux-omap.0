From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 04/13] OMAP: Introduce API to return a device list
 associated with a voltage domain
Date: Fri, 17 Sep 2010 20:18:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329539FDB@dbde02.ent.ti.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-5-git-send-email-thara@ti.com>
	<87y6brblt3.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424C1@dbde02.ent.ti.com>
 <874odpems0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42407 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab0IQOsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:48:22 -0400
In-Reply-To: <874odpems0.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 16, 2010 8:52 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage
>>domain
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>[...]
>>
>>>>>> +struct device **opp_init_voltage_params(struct voltagedomain *voltdm,
>>>>>> +					int *dev_count)
>>>>>> +{
>>>>>> +	struct device_opp *dev_opp;
>>>>>> +	struct device **dev_list;
>>>>>> +	int count = 0, i = 0;
>>>>>> +
>>>>>> +	list_for_each_entry(dev_opp, &dev_opp_list, node) {
>>>>>> +		if (!dev_opp->oh->vdd_name)
>>>>>> +			continue;
>>>>>> +
>>>>>> +		if (!strcmp(dev_opp->oh->vdd_name, voltdm->name)) {
>>>>>> +			dev_opp->oh->voltdm = voltdm;
>>>>>
>>>>>Couldn't we assign the voltdm at opp_add() time since you added it as
>>>>>part of the hwmod?
>>>
>>> We cannot as the voltage layer is not initialized at the point of opp_add.
>>> Having said this, today voltage layer is dependent on opp layer only to figure out
>>> the current nominal voltage from the opp table. If that can be some how decoupled we
>>> can initialize voltage layer early on and implement this.
>>
>>We could decouple the voltage init into and early init and late init to
>>handle this.

Hello Kevin,

Yes we could. In fact I do not like the idea of voltage layer dependent
on opp layer itself. So here is my proposal. Maintain a variable in the main
per vdd structure omap_vdd_info curr_volt which will get updated each time a
voltage scale is attempted. Now the only issue is during boot up how does the voltage
layer know what voltage each vdd should be put into ? A piece of code can be
implemented in pm34xx.c/pm44xx.c init functions to read the clock rate associated
with each vdd , call into the opp layer to get the corresponding
voltage ( basically the sequence we do today everytime in voltage layer
when the API to get  nominal voltage is called) and call omap_voltage_scale_vdd with
the corresponding voltage. This way we can fully decouple voltage laye from opp layer
and make voltage init an early_initcall. We might still need a late_initcall to register
debugfs entries though.
What is your take on this ?

Regards
Thara

>>
>>Kevin
