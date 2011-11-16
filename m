From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Wed, 16 Nov 2011 14:06:41 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8032290@DBDE01.ent.ti.com>
References: <1320676991-32152-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41223 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab1KPOGt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Nov 2011 09:06:49 -0500
In-Reply-To: <1320676991-32152-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, November 07, 2011 8:13 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hiremath, Vaibhav
> Subject: [RFC PATCH] arm:omap: cleanup & split omap2/3/4_check_revision
> function
> 
> This patch doesn't change functionality or behavior of the code
> execution; it barely cleans up the code and splits into SoC
> specific implementation for ID and feature detection; makes
> easier to add new SoC (especially for AM devices where we do not have
> feature register).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |   48 +++++++++++++---------------
> ----
>  arch/arm/mach-omap2/io.c              |    6 +++-
>  arch/arm/plat-omap/include/plat/cpu.h |    4 ++-
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 7f47092..f1784ee 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -226,9 +226,9 @@ static void __init omap4_check_features(void)
>  	}
>  }
> 
> -static void __init ti816x_check_features(void)
> +static void __init omap3_add_def_features(void)
>  {
> -	omap_features = OMAP3_HAS_NEON;
> +	omap_features = OMAP3_HAS_NEON | OMAP3_HAS_L2CACHE;
>  }
> 
>  static void __init omap3_check_revision(const char **cpu_rev)
> @@ -456,37 +456,29 @@ static void __init omap3_cpuinfo(const char
> *cpu_rev)
>  	printk(")\n");
>  }
> 
> -/*
> - * Try to detect the exact revision of the omap we're running on
> - */
> -void __init omap2_check_revision(void)
> +void __init omap2xxx_check_revision(void)
> +{
> +	omap24xx_check_revision();
> +}
> +
> +void __init omap3xxx_check_revision(bool has_feature_reg)
>  {
>  	const char *cpu_rev;
> 
> -	/*
> -	 * At this point we have an idea about the processor revision set
> -	 * earlier with omap2_set_globals_tap().
> -	 */
> -	if (cpu_is_omap24xx()) {
> -		omap24xx_check_revision();
> -	} else if (cpu_is_omap34xx()) {
> -		omap3_check_revision(&cpu_rev);
> +	omap3_check_revision(&cpu_rev);
> 
> -		/* TI816X doesn't have feature register */
> -		if (!cpu_is_ti816x())
> -			omap3_check_features();
> -		else
> -			ti816x_check_features();
> +	if (has_feature_reg)
> +		omap3_check_features();
> +	else
> +		omap3_add_def_features();
> 
> -		omap3_cpuinfo(cpu_rev);
> -		return;
> -	} else if (cpu_is_omap44xx()) {
> -		omap4_check_revision();
> -		omap4_check_features();
> -		return;
> -	} else {
> -		pr_err("OMAP revision unknown, please fix!\n");
> -	}
> +	omap3_cpuinfo(cpu_rev);
> +}
> +
> +void __init omap4xxx_check_revision(void)
> +{
> +	omap4_check_revision();
> +	omap4_check_features();
>  }
> 
>  /*
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 25d20ce..da9bc4a 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -321,7 +321,6 @@ void __iomem *omap_irq_base;
> 
>  static void __init omap_common_init_early(void)
>  {
> -	omap2_check_revision();
>  	omap_ioremap_init();
>  	omap_init_consistent_dma_size();
>  }
> @@ -363,6 +362,7 @@ static void __init omap_hwmod_init_postsetup(void)
>  void __init omap2420_init_early(void)
>  {
>  	omap2_set_globals_242x();
> +	omap2xxx_check_revision();
>  	omap_common_init_early();
>  	omap2xxx_voltagedomains_init();
>  	omap242x_powerdomains_init();
> @@ -375,6 +375,7 @@ void __init omap2420_init_early(void)
>  void __init omap2430_init_early(void)
>  {
>  	omap2_set_globals_243x();
> +	omap2xxx_check_revision();
>  	omap_common_init_early();
>  	omap2xxx_voltagedomains_init();
>  	omap243x_powerdomains_init();
> @@ -393,6 +394,7 @@ void __init omap2430_init_early(void)
>  void __init omap3_init_early(void)
>  {
>  	omap2_set_globals_3xxx();
> +	omap3xxx_check_revision(true);
>  	omap_common_init_early();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
> @@ -425,6 +427,7 @@ void __init am35xx_init_early(void)
>  void __init ti816x_init_early(void)
>  {
>  	omap2_set_globals_ti816x();
> +	omap3xxx_check_revision(false);
>  	omap_common_init_early();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
> @@ -439,6 +442,7 @@ void __init ti816x_init_early(void)
>  void __init omap4430_init_early(void)
>  {
>  	omap2_set_globals_443x();
> +	omap4xxx_check_revision();
>  	omap_common_init_early();
>  	omap44xx_voltagedomains_init();
>  	omap44xx_powerdomains_init();
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> index aa52d1e..51a0262 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -420,7 +420,9 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define OMAP446X_CLASS		0x44600044
>  #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))
> 
> -void omap2_check_revision(void);
> +void omap2xxx_check_revision(void);
> +void omap3xxx_check_revision(bool has_feature_reg);
> +void omap4xxx_check_revision(void);
> 
>  /*
>   * Runtime detection of OMAP3 features
> --
> 1.7.0.4

Any update/feedback/input on this patch? If not, can this be merged?

Thanks,
Vaibhav 
