From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] omap: dmtimer: Enable autoidle
Date: Tue, 15 Feb 2011 08:16:52 +0000
Message-ID: <854C6400F5AA6644BA6FE7953F3E769B037E9BDD@008-AM1MPN1-014.mgdnok.nokia.com>
References: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com>
 <87oc6exkjr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:54767 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab1BOIRh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 03:17:37 -0500
In-Reply-To: <87oc6exkjr.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org



>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@ti.com]
>Sent: 15 February, 2011 01:29
>To: Kristo Tero (Nokia-MS/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] omap: dmtimer: Enable autoidle
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> This will save some power.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>Please report which platforms this was tested with.

Tested only on OMAP3.

Should this be changed to apply only on that one? I don't know about OMAP4, but I think this should work on OMAP2 at least based on spec.


>
>Also, please Cc linux-arm-kernel.
>
>Thanks,
>
>Kevin
>
>> ---
>>  arch/arm/plat-omap/dmtimer.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
>omap/dmtimer.c
>> index 1d706cf..949becc 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -341,6 +341,7 @@ static void omap_dm_timer_reset(struct
>omap_dm_timer *timer)
>>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
>>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
>>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle
>*/
>> +	l |= 0x1 << 0;   /* Set autoidle */
>>
>>  	/*
>>  	 * Enable wake-up on OMAP2 CPUs.
