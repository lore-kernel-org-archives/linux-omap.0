From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2&3: hwmod: Replace l3 -> l3_main and fix iva2
Date: Thu, 24 Jun 2010 15:39:26 -0700
Message-ID: <87pqzgxdgh.fsf@deeprootsystems.com>
References: <1277418371-27322-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48575 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0FXWjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 18:39:33 -0400
Received: by pwj8 with SMTP id 8so2062543pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 15:39:32 -0700 (PDT)
In-Reply-To: <1277418371-27322-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 25 Jun 2010 00:26:11 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Benoit Cousson <b-cousson@ti.com> writes:

> Replace all the struct that contain l3 with l3_main in order
> to be consistent with the OMAP4 naming convention.
>
> Replace iva2 by iva for the same reason.
>
> This patch is based on the latest-latest (45 min ago) pm-wip/hwmods
> branch from Kevin's tree.

Thanks, will merge into the pm-wip/hwmods series.  I'll merge the IVA
changes into the existing IVA patch, and then leave the rest as a
separate patch.

Thanks,

Kevin

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   34 +++++++-------
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   34 +++++++-------
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   65 ++++++++++++++--------------
>  3 files changed, 66 insertions(+), 67 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index 646386c..8c90b27 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -30,41 +30,41 @@
>   */
>  
>  static struct omap_hwmod omap2420_mpu_hwmod;
> -static struct omap_hwmod omap2420_l3_hwmod;
> +static struct omap_hwmod omap2420_l3_main_hwmod;
>  static struct omap_hwmod omap2420_l4_core_hwmod;
>  
>  /* L3 -> L4_CORE interface */
> -static struct omap_hwmod_ocp_if omap2420_l3__l4_core = {
> -	.master	= &omap2420_l3_hwmod,
> +static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
> +	.master	= &omap2420_l3_main_hwmod,
>  	.slave	= &omap2420_l4_core_hwmod,
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
>  /* MPU -> L3 interface */
> -static struct omap_hwmod_ocp_if omap2420_mpu__l3 = {
> +static struct omap_hwmod_ocp_if omap2420_mpu__l3_main = {
>  	.master = &omap2420_mpu_hwmod,
> -	.slave	= &omap2420_l3_hwmod,
> +	.slave	= &omap2420_l3_main_hwmod,
>  	.user	= OCP_USER_MPU,
>  };
>  
>  /* Slave interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap2420_l3_slaves[] = {
> -	&omap2420_mpu__l3,
> +static struct omap_hwmod_ocp_if *omap2420_l3_main_slaves[] = {
> +	&omap2420_mpu__l3_main,
>  };
>  
>  /* Master interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap2420_l3_masters[] = {
> -	&omap2420_l3__l4_core,
> +static struct omap_hwmod_ocp_if *omap2420_l3_main_masters[] = {
> +	&omap2420_l3_main__l4_core,
>  };
>  
>  /* L3 */
> -static struct omap_hwmod omap2420_l3_hwmod = {
> +static struct omap_hwmod omap2420_l3_main_hwmod = {
>  	.name		= "l3_main",
>  	.class		= &l3_hwmod_class,
> -	.masters	= omap2420_l3_masters,
> -	.masters_cnt	= ARRAY_SIZE(omap2420_l3_masters),
> -	.slaves		= omap2420_l3_slaves,
> -	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_slaves),
> +	.masters	= omap2420_l3_main_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap2420_l3_main_masters),
> +	.slaves		= omap2420_l3_main_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2420_l3_main_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
>  	.flags		= HWMOD_NO_IDLEST,
>  };
> @@ -80,7 +80,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
>  
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
> -	&omap2420_l3__l4_core,
> +	&omap2420_l3_main__l4_core,
>  };
>  
>  /* Master interfaces on the L4_CORE interconnect */
> @@ -123,7 +123,7 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
>  
>  /* Master interfaces on the MPU device */
>  static struct omap_hwmod_ocp_if *omap2420_mpu_masters[] = {
> -	&omap2420_mpu__l3,
> +	&omap2420_mpu__l3_main,
>  };
>  
>  /* MPU */
> @@ -137,7 +137,7 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
>  };
>  
>  static __initdata struct omap_hwmod *omap2420_hwmods[] = {
> -	&omap2420_l3_hwmod,
> +	&omap2420_l3_main_hwmod,
>  	&omap2420_l4_core_hwmod,
>  	&omap2420_l4_wkup_hwmod,
>  	&omap2420_mpu_hwmod,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index b2100cf..c0f3311 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -30,41 +30,41 @@
>   */
>  
>  static struct omap_hwmod omap2430_mpu_hwmod;
> -static struct omap_hwmod omap2430_l3_hwmod;
> +static struct omap_hwmod omap2430_l3_main_hwmod;
>  static struct omap_hwmod omap2430_l4_core_hwmod;
>  
>  /* L3 -> L4_CORE interface */
> -static struct omap_hwmod_ocp_if omap2430_l3__l4_core = {
> -	.master	= &omap2430_l3_hwmod,
> +static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
> +	.master	= &omap2430_l3_main_hwmod,
>  	.slave	= &omap2430_l4_core_hwmod,
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
>  /* MPU -> L3 interface */
> -static struct omap_hwmod_ocp_if omap2430_mpu__l3 = {
> +static struct omap_hwmod_ocp_if omap2430_mpu__l3_main = {
>  	.master = &omap2430_mpu_hwmod,
> -	.slave	= &omap2430_l3_hwmod,
> +	.slave	= &omap2430_l3_main_hwmod,
>  	.user	= OCP_USER_MPU,
>  };
>  
>  /* Slave interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap2430_l3_slaves[] = {
> -	&omap2430_mpu__l3,
> +static struct omap_hwmod_ocp_if *omap2430_l3_main_slaves[] = {
> +	&omap2430_mpu__l3_main,
>  };
>  
>  /* Master interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap2430_l3_masters[] = {
> -	&omap2430_l3__l4_core,
> +static struct omap_hwmod_ocp_if *omap2430_l3_main_masters[] = {
> +	&omap2430_l3_main__l4_core,
>  };
>  
>  /* L3 */
> -static struct omap_hwmod omap2430_l3_hwmod = {
> +static struct omap_hwmod omap2430_l3_main_hwmod = {
>  	.name		= "l3_main",
>  	.class		= &l3_hwmod_class,
> -	.masters	= omap2430_l3_masters,
> -	.masters_cnt	= ARRAY_SIZE(omap2430_l3_masters),
> -	.slaves		= omap2430_l3_slaves,
> -	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_slaves),
> +	.masters	= omap2430_l3_main_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap2430_l3_main_masters),
> +	.slaves		= omap2430_l3_main_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap2430_l3_main_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
>  	.flags		= HWMOD_NO_IDLEST,
>  };
> @@ -82,7 +82,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
>  
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
> -	&omap2430_l3__l4_core,
> +	&omap2430_l3_main__l4_core,
>  };
>  
>  /* Master interfaces on the L4_CORE interconnect */
> @@ -125,7 +125,7 @@ static struct omap_hwmod omap2430_l4_wkup_hwmod = {
>  
>  /* Master interfaces on the MPU device */
>  static struct omap_hwmod_ocp_if *omap2430_mpu_masters[] = {
> -	&omap2430_mpu__l3,
> +	&omap2430_mpu__l3_main,
>  };
>  
>  /* MPU */
> @@ -139,7 +139,7 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
>  };
>  
>  static __initdata struct omap_hwmod *omap2430_hwmods[] = {
> -	&omap2430_l3_hwmod,
> +	&omap2430_l3_main_hwmod,
>  	&omap2430_l4_core_hwmod,
>  	&omap2430_l4_wkup_hwmod,
>  	&omap2430_mpu_hwmod,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 69080fa..8f7a3de 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -32,51 +32,51 @@
>   */
>  
>  static struct omap_hwmod omap3xxx_mpu_hwmod;
> -static struct omap_hwmod omap3xxx_iva2_hwmod;
> -static struct omap_hwmod omap3xxx_l3_hwmod;
> +static struct omap_hwmod omap3xxx_iva_hwmod;
> +static struct omap_hwmod omap3xxx_l3_main_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
>  
>  /* L3 -> L4_CORE interface */
> -static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
> -	.master	= &omap3xxx_l3_hwmod,
> +static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
> +	.master	= &omap3xxx_l3_main_hwmod,
>  	.slave	= &omap3xxx_l4_core_hwmod,
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
>  /* L3 -> L4_PER interface */
> -static struct omap_hwmod_ocp_if omap3xxx_l3__l4_per = {
> -	.master = &omap3xxx_l3_hwmod,
> +static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
> +	.master = &omap3xxx_l3_main_hwmod,
>  	.slave	= &omap3xxx_l4_per_hwmod,
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
>  /* MPU -> L3 interface */
> -static struct omap_hwmod_ocp_if omap3xxx_mpu__l3 = {
> +static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
>  	.master = &omap3xxx_mpu_hwmod,
> -	.slave	= &omap3xxx_l3_hwmod,
> +	.slave	= &omap3xxx_l3_main_hwmod,
>  	.user	= OCP_USER_MPU,
>  };
>  
>  /* Slave interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap3xxx_l3_slaves[] = {
> -	&omap3xxx_mpu__l3,
> +static struct omap_hwmod_ocp_if *omap3xxx_l3_main_slaves[] = {
> +	&omap3xxx_mpu__l3_main,
>  };
>  
>  /* Master interfaces on the L3 interconnect */
> -static struct omap_hwmod_ocp_if *omap3xxx_l3_masters[] = {
> -	&omap3xxx_l3__l4_core,
> -	&omap3xxx_l3__l4_per,
> +static struct omap_hwmod_ocp_if *omap3xxx_l3_main_masters[] = {
> +	&omap3xxx_l3_main__l4_core,
> +	&omap3xxx_l3_main__l4_per,
>  };
>  
>  /* L3 */
> -static struct omap_hwmod omap3xxx_l3_hwmod = {
> +static struct omap_hwmod omap3xxx_l3_main_hwmod = {
>  	.name		= "l3_main",
>  	.class		= &l3_hwmod_class,
> -	.masters	= omap3xxx_l3_masters,
> -	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_masters),
> -	.slaves		= omap3xxx_l3_slaves,
> -	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_slaves),
> +	.masters	= omap3xxx_l3_main_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_l3_main_masters),
> +	.slaves		= omap3xxx_l3_main_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_main_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
>  };
> @@ -92,7 +92,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
>  
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
> -	&omap3xxx_l3__l4_core,
> +	&omap3xxx_l3_main__l4_core,
>  };
>  
>  /* Master interfaces on the L4_CORE interconnect */
> @@ -114,7 +114,7 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
>  
>  /* Slave interfaces on the L4_PER interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
> -	&omap3xxx_l3__l4_per,
> +	&omap3xxx_l3_main__l4_per,
>  };
>  
>  /* Master interfaces on the L4_PER interconnect */
> @@ -156,7 +156,7 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
>  
>  /* Master interfaces on the MPU device */
>  static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
> -	&omap3xxx_mpu__l3,
> +	&omap3xxx_mpu__l3_main,
>  };
>  
>  /* MPU */
> @@ -174,36 +174,35 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>   */
>  
>  /* IVA2 <- L3 interface */
> -static struct omap_hwmod_ocp_if omap3xxx_l3__iva2 = {
> -	.master		= &omap3xxx_l3_hwmod,
> -	.slave		= &omap3xxx_iva2_hwmod,
> +static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
> +	.master		= &omap3xxx_l3_main_hwmod,
> +	.slave		= &omap3xxx_iva_hwmod,
>  	.clk		= "iva2_ck",
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> -static struct omap_hwmod_ocp_if *omap3xxx_iva2_masters[] = {
> -	&omap3xxx_l3__iva2,
> +static struct omap_hwmod_ocp_if *omap3xxx_iva_masters[] = {
> +	&omap3xxx_l3__iva,
>  };
>  
>  /*
>   * IVA2 (IVA2)
>   */
>  
> -static struct omap_hwmod omap3xxx_iva2_hwmod = {
> -	.name		= "iva2",
> -	.main_clk	= "iva2_ck",
> -	.masters	= omap3xxx_iva2_masters,
> -	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva2_masters),
> +static struct omap_hwmod omap3xxx_iva_hwmod = {
> +	.name		= "iva",
> +	.masters	= omap3xxx_iva_masters,
> +	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
>  };
>  
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
> -	&omap3xxx_l3_hwmod,
> +	&omap3xxx_l3_main_hwmod,
>  	&omap3xxx_l4_core_hwmod,
>  	&omap3xxx_l4_per_hwmod,
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
> -	&omap3xxx_iva2_hwmod,
> +	&omap3xxx_iva_hwmod,
>  	NULL,
>  };
