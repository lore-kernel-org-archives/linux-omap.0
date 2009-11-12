From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 07/11] OMAP3: Fixed ARM aux ctrl register save/restore
Date: Thu, 12 Nov 2009 09:39:58 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A2236D6F1EA2@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
 <87zl6sy757.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49849 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZKLIkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 03:40:51 -0500
In-Reply-To: <87zl6sy757.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 12 November, 2009 01:27
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 07/11] OMAP3: Fixed ARM aux ctrl register 
>save/restore
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> Current value is stored on SDRAM and it is written back 
>during wakeup.
>> Previously a static value of 0x72 was written there.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>
>Thanks, applying to PM branch, queuing for pm-fixes.

I have a slightly modified version available of this now, which stores the data inside arm_context. It is probably a bit nicer than this one. I'll send out the refreshed version of this patch and you can see which one you want to use.

>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/control.c   |    1 +
>>  arch/arm/mach-omap2/sleep34xx.S |   23 ++++++++++++++++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/control.c 
>b/arch/arm/mach-omap2/control.c
>> index 296f2c2..730fc53 100644
>> --- a/arch/arm/mach-omap2/control.c
>> +++ b/arch/arm/mach-omap2/control.c
>> @@ -94,6 +94,7 @@ void *omap3_secure_ram_storage;
>>   * during the restore path.
>>   */
>>  u32 omap3_arm_context[128];
>> +u32 omap3_aux_ctrl[2] = { 0x1, 0x0 };
>>  
>>  struct omap3_control_regs {
>>  	u32 sysconfig;
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S 
>b/arch/arm/mach-omap2/sleep34xx.S
>> index f4f5ebe..0b03bf9 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -26,6 +26,7 @@
>>   */
>>  #include <linux/linkage.h>
>>  #include <asm/assembler.h>
>> +#include <asm/memory.h>
>>  #include <mach/io.h>
>>  #include <mach/control.h>
>>  
>> @@ -278,7 +279,11 @@ restore:
>>  	mov	r1, #0		@ set task id for ROM code in r1
>>  	mov	r2, #4		@ set some flags in r2, r6
>>  	mov	r6, #0xff
>> -	adr	r3, write_aux_control_params	@ r3 points to 
>parameters
>> +	ldr	r3, write_aux_control_params	@ r3 points to 
>parameters
>> +	ldr	r4, phys_offset
>> +	adds	r3, r3, r4
>> +	ldr	r4, page_offset
>> +	subs	r3, r3, r4
>>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
>>  	.word	0xE1600071		@ call SMI monitor (smi #1)
>> @@ -287,13 +292,18 @@ restore:
>>  l2_inv_api_params:
>>  	.word   0x1, 0x00
>>  write_aux_control_params:
>> -	.word   0x1, 0x72
>> +	.word	omap3_aux_ctrl
>>  l2_inv_gp:
>>  	/* Execute smi to invalidate L2 cache */
>>  	mov r12, #0x1                         @ set up to invalide L2
>>  smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
>>  	/* Write to Aux control register to set some bits */
>> -	mov	r0, #0x72
>> +	ldr	r1, write_aux_control_params
>> +	ldr	r0, phys_offset
>> +	adds	r1, r1, r0
>> +	ldr	r0, page_offset
>> +	subs	r1, r1, r0
>> +	ldr	r0, [r1, #4]
>>  	mov	r12, #0x3
>>  	.word 0xE1600070	@ Call SMI monitor (smieq)
>>  logic_l1_restore:
>> @@ -420,6 +430,9 @@ usettbr0:
>>  save_context_wfi:
>>  	/*b	save_context_wfi*/	@ enable to debug save code
>>  	mov	r8, r0 /* Store SDRAM address in r8 */
>> +	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary 
>Control Register
>> +	ldr	r5, write_aux_control_params
>> +	str	r4, [r5, #4]
>>          /* Check what that target sleep state is:stored in r1*/
>>          /* 1 - Only L1 and logic lost */
>>          /* 2 - Only L2 lost */
>> @@ -605,6 +618,10 @@ wait_dll_lock:
>>          bne     wait_dll_lock
>>          bx      lr
>>  
>> +phys_offset:
>> +	.word	PHYS_OFFSET
>> +page_offset:
>> +	.word	PAGE_OFFSET
>>  cm_idlest1_core:
>>  	.word	CM_IDLEST1_CORE_V
>>  sdrc_dlla_status:
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