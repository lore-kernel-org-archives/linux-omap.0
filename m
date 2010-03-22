From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 01/17] OMAP3: PM: Adding hwmod data for Smartreflex
Date: Mon, 22 Mar 2010 12:07:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1003221132210.25802@utopia.booyaka.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com> <1268903755-4151-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35210 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab0CVSHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 14:07:24 -0400
In-Reply-To: <1268903755-4151-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Hello Thara,

a few comments:

On Thu, 18 Mar 2010, Thara Gopinath wrote:

> This patch adds the hwmod strucutres and other hwmod data for
> OMAP3 Smartreflex IP's.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   94 ++++++++++++++++++++++++++++
>  1 files changed, 94 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index ed60840..9c0c9e3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -35,6 +35,8 @@ static struct omap_hwmod omap3xxx_mpu_hwmod;
>  static struct omap_hwmod omap3xxx_l3_hwmod;
>  static struct omap_hwmod omap3xxx_l4_core_hwmod;
>  static struct omap_hwmod omap3xxx_l4_per_hwmod;
> +static struct omap_hwmod omap34xx_sr1_hwmod;
> +static struct omap_hwmod omap34xx_sr2_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap3xxx_l3__l4_core = {
> @@ -88,9 +90,47 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/* L4 CORE -> SR1 interface */
> +static struct omap_hwmod_addr_space omap34xx_sr1_addr_space[] = {
> +	{
> +		.pa_start	= OMAP34XX_SR1_BASE,
> +		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
> +		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,

Why ADDR_MAP_ON_INIT ?  This should only be used for a handful of modules, 
such as SDRC, SMS, etc.

> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap34xx_sr1_hwmod,
> +	.clk		= NULL,

This should be "sr_l4_ick"

> +	.addr		= omap34xx_sr1_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap34xx_sr1_addr_space),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +/* L4 CORE -> SR1 interface */
> +static struct omap_hwmod_addr_space omap34xx_sr2_addr_space[] = {
> +	{
> +		.pa_start	= OMAP34XX_SR2_BASE,
> +		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
> +		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,

As above.

> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
> +	.master		= &omap3xxx_l4_core_hwmod,
> +	.slave		= &omap34xx_sr2_hwmod,
> +	.clk		= NULL,

As above.

> +	.addr		= omap34xx_sr2_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap34xx_sr2_addr_space),
> +	.user		= OCP_USER_MPU,
> +};
> +
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
>  	&omap3xxx_l3__l4_core,
> +	&omap3_l4_core__sr1,
> +	&omap3_l4_core__sr2,
>  };
>  
>  /* Master interfaces on the L4_CORE interconnect */
> @@ -164,12 +204,66 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };
>  
> +/* SR common */
> +static struct omap_hwmod_sysc_fields omap34xx_sr_sysc_fields = {
> +	.clkact_shift	= 20,
> +};
> +
> +static struct omap_hwmod_class_sysconfig omap34xx_sr_sysc = {
> +	.sysc_offs	= 0x24,
> +	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
> +	.clockact	= CLOCKACT_TEST_ICLK,

What's the motivation behind this setting?  My understanding is that this 
is supposed to be set by the clock framework as FCLKEN, ICLKEN bits are 
set and cleared.  i.e., after *CLKEN is set to 1, the corresponding 
CLOCKACTIVITY bit would be set to 1; and before *CLKEN is set to 0, the 
corresponding CLOCKACTIVITY bit would be set to 0.  Is there a need here 
to initialize the CLOCKACTIVITY bits upon init?

> +	.sysc_fields	= &omap34xx_sr_sysc_fields,
> +};
> +
> +static struct omap_hwmod_class omap34xx_smartreflex_hwmod_class = {
> +	.name = "smartreflex",
> +	.sysc = &omap34xx_sr_sysc,
> +	.rev  = 1,

The above three lines need to be tab-aligned, ideally to the tab stop in 
the previous structures.

> +};
> +
> +/* SR1 */
> +static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
> +	&omap3_l4_core__sr1,
> +};
> +
> +static struct omap_hwmod omap34xx_sr1_hwmod = {
> +	.name		= "sr1_hwmod",
> +	.class		= &omap34xx_smartreflex_hwmod_class,
> +	.mpu_irqs	= NULL,
> +	.sdma_chs	= NULL,
> +	.main_clk	= "sr1_fck",
> +	.slaves		= omap34xx_sr1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +};
> +
> +/* SR2 */
> +static struct omap_hwmod_ocp_if *omap34xx_sr2_slaves[] = {
> +	&omap3_l4_core__sr2,
> +};
> +
> +static struct omap_hwmod omap34xx_sr2_hwmod = {
> +	.name		= "sr2_hwmod",
> +	.class		= &omap34xx_smartreflex_hwmod_class,
> +	.mpu_irqs	= NULL,
> +	.sdma_chs	= NULL,
> +	.main_clk	= "sr2_fck",
> +	.slaves		= omap34xx_sr2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +};
> +
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	&omap3xxx_l3_hwmod,
>  	&omap3xxx_l4_core_hwmod,
>  	&omap3xxx_l4_per_hwmod,
>  	&omap3xxx_l4_wkup_hwmod,
>  	&omap3xxx_mpu_hwmod,
> +	&omap34xx_sr1_hwmod,
> +	&omap34xx_sr2_hwmod,
>  	NULL,
>  };
>  
> -- 
> 1.7.0.rc1.33.g07cf0f
> 


- Paul
