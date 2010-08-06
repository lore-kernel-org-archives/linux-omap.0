From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-SR][PATCH 05/12] omap3: sr: device: check for dev_attr
Date: Fri, 06 Aug 2010 06:00:44 -0500
Message-ID: <4C5BEB5C.5060706@gmail.com>
References: <1281047052-21346-1-git-send-email-nm@ti.com> <1281047052-21346-6-git-send-email-nm@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401CE5B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35566 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab0HFLAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 07:00:50 -0400
Received: by gxk23 with SMTP id 23so2801121gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Aug 2010 04:00:48 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032401CE5B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

On 08/06/2010 02:27 AM, Gopinath, Thara wrote:
>
>
>>> -----Original Message-----
>>> From: Menon, Nishanth
>>> Sent: Friday, August 06, 2010 3:54 AM
>>> To: linux-omap
>>> Cc: Menon, Nishanth; Kevin Hilman; Gopinath, Thara
>>> Subject: [PM-SR][PATCH 05/12] omap3: sr: device: check for dev_attr
>>>
>>> In the unlikely case that hwmod database is messed up, dont crash
>>> report error and attempt to recover.
>>>
>>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>> Cc: Thara Gopinath<thara@ti.com>
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> ---
>>> arch/arm/mach-omap2/sr_device.c |    6 ++++++
>>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
>>> index 7d13704..6f70da6 100644
>>> --- a/arch/arm/mach-omap2/sr_device.c
>>> +++ b/arch/arm/mach-omap2/sr_device.c
>>> @@ -130,6 +130,12 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
>>> 	}
>>>
>>> 	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
>>> +	if (unlikely(!sr_dev_data)) {
>>> +		pr_err("%s: Bad oh->dev_attr!\n", __func__);
>>> +		kfree(sr_data);
>>> +		return -EINVAL;
>>> +	}
>
> Taken in after modifications as per the reply for patch 06/12

I dont agree to the mod of 06/12. sorry.

Regards,
Nishanth Menon
