From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [RFC 2/3] OMAP3: hwmod: Add support to associate an initiator
 with a hwmod
Date: Tue, 22 Mar 2011 14:01:53 +0530
Message-ID: <90b662f8f53f9eed052c978821054169@mail.gmail.com>
References: <1300705823-12784-1-git-send-email-rnayak@ti.com>
 <1300705823-12784-2-git-send-email-rnayak@ti.com> <1300705823-12784-3-git-send-email-rnayak@ti.com>
 <03a02588593f269848ca723790e0319a@mail.gmail.com> <4D885DA8.80002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41097 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753875Ab1CVIb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 04:31:58 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so2767882gxk.9
        for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 01:31:57 -0700 (PDT)
In-Reply-To: <4D885DA8.80002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>

>-----Original Message-----
>From: Rajendra Nayak [mailto:rnayak@ti.com]
>Sent: Tuesday, March 22, 2011 1:58 PM
>To: Hema Kalliguddi
>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Benoit Cousson
>Subject: Re: [RFC 2/3] OMAP3: hwmod: Add support to associate
>an initiator with a hwmod
>
>On 3/21/2011 6:38 PM, Hema Kalliguddi wrote:
>> Rajendra,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Rajendra Nayak
>>> Sent: Monday, March 21, 2011 4:40 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: paul@pwsan.com; b-cousson@ti.com; Rajendra Nayak
>>> Subject: [RFC 2/3] OMAP3: hwmod: Add support to associate an
>>> initiator with a hwmod
>>>
>>> Add hwmod api's to add and delete an initiator
>>> association with an hwmod.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> ---
>>> arch/arm/mach-omap2/omap_hwmod.c             |   33
>>> ++++++++++++++++++++++++++
>>> arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>>> 2 files changed, 35 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
>>> b/arch/arm/mach-omap2/omap_hwmod.c
>>> index e034294..d4826be 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -2369,3 +2369,36 @@ int omap_hwmod_no_setup_reset(struct
>>> omap_hwmod *oh)
>>>
>>> 	return 0;
>>> }
>>> +
>>> +int omap_hwmod_add_initiator_user(struct omap_hwmod *oh,
>u8 init_id)
>>> +{
>>> +	if (oh->_state != _HWMOD_STATE_ENABLED)
>>> +		return -EINVAL;
>>> +
>>> +	if (cpu_is_omap34xx()) {
>>> +		return omap2_prm_module_enable_initiator_wakeup(
>>> +						
>>> oh->prcm.omap2.module_offs,
>>> +						
>>> oh->prcm.omap2.idlest_reg_id,
>>> +						
>>> oh->prcm.omap2.idlest_idle_bit,
>>> +						init_id);
>>> +	}
>>> +
>>> +	return -EINVAL;
>>
>> Why are you returning error when it not a omap34xx?
>> Is it not that this API will be called for only omap34xx?
>
>No, this API could get called as part of a driver call
>to the omap_device API on non-supported platform's as well.

OK.
>
>>
>>> +}
>>> +
>>> +int omap_hwmod_del_initiator_user(struct omap_hwmod *oh,
>u8 init_id)
>>> +{
>>> +	if (oh->_state == _HWMOD_STATE_ENABLED)
>>> +		return -EINVAL;
>>> +
>>> +	if (cpu_is_omap34xx()) {
>>> +		return omap2_prm_module_disable_initiator_wakeup(
>>> +						
>>> oh->prcm.omap2.module_offs,
>>> +						
>>> oh->prcm.omap2.idlest_reg_id,
>>> +						
>>> oh->prcm.omap2.idlest_idle_bit,
>>> +						init_id);
>>> +	}
>>> +
>>> +	return -EINVAL;
>>
>> Ditto...
>>
>>> +
>>> +}
>>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> index 4bd7354..fe47448 100644
>>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>>> @@ -590,6 +590,8 @@ int omap_hwmod_add_initiator_dep(struct
>>> omap_hwmod *oh,
>>> 				 struct omap_hwmod *init_oh);
>>> int omap_hwmod_del_initiator_dep(struct omap_hwmod *oh,
>>> 				 struct omap_hwmod *init_oh);
>>> +int omap_hwmod_add_initiator_user(struct omap_hwmod *oh,
>u8 init_id);
>>> +int omap_hwmod_del_initiator_user(struct omap_hwmod *oh,
>u8 init_id);
>>>
>>> int omap_hwmod_set_clockact_both(struct omap_hwmod *oh);
>>> int omap_hwmod_set_clockact_main(struct omap_hwmod *oh);
>>> --
>>
>>
>> Regards,
>> Hema
>>
>>> 1.7.0.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
>
