From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP3: PM: Configure PRM setup times from board files
Date: Wed, 30 Sep 2009 12:13:31 -0700
Message-ID: <878wfwkzz8.fsf@deeprootsystems.com>
References: <1246286113-21197-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f191.google.com ([209.85.222.191]:58709 "EHLO
	mail-pz0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbZI3TNa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 15:13:30 -0400
Received: by pzk29 with SMTP id 29so4668062pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 12:13:33 -0700 (PDT)
In-Reply-To: <1246286113-21197-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Mon\, 29 Jun 2009 20\:05\:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> The setup times to be programmed in the PRM module on OMAP
> (for clksetup, voltsetup etc) are board specific.
> They depend heavily on the PMIC used and even on different boards
> with the same PMIC, they vary based on the sleep/wake
> sequence used, system clock speed et al.
>
> This patch makes it possible for these setup values to be
> configured from different board files.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Hi Rajendra,

Sorry about this, but your series slipped through cracks on my side.

I like this approach, but it needs to be rebased against current PM
branch since lots of the code that it touches has been reworked.

Also, instead of continuing to overload init_common_hw, how about
adding something like omap_pm_register() which takes the various rate
tables and setup times, or possibly adding the rate tables and setup
times as arguments to omap3_pm_earlly_init() and making it explicitly
called by board code instead of an arch_initcall().

Kevin

> ---
>  arch/arm/mach-omap2/board-3430sdp.c     |   20 +++++++++++++++++++-
>  arch/arm/mach-omap2/board-apollon.c     |    2 +-
>  arch/arm/mach-omap2/board-generic.c     |    2 +-
>  arch/arm/mach-omap2/board-h4.c          |    2 +-
>  arch/arm/mach-omap2/board-ldp.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
>  arch/arm/mach-omap2/board-overo.c       |    2 +-
>  arch/arm/mach-omap2/board-rx51.c        |    2 +-
>  arch/arm/mach-omap2/board-zoom2.c       |    2 +-
>  arch/arm/mach-omap2/io.c                |    5 ++++-
>  arch/arm/mach-omap2/pm.c                |    7 +++++++
>  arch/arm/mach-omap2/pm.h                |   16 +++++++++-------
>  arch/arm/mach-omap2/pm34xx.c            |   10 ++++++++++
>  arch/arm/plat-omap/include/mach/io.h    |    4 +++-
>  15 files changed, 61 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index e9a4d10..b43cf94 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -58,6 +58,23 @@
>  
>  #define TWL4030_MSECURE_GPIO 22
>  
> +/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
> +static struct prm_setup_vc omap3_setuptime_table = {
> +	.clksetup = 0xff,
> +	.voltsetup_time1 = 0xfff,
> +	.voltsetup_time2 = 0xfff,
> +	.voltoffset = 0xff,
> +	.voltsetup2 = 0xff,
> +	.vdd0_on = 0x30,
> +	.vdd0_onlp = 0x20,
> +	.vdd0_ret = 0x1e,
> +	.vdd0_off = 0x00,
> +	.vdd1_on = 0x2c,
> +	.vdd1_onlp = 0x20,
> +	.vdd1_ret = 0x1e,
> +	.vdd1_off = 0x00,
> +};
> +
>  static int sdp3430_keymap[] = {
>  	KEY(0, 0, KEY_LEFT),
>  	KEY(0, 1, KEY_RIGHT),
> @@ -174,7 +191,8 @@ static struct platform_device *sdp3430_devices[] __initdata = {
>  static void __init omap_3430sdp_init_irq(void)
>  {
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +			     omap3_dsp_rate_table, omap3_l3_rate_table,
> +			     &omap3_setuptime_table);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
> index 1a7fb81..293a9b2 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -250,7 +250,7 @@ out:
>  
>  static void __init omap_apollon_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	apollon_init_smc91x();
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 23583da..dfc1b49 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -33,7 +33,7 @@
>  
>  static void __init omap_generic_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  }
>  
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index de6adf7..af0ebaf 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -270,7 +270,7 @@ static void __init h4_init_flash(void)
>  
>  static void __init omap_h4_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	h4_init_flash();
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index 3b662ff..eb5e2e0 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -270,7 +270,7 @@ static inline void __init ldp_init_smsc911x(void)
>  
>  static void __init omap_ldp_init_irq(void)
>  {
> -	omap2_init_common_hw(NULL, NULL, NULL, NULL);
> +	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	ldp_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 36b4bfb..e0be6bd 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -289,7 +289,7 @@ static int __init omap3_beagle_i2c_init(void)
>  static void __init omap3_beagle_init_irq(void)
>  {
>  	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +			     omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
>  	omap_init_irq();
>  #ifdef CONFIG_OMAP_32K_TIMER
>  	omap2_gp_clockevent_set_gptimer(12);
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index e300a9e..eaab39b 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -284,7 +284,7 @@ struct spi_board_info omap3evm_spi_board_info[] = {
>  static void __init omap3_evm_init_irq(void)
>  {
>  	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
> -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> +			omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  	omap3evm_init_smc911x();
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 0bff181..f159e18 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -360,7 +360,7 @@ static int __init overo_i2c_init(void)
>  
>  static void __init overo_init_irq(void)
>  {
> -	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index 4733e4e..3629a0e 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -66,7 +66,7 @@ static struct omap_board_config_kernel rx51_config[] = {
>  static void __init rx51_init_irq(void)
>  {
>  	omap2_init_common_hw(rx51_get_sdram_timings(), omap3_mpu_rate_table,
> -			     omap3_dsp_rate_table, omap3_l3_rate_table);
> +			     omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> index 981f28e..e63bfa0 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -27,7 +27,7 @@
>  static void __init omap_zoom2_init_irq(void)
>  {
>  	omap2_init_common_hw(NULL, omap3_mpu_rate_table,
> -	                     omap3_dsp_rate_table, omap3_l3_rate_table);
> +			omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 980322d..266a5a1 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -44,6 +44,7 @@
>  
>  #include <mach/clockdomain.h>
>  #include "clockdomains.h"
> +#include "pm.h"
>  #endif
>  /*
>   * The machine specific code may provide the extra mapping besides the
> @@ -281,12 +282,14 @@ static int __init _omap2_init_reprogram_sdrc(void)
>  void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
>  				 struct omap_opp *mpu_opps,
>  				 struct omap_opp *dsp_opps,
> -				 struct omap_opp *l3_opps)
> +				 struct omap_opp *l3_opps,
> +				 struct prm_setup_vc *setup_times)
>  {
>  	omap2_mux_init();
>  #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
>  	/* The OPP tables have to be registered before a clk init */
>  	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
> +	omap_pm_early_init(setup_times);
>  	pwrdm_init(powerdomains_omap);
>  	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
>  	omapdev_init(omapdevs);
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 1192e01..b81ba3b 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -236,6 +236,13 @@ unsigned get_last_off_on_transaction_id(struct device *dev)
>  	return 0;
>  }
>  
> +void __init omap_pm_early_init(struct prm_setup_vc *setup_times)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_set_prm_setup_vc(setup_times);
> +	return;
> +}
> +
>  static int __init omap_pm_init(void)
>  {
>  	int error = -1;
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index ddc9453..0beb32d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -13,12 +13,6 @@
>  
>  #include <mach/powerdomain.h>
>  
> -#ifdef CONFIG_ARCH_OMAP3
> -extern unsigned short enable_dyn_sleep;
> -extern unsigned short enable_off_mode;
> -extern unsigned short voltage_off_while_idle;
> -extern void *omap3_secure_ram_storage;
> -
>  struct prm_setup_vc {
>  	u16 clksetup;
>  	u16 voltsetup_time1;
> @@ -37,6 +31,11 @@ struct prm_setup_vc {
>  	u16 vdd1_off;
>  };
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +extern unsigned short enable_dyn_sleep;
> +extern unsigned short enable_off_mode;
> +extern unsigned short voltage_off_while_idle;
> +extern void *omap3_secure_ram_storage;
>  extern void omap3_pm_off_mode_enable(int);
>  extern void omap_sram_idle(void);
>  extern int omap3_can_sleep(void);
> @@ -44,13 +43,15 @@ extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>  extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
> -
>  #ifdef CONFIG_CPU_IDLE
>  int omap3_idle_init(void);
>  #else
>  static inline int omap3_idle_init(void) { return 0; }
>  #endif
>  
> +#else /* CONFIG_ARCH_OMAP3 */
> +#define omap3_set_prm_setup_vc(setup_vc) do {} while (0);
> +
>  #endif /* CONFIG_ARCH_OMAP3 */
>  extern int resource_set_opp_level(int res, u32 target_level, int flags);
>  extern int resource_access_opp_lock(int res, int delta);
> @@ -90,5 +91,6 @@ extern unsigned int omap34xx_suspend_sz;
>  extern unsigned int save_secure_ram_context_sz;
>  extern unsigned int omap24xx_cpu_suspend_sz;
>  extern unsigned int omap34xx_cpu_suspend_sz;
> +void __init omap_pm_early_init(struct prm_setup_vc *setup_times);
>  
>  #endif
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7a4a525..7b05244 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -77,6 +77,13 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> +/*
> + * These values are board specific and have to be passed from
> + * the respective board files.
> + * The values used here are just worst case values which will
> + * be used on boards which do not pass on these values from
> + * the board files.
> + */
>  static struct prm_setup_vc prm_setup = {
>  	.clksetup = 0xff,
>  	.voltsetup_time1 = 0xfff,
> @@ -985,6 +992,9 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
>  
>  void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc)
>  {
> +	if (!setup_vc)
> +		return;
> +
>  	prm_setup.clksetup = setup_vc->clksetup;
>  	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
>  	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
> diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
> index 142f7e2..3582bef 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -224,6 +224,7 @@
>  
>  struct omap_sdrc_params;
>  struct omap_opp;
> +struct prm_setup_vc;
>  
>  extern void omap1_map_common_io(void);
>  extern void omap1_init_common_hw(void);
> @@ -232,7 +233,8 @@ extern void omap2_map_common_io(void);
>  extern void omap2_init_common_hw(struct omap_sdrc_params *sp,
>  				 struct omap_opp *mpu_opps,
>  				 struct omap_opp *dsp_opps,
> -				 struct omap_opp *l3_opps);
> +				 struct omap_opp *l3_opps,
> +				 struct prm_setup_vc *setup_times);
>  
>  #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
>  #define __arch_iounmap(v)	omap_iounmap(v)
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
