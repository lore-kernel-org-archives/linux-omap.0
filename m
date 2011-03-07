From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the hwmod data.
Date: Mon, 7 Mar 2011 11:22:14 +0100
Message-ID: <4D74B1D6.8020708@ti.com>
References: <1298295990-1070-1-git-send-email-santosh.shilimkar@ti.com> <1298295990-1070-6-git-send-email-santosh.shilimkar@ti.com> <4D62AAAA.40104@ti.com> <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34284 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab1CGKWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 05:22:17 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p27AMGCo003864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 04:22:16 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p27AMGwS018361
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 04:22:16 -0600 (CST)
In-Reply-To: <295be59bd43a2e9f0961c10263ce19c0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "R, Sricharan" <r.sricharan@ti.com>

On 2/21/2011 8:03 PM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: Cousson, Benoit [mailto:b-cousson@ti.com]
>> Sent: Monday, February 21, 2011 11:41 PM
>> To: Shilimkar, Santosh
>> Cc: linux-omap@vger.kernel.org; Balbi, Felipe; R, Sricharan
>> Subject: Re: [PATCH 5/6] omap4: Initialise the l3 device with the
>> hwmod data.
>>
>> On 2/21/2011 2:46 PM, Shilimkar, Santosh wrote:
>>> From: sricharan<r.sricharan@ti.com>
>>>
>>> The l3 interconnect device is build with all the data required
>>> to handle the error logging. The data is extracted from the
>>> hwmod data base.
>>>
>>> Signed-off-by: sricharan<r.sricharan@ti.com>
>>> Signed-off-by: sricharan<r.sricharan@ti.com>
>>> Tested-by: sricharan<r.sricharan@ti.com>
>>
>> Mmm, I'm not sure the tested-by is meaningfull in your case, since
>> you wrote the code and so everybody will assume you tested it.
>> One s-o-b should be probably enough.
>>
>
> Well he tested whole series including the patch from Felipe.
> So a tested-by on whole series doesn't hurt, right ?
>
> Just for record, I have seen tested by applied on whole series
> Where as some of the patches in this series are just comment
> updates.
>
>>> Cc: Benoit Cousson<b-cousson@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/devices.c |   23 +++++++++++++++++++++++
>>>    1 files changed, 23 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-
>> omap2/devices.c
>>> index 2d46f55..25fa2ad 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -57,6 +57,29 @@ static int __init omap3_l3_init(void)
>>>    }
>>>    postcore_initcall(omap3_l3_init);
>>>
>>> +static int __init omap4_l3_init(void)
>>> +{
>>> +	int l;
>>> +	struct omap_hwmod *oh;
>>> +	struct omap_device *od;
>>> +	char oh_name[12];
>>> +
>>> +	l = snprintf(oh_name, 12, "l3_main_1");
>>> +
>>> +	oh = omap_hwmod_lookup(oh_name);
>>> +
>>> +	if (!oh)
>>> +		pr_err("could not look up %s\n", oh_name);
>>> +
>>> +	od = omap_device_build("omap4-l3-interconnect", 0, oh, NULL,
>>
>> In order to stick to the OMAP device naming convention and to have
>> something not dependent of the chip version, I think we'd better
>> name
>> the device like that: "omap_l3_noc". Since it is a Arteris "Network
>> On
>> Chip" on OMAP4. We will not have to change it for OMAP5 then.
>> On OMAP3 the name can then be "omap_l3_smx" for the Sonics MX
>> interconnect.
>>
> Device name changes are fine but file name changes as per this.
> dosn't look right if they are like
> omap_l3_noc.c
> omap_l3_smx.c

Why do you think that does not look right?

> May be we can rename them like below
> omap_l3_3xxx.c
> omap_l3_4xxx.c

The point is that it will really depend of the amount of SoC specifics 
data are in this file. If most of the code is reusable on OMAP5 for 
example, then it makes sense to use the name of the IP.
If that's not the case, then you'd better use the SoC name.

Regards,
Benoit
