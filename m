From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should
 return error
Date: Fri, 06 Aug 2010 05:59:49 -0500
Message-ID: <4C5BEB25.6070609@gmail.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-7-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE58@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39579 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0HFK74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 06:59:56 -0400
Received: by ywh1 with SMTP id 1so2776454ywh.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 03:59:56 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE58@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 08/06/2010 02:24 AM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Friday, August 06, 2010 3:54 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>> Subject: [PM-SR][PATCH 06/12] omap3: sr: device: fail sr_dev_init should return error
>>>
>>> sr_dev_init should return error on error conditions
>>>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath<thara@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/sr_device.c |    3 ++-
>>> 1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>> index 6f70da6..8fb60d8 100644
>>> --- a/arch/arm/mach-omap2/sr_device.c
>>> +++ b/arch/arm/mach-omap2/sr_device.c
>>> @@ -162,7 +162,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>>> 				__func__, i + 1);
>>> 		i++;
>>> 		kfree(sr_data);
>>> -		return 0;
>>> +		return -ENODATA;
>>> 	}
>>> 	sr_set_nvalues(sr_dev_data, sr_data);
>>> 	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
>>> @@ -172,6 +172,7 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>>> 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
>>> 			__func__, name, oh->name);
>>> 		kfree(sr_data);
>>> +		return PTR_ERR(od);
>>> 	}
> NAK for this change.
> This API is called from omap_hwmod_for_each_by_class for every smartreflex module.
> If This API returns an error omap_hwmod_for_each_by_class will exit without looping over
> rest of the smartreflex modules. This means a error for one smartreflex module will prevent
> rest of the smartreflex modules to be initialized. We do not want this. Hence this API returns 0
> for non-availability of data for a smartreflex module.

why do we want this behavior(aka continue with as many modules as you 
can enable)? h/wmod data structure are NOT meant to be corrupted if they 
are, what guarentee do we have that the rest of the sr module data 
structures have the right hwmods(even if they passed device_build?).. if 
they are, what is the point in enabling SR in half the domains - we 
should flag this as an error to developer and get him to fix it instead 
of encouraging this slipping by half a dozen developers as only sr_l3 
failed or something similar..

Regards,
Nishanth Menon
