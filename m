From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Wait for SDRC ready iso a blind delay
Date: Wed, 14 Jan 2009 14:29:13 -0800
Message-ID: <87ocy9jzd2.fsf@deeprootsystems.com>
References: <1231949049-7285-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:36701 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487AbZANW3Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 17:29:24 -0500
Received: by nf-out-0910.google.com with SMTP id d3so124856nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 14:29:22 -0800 (PST)
In-Reply-To: <1231949049-7285-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Wed\, 14 Jan 2009 18\:04\:09 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Peter,

A couple minor things below...

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch improves the wakeup SRAM code polling the SDRC to become ready
> instead of just waiting for a fixed amount of time.
>

Signoff?

> ---
>  arch/arm/mach-omap2/sleep34xx.S |   50 ++++++++++++++++++++++++++++----------
>  1 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 0c33e30..d29c180 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -38,6 +38,8 @@
>  #define PM_PREPWSTST_CORE_P	0x48306AE8
>  #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
>  				OMAP3430_PM_PREPWSTST)
> +#define CM_IDLEST1_CORE_V	IO_ADDRESS(OMAP3430_CM_BASE + 0x220)
> +

For consistency, this should be OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)

>  /*
>   * This is the physical address of the register as specified
>   * by the _P. To be used while the MMU is still disabled.
> @@ -57,6 +59,8 @@
>  #define SDRC_MR_1_P		(OMAP343X_SDRC_BASE + SDRC_MR_1)
>  #define SDRC_EMR2_1_P		(OMAP343X_SDRC_BASE + SDRC_EMR2_1)
>  #define SDRC_MANUAL_1_P		(OMAP343X_SDRC_BASE + SDRC_MANUAL_1)
> +#define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
> +#define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
>  	.text
>  /* Function call to get the restore pointer for resume from OFF */
> @@ -192,7 +196,7 @@ loop:
>  	nop
>  	nop
>  	nop
> -	bl i_dll_wait
> +	bl wait_sdrc_ok
>  
>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
>  restore_es3:
> @@ -651,21 +655,41 @@ skip_l2_inval:
>  	nop
>  	nop
>  	nop
> -	bl i_dll_wait
> +	bl wait_sdrc_ok
>  	/* restore regs and return */
>  	ldmfd   sp!, {r0-r12, pc}
>  
> -i_dll_wait:
> -	ldr     r4, clk_stabilize_delay
> -
> -i_dll_delay:
> -	subs    r4, r4, #0x1
> -	bne     i_dll_delay
> -	ldr     r4, sdrc_power
> -	ldr     r5, [r4]
> -	bic     r5, r5, #0x40
> -	str     r5, [r4]
> -	bx	lr
> +/* Make sure SDRC accesses are ok */
> +wait_sdrc_ok:
> +        ldr     r4, cm_idlest1_core
> +        ldr     r5, [r4]
> +        and     r5, r5, #0x2
> +        cmp     r5, #0
> +        bne     wait_sdrc_ok
> +        ldr     r4, sdrc_power
> +        ldr     r5, [r4]
> +        bic     r5, r5, #0x40
> +        str     r5, [r4]
> +wait_dll_lock:
> +        /* Is dll in lock mode? */
> +        ldr     r4, sdrc_dlla_ctrl
> +        ldr     r5, [r4]
> +        tst     r5, #0x4
> +        bxne    lr
> +        /* wait till dll locks */
> +        ldr     r4, sdrc_dlla_status
> +        ldr     r5, [r4]
> +        and     r5, r5, #0x4
> +        cmp     r5, #0x4
> +        bne     wait_dll_lock
> +        bx      lr
> +
> +cm_idlest1_core:
> +	.word	CM_IDLEST1_CORE_V
> +sdrc_dlla_status:
> +	.word	SDRC_DLLA_STATUS_V
> +sdrc_dlla_ctrl:
> +	.word	SDRC_DLLA_CTRL_V
>  pm_prepwstst_core:
>  	.word	PM_PREPWSTST_CORE_V
>  pm_prepwstst_core_p:
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
