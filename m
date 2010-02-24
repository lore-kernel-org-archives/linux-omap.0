From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 01/16] OMAP3: PM: Adding hwmod data for Smartreflex
Date: Wed, 24 Feb 2010 10:52:39 -0600
Message-ID: <4B855957.7080805@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com> <1267003757-22456-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46029 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757293Ab0BXQwq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 11:52:46 -0500
In-Reply-To: <1267003757-22456-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

Thara Gopinath wrote:
> This patch adds the hwmod strucutres and other hwmod data for
> OMAP3 Smartreflex IP's.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_34xx.h |   92 +++++++++++++++++++++++++++++++++
>  1 files changed, 92 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
> index 2e629dc..dccb4a4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
> +++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
> @@ -25,6 +25,8 @@ static struct omap_hwmod omap34xx_mpu_hwmod;
>  static struct omap_hwmod omap34xx_l3_hwmod;
>  static struct omap_hwmod omap34xx_l4_core_hwmod;
>  static struct omap_hwmod omap34xx_l4_per_hwmod;
> +static struct omap_hwmod omap34xx_sr1_hwmod;
> +static struct omap_hwmod omap34xx_sr2_hwmod;
>  
>  /* L3 -> L4_CORE interface */
>  static struct omap_hwmod_ocp_if omap34xx_l3__l4_core = {
> @@ -77,9 +79,49 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
>  	.user	= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> +/* L4 CORE -> SR1 interface */
> +static struct omap_hwmod_addr_space omap34xx_sr1_addr_space[] = {
> +	{
> +		.pa_start	= OMAP34XX_SR1_BASE,
> +		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
> +		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3_l4_core__sr1 = {
> +	.master		= &omap34xx_l4_core_hwmod,
> +	.slave		= &omap34xx_sr1_hwmod,
> +	.clkdev_dev_id	= NULL,
> +	.clkdev_con_id  = NULL,
> +	.addr		= omap34xx_sr1_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap34xx_sr1_addr_space),
> +	.user		= OCP_USER_MPU,
> +};
> +
> +/* L4 CORE -> SR1 interface */

Comment above should be "SR2 interface"

Regards,
Mike

> +static struct omap_hwmod_addr_space omap34xx_sr2_addr_space[] = {
> +	{
> +		.pa_start	= OMAP34XX_SR2_BASE,
> +		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
> +		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
> +	},
> +};
> +
> +static struct omap_hwmod_ocp_if omap3_l4_core__sr2 = {
> +	.master		= &omap34xx_l4_core_hwmod,
> +	.slave		= &omap34xx_sr2_hwmod,
> +	.clkdev_dev_id	= NULL,
> +	.clkdev_con_id  = NULL,
> +	.addr		= omap34xx_sr2_addr_space,
> +	.addr_cnt	= ARRAY_SIZE(omap34xx_sr2_addr_space),
> +	.user		= OCP_USER_MPU,
> +};
> +
>  /* Slave interfaces on the L4_CORE interconnect */
>  static struct omap_hwmod_ocp_if *omap34xx_l4_core_slaves[] = {
>  	&omap34xx_l3__l4_core,
> +	&omap3_l4_core__sr1,
> +	&omap3_l4_core__sr2,
>  };
>  
>  /* Master interfaces on the L4_CORE interconnect */
> @@ -150,12 +192,62 @@ static struct omap_hwmod omap34xx_mpu_hwmod = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  };
>  
> +/* SR common */
> +static struct omap_hwmod_sysc_fields sr_sysc_fields = {
> +	.clkact_shift	= 20,
> +};
> +
> +static struct omap_hwmod_sysconfig sr_if_ctrl = {
> +	.sysc_offs	= 0x24,
> +	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_NO_CACHE),
> +	.clockact	= CLOCKACT_TEST_ICLK,
> +	.sysc_fields	= &sr_sysc_fields,
> +};
> +
> +/* SR1 */
> +static struct omap_hwmod_ocp_if *omap34xx_sr1_slaves[] = {
> +	&omap3_l4_core__sr1,
> +};
> +
> +static struct omap_hwmod omap34xx_sr1_hwmod = {
> +	.name		= "sr1_hwmod",
> +	.mpu_irqs	= NULL,
> +	.sdma_chs	= NULL,
> +	.clkdev_dev_id	= NULL,
> +	.clkdev_con_id	= "sr1_fck",
> +	.slaves		= omap34xx_sr1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr1_slaves),
> +	.sysconfig	= &sr_if_ctrl,
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
> +	.mpu_irqs	= NULL,
> +	.sdma_chs	= NULL,
> +	.clkdev_dev_id	= NULL,
> +	.clkdev_con_id	= "sr2_fck",
> +	.slaves		= omap34xx_sr2_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap34xx_sr2_slaves),
> +	.sysconfig	= &sr_if_ctrl,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +};
> +
>  static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
>  	&omap34xx_l3_hwmod,
>  	&omap34xx_l4_core_hwmod,
>  	&omap34xx_l4_per_hwmod,
>  	&omap34xx_l4_wkup_hwmod,
>  	&omap34xx_mpu_hwmod,
> +	&omap34xx_sr1_hwmod,
> +	&omap34xx_sr2_hwmod,
>  	NULL,
>  };
>  

