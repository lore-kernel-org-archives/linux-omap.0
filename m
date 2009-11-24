From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 2/2] OMAP3: Implemented VFP restore/save context
Date: Tue, 24 Nov 2009 12:47:26 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D9B8E7C@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
 <1259059024-23719-2-git-send-email-tero.kristo@nokia.com>
 <1259059024-23719-3-git-send-email-tero.kristo@nokia.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA83D849@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39514 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbZKXLsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 06:48:06 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA83D849@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vishwanath.bs@ti.com, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Sripathy, Vishwanath [mailto:vishwanath.bs@ti.com] 
>Sent: 24 November, 2009 13:34
>To: Kristo Tero (Nokia-D/Tampere); linux-arm-kernel@lists.infradead.org
>Cc: linux-omap@vger.kernel.org
>Subject: RE: [PATCH 2/2] OMAP3: Implemented VFP restore/save context
>
>
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Tero Kristo
>> Sent: Tuesday, November 24, 2009 4:07 PM
>> To: linux-arm-kernel@lists.infradead.org
>> Cc: linux-omap@vger.kernel.org
>> Subject: [PATCH 2/2] OMAP3: Implemented VFP restore/save context
>> 
>> From: Tero Kristo <tero.kristo@nokia.com>
>> 
>> VFP save context is called before MPU/NEON off. Restore is 
>not needed as
>> the next VFP trap will restore context automatically. Uses 
>the support
>> routine implemented in arch/arm/vfp/vfpmodule.c.
>> 
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Richard Woodruff <r-woodruff2@ti.com>
>> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm.h     |    1 +
>>  arch/arm/mach-omap2/pm34xx.c |   21 ++++++++++++++++++++-
>>  2 files changed, 21 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 4f22107..dd5bbaf 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -18,6 +18,7 @@ extern u32 sleep_while_idle;
>>  extern u32 voltage_off_while_idle;
>> 
>>  extern void *omap3_secure_ram_storage;
>> +extern void vfp_pm_save_context(void);
>>  extern void omap3_pm_off_mode_enable(int);
>>  extern void omap_sram_idle(void);
>>  extern int omap3_can_sleep(void);
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index b26ae5b..4b01303 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -321,6 +321,18 @@ static void restore_control_register(u32 val)
>>  	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : 
>"r" (val));
>>  }
>> 
>> +static inline void omap3_save_neon_context(void)
>> +{
>> +#ifdef CONFIG_VFP
>> +	vfp_pm_save_context();
>> +#endif
>> +}
>> +
>> +static inline void omap3_restore_neon_context(void)
>> +{
>> +	return;
>> +}
>> +
>>  /* Function to restore the table entry that was modified 
>for enabling MMU */
>>  static void restore_table_entry(void)
>>  {
>> @@ -365,6 +377,7 @@ void omap_sram_idle(void)
>>  	/* save_state = 3 => L1, L2 and logic lost */
>>  	int save_state = 0;
>>  	int mpu_next_state = PWRDM_POWER_ON;
>> +	int neon_next_state = PWRDM_POWER_ON;
>>  	int per_next_state = PWRDM_POWER_ON;
>>  	int core_next_state = PWRDM_POWER_ON;
>>  	int core_prev_state, per_prev_state;
>> @@ -398,8 +411,12 @@ void omap_sram_idle(void)
>>  	pwrdm_pre_transition();
>> 
>>  	/* NEON control */
>> -	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>> +	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
>>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
>> +		neon_next_state = mpu_next_state;
>> +		if (neon_next_state == PWRDM_POWER_OFF)
>> +			omap3_save_neon_context();
>> +	}
>> 
>>  	/* PER */
>>  	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>> @@ -537,6 +554,8 @@ void omap_sram_idle(void)
>>  		omap3_disable_io_chain();
>>  	}
>> 
>> +	if (neon_next_state == PWRDM_POWER_OFF)
>> +		omap3_restore_neon_context();
>> 
>Why do call restore here when restore is done automatically 
>upon context switch?

That is just a stub if we would need to add something there at some point. restore_neon_context() currently does nothing.


>
>>  	pwrdm_post_transition();
>>  }
>> --
>> 1.5.4.3
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>