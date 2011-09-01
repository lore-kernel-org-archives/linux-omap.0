From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] OMAP: PM: omap_device: add few quick access functions
Date: Thu, 01 Sep 2011 07:55:14 -0700
Message-ID: <87aaaol3cd.fsf@ti.com>
References: <1314026347-21623-1-git-send-email-b-cousson@ti.com>
	<1314026347-21623-3-git-send-email-b-cousson@ti.com>
	<87r5418bkz.fsf@ti.com> <4E5F72A2.6000002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56298 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757731Ab1IAOzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 10:55:18 -0400
Received: by mail-gy0-f169.google.com with SMTP id 1so120635gyf.28
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 07:55:17 -0700 (PDT)
In-Reply-To: <4E5F72A2.6000002@ti.com> (Benoit Cousson's message of "Thu, 1
	Sep 2011 13:55:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 9/1/2011 12:23 AM, Hilman, Kevin wrote:
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>>> From: Nishanth Menon<nm@ti.com>
>>>
>>> Provide a quick set of access functions:
>>> a) Convert omap_device to platform_device - This is the flip of
>>>     to_omap_device for equivalent usage
>>> b) Convert omap_device to device pointer - This is useful for
>>>     most devices that need to go through standard linux functions that
>>>     take device pointer.
>>> c) Convert hwmod to device pointer - This wrapper provides ability for
>>>     drivers to convert directly from hwmod name back to device pointer
>>>     without having to handle this on a driver by driver basis
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>> [b-cousson@ti.com: Adapt it to the new pdev pointer inside od]
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> ---
>>>   arch/arm/plat-omap/include/plat/omap_device.h |   15 +++++++++++++++
>>>   1 files changed, 15 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
>>> index bdc2804..903f329 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>>> @@ -152,6 +152,21 @@ static inline struct omap_device *to_omap_device(struct platform_device *pdev)
>>>   	return pdev ? pdev->archdata.od : NULL;
>>>   }
>>>
>>> +/* Convert omap_device to platform device pointer */
>>> +#define omap_device_get_pdev(x) ((x)->pdev)
>>> +/* Convert omap_device to device pointer */
>>> +#define omap_device_get_dev(x) (&omap_device_get_pdev(x)->dev)
>>
>> I don't see these used elsewhere, and I don't think they're needed...
>
> Well, there are used once... just below, and that's all.
>
>>> +/* Convert omap_hwmod name to device pointer */
>>> +static inline struct device *omap_hwmod_name_get_dev(const char *oh_name)
>>> +{
>>> +	struct omap_device *od;
>>> +	od = omap_hwmod_name_get_odev(oh_name);
>>> +	if (IS_ERR_OR_NULL(od))
>>> +		return ERR_PTR(od ? PTR_ERR(od) : -ENODEV);
>>> +	return omap_device_get_dev(od);
>>> +}
>>> +
>
> I will let Nishant comment, but I guess the idea was that an
> omap_device API should handle omap_device pointer, and then access to
> pdev or dev is done using these helpers.
>
> Assuming that now omap_device API should preferably use pdev, we can
> remove one step of indirection and thus get rid of the helpers, since
> they are not used anywhere else.
>

Yes please.

I've made most of the omap_device API now use pdev pointers already in
my series.

Thanks,


Kevin
