From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] OMAP3: Only update pm-counters when needed
Date: Fri, 30 Oct 2009 09:23:47 -0700
Message-ID: <878wessve4.fsf@deeprootsystems.com>
References: <1256901974-29145-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256902713.31764.141.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51777 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932571AbZJ3QXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 12:23:45 -0400
Received: by pxi9 with SMTP id 9so1928463pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 09:23:50 -0700 (PDT)
In-Reply-To: <1256902713.31764.141.camel@ubuntu> (Kalle Jokiniemi's message of "Fri\, 30 Oct 2009 13\:38\:33 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> On Fri, 2009-10-30 at 13:26 +0200, Kalle Jokiniemi wrote:
>> From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
>> 
>> The biggest source of latency in idle loop (omap_sram_idle
>> function) comes from updating the state counters for each
>> power domain. The two purposes of these counters are to
>> provide debug data in debugfs, and to keep track of context
>> losses occurring during idle transitions (off mode counters).
>> 
>> I created new debugfs interface "enable_count" for
>> enabling the "count" interface, which exposes the debug
>> part of these counters. The counters are not updated
>> anymore for CORE ON idle transitions, when the count
>> interface is disabled. For deeper CORE states, counters
>> are still updated to preserve context loss tracking.
>> 
>> This change decreases C1/C2 state latency over 100us at
>> OPP2.
>> 
>> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

[...]

>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 01260ec..1e3041e 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -378,15 +378,16 @@ void omap_sram_idle(void)
>>  		return;
>>  	}
>>  
>> -	pwrdm_pre_transition();
>> +	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>> +
>> +	pwrdm_pre_transition(core_next_state != PWRDM_POWER_ON);
>
> I still left a little condition handling here, but it's nicer than the
> previous one, don't you think. Just passing this force_update parameter
> seemed like the most efficient way of doing it. 

Yes, I'm OK with the 'force update' idea for now.  You should just
update the changelog to talk about the force-update additon to the
transition hooks as well.

Other than that, looks fine with me for now.

Kevin

> I did not want to duplicate core state recording into powerdomain code,
> nor inefficient code looking for core pwrdm and then checking it's next
> state in powerdomain code. I think it's idle codes responsibility to
> know whether off-transitions will happen in general (do we need to force
> state counter update). Or at least that information is most efficiently
> available there now.
>
> We could consider cpuidle passing some "safe state" parameter, in case
> of C1/C2, which could be used instead of this core_next_state
> comparison. If you want to make it even nicer looking.
>
> - Kalle
>
>>  
>>  	/* NEON control */
>>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
>>  
>>  	/* PER */
>> -	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>> -	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>>  	if (per_next_state < PWRDM_POWER_ON) {
>>  		omap_uart_prepare_idle(2);
>>  		omap2_gpio_prepare_for_idle(per_next_state);
>> @@ -505,8 +506,7 @@ void omap_sram_idle(void)
>>  		omap3_disable_io_chain();
>>  	}
>>  
>> -
>> -	pwrdm_post_transition();
>> +	pwrdm_post_transition(core_next_state != PWRDM_POWER_ON);
>>  
>>  	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>>  }
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index f00289a..71af2b8 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -1216,15 +1216,17 @@ int pwrdm_clk_state_switch(struct clk *clk)
>>  	return -EINVAL;
>>  }
>>  
>> -int pwrdm_pre_transition(void)
>> +int pwrdm_pre_transition(int force_update)
>>  {
>> -	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
>> +	if (pm_dbg_count_is_active() || force_update)
>> +		pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
>>  	return 0;
>>  }
>>  
>> -int pwrdm_post_transition(void)
>> +int pwrdm_post_transition(int force_update)
>>  {
>> -	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
>> +	if (pm_dbg_count_is_active() || force_update)
>> +		pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
>>  	return 0;
>>  }
>>  
>> diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
>> index fa64614..cb93272 100644
>> --- a/arch/arm/plat-omap/include/mach/powerdomain.h
>> +++ b/arch/arm/plat-omap/include/mach/powerdomain.h
>> @@ -176,7 +176,7 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm);
>>  
>>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>>  int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
>> -int pwrdm_pre_transition(void);
>> -int pwrdm_post_transition(void);
>> +int pwrdm_pre_transition(int force_update);
>> +int pwrdm_post_transition(int force_update);
>>  
>>  #endif
