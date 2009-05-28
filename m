From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3: Re-program also chipselect 1 when changing SDRAM
 timing
Date: Thu, 28 May 2009 09:52:13 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A20545378170@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1243426419-32652-1-git-send-email-tero.kristo@nokia.com>
 <87bppewnox.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17689 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbZE1Hwm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 03:52:42 -0400
In-Reply-To: <87bppewnox.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 27 May, 2009 18:50
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH] OMAP3: Re-program also chipselect 1 when 
>changing SDRAM timing
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Previously only chipselect 0 was controlled, which would 
>result in the 
>> chipselect 1 running on too low rate during low core OPPs.
>>
>> Applies on top of PM branch.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>Hi Tero,
>
>This does part of what Jean Pihet does in his recent patch[1] 
>to add support for 2 CSs.  Your version assumes the same 
>parameters for both SDRAM parts, and Jean has expanded that so 
>board code can configure different paramaters for the different CSes.
>
>I have yet to fully review Jean's patch, but will probably 
>take his version so that two different SDRAM parts could be used.

Yeah, I did not notice that patch of course as I just checked if something like this is done on top of PM branch yet. I'll give Jean's patch a shot and see if it works for me.

>
>Kevin
>
>
>[1] See hist post from 26 May: [RFC][PATCH] OMAP3: add support 
>for 2 SDRAM chip selects (was: Re: Beagleboard rev C memory 
>timings & suspend/resume)
>
>> ---
>>  arch/arm/mach-omap2/sram34xx.S |   29 +++++++++++++++++++++++------
>>  1 files changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/sram34xx.S 
>> b/arch/arm/mach-omap2/sram34xx.S index f41f8d9..bcfe9eb 100644
>> --- a/arch/arm/mach-omap2/sram34xx.S
>> +++ b/arch/arm/mach-omap2/sram34xx.S
>> @@ -187,15 +187,24 @@ wait_dll_unlock:
>>  	bne	wait_dll_unlock
>>  	bx	lr
>>  configure_sdrc:
>> -	ldr	r11, omap3_sdrc_rfr_ctrl
>> +	ldr	r11, omap3_sdrc_rfr_ctrl_0
>>  	str	r0, [r11]
>> -	ldr	r11, omap3_sdrc_actim_ctrla
>> +	ldr	r11, omap3_sdrc_rfr_ctrl_1
>> +	str	r0, [r11]
>> +	ldr	r11, omap3_sdrc_actim_ctrla_0
>> +	str	r1, [r11]
>> +	ldr	r11, omap3_sdrc_actim_ctrla_1
>>  	str	r1, [r11]
>> -	ldr	r11, omap3_sdrc_actim_ctrlb
>> +	ldr	r11, omap3_sdrc_actim_ctrlb_0
>> +	str	r2, [r11]
>> +	ldr	r11, omap3_sdrc_actim_ctrlb_1
>>  	str	r2, [r11]
>>  	ldr	r11, omap3_sdrc_mr_0
>>  	str	r6, [r11]
>>  	ldr	r6, [r11]		@ posted-write barrier for SDRC
>> +	ldr	r11, omap3_sdrc_mr_1
>> +	str	r6, [r11]
>> +	ldr	r6, [r11]		@ posted-write barrier for SDRC
>>  	bx	lr
>>  
>>  omap3_sdrc_power:
>> @@ -206,14 +215,22 @@ omap3_cm_idlest1_core:
>>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
>>  omap3_cm_iclken1_core:
>>  	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
>> -omap3_sdrc_rfr_ctrl:
>> +omap3_sdrc_rfr_ctrl_0:
>>  	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
>> -omap3_sdrc_actim_ctrla:
>> +omap3_sdrc_rfr_ctrl_1:
>> +	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
>> +omap3_sdrc_actim_ctrla_0:
>>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
>> -omap3_sdrc_actim_ctrlb:
>> +omap3_sdrc_actim_ctrla_1:
>> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
>> +omap3_sdrc_actim_ctrlb_0:
>>  	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
>> +omap3_sdrc_actim_ctrlb_1:
>> +	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
>>  omap3_sdrc_mr_0:
>>  	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
>> +omap3_sdrc_mr_1:
>> +	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
>>  omap3_sdrc_dlla_status:
>>  	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>>  omap3_sdrc_dlla_ctrl:
>> --
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>