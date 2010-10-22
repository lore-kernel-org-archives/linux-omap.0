From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 04/11] OMAP3: PM: Adding smartreflex device file.
Date: Fri, 22 Oct 2010 09:32:12 -0700
Message-ID: <87aam6b33n.fsf@deeprootsystems.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-5-git-send-email-thara@ti.com>
	<1287084563.14514.155.camel@localhost>
	<5A47E75E594F054BAF48C5E4FC4B92AB035EB95EA6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34706 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab0JVQcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 12:32:17 -0400
Received: by yxn35 with SMTP id 35so791231yxn.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 09:32:17 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035EB95EA6@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Fri, 22 Oct 2010 20:06:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>On Wed, 2010-09-22 at 20:15 +0530, Thara Gopinath wrote:
>>>> This patch adds support for device registration of various
>>>> smartreflex module present in the system. This patch introduces
>>>> the platform data for smartreflex devices which include
>>>> the efused and test n-target vaules, module enable/disable
>>>> pointers and a parameter to indicate whether smartreflex
>>>> autocompensation needs to be enabled on init or not.
>>>> Currently auocompensation is enabled on init by default
>>>> for OMAP3430 ES3.1 chip.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

>>>> +	sr_data->voltdm = omap_voltage_domain_get(sr_dev_data->vdd_name);
>>>> +	if (IS_ERR(sr_data->voltdm)) {
>>>> +		pr_err("%s: Unable to get voltage domain pointer for VDD %s\n",
>>>> +			__func__, sr_dev_data->vdd_name);
>>>> +		goto exit;
>>>> +	}
>>>> +
>>>> +	sr_dev_data->volts_supported = omap_voltage_get_volttable(
>>>> +			sr_data->voltdm, &sr_dev_data->volt_data);
>>>>
>>>> +	if (!sr_dev_data->volts_supported) {
>>>> +		pr_warning("%s: No Voltage table registerd fo VDD%d."
>>>> +			"Something really wrong\n\n", __func__, i + 1);
>>>> +		goto exit;
>>>> +	}
>>>> +
>>>> +	sr_set_nvalues(sr_dev_data, sr_data);
>>>
>>>First question: why does this N-value init need to be done in the device
>>>init?  It seems better to be a part of the SR driver probe.
>
> OMAP3 and OMAP4 has different ways of reading the efuse registers. I
> would like it to be in device file so that we can have the necessary
> checks. The driver should not be bothered about getting of the
> n-values.

Bothered?   The driver's job is to probe the HW.  The device code
can tell the driver where the N-values are located (register offsets,
via platform_data), but IMO, should not be reading the values from HW.

>>>
>>>Second, this section took me quite some time to understand, as it seems
>>>to blur the lines of device and driver but also how it interacts with
>>>the voltage layer.
>>>
>>>sr_set_nvalues() is directly manipulating structures that are internal
>>>to the voltage layer.  It also makes assumptions about the ordering of
>>>volt_data structs in the voltage layer.
>>>
>>>Strictly speaking neither the sr_nvalue or sr_errminlimit fields of
>>>volt_data are not used at all in the voltage layer, but only in the SR
>>>layer, so ideally they should really stay in the SR layer.
>>>
>>>I think what is needed here is a cleaner way for the SR layer to connect
>>>the N-values to a voltage.  The current method of manipulating voltage
>>>layer structs inside the SR layer is not acceptable.  Since the n-values
>>>are fixed in HW (per SoC), what I suggest is simply having a field like
>>>'efuse_id' or something in volt_data.  Then, the smart reflex layer can
>>>lookup and index all the efuse values during probe, and when sr_enable
>>>is called, it looks up the nvalue based on efuse_id.
>>>
>>>I assume that the sr_errminlimit could also be set based on efuse_id,
>>>and therefore remain contained within the SR layer, but I'm not sure I
>>>like that idea any better than keeping it inside volt_data.  For now,
>>>I'll let you make the call on errminlimit, but I really want to see the
>>>N-value stuff isolated in the SR layer.
>
> I do not understand your proposal here? What kind of variable is efuse-id??
>

Sorry, it was kind of rambling.  I'll try again...

Currently, omap_volt_data (in the voltage layer) includes SR N-value
field:

struct omap_volt_data {
	u32	volt_nominal;
	u32	sr_nvalue;
	u8	sr_errminlimit;
	u8	vp_errgain;
};

but sr_nvalue is not used in the voltage layer at all.

This choice has led to the SR device init code having to populate
internal structures of the voltage layer.  That is what I don't like.
(I have a similar problem with the presence of sr_errminlimit in the
omap_volt_data, because it's not used in the voltage layer either.)

So my suggestion was to remove the sr_nvalue field and replace it with
something like an efuse_id field.  Since n-values are directly connected
with HW registers, this is a simple mapping.  

This way, the voltage layer does not know about the exact N-value
(because it doesn't care), ll the voltage layer needs to know is 
which efuse to use for this voltage.

As for implementation, in the SR driver, probe could read the N-values
from HW into a table.  The enable/disable functiosn can look up the
N-values from the table using the efuse_id from volt_data.

Did I explain any better this time?

Kevin









