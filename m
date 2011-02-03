From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2 3/5] ARM: omap3: Remove hand-encoded SMC instructions
Date: Fri, 4 Feb 2011 00:08:22 +0530
Message-ID: <c798e36c2e4f42e8c6d6cf85df80a07b@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org> <1296756161-26092-4-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55273 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932312Ab1BCSi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 13:38:26 -0500
Received: by mail-gx0-f180.google.com with SMTP id 19so630141gxk.11
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 10:38:25 -0800 (PST)
In-Reply-To: <1296756161-26092-4-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet-XID <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin@linaro.org]
> Sent: Thursday, February 03, 2011 11:33 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> linux-omap@vger.kernel.org; Nicolas Pitre
> Subject: [PATCH v2 3/5] ARM: omap3: Remove hand-encoded SMC
> instructions
>
> For various reasons, Linux now only officially supports being built
> with tools which are new enough to understand the SMC instruction.
>
> Replacing the hand-encoded instructions when the mnemonic also
> allows for correct assembly in Thumb-2 (otherwise, the result is
> random data in the middle of the code).
>
> The Makefile already ensures that this file is built with a high
> enough gcc -march= flag (armv7-a).
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

I had a similar patch which was planning to post.
May be you could use "smc #1" for consistency.
Otherwise, patch looks fine to me
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/sleep34xx.S |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 98d8232..4032a8e 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -133,7 +133,7 @@ ENTRY(save_secure_ram_context)
>  	mov	r6, #0xff
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
> -	.word	0xE1600071		@ call SMI monitor (smi #1)
> +	smc	1			@ call SMI monitor (smi #1)
>  	nop
>  	nop
>  	nop
> @@ -408,7 +408,7 @@ skipl2dis:
>  	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
> -	.word	0xE1600071		@ call SMI monitor (smi #1)
> +	smc	1			@ call SMI monitor (smi #1)
>  	/* Write to Aux control register to set some bits */
>  	mov	r0, #42			@ set service ID for PPA
>  	mov	r12, r0			@ copy secure Service ID in r12
> @@ -419,7 +419,7 @@ skipl2dis:
>  	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
> -	.word	0xE1600071		@ call SMI monitor (smi #1)
> +	smc	1			@ call SMI monitor (smi #1)
>
>  #ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
>  	/* Restore L2 aux control register */
> @@ -434,7 +434,7 @@ skipl2dis:
>  	adds	r3, r3, #8		@ r3 points to parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
> -	.word	0xE1600071		@ call SMI monitor (smi #1)
> +	smc	1			@ call SMI monitor (smi #1)
>  #endif
>  	b	logic_l1_restore
>
> @@ -443,18 +443,18 @@ l2_inv_api_params:
>  l2_inv_gp:
>  	/* Execute smi to invalidate L2 cache */
>  	mov r12, #0x1			@ set up to invalidate L2
> -	.word 0xE1600070		@ Call SMI monitor (smieq)
> +	smc	0			@ Call SMI monitor (smieq)
>  	/* Write to Aux control register to set some bits */
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	ldr	r0, [r3,#4]
>  	mov	r12, #0x3
> -	.word	0xE1600070		@ Call SMI monitor (smieq)
> +	smc	0			@ Call SMI monitor (smieq)
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	ldr	r0, [r3,#12]
>  	mov	r12, #0x2
> -	.word	0xE1600070		@ Call SMI monitor (smieq)
> +	smc	0			@ Call SMI monitor (smieq)
>  logic_l1_restore:
>  	ldr	r1, l2dis_3630
>  	cmp	r1, #0x1		@ Test if L2 re-enable needed on
3630
> --
> 1.7.1
