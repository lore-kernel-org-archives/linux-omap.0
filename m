From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix compile time warning and errors
Date: Wed, 30 Sep 2009 11:43:44 -0700
Message-ID: <873a64mfxb.fsf@deeprootsystems.com>
References: <1253274532-29002-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f191.google.com ([209.85.222.191]:61222 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbZI3Snm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 14:43:42 -0400
Received: by pzk29 with SMTP id 29so4645681pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 11:43:46 -0700 (PDT)
In-Reply-To: <1253274532-29002-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 18 Sep 2009 17\:18\:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> Made a mistake of enabling PM_DEBUG without DEBUG_FS. This leads to
> compile time warnings and errors.
>
> arch/arm/mach-omap2/pm-debug.c:56: warning: 'pm_dbg_init'
>  declared 'static' but never defined
>
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> arch/arm/mach-omap2/pm34xx.c:442: undefined reference to
>  'pm_dbg_regset_save'
> arch/arm/mach-omap2/built-in.o: In function `configure_vc':
> arch/arm/mach-omap2/pm34xx.c:1221: undefined reference to
>  'pm_dbg_regset_init'
>
> Another alternate is to link these Kconfig options; but didn't seem
> intuitive.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/pm-debug.c |    2 ++
>  arch/arm/mach-omap2/pm34xx.c   |    4 ++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 1b4c160..175d461 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -53,7 +53,9 @@ int omap2_pm_debug;
>  	regs[reg_count].name = #reg; \
>  	regs[reg_count++].val = __raw_readl(OMAP2_IO_ADDRESS(0x480fe000 + (off)))
>  
> +#ifdef CONFIG_DEBUG_FS
>  static int __init pm_dbg_init(void);
> +#endif

Move this into the other #ifdef CONFIG_DEBUG_FS later in the same file.

>  void omap2_pm_dump(int mode, int resume, unsigned int us)
>  {
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7a1eb95..e3da0ab 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -438,8 +438,10 @@ void omap_sram_idle(void)
>  	    core_next_state == PWRDM_POWER_OFF)
>  		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
>  
> +#ifdef CONFIG_DEBUG_FS
>  	if (regset_save_on_suspend)
>  		pm_dbg_regset_save(1);
> +#endif

I don't like the #ifdefs here...

>  
>  	/*
>  	 * omap3_arm_context is the location where ARM registers
> @@ -1218,7 +1220,9 @@ static void __init configure_vc(void)
>  	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTSETUP2_OFFSET);
>  
> +#ifdef CONFIG_DEBUG_FS
>  	pm_dbg_regset_init(1);
> +#endif

or here.

how about just adding dummy functions in pm-debug.c like this (on top
of your patch), then these #ifdefs can go away.

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 175d461..99855aa 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -578,4 +578,6 @@ arch_initcall(pm_dbg_init);
 
 #else
 void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
+int pm_dbg_regset_save(int reg_set) { return 0; }
+int pm_dbg_regset_init(int reg_set) { return 0; }
 #endif
