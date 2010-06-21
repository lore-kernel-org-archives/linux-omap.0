From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH V3] OMAP3: PM: Workaround for DLL Lock issue
Date: Mon, 21 Jun 2010 10:14:02 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030580B0C4@dbde02.ent.ti.com>
References: <> <1274964626-5202-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104Ab0FUEoL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 00:44:11 -0400
In-Reply-To: <1274964626-5202-1-git-send-email-vishwanath.bs@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "Gulati, Shweta" <shweta.gulati@ti.com>

Kevin,
Any comments on this patch? 

Regards
Vishwa

> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Thursday, May 27, 2010 6:20 PM
> To: linux-omap@vger.kernel.org
> Cc: Sripathy, Vishwanath; Peter 'p2' De Schrijver; Gulati, Shweta
> Subject: [PATCH V3] OMAP3: PM: Workaround for DLL Lock issue
> 
> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> OMAP3430/3630 has a Silicon bug because of which SDRC is
> released from IDLE even before Core DPLL has locked. This leads
> to undefined behaviour of SDRC DLL.
> 
> Bug Descritpion: The root cause of the issue is that SDRC IDLEREQ
> is deasserted before DPLL3 has locked. Because of this DLL may/may
> not lock based on Process Voltage Temperature conditions. The bug
> can occur when DPLL3 automatic transition is enabled. So DPLL3 automatic
> transition is disabled by default and it is enabled only when system
> is entering ret/off state (to facilitate voltage scaling). So when system
> is entering ret/off state, WA is applied (since DPLL3 autoidle is enabled,
> we can possibly hit the issue; hence the WA)
> 
> Errata id: i581
> 
> Workaround Descrioption:
> Description of WA for 3430:
> Initialization:
> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3
> 	is always locked.
> 
> Before CORE Voltage Domain (VDD2) Sleep Transition to RETENTION or OFF mode:
> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP2 Frequency
> 	(by changing M2 Divider value). This is increasing the period duration of
> 	one L3 clock cycle.
> 	o	In case of CORE is at OPP3 (166MHz@1.15V):
> 	"	Lower the frequency to 83MHz.
> 
> 	o	In case of CORE is at OPP2 (83MHz@1.05V):
> 	"	Keep the frequency as it is (83MHz).
> 
> 2.	Increase CORE Voltage to 1.2V. This is reducing the timing duration of the
> 	critical path signal which will now fit to one L3 clock cycle.
> 
> 3.	Enable DPLL3 Automatic mode. This will ensure proper transition to
> 	RETENTION or OFF mode.
> 
> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
> 1.	Disable DPLL3 Automatic mode.
> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
> 
> Description of WA for 3630:
> Initialization:
> 	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 is
> always
> locked.
> 
> Before CORE Voltage Domain(VDD2) Sleep Transition to RETENTION or OFF mode:
> 1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP50 Frequency
> 	(by changing M2 Divider value) and set VDD2 Voltage for OPP100.
> 	This is increasing the period duration of one L3 clock cycle and reducing
> 	the timing duration of the critical path signal which will now fit to one
> 	L3 clock cycle.
> 	o	In case of CORE is at OPP100 (L3=200MHz, VDD2=1.1375V):
> 		"	Lower the frequency to 100MHz.
> 		"	Keep the voltage as it is (1.1375V).
> 
> 	o	In case of CORE is at OPP50 (L3=100MHz, VDD2=0.93V):
> 		"	Keep the frequency as it is (100MHz).
> 		"	Increase the voltage to 1.1375V.
> 
> 2.	Enable DPLL3 Automatic mode. This will ensure proper transition to
> 	RETENTION or OFF mode.
> 
> After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
> 1.	Disable DPLL3 Automatic mode.
> 2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.
> 
> Also OSWR should not be attempted if DPLL3 has locked. This should be done as part
> of OSWR patch
> series.
> These patch is based on Thara's Smart Reflex V3 patch series (wip_sr branch) and
> Tero's OS Idle changes @
> https://patchwork.kernel.org/patch/85268/
> 
> Patch tested on 3430SDP and 3630 ZOOM3.
> 
> Changes done in V3:
> 1. Addressed comments from Kevin
> 2. Optimized the code based on Peter's patch
> 
> Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> 
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c  |  114
> ++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/voltage.c |    1 +
>  2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 9c57081..b0a5d09 100755
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -55,6 +55,7 @@
>  #include "pm.h"
>  #include "sdrc.h"
>  #include "omap3-opp.h"
> +#include "clock3xxx.h"
> 
>  #ifdef CONFIG_SUSPEND
>  static suspend_state_t suspend_state = PM_SUSPEND_ON;
> @@ -97,6 +98,15 @@ static int (*_omap_save_secure_sram)(u32 *addr);
> 
>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
> +static struct powerdomain *dss_pwrdm, *usbhost_pwrdm;
> +static struct powerdomain *cam_pwrdm, *sgx_pwrdm;
> +static struct clk *dpll3_clk;
> +static struct omap_opp *vdd2_opp50, *vdd2_opp100;
> +static unsigned long vdd2_opp50_volt, vdd2_opp100_volt;
> +
> +#define DLL_LOCK_ERRATA_581 (1 << 0)
> +static u16 pm34xx_errata;
> +#define IS_PM34XX_ERRATA(id) (pm34xx_errata & (id))
> 
>  static inline void omap3_per_save_context(void)
>  {
> @@ -367,6 +377,7 @@ void omap_sram_idle(void)
>  	int core_next_state = PWRDM_POWER_ON;
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
> +	int prev_dpll3_div = 0;
> 
>  	if (!_omap_sram_idle)
>  		return;
> @@ -417,9 +428,43 @@ void omap_sram_idle(void)
>  	 */
>  	if (mpu_next_state <= PWRDM_POWER_RET)
>  		omap_smartreflex_disable(VDD1, 1);
> -	if (core_next_state <= PWRDM_POWER_RET)
> +	if (core_next_state <= PWRDM_POWER_RET) {
>  		omap_smartreflex_disable(VDD2, 1);
> 
> +	/* Apply the errata if Core is entering RET/OFF */
> +	if ((IS_PM34XX_ERRATA(DLL_LOCK_ERRATA_581)) &&
> +		 (core_next_state <= PWRDM_POWER_RET)) {
> +		if (pwrdm_can_idle(core_pwrdm) &&
> +			pwrdm_can_idle(per_pwrdm) &&
> +			pwrdm_can_idle(dss_pwrdm) &&
> +			pwrdm_can_idle(usbhost_pwrdm) &&
> +			pwrdm_can_idle(cam_pwrdm) &&
> +			pwrdm_can_idle(sgx_pwrdm)) {
> +				u32 clksel1_pll;
> +				clksel1_pll = cm_read_mod_reg(PLL_MOD,
> +					OMAP3430_CM_CLKSEL1_PLL);
> +				prev_dpll3_div = clksel1_pll >>
> +					OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT;
> +				if (prev_dpll3_div == 1) {
> +					omap3_core_dpll_m2_set_rate(dpll3_clk,
> +						opp_get_freq(vdd2_opp50) * 2);
> +					if (cpu_is_omap343x())
> +						omap_voltage_scale(VDD2, 1200000,
> +						vdd2_opp100_volt);
> +				} else {
> +					if (cpu_is_omap3630())
> +						omap_voltage_scale(VDD2,
> vdd2_opp100_volt,
> +						vdd2_opp50_volt);
> +					else if (cpu_is_omap343x())
> +						omap_voltage_scale(VDD2, 1200000,
> +						vdd2_opp50_volt);
> +				}
> +
> 	cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
> +				0x1, PLL_MOD, CM_AUTOIDLE);
> +			}
> +		}
> +	}
> +
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0);
> @@ -484,6 +529,44 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
>  		restore_table_entry();
> 
> +	if (IS_PM34XX_ERRATA(DLL_LOCK_ERRATA_581) &&
> +		(core_next_state < PWRDM_POWER_INACTIVE)) {
> +		if (pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
> +			u32 clksel1_pll;
> +
> +			/* ROM code restored the scratchpad settings. So DPLL3
> +			 * autoidle is disabled and L3 clock is back to the
> +			 * value before entering this function. This means we
> +			 * only have to lower the voltage if L3 runs at OPP50
> +			 */
> +
> +			clksel1_pll = cm_read_mod_reg(PLL_MOD,
> +						OMAP3430_CM_CLKSEL1_PLL);
> +			if ((clksel1_pll >> OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT)
> == 2) {
> +				/* restore VDD2 OPP2 voltage */
> +				if (cpu_is_omap3630())
> +					omap_voltage_scale(VDD2, vdd2_opp50_volt,
> vdd2_opp100_volt);
> +				else if (cpu_is_omap343x())
> +					omap_voltage_scale(VDD2, vdd2_opp50_volt,
> 1200000);
> +			}
> +		} else {
> +			/* disable DPLL3 autoidle */
> +			cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
> +					0x0, PLL_MOD, CM_AUTOIDLE);
> +			if (prev_dpll3_div == 1) {
> +				omap3_core_dpll_m2_set_rate(dpll3_clk,
> +						opp_get_freq(vdd2_opp100) * 2);
> +				if (cpu_is_omap343x())
> +					omap_voltage_scale(VDD2, vdd2_opp100_volt,
> 1200000);
> +			} else {
> +				if (cpu_is_omap3630())
> +					omap_voltage_scale(VDD2, vdd2_opp50_volt,
> vdd2_opp100_volt);
> +				else if (cpu_is_omap343x())
> +					omap_voltage_scale(VDD2, vdd2_opp50_volt,
> 1200000);
> +			}
> +		}
> +	}
> +
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
> @@ -1006,7 +1089,12 @@ static void __init prcm_setup_regs(void)
>  	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
>  			 MPU_MOD,
>  			 CM_AUTOIDLE2);
> -	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
> +	if (IS_PM34XX_ERRATA(DLL_LOCK_ERRATA_581))
> +		cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
> +			 PLL_MOD,
> +			 CM_AUTOIDLE);
> +	else
> +		cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
>  			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
>  			 PLL_MOD,
>  			 CM_AUTOIDLE);
> @@ -1178,17 +1266,27 @@ void omap_push_sram_idle(void)
>  				save_secure_ram_context_sz);
>  }
> 
> +void pm_errata_configure()
> +{
> +	/* TODO: add 3630 && omap_rev() <= OMAP3630_REV_ES1_1 */
> +	if (cpu_is_omap343x() || (cpu_is_omap3630()))
> +			pm34xx_errata |= DLL_LOCK_ERRATA_581;
> +}
> +
>  static int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst, *tmp;
>  	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
>  	int ret;
> +	unsigned long freq = 0;
> 
>  	if (!cpu_is_omap34xx())
>  		return -ENODEV;
> 
>  	printk(KERN_ERR "Power Management for TI OMAP3.\n");
> 
> +	pm_errata_configure();
> +
>  	/* XXX prcm_setup_regs needs to be before enabling hw
>  	 * supervised mode for powerdomains */
>  	prcm_setup_regs();
> @@ -1219,12 +1317,24 @@ static int __init omap3_pm_init(void)
>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
> +	usbhost_pwrdm = pwrdm_lookup("usbhost_pwrdm");
> +	sgx_pwrdm = pwrdm_lookup("sgx_pwrdm");
> +	dss_pwrdm = pwrdm_lookup("dss_pwrdm");
> +	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
> 
>  	neon_clkdm = clkdm_lookup("neon_clkdm");
>  	mpu_clkdm = clkdm_lookup("mpu_clkdm");
>  	per_clkdm = clkdm_lookup("per_clkdm");
>  	core_clkdm = clkdm_lookup("core_clkdm");
> 
> +	dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
> +
> +	vdd2_opp50 = opp_find_freq_ceil(OPP_L3, &freq);
> +	freq = ULONG_MAX;
> +	vdd2_opp100 = opp_find_freq_floor(OPP_L3, &freq);
> +	vdd2_opp50_volt = opp_get_voltage(vdd2_opp50);
> +	vdd2_opp100_volt = opp_get_voltage(vdd2_opp100);
> +
>  	omap_push_sram_idle();
>  #ifdef CONFIG_SUSPEND
>  	suspend_set_ops(&omap_pm_ops);
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index c5e9c42..e84a0ff 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -173,6 +173,7 @@ static struct omap_volt_data omap34xx_vdd2_volt_data[] =
> {
>  	{975000, 0, 0xF4, 0x0C},
>  	{1050000, 0, 0xF4, 0x0C},
>  	{1150000, 0, 0xF9, 0x18},
> +	{1200000, 0, 0xF9, 0x18},
>  };
> 
>  static struct omap_volt_data omap36xx_vdd2_volt_data[] = {
> --
> 1.5.4.3

