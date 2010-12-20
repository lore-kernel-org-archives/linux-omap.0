From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
Date: Mon, 20 Dec 2010 12:17:05 +0530
Message-ID: <ff992259ca9324925ce680a11cae0245@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48048 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753534Ab0LTGrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 01:47:08 -0500
Received: by gxk20 with SMTP id 20so1725508gxk.15
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 22:47:07 -0800 (PST)
In-Reply-To: <1292712817-24999-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Sunday, December 19, 2010 4:24 AM
> To: linux-omap; linux-arm
> Cc: Jean Pihet; Kevin; Tony
> Subject: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick
strategy
>
> From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>
> Erratum i581 impacts OMAP3 platforms.
> PRCM DPLL control FSM removes SDRC_IDLEREQ before DPLL3 locks causing
> the DPLL not to be locked at times.
>
> IMPORTANT:
> *) This is not a complete workaround implementation as recommended
> by the silicon erratum. this is a support logic for detecting lockups
and
> attempting to recover where possible and is known to provide stability
> in multiple platforms.
> *) This code is mostly important for inactive and retention. The ROM
code
> waits for the maximum dll lock time when resuming from off mode. So for
> off mode this code isn't really needed.
>
> This should eventually get refactored as part of cleanups to sleep34xx.S
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
> (no change done, posting for completeness of the series)
> v2: https://patchwork.kernel.org/patch/365252/
> 	typo correction- erratum, support, added comment from Peter from
the
> 	thread to commit message
> v1: http://marc.info/?l=linux-omap&m=129013172525234&w=2
>  arch/arm/mach-omap2/sleep34xx.S |   52
> +++++++++++++++++++++++++++++++++++---
>  1 files changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 2c20fcf..3fbd1e5 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -42,6 +42,7 @@
>  				OMAP3430_PM_PREPWSTST)
>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD +
> OMAP2_PM_PWSTCTRL
>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
> +#define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
We need to avoid these macro's calculating VA directly. But I guess
it needs to be done more than just this line and hence can be done
in a separate patch.

>  #define SRAM_BASE_P		0x40200000
>  #define CONTROL_STAT		0x480022F0
>  #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
> @@ -554,31 +555,67 @@ skip_l2_inval:
>
>  /* Make sure SDRC accesses are ok */
>  wait_sdrc_ok:
> +
> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures
> this. */
> +	ldr	r4, cm_idlest_ckgen
> +wait_dpll3_lock:
> +	ldr	r5, [r4]
> +	tst	r5, #1
> +	beq	wait_dpll3_lock
> +
>          ldr     r4, cm_idlest1_core
> +wait_sdrc_ready:
>          ldr     r5, [r4]
> -        and     r5, r5, #0x2
> -        cmp     r5, #0
> -        bne     wait_sdrc_ok
> +        tst     r5, #0x2
> +        bne     wait_sdrc_ready
> +	/* allow DLL powerdown upon hw idle req */
>          ldr     r4, sdrc_power
>          ldr     r5, [r4]
>          bic     r5, r5, #0x40
>          str     r5, [r4]
> -wait_dll_lock:
> +is_dll_in_lock_mode:
> +
>          /* Is dll in lock mode? */
>          ldr     r4, sdrc_dlla_ctrl
>          ldr     r5, [r4]
>          tst     r5, #0x4
>          bxne    lr
>          /* wait till dll locks */
> -        ldr     r4, sdrc_dlla_status
> +wait_dll_lock_timed:
> +	ldr	r4, wait_dll_lock_counter
> +	add	r4, r4, #1
> +	str	r4, wait_dll_lock_counter
> +	ldr	r4, sdrc_dlla_status
> +        mov	r6, #8		/* Wait 20uS for lock */
> +wait_dll_lock:
> +	subs	r6, r6, #0x1
> +	beq	kick_dll
>          ldr     r5, [r4]
>          and     r5, r5, #0x4
>          cmp     r5, #0x4
>          bne     wait_dll_lock
>          bx      lr
>
> +	/* disable/reenable DLL if not locked */
> +kick_dll:
> +	ldr	r4, sdrc_dlla_ctrl
> +	ldr	r5, [r4]
> +	mov	r6, r5
> +	bic	r6, #(1<<3)	/* disable dll */
> +	str	r6, [r4]
> +	dsb
> +	orr	r6, r6, #(1<<3)	/* enable dll */
> +	str	r6, [r4]
> +	dsb
> +	ldr	r4, kick_counter
> +	add	r4, r4, #1
> +	str	r4, kick_counter
> +	b	wait_dll_lock_timed
> +
>  cm_idlest1_core:
>  	.word	CM_IDLEST1_CORE_V
> +cm_idlest_ckgen:
> +	.word	CM_IDLEST_CKGEN_V
>  sdrc_dlla_status:
>  	.word	SDRC_DLLA_STATUS_V
>  sdrc_dlla_ctrl:
> @@ -615,5 +652,10 @@ control_stat:
>  	.word	CONTROL_STAT
>  kernel_flush:
>  	.word v7_flush_dcache_all
> +	/* these 2 words need to be at the end !!! */
> +kick_counter:
> +	.word	0
> +wait_dll_lock_counter:
> +	.word	0
>  ENTRY(omap34xx_cpu_suspend_sz)
>  	.word	. - omap34xx_cpu_suspend
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
