From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if
 < ES1.2
Date: Mon, 20 Dec 2010 13:07:18 -0600
Message-ID: <4D0FA966.5040100@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>	<1292712817-24999-8-git-send-email-nm@ti.com> <8739ps5kpv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:35789 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757419Ab0LTTHW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 14:07:22 -0500
Received: by mail-yw0-f42.google.com with SMTP id 5so1502455yws.29
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 11:07:21 -0800 (PST)
In-Reply-To: <8739ps5kpv.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 12/20/2010 01:05 PM, the following:
[..]
>>  struct cpuidle_driver omap3_idle_driver = {
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 92ef400..9032d09 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>>  extern unsigned int omap34xx_cpu_suspend_sz;
>>  
>>  #define PM_RTA_ERRATUM_i608		(1 << 0)
>> +#define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
>>  
>>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>>  extern u16 pm34xx_errata;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 21cd36e..7faea55 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -928,12 +928,28 @@ void omap3_pm_off_mode_enable(int enable)
>>  		state = PWRDM_POWER_RET;
>>  
>>  #ifdef CONFIG_CPU_IDLE
>> -	omap3_cpuidle_update_states(state, state);
>> +	/*
>> +	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
>> +	 * enable OFF mode in a stable form for previous revisions, restrict
>> +	 * instead to RET
>> +	 */
>> +	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
>> +		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
>> +	else
>> +		omap3_cpuidle_update_states(state, state);
>>  #endif
>>  
>>  	list_for_each_entry(pwrst, &pwrst_list, node) {
>> -		pwrst->next_state = state;
>> -		omap_set_pwrdm_state(pwrst->pwrdm, state);
>> +		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
>> +				pwrst->pwrdm == core_pwrdm &&
>> +				state == PWRDM_POWER_OFF) {
>> +			pwrst->next_state = PWRDM_POWER_RET;
>> +			pr_err("%s: Core OFF disabled due to errata i583\n",
>> +				__func__);
> 
> This is a warning, not an error condition, so should probably be
> pr_warning().
> 
> That being said, this could be noisy if enable_off_mode is being toggled
> repeatedly, so using WARN_ONCE() might be more appropriate as suggested
> by others.

ok WARN_ONCE it is then.. :) next rev coming right up in a few more mins..

-- 
Regards,
Nishanth Menon
