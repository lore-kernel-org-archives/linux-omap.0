From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 1/5] OMAP3: Fixed ARM aux ctrl register save/restore
Date: Thu, 26 Nov 2009 16:48:03 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030AAC3205@dbde02.ent.ti.com>
References: <> <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45066 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759453AbZKZLSI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 06:18:08 -0500
In-Reply-To: <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tero
>>Kristo
>>Sent: Thursday, November 12, 2009 3:37 PM
>>To: linux-omap@vger.kernel.org
>>Subject: [PATCH 1/5] OMAP3: Fixed ARM aux ctrl register save/restore
>>
>>From: Tero Kristo <tero.kristo@nokia.com>
>>
>>Current value is stored on SDRAM and it is written back during wakeup.
>>Previously a static value of 0x72 was written there.
>>
>>Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>>---
>> arch/arm/mach-omap2/sleep34xx.S |   13 +++++++++----
>> 1 files changed, 9 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>>index 4707ba8..8bd5fc5 100644
>>--- a/arch/arm/mach-omap2/sleep34xx.S
>>+++ b/arch/arm/mach-omap2/sleep34xx.S
>>@@ -278,7 +278,8 @@ restore:
>> 	mov	r1, #0		@ set task id for ROM code in r1
>> 	mov	r2, #4		@ set some flags in r2, r6
>> 	mov	r6, #0xff
>>-	adr	r3, write_aux_control_params	@ r3 points to parameters
>>+	ldr	r4, scratchpad_base
>>+	ldr	r3, [r4, #0xBC]	@ r3 points to parameters
>> 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>> 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
>> 	.word	0xE1600071		@ call SMI monitor (smi #1)
>>@@ -286,14 +287,14 @@ restore:
>> 	b	logic_l1_restore
>> l2_inv_api_params:
>> 	.word   0x1, 0x00
>>-write_aux_control_params:
>>-	.word   0x1, 0x72
>> l2_inv_gp:
>> 	/* Execute smi to invalidate L2 cache */
>> 	mov r12, #0x1                         @ set up to invalide L2
>> smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
>> 	/* Write to Aux control register to set some bits */
>>-	mov	r0, #0x72
>>+	ldr	r4, scratchpad_base
>>+	ldr	r3, [r4,#0xBC]
>>+	ldr	r0, [r3,#4]
>> 	mov	r12, #0x3
>> 	.word 0xE1600070	@ Call SMI monitor (smieq)
>> logic_l1_restore:
>>@@ -304,6 +305,7 @@ logic_l1_restore:
>>
>> 	ldr	r4, scratchpad_base
>> 	ldr	r3, [r4,#0xBC]
>>+	adds	r3, r3, #8
>> 	ldmia	r3!, {r4-r6}
>> 	mov	sp, r4
>> 	msr	spsr_cxsf, r5
>>@@ -420,6 +422,9 @@ usettbr0:
>> save_context_wfi:
>> 	/*b	save_context_wfi*/	@ enable to debug save code
>> 	mov	r8, r0 /* Store SDRAM address in r8 */
>>+	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
>>+	mov	r4, #0x1		@ Number of parameters for restore call
>>+	stmia	r8!, {r4-r5}
>>         /* Check what that target sleep state is:stored in r1*/
>>         /* 1 - Only L1 and logic lost */
>>         /* 2 - Only L2 lost */

Looks Ok to me. Acked.
>>--
>>1.5.4.3
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html

