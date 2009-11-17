From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 2/6] OMAP3: PM: Added support for INACTIVE and ON states
 for powerdomains
Date: Tue, 17 Nov 2009 12:07:33 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D7ECB9F@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
	<1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
 <87bpj2jlyr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31710 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbZKQLIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 06:08:04 -0500
In-Reply-To: <87bpj2jlyr.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 16 November, 2009 21:42
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 2/6] OMAP3: PM: Added support for INACTIVE 
>and ON states for powerdomains
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Previously omap_sram_idle() did not know about the 
>difference between ON and
>> INACTIVE states, which complicated the state handling in these cases.
>
>This changelog needs an update.
>
>This patch changes makes the IO-chain arming conditional and removes
>the clockdomain idle calls.

IO-chain arming is already conditional, the condition needs to be changed a bit due to changed powerdomain states.

- previously: less than PWRDM_POWER_ON = RET and OFF
- now: less than or equal to PWRDM_POWER_RET = RET and OFF

What is changed actually is that if CORE or PER is going INACTIVE, we will disable UART clocks which will allow CORE and UART to go inactive. Previously this did not happen.

>While I understand the clkdm idle call removal, It's not clear from
>the changelog how these are related to the new handling of INACTIVE
>states.

Yes, I can try to fix the changelog a bit regarding this.

>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   14 +++++++-------
>>  1 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 9d0a9b4..7b52f30 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -383,6 +383,7 @@ void omap_sram_idle(void)
>>  	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
>>  	switch (mpu_next_state) {
>>  	case PWRDM_POWER_ON:
>> +	case PWRDM_POWER_INACTIVE:
>>  	case PWRDM_POWER_RET:
>>  		/* No need to save context */
>>  		save_state = 0;
>> @@ -448,9 +449,11 @@ void omap_sram_idle(void)
>>  						OMAP3430_GR_MOD,
>>  						
>OMAP3_PRM_VOLTCTRL_OFFSET);
>>  		}
>> -		/* Enable IO-PAD and IO-CHAIN wakeups */
>> -		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>> -		omap3_enable_io_chain();
>> +		if (core_next_state <= PWRDM_POWER_RET) {
>> +			/* Enable IO-PAD and IO-CHAIN wakeups */
>> +			prm_set_mod_reg_bits(OMAP3430_EN_IO, 
>WKUP_MOD, PM_WKEN);
>> +			omap3_enable_io_chain();
>> +		}
>>  	}
>>  	omap3_intc_prepare_idle();
>>  
>> @@ -542,15 +545,13 @@ void omap_sram_idle(void)
>>  	}
>>  
>>  	/* Disable IO-PAD and IO-CHAIN wakeup */
>> -	if (core_next_state < PWRDM_POWER_ON) {
>> +	if (core_next_state <= PWRDM_POWER_ON) {
>
>Hmm, did you mean <= RET here?   

True, this is a bug. Should be RET.

>Otherwise, you can just remove the conditional.
>
>>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO, 
>WKUP_MOD, PM_WKEN);
>>  		omap3_disable_io_chain();
>>  	}
>>  
>>  
>>  	pwrdm_post_transition();
>> -
>> -	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>>  }
>>  
>>  int omap3_can_sleep(void)
>> @@ -598,7 +599,6 @@ int set_pwrdm_state(struct powerdomain 
>*pwrdm, u32 state)
>>  	}
>>  
>>  	if (sleep_switch) {
>> -		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>>  		pwrdm_wait_transition(pwrdm);
>>  		pwrdm_state_switch(pwrdm);
>>  	}
>> -- 
>> 1.5.4.3
>
>Kevin
>