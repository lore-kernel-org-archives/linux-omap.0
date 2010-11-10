From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 04/11] OMAP3: PM: Adding smartreflex device file.
Date: Wed, 10 Nov 2010 10:55:17 -0800
Message-ID: <87y69180ve.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-5-git-send-email-thara@ti.com>
	<1287084563.14514.155.camel@localhost>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EA6@dbde02.ent.ti.com>
	<87aam6b33n.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95F70@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49520 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613Ab0KJSzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 13:55:21 -0500
Received: by pva4 with SMTP id 4so234645pva.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 10:55:20 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95F70@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Sat, 23 Oct 2010 16:25:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>"Gopinath, Thara" <thara@ti.com> writes:
>>>
>>>>>>On Wed, 2010-09-22 at 20:15 +0530, Thara Gopinath wrote:
>>>>>>> This patch adds support for device registration of various
>>>>>>> smartreflex module present in the system. This patch introduces
>>>>>>> the platform data for smartreflex devices which include
>>>>>>> the efused and test n-target vaules, module enable/disable
>>>>>>> pointers and a parameter to indicate whether smartreflex
>>>>>>> autocompensation needs to be enabled on init or not.
>>>>>>> Currently auocompensation is enabled on init by default
>>>>>>> for OMAP3430 ES3.1 chip.
>>>>>>>
>>>>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>[...]
>>>
>>>>>>> +	sr_data->voltdm = omap_voltage_domain_get(sr_dev_data->vdd_name);
>>>>>>> +	if (IS_ERR(sr_data->voltdm)) {
>>>>>>> +		pr_err("%s: Unable to get voltage domain pointer for VDD
>>>%s\n",
>>>>>>> +			__func__, sr_dev_data->vdd_name);
>>>>>>> +		goto exit;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	sr_dev_data->volts_supported = omap_voltage_get_volttable(
>>>>>>> +			sr_data->voltdm, &sr_dev_data->volt_data);
>>>>>>>
>>>>>>> +	if (!sr_dev_data->volts_supported) {
>>>>>>> +		pr_warning("%s: No Voltage table registerd fo VDD%d."
>>>>>>> +			"Something really wrong\n\n", __func__, i + 1);
>>>>>>> +		goto exit;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	sr_set_nvalues(sr_dev_data, sr_data);
>>>>>>
>>>>>>First question: why does this N-value init need to be done in the device
>>>>>>init?  It seems better to be a part of the SR driver probe.
>>>>
>>>> OMAP3 and OMAP4 has different ways of reading the efuse registers. I
>>>> would like it to be in device file so that we can have the necessary
>>>> checks. The driver should not be bothered about getting of the
>>>> n-values.
>>>
>>>Bothered?   The driver's job is to probe the HW.  The device code
>>>can tell the driver where the N-values are located (register offsets,
>>>via platform_data), but IMO, should not be reading the values from HW.
>
> But then we will have to put cpu_is_omap34xx() and cpu_is_omap44xx()
> checks in the driver. Also omap_ctrl_readl API will have to be used
> from the driver.

OK, so read them in the device file, and register the values with the SR
layer (not the voltage layer.)  They should be registered using some
register function, not by directly manipulating structures internal to
that layer.

Also, I don't see why sr_dev_data->volts_supported has to be determined
at runtime.  That could be set in the hwmod data using ARRAY_SIZE of the
efuse offsets.

Kevin

