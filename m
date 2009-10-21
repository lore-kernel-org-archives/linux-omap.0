From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 09/17] OMAP3: PM: Ack pending interrupts before entering
 suspend
Date: Wed, 21 Oct 2009 12:03:34 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A210F6A5824E@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <871vkykm5y.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45032 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZJUKED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 06:04:03 -0400
In-Reply-To: <871vkykm5y.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 20 October, 2009 20:31
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 09/17] OMAP3: PM: Ack pending interrupts 
>before entering suspend
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Suspending drivers may still generate interrupts just before 
>their suspend is
>> completed. Any pending interrupts here will prevent sleep.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>This could also be done in omap3_intc_prepare_idle() hook.

I thought it is better to do this in suspend path only, because in normal sleep case we most likely don't want to miss any interrupts. In suspend case, we usually want to enter the suspend no matter what, and this is used here only to clean up the mess left by some of the drivers. The GPT case is one of the main things we try to fix here.

-Tero

>
>> ---
>>  arch/arm/mach-omap2/irq.c              |    2 +-
>>  arch/arm/mach-omap2/pm34xx.c           |    2 ++
>>  arch/arm/plat-omap/include/mach/irqs.h |    1 +
>>  3 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
>> index aceedd8..4ed05e9 100644
>> --- a/arch/arm/mach-omap2/irq.c
>> +++ b/arch/arm/mach-omap2/irq.c
>> @@ -101,7 +101,7 @@ static int omap_check_spurious(unsigned int irq)
>>  }
>>  
>>  /* XXX: FIQ and additional INTC support (only MPU at the moment) */
>> -static void omap_ack_irq(unsigned int irq)
>> +void omap_ack_irq(unsigned int irq)
>>  {
>>  	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
>>  }
>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> index 5854fa7..6a41811 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -778,6 +778,8 @@ static int omap3_pm_suspend(void)
>>  
>>  	omap_uart_prepare_suspend();
>>  
>> +	/* Ack pending IRQs, as a pending IRQ will cause the 
>suspend to fail */
>> +	omap_ack_irq(0);
>>  	regset_save_on_suspend = 1;
>>  	omap_sram_idle();
>>  	regset_save_on_suspend = 0;
>> diff --git a/arch/arm/plat-omap/include/mach/irqs.h 
>b/arch/arm/plat-omap/include/mach/irqs.h
>> index 2473910..d56be1c 100644
>> --- a/arch/arm/plat-omap/include/mach/irqs.h
>> +++ b/arch/arm/plat-omap/include/mach/irqs.h
>> @@ -483,6 +483,7 @@
>>  #ifndef __ASSEMBLY__
>>  extern void omap_init_irq(void);
>>  extern int omap_irq_pending(void);
>> +extern void omap_ack_irq(unsigned int irq);
>>  void omap3_intc_save_context(void);
>>  void omap3_intc_restore_context(void);
>>  #endif
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>