From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] PM OMAP3: Change omap3_save_secure_ram to be called
 only during init
Date: Thu, 13 Aug 2009 17:06:20 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2054BB54E81@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1229073605-24235-1-git-send-email-tero.kristo@nokia.com>
 <8763crkdds.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40363 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbZHMPGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 11:06:30 -0400
In-Reply-To: <8763crkdds.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 13 August, 2009 17:17
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] PM OMAP3: Change omap3_save_secure_ram to 
>be called only during init
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> This function is now called only once during the 
>initialization of the device
>> and consequent sleep cycles will re-use the same saved 
>contents for secure
>> RAM. Users who need secure services should do secure RAM 
>saving before
>> entering off-mode, if a secure service has been accessed 
>after last save.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>You explain what you're doing, but you don't explain why.
>
>Is there a large latency involved in this save/restore that you're
>trying to eliminate for the no-secure-services case?

There are both latency and reliability issues. The context save uses a hardware resource which takes an order of hundreds of milliseconds to initialize after a wake up from off-mode, and also there is no way of checking whether it is ready from kernel side or not. It just crashes if you use it too quickly.

>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++++++++-
>>  1 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 4223622..b8cf5f2 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -127,6 +127,12 @@ static void omap3_core_restore_context(void)
>>  	omap_dma_global_context_restore();
>>  }
>>  
>> +/*
>> + * FIXME: This function should be called before entering 
>off-mode after
>> + * OMAP3 secure services have been accessed. Currently it 
>is only called
>> + * once during boot sequence, but this works as we are not 
>using secure
>> + * services.
>> + */
>>  static void omap3_save_secure_ram_context(u32 target_mpu_state)
>>  {
>>  	u32 ret;
>> @@ -349,7 +355,6 @@ void omap_sram_idle(void)
>>  					     OMAP3_PRM_VOLTCTRL_OFFSET);
>>  			omap3_core_save_context();
>>  			omap3_prcm_save_context();
>> -			omap3_save_secure_ram_context(mpu_next_state);
>>  		}
>>  		/* Enable IO-PAD wakeup */
>>  		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>> @@ -923,6 +928,18 @@ int __init omap3_pm_init(void)
>>  	}
>>  	omap3_save_scratchpad_contents();
>>  
>> +	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>> +		local_irq_disable();
>> +		local_fiq_disable();
>> +
>> +		omap_dma_global_context_save();
>> +		omap3_save_secure_ram_context(PWRDM_POWER_ON);
>> +		omap_dma_global_context_restore();
>> +
>> +		local_irq_enable();
>> +		local_fiq_enable();
>> +	}
>> +
>>  err1:
>>  	return ret;
>>  err2:
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>