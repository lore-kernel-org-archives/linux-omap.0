From: Nishanth Menon <nm@ti.com>
Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
Date: Thu, 27 Jan 2011 22:23:59 +0530
Message-ID: <4D41A327.6040206@ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com> <AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com> <2dcb8dc49945099cbbc5c4f725d845a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42326 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab1A0QyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 11:54:14 -0500
Received: by mail-ew0-f54.google.com with SMTP id 24so1043870ewy.13
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 08:54:13 -0800 (PST)
In-Reply-To: <2dcb8dc49945099cbbc5c4f725d845a5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org

Vishwanath Sripathy wrote, on 01/27/2011 07:55 PM:
> Nishant,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>> Sent: Thursday, January 27, 2011 3:06 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
>>
>> Sanjeev,
>>
>> On Tue, Jan 25, 2011 at 20:55, Premi, Sanjeev<premi@ti.com>  wrote:
>>> While building the kernel at 2.6.37, i see this warning for omap3evm -
>> with omap3630:
>>>
>>> Power Management for TI OMAP3.
>>> sr_init: No PMIC hook to init smartreflex<-- THIS IS THE WARNING.
>>> smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver
>> initialized
>>> smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver
>> initialized
>>> SmartReflex Class3 initialized
>>>
>>> In the code, i see this comment:
>>>   /*
>>>   * sr_init is a late init. If by then a pmic specific API is not
>>>   * registered either there is no need for anything to be done on
>>>   * the PMIC side or somebody has forgotten to register a PMIC
>>>   * handler. Warn for the second condition.
>>>   */
>>>   if (sr_pmic_data&&  sr_pmic_data->sr_pmic_init)
>>>   sr_pmic_data->sr_pmic_init();
>>>   else
>>>   pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
>>>
>>> But, I couldn't find any place where PMIC is being registered.
>>
>> This is a harmless warning (ideally, we should remove the pr_warning).
>>   the intent here is to have hook for pmic_init which could be
>> populated for custom PMICs which may need "something additional" for
>> Smart reflex enablement. if you look at the sr_pmic_data - it just has
>> a single api for pmic_init
>>
>> e.g. in the case of TWL4030/5030, we might need to set the bit to
>> switch mode from I2C1 to I2C_SR - e.g. the patch from Shweta[1]
>>
>> if Smartreflex AVS was the *only* mechanism in the system, we could
>> have hooked pmic_init to this bit setting. but since the system can do
>> voltage scaling (VP forceupdate/vc bypass) independent of SR AVS
>> block, the patch in [1] does initialization independent of
>> sr_pmic_data->pmic_init which makes sense.
>>
>> in short, my 2cents: the warning is probably something we should
>> remove from the code.
> As you mentioned, incase of TWL4030/5030, we do not need any hook. However
> if some other PMIC is used that genuinely needs this hook, then shouldn't
> SR throw up this warning? As SR module is independent of PMIC, it cannot
> distinguish them. So I feel this warning should be present probably
> reworded better like "No PMIC hook registered to init smartreflex. Either
> this PM IC does not need SR init or PMIC hook is missing".

Fair enough - but how do we know if the warning spawns off question such 
as this thread? aka false alarm? if a platform does need initialization 
it should be up to the platform porting person rt?

Just that I dont think it makes sense to false flag folks considering 
that the API is optional.

-- 
Regards,
Nishanth Menon
