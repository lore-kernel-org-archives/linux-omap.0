From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] Fix crash on non-3430SDP platforms with DVFS/CPUFreq
Date: Wed, 26 Nov 2008 11:45:09 -0800
Message-ID: <8763majmpm.fsf@deeprootsystems.com>
References: <04c101c94fc7$22fea610$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:8922 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbYKZTpV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 14:45:21 -0500
Received: by nf-out-0910.google.com with SMTP id d3so345689nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 11:45:15 -0800 (PST)
In-Reply-To: <04c101c94fc7$22fea610$LocalHost@wipultra1382> (Rajendra Nayak's message of "Wed\, 26 Nov 2008 18\:31\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> The SRF/DVFS + CPUFreq patches had issues booting on
> non-3430SDP platforms as reported by Kevin Hilman.
> This patch puts non-NULL checks in place for mpu_opps/dsp_opps
> /l3_opps before accessing them and fixes the issue.
>
> This fix/patch can be applied on top of 
> pm-20081119 branch 
> + [PATCH 00/08] OMAP3 SRF: OPP and Frequency resources
> + [PATCH 00/03] OMAP3 PM: CPUFreq driver for OMAP3

Thanks, I'll pull this fix along with the above two series into 
the next PM branch (which should be out later today.)

Kevin

> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c            |   33 ++++++++++++++++++++---------
>  arch/arm/mach-omap2/pm.h                   |   18 ---------------
>  arch/arm/mach-omap2/resource34xx.c         |   21 ++++++++++++++++++
>  arch/arm/plat-omap/cpu-omap.c              |    6 +----
>  arch/arm/plat-omap/include/mach/omap34xx.h |   18 +++++++++++++++
>  5 files changed, 64 insertions(+), 32 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.c	2008-11-26 17:43:12.011090533 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c	2008-11-26 17:47:40.551795371 +0530
> @@ -666,6 +666,9 @@ void omap2_clk_init_cpufreq_table(struct
>  	struct omap_opp *prcm;
>  	int i = 0;
>  
> +	if (!mpu_opps)
> +		return;
> +
>  	/* Avoid registering the 120% Overdrive with CPUFreq */
>  	prcm = mpu_opps + MAX_VDD1_OPP - 1;
>  	for (; prcm->rate; prcm--) {
> @@ -798,20 +801,24 @@ int __init omap2_clk_init(void)
>  	dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
>  
>  	mpu_speed = dpll1_clk->rate;
> -	prcm_vdd = mpu_opps + MAX_VDD1_OPP;
> -	for (; prcm_vdd->rate; prcm_vdd--) {
> -		if (prcm_vdd->rate <= mpu_speed) {
> -			curr_vdd1_prcm_set = prcm_vdd;
> -			break;
> +	if (mpu_opps) {
> +		prcm_vdd = mpu_opps + MAX_VDD1_OPP;
> +		for (; prcm_vdd->rate; prcm_vdd--) {
> +			if (prcm_vdd->rate <= mpu_speed) {
> +				curr_vdd1_prcm_set = prcm_vdd;
> +				break;
> +			}
>  		}
>  	}
>  
>  	core_speed = dpll3_clk->rate;
> -	prcm_vdd = l3_opps + MAX_VDD2_OPP;
> -	for (; prcm_vdd->rate; prcm_vdd--) {
> -		if (prcm_vdd->rate <= core_speed) {
> -			curr_vdd2_prcm_set = prcm_vdd;
> -			break;
> +	if (l3_opps) {
> +		prcm_vdd = l3_opps + MAX_VDD2_OPP;
> +		for (; prcm_vdd->rate; prcm_vdd--) {
> +			if (prcm_vdd->rate <= core_speed) {
> +				curr_vdd2_prcm_set = prcm_vdd;
> +				break;
> +			}
>  		}
>  	}
>  
> @@ -878,6 +885,9 @@ static long omap3_round_to_table_rate(st
>  	if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
>  		return -EINVAL;
>  
> +	if (!mpu_opps || !dsp_opps || !l3_opps)
> +		return -EINVAL;
> +
>  	highest_rate = -EINVAL;
>  
>  	if (clk == &virt_vdd1_prcm_set)
> @@ -904,6 +914,9 @@ static int omap3_select_table_rate(struc
>  	if ((clk != &virt_vdd1_prcm_set) && (clk != &virt_vdd2_prcm_set))
>  		return -EINVAL;
>  
> +	if (!mpu_opps || !dsp_opps || !l3_opps)
> +		return -EINVAL;
> +
>  	if (clk == &virt_vdd1_prcm_set) {
>  		prcm_vdd = mpu_opps + MAX_VDD1_OPP;
>  		index = MAX_VDD1_OPP;
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-11-26 17:43:12.011090533 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-11-26 17:47:40.552795340 +0530
> @@ -39,24 +39,6 @@ extern void omap3_pm_off_mode_enable(int
>  #endif
>  extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  
> -
> -/* VDD1 OPPS */
> -#define VDD1_OPP1	0x1
> -#define VDD1_OPP2	0x2
> -#define VDD1_OPP3	0x3
> -#define VDD1_OPP4	0x4
> -#define VDD1_OPP5	0x5
> -
> -/* VDD2 OPPS */
> -#define VDD2_OPP1	0x1
> -#define VDD2_OPP2	0x2
> -#define VDD2_OPP3	0x3
> -
> -#define MIN_VDD1_OPP	VDD1_OPP1
> -#define MAX_VDD1_OPP	VDD1_OPP5
> -#define MIN_VDD2_OPP	VDD2_OPP1
> -#define MAX_VDD2_OPP	VDD2_OPP3
> -
>  #ifdef CONFIG_PM_DEBUG
>  extern u32 omap2_read_32k_sync_counter(void);
>  extern void omap2_pm_dump(int mode, int resume, unsigned int us);
> Index: linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/resource34xx.c	2008-11-26 17:43:12.011090533 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/resource34xx.c	2008-11-26 18:16:28.376582736 +0530
> @@ -144,6 +144,10 @@ static struct device dummy_dsp_dev;
>  void init_opp(struct shared_resource *resp)
>  {
>  	resp->no_of_users = 0;
> +	
> +	if (!mpu_opps || !dsp_opps || !l3_opps)
> +		return 0;
> +
>  	/* Initialize the current level of the OPP resource
>  	* to the  opp set by u-boot.
>  	*/
> @@ -167,6 +171,9 @@ int set_opp(struct shared_resource *resp
>  	if (resp->curr_level == target_level)
>  		return 0;
>  
> +	if (!mpu_opps || !dsp_opps || !l3_opps)
> +		return 0;
> +
>  	if (strcmp(resp->name, "vdd1_opp") == 0) {
>  		mpu_old_freq = get_freq(mpu_opps + MAX_VDD1_OPP,
>  					curr_vdd1_prcm_set->opp_id);
> @@ -184,12 +191,16 @@ int set_opp(struct shared_resource *resp
>  		if (resp->curr_level > target_level) {
>  			/* Scale Frequency and then voltage */
>  			clk_set_rate(vdd1_clk, mpu_freq);
> +#ifdef CONFIG_OMAP_SMARTREFLEX
>  			sr_voltagescale_vcbypass(t_opp,
>  					mpu_opps[target_level].vsel);
> +#endif
>  		} else {
> +#ifdef CONFIG_OMAP_SMARTREFLEX
>  			/* Scale Voltage and then frequency */
>  			sr_voltagescale_vcbypass(t_opp,
>  					mpu_opps[target_level].vsel);
> +#endif
>  			clk_set_rate(vdd1_clk, mpu_freq);
>  		}
>  		resp->curr_level = curr_vdd1_prcm_set->opp_id;
> @@ -221,12 +232,16 @@ int set_opp(struct shared_resource *resp
>  		if (resp->curr_level > target_level) {
>  			/* Scale Frequency and then voltage */
>  			clk_set_rate(vdd2_clk, l3_freq);
> +#ifdef CONFIG_OMAP_SMARTREFLEX
>  			sr_voltagescale_vcbypass(t_opp,
>  					l3_opps[target_level].vsel);
> +#endif
>  		} else {
> +#ifdef CONFIG_OMAP_SMARTREFLEX
>  			/* Scale Voltage and then frequency */
>  			sr_voltagescale_vcbypass(t_opp,
>  					l3_opps[target_level].vsel);
> +#endif
>  			clk_set_rate(vdd2_clk, l3_freq);
>  		}
>  		resp->curr_level = curr_vdd2_prcm_set->opp_id;
> @@ -253,6 +268,9 @@ void init_freq(struct shared_resource *r
>  	char *linked_res_name;
>  	resp->no_of_users = 0;
>  
> +	if (!mpu_opps || !dsp_opps)
> +		return;
> +
>  	linked_res_name = (char *)resp->resource_data;
>  	/* Initialize the current level of the Freq resource
>  	* to the frequency set by u-boot.
> @@ -271,6 +289,9 @@ int set_freq(struct shared_resource *res
>  {
>  	unsigned int vdd1_opp;
>  
> +	if (!mpu_opps || !dsp_opps)
> +		return 0;
> +
>  	if (strcmp(resp->name, "mpu_freq") == 0) {
>  		vdd1_opp = get_opp(mpu_opps + MAX_VDD1_OPP, target_level);
>  		resource_request("vdd1_opp", &dummy_mpu_dev, vdd1_opp);
> Index: linux-omap-2.6/arch/arm/plat-omap/cpu-omap.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/cpu-omap.c	2008-11-26 17:43:12.011090533 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/cpu-omap.c	2008-11-26 17:47:40.552795340 +0530
> @@ -31,7 +31,6 @@
>  #include <mach/clock.h>
>  #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>  #include <mach/omap-pm.h>
> -#include "../mach-omap2/pm.h"
>  #endif
>  
>  #define VERY_HI_RATE	900000000
> @@ -107,9 +106,8 @@ static int omap_target(struct cpufreq_po
>  #endif
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)\
> -	&& defined(CONFIG_MACH_OMAP_3430SDP)
> -	{
> +#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> +	if (mpu_opps) {
>  		int ind;
>  		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
>  			if (mpu_opps[ind].rate/1000 >= freqs.new) {
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/omap34xx.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/omap34xx.h	2008-11-26 17:43:12.011090533 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/omap34xx.h	2008-11-26 17:47:40.553795309 +0530
> @@ -71,5 +71,23 @@
>  #define OMAP34XX_DSP_MEM_BASE	(OMAP34XX_DSP_BASE + 0x0)
>  #define OMAP34XX_DSP_IPI_BASE	(OMAP34XX_DSP_BASE + 0x1000000)
>  #define OMAP34XX_DSP_MMU_BASE	(OMAP34XX_DSP_BASE + 0x2000000)
> +
> +/* VDD1 OPPS */
> +#define VDD1_OPP1	0x1
> +#define VDD1_OPP2	0x2
> +#define VDD1_OPP3	0x3
> +#define VDD1_OPP4	0x4
> +#define VDD1_OPP5	0x5
> +
> +/* VDD2 OPPS */
> +#define VDD2_OPP1	0x1
> +#define VDD2_OPP2	0x2
> +#define VDD2_OPP3	0x3
> +
> +#define MIN_VDD1_OPP	VDD1_OPP1
> +#define MAX_VDD1_OPP	VDD1_OPP5
> +#define MIN_VDD2_OPP	VDD2_OPP1
> +#define MAX_VDD2_OPP	VDD2_OPP3
> +
>  #endif /* __ASM_ARCH_OMAP34XX_H */
>  
