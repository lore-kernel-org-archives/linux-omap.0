From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 4/6] OMAP3: PM: Removed PER + CORE state hacking from
 omap_sram_idle
Date: Tue, 17 Nov 2009 12:08:07 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D7ECBA3@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-4-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-5-git-send-email-tero.kristo@nokia.com>
 <87zl6mi78n.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38177 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZKQLIw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 06:08:52 -0500
In-Reply-To: <87zl6mi78n.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 16 November, 2009 21:45
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 4/6] OMAP3: PM: Removed PER + CORE state 
>hacking from omap_sram_idle
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>
>A more descriptive changelog would be nice here.
>
>> This should be moved inside cpuidle to simplify design.
>
>And this should probably say "... and will be moved into CPUidle in
>subsequent patch."

I'll update this.

>
>Kevin
>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   18 ++----------------
>>  1 files changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 7b52f30..c704756 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -81,7 +81,6 @@ static int (*_omap_save_secure_sram)(u32 *addr);
>>  
>>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>> -static struct powerdomain *cam_pwrdm;
>>  
>>  static struct prm_setup_times_vc prm_setup_times_default = {
>>  	.clksetup = 0xff,
>> @@ -370,7 +369,6 @@ void omap_sram_idle(void)
>>  	int core_next_state = PWRDM_POWER_ON;
>>  	int core_prev_state, per_prev_state;
>>  	u32 sdrc_pwr = 0;
>> -	int per_state_modified = 0;
>>  
>>  	if (!_omap_sram_idle)
>>  		return;
>> @@ -409,19 +407,10 @@ void omap_sram_idle(void)
>>  	if (per_next_state < PWRDM_POWER_ON) {
>>  		omap_uart_prepare_idle(2);
>>  		omap2_gpio_prepare_for_idle(per_next_state);
>> -		if (per_next_state == PWRDM_POWER_OFF) {
>> -			if (core_next_state == PWRDM_POWER_ON) {
>> -				per_next_state = PWRDM_POWER_RET;
>> -				pwrdm_set_next_pwrst(per_pwrdm, 
>per_next_state);
>> -				per_state_modified = 1;
>> -			} else
>> -				omap3_per_save_context();
>> -		}
>> +		if (per_next_state == PWRDM_POWER_OFF)
>> +			omap3_per_save_context();
>>  	}
>>  
>> -	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
>> -		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>> -
>>  	/*
>>  	 * Disable smartreflex before entering WFI.
>>  	 * Only needed if we are going to enter retention or off.
>> @@ -540,8 +529,6 @@ void omap_sram_idle(void)
>>  			omap3_gpio_restore_pad_context(1);
>>  		omap2_gpio_resume_after_idle();
>>  		omap_uart_resume_idle(2);
>> -		if (per_state_modified)
>> -			pwrdm_set_next_pwrst(per_pwrdm, 
>PWRDM_POWER_OFF);
>>  	}
>>  
>>  	/* Disable IO-PAD and IO-CHAIN wakeup */
>> @@ -1170,7 +1157,6 @@ static int __init omap3_pm_init(void)
>>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
>> -	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>>  
>>  	omap_push_sram_idle();
>>  #ifdef CONFIG_SUSPEND
>> -- 
>> 1.5.4.3
>