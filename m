From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should
 return error
Date: Fri, 13 Aug 2010 16:01:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324111135@dbde02.ent.ti.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com>
 <1281047052-21346-7-git-send-email-nm@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032401CE58@dbde02.ent.ti.com>
 <4C5BEB25.6070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34067 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761408Ab0HMKbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 06:31:36 -0400
In-Reply-To: <4C5BEB25.6070609@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>Nishanth Menon
>>Sent: Friday, August 06, 2010 4:30 PM
>>To: Gopinath, Thara
>>Cc: Menon, Nishanth; linux-omap; Kevin Hilman
>>Subject: Re: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should return error
>>
>>On 08/06/2010 02:24 AM, Gopinath, Thara wrote:
>>>
>>>
>>>>> -----Original Message-----
>>>>> From: Menon, Nishanth
>>>>> Sent: Friday, August 06, 2010 3:54 AM
>>>>> To: linux-omap
>>>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>>>> Subject: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should return error
>>>>>
>>>>> sr_dev_init should return error on error conditions
>>>>>
>>>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>>> Cc: Thara Gopinath<thara@ti.com>
>>>>>
>>>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>>>> ---
>>>>> arch/arm/mach-omap2/sr_device.c |    3 ++-
>>>>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>>>> index 6f70da6..8fb60d8 100644
>>>>> --- a/arch/arm/mach-omap2/sr_device.c
>>>>> +++ b/arch/arm/mach-omap2/sr_device.c
>>>>> @@ -162,7 +162,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>>>>> 				__func__, i + 1);
>>>>> 		i++;
>>>>> 		kfree(sr_data);
>>>>> -		return 0;
>>>>> +		return -ENODATA;
>>>>> 	}
>>>>> 	sr_set_nvalues(sr_dev_data, sr_data);
>>>>> 	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
>>>>> @@ -172,6 +172,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>>>>> 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
>>>>> 			__func__, name, oh->name);
>>>>> 		kfree(sr_data);
>>>>> +		return PTR_ERR(od);
>>>>> 	}
>>> NAK for this change.
>>> This API is called from omap_hwmod_for_each_by_class for every smartreflex module.
>>> If This API returns an error omap_hwmod_for_each_by_class will exit without looping over
>>> rest of the smartreflex modules. This means a error for one smartreflex module will prevent
>>> rest of the smartreflex modules to be initialized. We do not want this. Hence this API returns 0
>>> for non-availability of data for a smartreflex module.
>>
>>why do we want this behavior(aka continue with as many modules as you
>>can enable)? h/wmod data structure are NOT meant to be corrupted if they
>>are, what guarentee do we have that the rest of the sr module data
>>structures have the right hwmods(even if they passed device_build?).. if
>>they are, what is the point in enabling SR in half the domains - we
>>should flag this as an error to developer and get him to fix it instead
>>of encouraging this slipping by half a dozen developers as only sr_l3
>>failed or something similar..

It could be a typo that is causing one hwmod to fail. Also I disagree with the point that we
cannot enable sr for one voltage domain alone. There are two or three separate voltage domains in
the system so that they can be controlled and configured independent of each other.
Also if one of the sr modules fail registration we do flag the error in today's code plus if the
debug fs is enabled the entry for the failed sr module will be missing. I think that is enough
of error handling and flagging. 

Regards
Thara

>>
>>Regards,
>>Nishanth Menon
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
