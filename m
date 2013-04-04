From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2 03/18] ARM: OMAP4+: PM: Consolidate and use OMAP4 PM
 code for OMAP5
Date: Thu, 4 Apr 2013 17:21:51 +0530
Message-ID: <515D6957.5000802@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com> <1364205910-32392-4-git-send-email-santosh.shilimkar@ti.com> <87li8zwel4.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759284Ab3DDLt5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 07:49:57 -0400
In-Reply-To: <87li8zwel4.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

On Thursday 04 April 2013 01:50 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> OMAP5 has backward compatible PRCM block and it's programming
>> model is mostly similar to OMAP4. Same is going to be maintained
>> for future OMAP4 based SOCs. Hence consolidate the OMAP4 power
>> management code so that it can be re-used on OMAP5 and later devices.
>>
>> With consolidated code, let basic power management code build
>> for OMAP5 devices. While at it, update the kernel-doc for omap4_pm_init().
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/Makefile                       |    9 ++--
>>  arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c}   |   54 ++++++++++++++++----
>>  .../mach-omap2/{sleep44xx.S => sleep_omap4plus.S}  |    0
>>  3 files changed, 49 insertions(+), 14 deletions(-)
>>  rename arch/arm/mach-omap2/{pm44xx.c => pm_omap4plus.c} (86%)
>>  rename arch/arm/mach-omap2/{sleep44xx.S => sleep_omap4plus.S} (100%)
>>

[..]

>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm_omap4plus.c
>> similarity index 86%
>> rename from arch/arm/mach-omap2/pm44xx.c
>> rename to arch/arm/mach-omap2/pm_omap4plus.c
>> index 5ba6d88..e920c34 100644
>> --- a/arch/arm/mach-omap2/pm44xx.c
>> +++ b/arch/arm/mach-omap2/pm_omap4plus.c
>> @@ -1,7 +1,7 @@
>>  /*
>> - * OMAP4 Power Management Routines
>> + * OMAP4PLUS Power Management Routines
> 
> nit: OMAP4+  (you only need to spell out "plus" in the filename.
> 
OK. I will replace '+' instead of 'PLUS' in rest of the places.
>>   *
>> - * Copyright (C) 2010-2011 Texas Instruments, Inc.
>> + * Copyright (C) 2010-2013 Texas Instruments, Inc.
>>   * Rajendra Nayak <rnayak@ti.com>
>>   * Santosh Shilimkar <santosh.shilimkar@ti.com>
>>   *
>> @@ -135,16 +135,16 @@ static void omap_default_idle(void)
>>  }
>>  
>>  /**
>> - * omap4_pm_init - Init routine for OMAP4 PM
>> + * omap4_init_static_deps - Add OMAP4 static dependencies
>>   *
>> - * Initializes all powerdomain and clockdomain target states
>> - * and all PRCM settings.
>> + * Add needed static clockdomain dependencies on OMAP4 devices.
>> + * Return: 0 on success or 'err' on failures
>>   */
>> -int __init omap4_pm_init(void)
>> +static inline int omap4_init_static_deps(void)
> 
> You dropped the __init here, but it's still only called from another
> __init function, so I suspect it should stay.
> 
Yep. Will keep that in next version.

Regards,
Santosh

