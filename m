From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 12/16] OMAP3: PM: Support for enabling smartreflex
 autocompensation by default.
Date: Fri, 5 Mar 2010 20:50:45 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B9@dbde02.ent.ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
	<1267003757-22456-9-git-send-email-thara@ti.com>
	<1267003757-22456-10-git-send-email-thara@ti.com>
	<1267003757-22456-11-git-send-email-thara@ti.com>
	<1267003757-22456-12-git-send-email-thara@ti.com>
	<1267003757-22456-13-git-send-email-thara@ti.com>
 <87d3zmqlfw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33267 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753721Ab0CEPUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:20:51 -0500
In-Reply-To: <87d3zmqlfw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, March 03, 2010 6:19 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 12/16] OMAP3: PM: Support for enabling smartreflex autocompensation by default.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds support to pdata enable smartreflex autocompenstion
>>> during init based on init_enable flag passed as pdata.
>>>
>>> This patch also adds enabling of autocompensation by
>>> default (setting init_enable flag to true) in case of ES3.1
>>> OMAP3430 chip. In the current implementation
>>> this step is kept in smartreflex.c itself.Later an API can be added
>>> so that the decision to enable autocompensation by default
>>> can be passed from the corresponding board files.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/smartreflex.c |   32 ++++++++++++++++++++++++++++----
>>>  1 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>> index 96dc76b..085dd05 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>> @@ -477,9 +477,15 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
>>>
>>>  	sr_class = class_data;
>>>  	/*
>>> -	 * Register the interrupt handler incase requested by the class driver
>>> +	 * Check if any SR module needs to be enabled as part of init.
>>> +	 * In case the probe for the SR module is not yet called the enable
>>> +	 * will not be done here but will be done in the probe whenever
>>> +	 * it gets called. Also register the interrupt handler incase
>>> +	 * requested by the class driver.
>>>  	 */
>>>  	list_for_each_entry(sr_info, &sr_list, node) {
>>> +		struct omap_smartreflex_data *pdata =
>>> +				sr_info->pdev->dev.platform_data;
>>>  		if (sr_class->class_type == SR_CLASS2 &&
>>>  				sr_class->notify_flags && sr_info->irq) {
>>>  			char name[SMARTREFLEX_NAME_LEN];
>>> @@ -496,6 +502,8 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
>>>  				return;
>>>  			}
>>>  		}
>>> +		if (pdata->init_enable)
>>> +			sr_start_vddautocomap(sr_info->srid);
>>
>>I think this flag is better named enable_on_init.
>>
>>>  	}
>>>  }
>>>
>>> @@ -562,11 +570,15 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>>>  	list_add(&sr_info->node, &sr_list);
>>>
>>>  	/*
>>> -	 * Register interrrupt handler if smartreflex class driver is already
>>> -	 * registered and has requested for interrupts. This will be attempted
>>> +	 * Enable the smartreflex module if init_enable flag is set and
>>> +	 * if the class driver is registered. Also Register interrrupt handler
>>> +	 * if smartreflex class driver is already registered and has
>>> +	 * requested for interrupts. This will be attempted
>>>  	 * in the class driver register again if it does not happen here.
>>>  	 */
>>>  	if (sr_class) {
>>> +		struct omap_smartreflex_data *pdata = pdev->dev.platform_data;
>>> +
>>>  		if (sr_class->class_type == SR_CLASS2 &&
>>>  				sr_class->notify_flags && sr_info->irq) {
>>>  			sprintf(name, "sr%d", sr_info->srid);
>>> @@ -580,6 +592,8 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
>>>  				return ret;
>>>  			}
>>>  		}
>>> +		if (pdata->init_enable)
>>> +			sr_start_vddautocomap(sr_info->srid);
>>>  	}
>>
>>As with the duplicate request_irq() in previous patch, I don't follow
>>why it's the start is needed twice.
>>
>>Is it to handle the case where no class driver is installed?

Same reason as I explained for request_irq.. so as to avoid dependency that class driver can be registered only after smartreflex driver initialization is done

Regards
Thara
>>
>>>
>>>  	pr_info("SmartReflex driver initialized\n");
>>> @@ -782,7 +796,17 @@ static int __init omap_devinit_smartreflex(void)
>>>  		if (WARN_ON(!sr_data))
>>>  			return -ENOMEM;
>>>
>>> -		sr_data->init_enable = false;
>>> +		/*
>>> +		 * Enable the SR module by default if it is a OMAP3430
>>> +		 * ES3.1 chip
>>
>>You should add a comment about why: starting with ES3.1, efuse values can be trusted?
>>
>>> +		 */
>>> +		if (cpu_is_omap343x()) {
>>> +			if (omap_rev() == OMAP3430_REV_ES3_1)
>>> +				sr_data->init_enable = true;
>>> +			else
>>> +				sr_data->init_enable = false;
>>> +		} else
>>> +			sr_data->init_enable = false;
>>>  		sr_data->device_enable = omap_device_enable;
>>>  		sr_data->device_shutdown = omap_device_shutdown;
>>>  		sr_data->device_idle = omap_device_idle;
>>
>>Kevin
