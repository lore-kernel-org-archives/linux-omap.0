From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/06] OMAP3: PM: Implement locking for any scratchpad access
Date: Thu, 04 Jun 2009 16:24:11 -0700
Message-ID: <87zlcnd1lw.fsf@deeprootsystems.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
	<1243514587-5323-2-git-send-email-rnayak@ti.com>
	<1243514587-5323-3-git-send-email-rnayak@ti.com>
	<1243514587-5323-4-git-send-email-rnayak@ti.com>
	<1243514587-5323-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:58213 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbZFDXYM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 19:24:12 -0400
Received: by pzk1 with SMTP id 1so471343pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 04 Jun 2009 16:24:14 -0700 (PDT)
In-Reply-To: <1243514587-5323-5-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Thu\, 28 May 2009 18\:13\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> This patch implements locking using the semaphore in scratchpad
> memory preventing any concurrent access to scratchpad from OMAP
> and Baseband/Modem processor.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Any reason this function has to be written in asm?  It's written along
with a bunch of other asm functions that are copied to and executed
from SRAM, but that doesn't appear to be the case here.

Looks like a simple C function would be clearer here.

Kevin

> ---
>  arch/arm/mach-omap2/resource34xx.c |    6 +++++-
>  arch/arm/mach-omap2/resource34xx.h |    2 ++
>  arch/arm/mach-omap2/sleep34xx.S    |   32 ++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 82405b6..408d3ab 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -236,6 +236,7 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  	int ret = 0, l3_div;
>  	int *curr_opp;
>  
> +	lock_scratchpad_sem();
>  	if (res == VDD1_OPP) {
>  		curr_opp = &curr_vdd1_opp;
>  		clk_set_rate(dpll1_clk, mpu_opps[target_level].rate);
> @@ -253,11 +254,14 @@ static int program_opp_freq(int res, int target_level, int current_level)
>  		ret = clk_set_rate(dpll3_clk,
>  				l3_opps[target_level].rate * l3_div);
>  	}
> -	if (ret)
> +	if (ret) {
> +		unlock_scratchpad_sem();
>  		return current_level;
> +	}
>  #ifdef CONFIG_PM
>  	omap3_save_scratchpad_contents();
>  #endif
> +	unlock_scratchpad_sem();
>  
>  	*curr_opp = target_level;
>  	return target_level;
> diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
> index a160665..5b5618a 100644
> --- a/arch/arm/mach-omap2/resource34xx.h
> +++ b/arch/arm/mach-omap2/resource34xx.h
> @@ -29,6 +29,8 @@
>  #include <mach/omap34xx.h>
>  
>  extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
> +extern void lock_scratchpad_sem();
> +extern void unlock_scratchpad_sem();
>  
>  /*
>   * mpu_latency/core_latency are used to control the cpuidle C state.
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 38aa3fd..aedcf94 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -39,6 +39,7 @@
>  #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
>  				OMAP3430_PM_PREPWSTST)
>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
> +#define SDRC_SCRATCHPAD_SEM_V	0xd800291C
>  
>  /*
>   * This is the physical address of the register as specified
> @@ -62,6 +63,37 @@
>  #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
> +        .text
> +/* Function to aquire the semaphore in scratchpad */
> +ENTRY(lock_scratchpad_sem)
> +	stmfd	sp!, {lr}	@ save registers on stack
> +wait_sem:
> +	mov	r0,#1
> +	ldr	r1, sdrc_scratchpad_sem
> +wait_loop:
> +	ldr	r2, [r1]	@ load the lock value
> +	cmp	r2, r0		@ is the lock free ?
> +	beq	wait_loop	@ not free...
> +	swp	r2, r0, [r1]	@ semaphore free so lock it and proceed
> +	cmp	r2, r0		@ did we succeed ?
> +	beq	wait_sem	@ no - try again
> +	ldmfd	sp!, {pc}	@ restore regs and return
> +sdrc_scratchpad_sem:
> +        .word SDRC_SCRATCHPAD_SEM_V
> +ENTRY(lock_scratchpad_sem_sz)
> +        .word   . - lock_scratchpad_sem
> +
> +        .text
> +/* Function to release the scratchpad semaphore */
> +ENTRY(unlock_scratchpad_sem)
> +	stmfd	sp!, {lr}	@ save registers on stack
> +	ldr	r3, sdrc_scratchpad_sem
> +	mov	r2,#0
> +	str	r2,[r3]
> +	ldmfd	sp!, {pc}	@ restore regs and return
> +ENTRY(unlock_scratchpad_sem_sz)
> +        .word   . - unlock_scratchpad_sem
> +
>  	.text
>  /* Function call to get the restore pointer for resume from OFF */
>  ENTRY(get_restore_pointer)
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
