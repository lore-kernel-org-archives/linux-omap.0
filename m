From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 09/19] omap3+: sr: introduce class init,deinit and priv data
Date: Wed, 02 Mar 2011 16:57:33 -0800
Message-ID: <87k4ght402.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-10-git-send-email-nm@ti.com> <87r5apvzfc.fsf@ti.com>
	<4D6EE3C0.8060202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39274 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413Ab1CCA5r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:57:47 -0500
Received: by mail-iy0-f169.google.com with SMTP id 13so534393iyf.28
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:57:47 -0800 (PST)
In-Reply-To: <4D6EE3C0.8060202@ti.com> (Nishanth Menon's message of "Thu, 03
	Mar 2011 06:11:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 03/03/2011 05:38 AM:
>> Nishanth Menon<nm@ti.com>  writes:
>>
>>> Certain class drivers such as class 1.5 drivers, will need specific
>>> notification that they have to be started up or stopped independent
>>> of smart reflex operation. They also may need private data to be
>>> used for operations of their own, provide the same.
>>>
>>> Signed-off-by: Nishanth Menon<nm@ti.com>
>>
>> Basic principle looks fine, but some naming comments below...
> k, thx.
>
>>
>> [...]
>>
>>> diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/plat-omap/include/plat/smartreflex.h
>>> index 6568c88..8b6ecd9 100644
>>> --- a/arch/arm/plat-omap/include/plat/smartreflex.h
>>> +++ b/arch/arm/plat-omap/include/plat/smartreflex.h
>>> @@ -167,6 +167,8 @@ struct omap_sr_pmic_data {
>>>    *
>>>    * @enable:		API to enable a particular class smaartreflex.
>>>    * @disable:		API to disable a particular class smartreflex.
>>> + * @class_init:		API to do class specific initialization (optional)
>>> + * @class_deinit:	API to do class specific initialization (optional)
>>
>> The 'class_' prefix here is not needed.
> ack.
>
>>
>> The changelog uses 'start' and 'stop' instead of init&  deinit.  I
>> prefer those names to [de]init.
>
> Would'nt start and stop cause confusion when mixed with existing
> enable/disable? does enable/start actually start the SR? intent here
> with init/deinit is to do class specific initialization or
> deinitialization.

Well, one way or another, make the changelog consistent with the
function names.

To me though, start/stop has more meaning.  They are called from
sr_[start|stop]_vddautocomp, so using start/stop is consistent there.
Also, init is usually something done once (and doesn't have a de-init
counterpart) but here we're talking about something done for each 
sr_[start|stop]_vddautocomp()

Kevin


