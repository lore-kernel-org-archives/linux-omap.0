From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from
 going to RET or OFF when DSS is on
Date: Fri, 4 Mar 2011 08:14:07 +0000
Message-ID: <854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
	<20110301224918.32613.95176.stgit@twilight.localdomain>
 <87pqq7pz27.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:42951 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab1CDIO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 03:14:27 -0500
In-Reply-To: <87pqq7pz27.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@ti.com]
>Sent: 04 March, 2011 01:25
>To: Paul Walmsley
>Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>Kristo Tero (Nokia-MS/Tampere)
>Subject: Re: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from
>going to RET or OFF when DSS is on
>
>Paul Walmsley <paul@pwsan.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Prevent the CORE power domain from entering RETENTION or OFF when DSS
>> is on.  Otherwise, the display FIFO(s) may underflow due to the time
>> needed for the CORE to wake back up, causing tearing and unnecessary
>> interrupts.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> [paul@pwsan.com: wrote commit message]
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>
>This isn't quite ready for merge, and needs a little more testing with
>current DSS driver and mainline.
>
>> ---
>>  arch/arm/mach-omap2/cpuidle34xx.c |   10 ++++++++--
>>  1 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
>omap2/cpuidle34xx.c
>> index 0335cd8..d1b7789 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -9,8 +9,9 @@
>>   * Copyright (C) 2007 Texas Instruments, Inc.
>>   * Karthik Dasu <karthik-dp@ti.com>
>>   *
>> - * Copyright (C) 2006 Nokia Corporation
>> + * Copyright (C) 2006, 2011 Nokia Corporation
>>   * Tony Lindgren <tony@atomide.com>
>> + * Tero Kristo <tero.kristo@nokia.com>
>>   *
>>   * Copyright (C) 2005 Texas Instruments, Inc.
>>   * Richard Woodruff <r-woodruff2@ti.com>
>> @@ -268,6 +269,12 @@ static int omap3_enter_idle_bm(struct
>cpuidle_device *dev,
>>  		goto select_state;
>>  	}
>>
>> +	/* If DSS is active, prevent CORE RET/OFF */
>> +	dss_state = pwrdm_read_pwrst(dss_pd);
>> +	if (dss_state == PWRDM_POWER_ON &&
>> +	    core_next_state != PWRDM_POWER_ON)
>> +		core_next_state = PWRDM_POWER_INACTIVE;
>> +
>
>Due to sleepdeps/autodeps, when this code runs, DSS powerdomain is
>always on.  The result is that CORE is always set to INACTIVE.

Now I recall that someone was asking about a patch similar to this earlier, and had the same issue with DSS sleepdep collision.

What is the reason for having the sleepdep for DSS powerdomain anyway? At least I can't see any reason why the sleepdep for DSS should be set. In my opinion it should be perfectly okay for DSS domain to idle independently of MPU/CORE, as this is going to be better for power consumption also.


>
>A side effect of this problem is exposing a known issue with PER wakeups
>(UART3, GPIO).  Since CORE never goes to retention/off, IO-pad
>wakeups are never enabled, so PER wakeups do not work.
>
>I think we need a different way of checking for DSS activity.
>
>Sounds like another usecase for idle notifiers.
>
>Kevin
