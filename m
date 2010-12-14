From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: clean up ASM idle code
Date: Mon, 13 Dec 2010 20:12:08 -0800
Message-ID: <877hfdxaav.fsf@deeprootsystems.com>
References: <1291720319-30868-1-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35612 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab0LNEMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 23:12:13 -0500
Received: by gyb11 with SMTP id 11so105145gyb.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 20:12:13 -0800 (PST)
In-Reply-To: <1291720319-30868-1-git-send-email-jean.pihet@newoldbits.com>
	(jean pihet's message of "Tue, 7 Dec 2010 12:11:59 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> Clean up of the ASM code:
> - reorganized the code in logical sections: defines, API
>    functions, internal functions and variables,
> - reworked and simplified the execution paths, for better
>    readability and to avoid duplication of code,
> - added comments on the entry and exit points,
> - reworked the existing comments for better readability,
> - reworked the code formating, alignment and white spaces,
> - added comments for the i443 erratum workarounds,
> - changed the hardcoded values in favor of existing macros
>    from include files,
> - clean up of non used symbols.

The 'lock_scratchpad_sem' code is also unused.  IIRC, you removed that
in an earlier version of the series.  Are you still planning to remove
that? maybe in a subsequent patch?

That being said, pure whitespace changes and unused code removal should
probably be a separate patch.  It's a great help to reviewers if
functional changes are separated from whitespace changes.  It's a bit
tricky in this series as there's lots of code moving as well, so I'll
leave it up to your judgement on how/if to separate these out.

> Tested on OMAP3EVM and Beagleboard with full RET and OFF modes.

In idle?  in suspend?  both?  was CPUidle enabled?

FWIW, I tested on 3430-ES3.1/n900 with retention idle & suspend and off
idle & suspend with CPUidle enabled.

> Heavily reworked from Vishwa's original patch.

Here, it's more customary to  say "Based on original patch from Vishwa"
and ensure the original author is CC'd (which you've done.)

Other than that, this is a great cleanup, and makes this much more
readable.  Thanks.  

Some other minor comments below.

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> Applies on top of Nishant's latest idle path errata fixes step 2,
> cf. http://marc.info/?l=linux-omap&m=129139584919242&w=2
>

[...]

> @@ -208,36 +172,153 @@ api_params:
>  ENTRY(save_secure_ram_context_sz)
>  	.word	. - save_secure_ram_context
>  
> +
> +/* ======================
> + * == Idle entry point ==
> + * ======================
> + */

Let's keep C multi-line coding style even for assembly.   Same goes for
several other places below.

>  /*
>   * Forces OMAP into idle state
>   *
> - * omap34xx_suspend() - This bit of code just executes the WFI
> - * for normal idles.
> + * omap34xx_suspend() - This bit of code saves the CPU context if needed
> + * and executes the WFI instruction
> + *
> + * Note: This code get's copied to internal SRAM at boot.
>   *
> - * Note: This code get's copied to internal SRAM at boot. When the OMAP
> - *	 wakes up it continues execution at the point it went to sleep.
> + * Note: When the OMAP wakes up it continues at different execution points,
> + *  depending on the low power mode (non-OFF vs OFF modes),
> + *  cf. 'Resume path for xxx mode' comments.
>   */
>  ENTRY(omap34xx_cpu_suspend)
>  	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
>  loop:
>  	/*b	loop*/	@Enable to debug by stepping through code

While here, let's get rid of these infinite loop hacks for debugging as
anyone debugging this code can add these back as needed.  Otherwise,
they clutter the code.   There are a few of theses throughout the
original code.

[...]

> @@ -250,9 +331,28 @@ loop:
>  	nop
>  	bl wait_sdrc_ok
>  
> -	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
> +/* ===================================
> + * == Exit point from non-OFF modes ==
> + * ===================================
> + */
> +	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
> +
> +
> +/* ==============================
> + * == Resume path for OFF mode ==
> + * ==============================
> + */

I don't think this is quite correct.  I don't believe it starts
immediately here.  Doesn't it resume from DDR first, and then  jump
here.  A brief description of that process would help clarify that process.

> +/*
> + * The restore_* functions are executed when back from WFI in OFF mode
> + *
> + *  restore_es3: applies to 34xx >= ES3.0
> + *  restore_3630: applies to 36xx
> + *  restore: common code for 3xxx
> + */
>  restore_es3:
>  	/*b restore_es3*/		@ Enable to debug restore code
> +
>  	ldr	r5, pm_prepwstst_core_p
>  	ldr	r4, [r5]
>  	and	r4, r4, #0x3
> @@ -282,18 +382,20 @@ restore_3630:
>  	ldr	r1, control_mem_rta
>  	mov	r2, #OMAP36XX_RTA_DISABLE
>  	str	r2, [r1]
> -	/* Fall thru for the remaining logic */
> +
> +	/* Fall thru to common code for the remaining logic */
> +
>  restore:
>  	/* b restore*/  @ Enable to debug restore code
> -        /* Check what was the reason for mpu reset and store the reason in r9*/
> -        /* 1 - Only L1 and logic lost */
> -        /* 2 - Only L2 lost - In this case, we wont be here */
> -        /* 3 - Both L1 and L2 lost */
> +	/* Check what was the reason for mpu reset and store the reason in r9*/
> +	/* 1 - Only L1 and logic lost */
> +	/* 2 - Only L2 lost - In this case, we wont be here */
> +	/* 3 - Both L1 and L2 lost */
>  	ldr     r1, pm_pwstctrl_mpu
>  	ldr	r2, [r1]
>  	and     r2, r2, #0x3
>  	cmp     r2, #0x0	@ Check if target power state was OFF or RET
> -        moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
> +	moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
>  	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
>  	bne	logic_l1_restore
>  
> @@ -309,23 +411,23 @@ skipl2dis:
>  	and	r1, #0x700
>  	cmp	r1, #0x300
>  	beq	l2_inv_gp
> -	mov	r0, #40		@ set service ID for PPA
> -	mov	r12, r0		@ copy secure Service ID in r12
> -	mov	r1, #0		@ set task id for ROM code in r1
> -	mov	r2, #4		@ set some flags in r2, r6
> +	mov	r0, #40			@ set service ID for PPA
> +	mov	r12, r0			@ copy secure Service ID in r12
> +	mov	r1, #0			@ set task id for ROM code in r1
> +	mov	r2, #4			@ set some flags in r2, r6

This is the type of change that should normally be in a separate patch,
as it seems to be pure whitespace change.


Kevin
