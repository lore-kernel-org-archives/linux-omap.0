From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 20 Dec 2010 12:29:22 +0530
Message-ID: <c8819161924787cb5de43492278c4e36@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-5-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59798 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753639Ab0LTG7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 01:59:24 -0500
Received: by gwaa18 with SMTP id a18so1437479gwa.23
        for <linux-omap@vger.kernel.org>; Sun, 19 Dec 2010 22:59:23 -0800 (PST)
In-Reply-To: <1292712817-24999-5-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Nishant
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Nishanth Menon
> Sent: Sunday, December 19, 2010 4:24 AM
> To: linux-omap; linux-arm
> Cc: Jean Pihet; Kevin; Tony
> Subject: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
>
> Erratum id: i608
> RTA (Retention Till Access) feature is not supported and leads to device
> stability issues when enabled. This impacts modules with embedded
memories
> on OMAP3630
>
> Workaround is to disable RTA on boot and coming out of core off.
> For disabling rta coming out of off mode, we do this by overriding the
> restore pointer for 3630 to allow us restore handler as the first point
of
> entry before caches are touched and is common for GP and HS devices.
> to disable earlier than this could be possible by modifying the ppa for
HS
> devices, but not for GP devices.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
>
> [ambresh@ti.com: co-developer]
> Signed-off-by: Ambresh K <ambresh@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> v4:
> 	control register handling moved to control.c
> 	errata handling framework introduction split out
> 	into a separate patch
> v3: http://marc.info/?t=129140247800026&r=1&w=2
> 	additional comment to explain Ambresh's contrib
> 	removed the redundant check for cpu_is34xx - it is already
> 		done by pm_init
> 	pm_errata_configure is __init
> v2: https://patchwork.kernel.org/patch/365242/
> 	fixed missing b restore for 3430 es3.1 code.
> 	introduced erratum handling logic here splitting it out of uart
> errata
> 	typo fixes for erratum
> v1: http://marc.info/?l=linux-omap&m=129013172825240&w=2
>
>  arch/arm/mach-omap2/control.c   |   13 ++++++++++++-
>  arch/arm/mach-omap2/control.h   |    7 ++++++-
>  arch/arm/mach-omap2/pm.h        |    2 ++
>  arch/arm/mach-omap2/pm34xx.c    |   10 ++++++++++
>  arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++++
>  5 files changed, 56 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c
b/arch/arm/mach-omap2/control.c
> index 1fa3294..27ed558 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -241,7 +241,10 @@ void omap3_save_scratchpad_contents(void)
>
>  	/* Populate the Scratchpad contents */
>  	scratchpad_contents.boot_config_ptr = 0x0;
> -	if (omap_rev() != OMAP3430_REV_ES3_0 &&
> +	if (cpu_is_omap3630())
> +		scratchpad_contents.public_restore_ptr =
> +			virt_to_phys(get_omap3630_restore_pointer());
> +	else if (omap_rev() != OMAP3430_REV_ES3_0 &&
>  					omap_rev() != OMAP3430_REV_ES3_1)
>  		scratchpad_contents.public_restore_ptr =
>  			virt_to_phys(get_restore_pointer());
> @@ -474,4 +477,12 @@ void omap3_control_restore_context(void)
>  	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
>  	return;
>  }
> +
> +void omap3630_ctrl_disable_rta(void)
> +{
> +	if (!cpu_is_omap3630())
> +		return;
> +	omap_ctrl_writel(OMAP36XX_RTA_DISABLE,
> OMAP36XX_CONTROL_MEM_RTA_CTRL);
> +}
> +
>  #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> diff --git a/arch/arm/mach-omap2/control.h
b/arch/arm/mach-omap2/control.h
> index b6c6b7c..ec98dd7 100644
> --- a/arch/arm/mach-omap2/control.h
> +++ b/arch/arm/mach-omap2/control.h
> @@ -204,6 +204,10 @@
>  #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP +
> 0x014)
>  #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP +
> 0x018)
>
> +/* 36xx-only RTA - Retention till Accesss control registers and bits */
> +#define OMAP36XX_CONTROL_MEM_RTA_CTRL	0x40C
> +#define OMAP36XX_RTA_DISABLE		0x0
> +
>  /* 34xx D2D idle-related pins, handled by PM core */
>  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
>  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
> @@ -347,10 +351,11 @@ extern void omap3_save_scratchpad_contents(void);
>  extern void omap3_clear_scratchpad_contents(void);
>  extern u32 *get_restore_pointer(void);
>  extern u32 *get_es3_restore_pointer(void);
> +extern u32 *get_omap3630_restore_pointer(void);
>  extern u32 omap3_arm_context[128];
>  extern void omap3_control_save_context(void);
>  extern void omap3_control_restore_context(void);
> -
> +extern void omap3630_ctrl_disable_rta(void);
>  #else
>  #define omap_ctrl_base_get()		0
>  #define omap_ctrl_readb(x)		0
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0348fd7..8d9aa3e 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -85,6 +85,8 @@ extern unsigned int save_secure_ram_context_sz;
>  extern unsigned int omap24xx_cpu_suspend_sz;
>  extern unsigned int omap34xx_cpu_suspend_sz;
>
> +#define PM_RTA_ERRATUM_i608		(1 << 0)
> +
>  #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>  extern u16 pm34xx_errata;
>  #define IS_PM34XX_ERRATUM(id)		(pm34xx_errata & (id))
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 5702f41..b32a2ed 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -1007,6 +1007,8 @@ void omap_push_sram_idle(void)
>
>  static void __init pm_errata_configure(void)
>  {
> +	if (cpu_is_omap3630())
> +		pm34xx_errata |= PM_RTA_ERRATUM_i608;
>  }
>
>  static int __init omap3_pm_init(void)
> @@ -1067,6 +1069,14 @@ static int __init omap3_pm_init(void)
>  	pm_idle = omap3_pm_idle;
>  	omap3_idle_init();
>
> +	/*
> +	 * RTA is disabled during initialization as per erratum i608
> +	 * it is safer to disable rta by the bootloader, but we would like
> +	 * to be doubly sure here and prevent any mishaps.
> +	 */
> +	if (IS_PM34XX_ERRATUM(PM_RTA_ERRATUM_i608))
> +		omap3630_ctrl_disable_rta();
> +
>  	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
>  	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>  		omap3_secure_ram_storage =
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 3fbd1e5..cc3507b 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -45,6 +45,8 @@
>  #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
>  #define SRAM_BASE_P		0x40200000
>  #define CONTROL_STAT		0x480022F0
> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
> +					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
Just a clarification. This register is not part of HW SAR SCM
Registers, right ?

>  #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
>  				       * available */
>  #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +
> OMAP343X_CONTROL_MEM_WKUP\
> @@ -99,6 +101,14 @@ ENTRY(get_restore_pointer)
>          ldmfd   sp!, {pc}     @ restore regs and return
>  ENTRY(get_restore_pointer_sz)
>          .word   . - get_restore_pointer
> +	.text
> +/* Function call to get the restore pointer for 3630 resume from OFF */
> +ENTRY(get_omap3630_restore_pointer)
> +        stmfd   sp!, {lr}     @ save registers on stack
> +	adr	r0, restore_3630
> +        ldmfd   sp!, {pc}     @ restore regs and return
> +ENTRY(get_omap3630_restore_pointer_sz)
> +        .word   . - get_omap3630_restore_pointer
>
>  	.text
>  /* Function call to get the restore pointer for for ES3 to resume from
> OFF */
> @@ -246,6 +256,20 @@ copy_to_sram:
>  	bne	copy_to_sram
>  	ldr	r1, sram_base
>  	blx	r1
> +	b	restore
> +
> +restore_3630:
> +	/*b restore_es3630*/		@ Enable to debug restore code
> +	ldr	r1, pm_prepwstst_core_p
> +	ldr	r2, [r1]
> +	and	r2, r2, #0x3
> +	cmp	r2, #0x0	@ Check if previous power state of CORE is
OFF
> +	bne	restore
> +	/* Disable rta before giving control */
> +	ldr	r1, control_mem_rta
> +	mov	r2, #OMAP36XX_RTA_DISABLE
> +	str	r2, [r1]
> +	/* Fall thru for the remaining logic */
>  restore:
>  	/* b restore*/  @ Enable to debug restore code
>          /* Check what was the reason for mpu reset and store the reason
> in r9*/
> @@ -650,6 +674,8 @@ cache_pred_disable_mask:
>  	.word	0xFFFFE7FB
>  control_stat:
>  	.word	CONTROL_STAT
> +control_mem_rta:
> +	.word	CONTROL_MEM_RTA_CTRL
>  kernel_flush:
>  	.word v7_flush_dcache_all
>  	/* these 2 words need to be at the end !!! */
> --
> 1.6.3.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
