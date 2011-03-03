From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/19] omap3+: sr: introduce class init,deinit and priv
 data
Date: Thu, 03 Mar 2011 06:52:08 +0530
Message-ID: <4D6EED40.6000702@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-10-git-send-email-nm@ti.com> <87r5apvzfc.fsf@ti.com>	<4D6EE3C0.8060202@ti.com> <87k4ght402.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49760 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754658Ab1CCBWP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:22:15 -0500
Received: by mail-vx0-f177.google.com with SMTP id 2so692518vxd.22
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 17:22:14 -0800 (PST)
In-Reply-To: <87k4ght402.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 06:27 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> Kevin Hilman wrote, on 03/03/2011 05:38 AM:
>>> Nishanth Menon<nm@ti.com>   writes:
>>>
>>>> Certain class drivers such as class 1.5 drivers, will need specific
>>>> notification that they have to be started up or stopped independent
>>>> of smart reflex operation. They also may need private data to be
>>>> used for operations of their own, provide the same.
>>>>
>>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>>
>>> Basic principle looks fine, but some naming comments below...
>> k, thx.
>>
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
>>>> index 6568c88..8b6ecd9 100644
>>>> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
>>>> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
>>>> @@ -167,6 +167,8 @@ struct omap_sr_pmic_data {
>>>>     *
>>>>     * @enable:		API to enable a particular class smaartreflex.
>>>>     * @disable:		API to disable a particular class smartreflex.
>>>> + * @class_init:		API to do class specific initialization (optional)
>>>> + * @class_deinit:	API to do class specific initialization (optional)
>>>
>>> The 'class_' prefix here is not needed.
>> ack.
>>
>>>
>>> The changelog uses 'start' and 'stop' instead of init&   deinit.  I
>>> prefer those names to [de]init.
>>
>> Would'nt start and stop cause confusion when mixed with existing
>> enable/disable? does enable/start actually start the SR? intent here
>> with init/deinit is to do class specific initialization or
>> deinitialization.
>
> Well, one way or another, make the changelog consistent with the
> function names.
>
> To me though, start/stop has more meaning.  They are called from
> sr_[start|stop]_vddautocomp, so using start/stop is consistent there.
> Also, init is usually something done once (and doesn't have a de-init
> counterpart) but here we're talking about something done for each
> sr_[start|stop]_vddautocomp()

fair enough - unless there are other dissenting voices, will switch to 
start/stop for the api name and add documentation in code to explain the 
need.

-- 
Regards,
Nishanth Menon
