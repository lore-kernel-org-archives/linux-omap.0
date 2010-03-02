From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv6 1/9] OMAP3: PM: Added support functions for omap3
 pwrdm handling
Date: Tue, 2 Mar 2010 11:20:28 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A224BF70AF2C@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
	<1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
 <877hpvaaz5.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18328 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab0CBKUo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:20:44 -0500
In-Reply-To: <877hpvaaz5.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 02 March, 2010 01:17
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv6 1/9] OMAP3: PM: Added support functions 
>for omap3 pwrdm handling
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Added omap3_pwrdm_set_next_pwrst and 
>omap3_pwrdm_read_next_pwrst. These
>> functions add support for INACTIVE and ON states to the standard OMAP
>> powerdomain functions, and add caching logic for the next 
>state. These
>> functions are used in subsequent patches to simplify the 
>logic of the idle
>> loop.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm.h     |    2 +
>>  arch/arm/mach-omap2/pm34xx.c |   60 
>+++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 61 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 75aa685..1d9a740 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -67,6 +67,8 @@ static inline void omap3_pm_init_vc(struct 
>prm_setup_vc *setup_vc)
>>  
>>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>>  extern int omap3_pm_set_suspend_state(struct powerdomain 
>*pwrdm, int state);
>> +extern int omap3_pwrdm_set_next_pwrst(struct powerdomain 
>*pwrdm, u8 pwrst);
>> +extern int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
>>  
>>  extern u32 wakeup_timer_seconds;
>>  extern struct omap_dm_timer *gptimer_wakeup;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 1359ec9..f20d3d8 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -576,6 +576,64 @@ int omap3_can_sleep(void)
>>  	return 1;
>>  }
>>  
>> +struct powerdomain_data {
>> +	u8 next_state;
>> +	u8 init_done;
>> +};
>> +
>> +static struct powerdomain_data mpu_pwrdm_data;
>> +static struct powerdomain_data core_pwrdm_data;
>> +static struct powerdomain_data neon_pwrdm_data;
>> +
>> +static struct powerdomain_data *get_pwrdm_data(struct 
>powerdomain *pwrdm)
>> +{
>> +	if (pwrdm == mpu_pwrdm)
>> +		return &mpu_pwrdm_data;
>> +	else if (pwrdm == core_pwrdm)
>> +		return &core_pwrdm_data;
>> +	else if (pwrdm == neon_pwrdm)
>> +		return &neon_pwrdm_data;
>> +	return NULL;
>> +}
>> +
>> +int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>
>I think this func should be documented along the lines of the 
>changelog.
>It should describe the caching and the fact that 'INACTIVE' is a state
>that can be read, but not written.

Ok, will do the change.

>> +{
>> +	struct powerdomain_data *data = get_pwrdm_data(pwrdm);
>> +	u8 prg_pwrst;
>> +
>> +	if (!data)
>> +		return pwrdm_set_next_pwrst(pwrdm, pwrst);
>> +
>> +	if (!data->init_done)
>> +		data->init_done = 1;
>
>Not sure I follow the purpose of the 'init_done' flag here, 
>but I'm having
>an averse reaction to it.

init_done actually means if the cache is valid or not. If not, we ignore the current cached state. Another way of doing this would be to initialize all values at proper point during boot by reading from HW, or just put the HW reset values to the cache during compile time. The cache validity bit is needed in the read_next_pwrst code also below.

>
>> +	else if (data->next_state == pwrst)
>> +		return 0;
>> +
>> +	if (pwrst == PWRDM_POWER_INACTIVE)
>> +		prg_pwrst = PWRDM_POWER_ON;
>> +	else
>> +		prg_pwrst = pwrst;
>> +
>> +	pwrdm_set_next_pwrst(pwrdm, prg_pwrst);
>> +
>> +	if (pwrst == PWRDM_POWER_ON)
>> +		omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[0]);
>> +	else
>> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>> +
>> +	data->next_state = pwrst;
>> +	return 0;
>> +}
>> +
>> +int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>> +{
>> +	struct powerdomain_data *data = get_pwrdm_data(pwrdm);
>> +
>> +	if (!data || !data->init_done)
>> +		return pwrdm_read_next_pwrst(pwrdm);
>> +	return data->next_state;
>> +}
>> +
>>  /* This sets pwrdm state (other than mpu & core. Currently only ON &
>>   * RET are supported. Function is assuming that clkdm doesn't have
>>   * hw_sup mode enabled. */
>> @@ -604,7 +662,7 @@ int set_pwrdm_state(struct powerdomain 
>*pwrdm, u32 state)
>>  		pwrdm_wait_transition(pwrdm);
>>  	}
>>  
>> -	ret = pwrdm_set_next_pwrst(pwrdm, state);
>> +	ret = omap3_pwrdm_set_next_pwrst(pwrdm, state);
>>  	if (ret) {
>>  		printk(KERN_ERR "Unable to set state of 
>powerdomain: %s\n",
>>  		       pwrdm->name);
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>