From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] OMAP3: PRCM interrupt: only check for enabled PRCM IRQs
Date: Mon, 26 Apr 2010 19:40:32 -0500
Message-ID: <4BD63280.10202@ti.com>
References: <1272320584-14244-1-git-send-email-khilman@deeprootsystems.com> <4BD631D3.4000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54586 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0D0Ake (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 20:40:34 -0400
In-Reply-To: <4BD631D3.4000800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Turquette, Mike wrote:
> Kevin Hilman wrote:
>> While handling PRCM IRQs, mask out interrupts that are not enabled in
>> PRM_IRQENABLE_MPU.  If these are not masked out,  non-enabled
>> interrupts are caught and a WARN() is dumped.
>>
>> This was noticed using SmartReflex transitions which cause the VPx_*
>> interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
>> but not enabled in PRM_IRQENABLE_MPU.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> For review here, will be queued with other PM updates for 2.6.35.
>>
>>  arch/arm/mach-omap2/pm34xx.c |   15 ++++++++++-----
>>  1 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index fee2efb..63d1843 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -266,13 +266,15 @@ static int _prcm_int_handle_wakeup(void)
>>   */
>>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>>  {
>> -	u32 irqstatus_mpu;
>> +	u32 irqenable_mpu, irqstatus_mpu;
>>  	int c = 0;
>>  
>> -	do {
>> -		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
>> -					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>> +	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
>> +					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
>> +	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
>> +					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>>  
>> +	do {
>>  		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
>>  			c = _prcm_int_handle_wakeup();
>>  
>> @@ -291,7 +293,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>>  		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
>>  					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
> 
> I think that this is partially correct.  Only iterating for status bits 
> that correspond to enabled interrupts is correct.  However I think 
> clearing all of the status bits indiscriminately is bad.
> 
> The root of the problem is that status bits get set regardless of 
> whether the IRQ is enabled (which defies common assumptions).  I have 
> seen the exact same issue on Android after introducing ABB and I just 
> stopped clearing the register altogether:
> 
> http://review.omapzoom.org/#patch,sidebyside,2675,2,arch/arm/mach-omap2/pm34xx.c

OOPS, misleading typo above.  I meant to say that "I stopped WARNing all 
together", but I still cleared the register indiscriminately, which 
turns out is bad.

Mike

> 
> This turned about to be a bad idea; for instance VP1_TRANXDONE_ST and 
> ABB_TRANXDONE_ST are currently polled (no interrupt is enabled).  With 
> the above code it is possible to have a vpforceupdate voltage change or 
> an ABB OPP change, then get interrupted, and then have the timeouts for 
> the polled code fail after the interrupt is served since those status 
> bits got cleared resulting in wasted poll loops and false-positive 
> WARNs.  This has been observed.
> 
> I think a better solution for both code bases might be,
> 
> prm_write_mod_reg((irqstatus_mpu | irqenable_mpu), OCP_MOD,
> 			OMAP3_PRM_MPU_OFFSET);
> 
> Regards,
> Mike
> 
>>  
>> -	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
>> +		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
>> +					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>> +		
>> +	} while (irqstatus_mpu & irqenable_mpu);
>>  
>>  	return IRQ_HANDLED;
>>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

