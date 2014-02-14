From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH V2 4/4] ARM: OMAP2+: AM43x: Use gptimer as clocksource
Date: Fri, 14 Feb 2014 14:16:13 +0530
Message-ID: <52FDD7D5.30508@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com> <1391768486-2134-5-git-send-email-lokeshvutla@ti.com> <20140213231919.GO28216@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55859 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbaBNIrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 03:47:06 -0500
In-Reply-To: <20140213231919.GO28216@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, linux@arm.linux.org.uk, nsekhar@ti.com

On Friday 14 February 2014 04:49 AM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [140207 02:24]:
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> The SyncTimer in AM43x is clocked using the following two sources:
>> 1) An inaccuarte 32k clock (CLK_32KHZ) derived from PER DPLL, causing system
>>    time to go slowly (~10% deviation).
>> 2) external 32KHz RTC clock, which may not always be available on board like
>>    in the case of ePOS EVM
>>
>> Use gptimer as clocksource instead, as is done in the case of AM335x
>> (which does not have a SyncTimer). With this, system time keeping works
>> accurately.
> 
> Hmm doesn't this also mean that PM for any deeper idle states won't
> work properly?

Thats true. This would mean we cannot put the peripheral/core domain down
in idle. Suspend however can still work if suspend/resume callbacks are added
to the clockevent and clocksource code to shut the non-wakeup domain timer.

regards,
Rajendra

> 
> Regards,
> 
> Tony
>  
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c |    2 +-
>>  arch/arm/mach-omap2/timer.c         |    3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 8e3daa1..5679464a 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -229,7 +229,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
>>  	.init_late	= am43xx_init_late,
>>  	.init_irq	= omap_gic_of_init,
>>  	.init_machine	= omap_generic_init,
>> -	.init_time	= omap3_sync32k_timer_init,
>> +	.init_time	= omap3_gptimer_timer_init,
>>  	.dt_compat	= am43_boards_compat,
>>  MACHINE_END
>>  #endif
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 74044aa..b62de9f 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -604,7 +604,8 @@ OMAP_SYS_32K_TIMER_INIT(3_secure, 12, "secure_32k_fck", "ti,timer-secure",
>>  			2, "timer_sys_ck", NULL);
>>  #endif /* CONFIG_ARCH_OMAP3 */
>>  
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || \
>> +	defined(CONFIG_SOC_AM43XX)
>>  OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
>>  		       1, "timer_sys_ck", "ti,timer-alwon");
>>  #endif
>> -- 
>> 1.7.9.5
>>

