From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2] omap2/3: dmtimer: Enable autoidle
Date: Tue, 15 Feb 2011 08:19:35 -0800
Message-ID: <878vxhuv6w.fsf@ti.com>
References: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
	<6038d98e9a2eb2129200f5e08560cf7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:49685 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952Ab1BOQTs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:19:48 -0500
Received: by mail-vx0-f179.google.com with SMTP id 40so226947vxb.38
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 08:19:45 -0800 (PST)
In-Reply-To: <6038d98e9a2eb2129200f5e08560cf7e@mail.gmail.com> (Santosh
	Shilimkar's message of "Tue, 15 Feb 2011 21:07:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tero Kristo
>> Sent: Tuesday, February 15, 2011 10:00 PM
>> To: linux-omap@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
>>
>> This saves some power. OMAP4 version should check for GPT module ID,
>> as
>> autoidle is only supported on a subset of these.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/plat-omap/dmtimer.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
>> omap/dmtimer.c
>> index 1d706cf..ee9f6eb 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -342,6 +342,10 @@ static void omap_dm_timer_reset(struct
>> omap_dm_timer *timer)
>>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
>>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on
>> idle */
>>
>> +	/* Enable autoidle on OMAP2 / OMAP3 */
>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +		l |= 0x1 << 0;
>> +
> We should get rid of this CPU checks. How about adding a flag
> and populating it on init for the architectures it supports.
>

Instead, this should be implemented on top of Tarun's hwmod conversion
which knows that different timers have different capabilities (e.g. 1ms)
and autoidle can be set based on capabilities.

Kevin

