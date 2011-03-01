From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC] omap3: Allow dynamic (de)selection of HWMODs
Date: Tue, 01 Mar 2011 14:18:26 -0800
Message-ID: <878vwyh4ct.fsf@ti.com>
References: <1298389570-31442-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54587 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753068Ab1CAWSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 17:18:32 -0500
Received: by mail-yx0-f169.google.com with SMTP id 33so2742989yxt.0
        for <linux-omap@vger.kernel.org>; Tue, 01 Mar 2011 14:18:30 -0800 (PST)
In-Reply-To: <1298389570-31442-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Tue, 22 Feb 2011 21:16:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> OMAP35xx, AM35xx, AM37xx families hve multiple
> variants that differ from each other based on
> features and peripherals.
>
> This patch defines a simple framework to keep
> the HWMOD database to be a generic superset and
> then allow runtime selection and deselection of
> HWMODs corresponding to detected silicon variant.
>
> It eliminates the need to define CHIP_IS_xxx for
> each variant.

It doesn't eliminate the need, it just creates a second mechanism for
doing the same thing.

Rather than adding a new "simple" mechansim, which will of course grow
into something not-so-simple, please use CHIP_IS_xxx.

Kevin

> Continuation of ongoing discussion[1] but this
> time with actual code.
>
>  [1] http://marc.info/?l=linux-omap&m=129838265800443&w=2
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
> This patch contains changes to add CHIP_IS_AM3505
> from my work-in-progress branch... but essence of
> this proposal is to do away with need to define
> this and additional bits.
>
> Please ignore this change during review.
>
>  arch/arm/mach-omap2/id.c                     |    4 +-
>  arch/arm/mach-omap2/omap_hwmod.c             |    3 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   92 +++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/cpu.h        |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>  5 files changed, 98 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 5f9086c..99bd54f 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -263,11 +263,9 @@ static void __init omap3_check_revision(void)
>  		 *
>  		 * Set the device to be OMAP3505 here. Actual device
>  		 * is identified later based on the features.
> -		 *
> -		 * REVISIT: AM3505/AM3517 should have their own CHIP_IS
>  		 */
>  		omap_revision = OMAP3505_REV(rev);
> -		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
> +		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1 | CHIP_IS_AM3505;
>  		break;
>  	case 0xb891:
>  		/* Handle 36xx devices */
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e282e35..62d19b6 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1362,6 +1362,9 @@ static int _setup(struct omap_hwmod *oh, void *data)
>  	int i, r;
>  	u8 postsetup_state;
>  
> +	if (!oh->select)
> +		return 0;
> +
>  	/* Set iclk autoidle mode */
>  	if (oh->slaves_cnt > 0) {
>  		for (i = 0; i < oh->slaves_cnt; i++) {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 800eda4..e7d0906 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -105,6 +105,7 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l3_main_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.select		= true,
>  };
>  
>  static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
> @@ -333,6 +334,7 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_core_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.select		= true,
>  };
>  
>  /* Slave interfaces on the L4_PER interconnect */
> @@ -356,6 +358,7 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_per_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.select		= true,
>  };
>  
>  /* Slave interfaces on the L4_WKUP interconnect */
> @@ -377,6 +380,7 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.select		= true,
>  };
>  
>  /* Master interfaces on the MPU device */
> @@ -392,6 +396,7 @@ static struct omap_hwmod omap3xxx_mpu_hwmod = {
>  	.masters	= omap3xxx_mpu_masters,
>  	.masters_cnt	= ARRAY_SIZE(omap3xxx_mpu_masters),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /*
> @@ -419,7 +424,8 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
>  	.class		= &iva_hwmod_class,
>  	.masters	= omap3xxx_iva_masters,
>  	.masters_cnt	= ARRAY_SIZE(omap3xxx_iva_masters),
> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* l4_wkup -> wd_timer2 */
> @@ -496,6 +502,7 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
>  	.slaves		= omap3xxx_wd_timer2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* UART common */
> @@ -551,6 +558,7 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart1_slaves),
>  	.class		= &uart_class,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* UART2 */
> @@ -588,6 +596,7 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart2_slaves),
>  	.class		= &uart_class,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* UART3 */
> @@ -625,6 +634,7 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart3_slaves),
>  	.class		= &uart_class,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* UART4 */
> @@ -662,6 +672,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
>  	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart4_slaves),
>  	.class		= &uart_class,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.select		= true,
>  };
>  
>  static struct omap_hwmod_class i2c_class = {
> @@ -709,6 +720,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
>  	.class		= &i2c_class,
>  	.dev_attr	= &i2c1_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* I2C2 */
> @@ -751,6 +763,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
>  	.class		= &i2c_class,
>  	.dev_attr	= &i2c2_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* I2C3 */
> @@ -793,6 +806,7 @@ static struct omap_hwmod omap3xxx_i2c3_hwmod = {
>  	.class		= &i2c_class,
>  	.dev_attr	= &i2c3_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* l4_wkup -> gpio1 */
> @@ -958,6 +972,7 @@ static struct omap_hwmod omap3xxx_gpio1_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* gpio2 */
> @@ -994,6 +1009,7 @@ static struct omap_hwmod omap3xxx_gpio2_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* gpio3 */
> @@ -1030,6 +1046,7 @@ static struct omap_hwmod omap3xxx_gpio3_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* gpio4 */
> @@ -1066,6 +1083,7 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* gpio5 */
> @@ -1102,6 +1120,7 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* gpio6 */
> @@ -1138,6 +1157,7 @@ static struct omap_hwmod omap3xxx_gpio6_hwmod = {
>  	.class		= &omap3xxx_gpio_hwmod_class,
>  	.dev_attr	= &gpio_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* dma_system -> L3 */
> @@ -1230,6 +1250,7 @@ static struct omap_hwmod omap3xxx_dma_system_hwmod = {
>  	.dev_attr	= &dma_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.flags		= HWMOD_NO_IDLEST,
> +	.select		= true,
>  };
>  
>  /* SR common */
> @@ -1294,6 +1315,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +	.select		= true,
>  };
>  
>  static struct omap_hwmod omap36xx_sr1_hwmod = {
> @@ -1313,6 +1335,7 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
>  	.slaves		= omap3_sr1_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr1_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.select		= true,
>  };
>  
>  /* SR2 */
> @@ -1340,6 +1363,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
>  					CHIP_IS_OMAP3430ES3_0 |
>  					CHIP_IS_OMAP3430ES3_1),
>  	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
> +	.select		= true,
>  };
>  
>  static struct omap_hwmod omap36xx_sr2_hwmod = {
> @@ -1359,6 +1383,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
>  	.slaves		= omap3_sr2_slaves,
>  	.slaves_cnt	= ARRAY_SIZE(omap3_sr2_slaves),
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
> +	.select		= true,
>  };
>  
>  /* l4 core -> mcspi1 interface */
> @@ -1501,6 +1526,7 @@ static struct omap_hwmod omap34xx_mcspi1 = {
>  	.class		= &omap34xx_mcspi_class,
>  	.dev_attr       = &omap_mcspi1_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* mcspi2 */
> @@ -1544,6 +1570,7 @@ static struct omap_hwmod omap34xx_mcspi2 = {
>  	.class		= &omap34xx_mcspi_class,
>  	.dev_attr       = &omap_mcspi2_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* mcspi3 */
> @@ -1587,6 +1614,7 @@ static struct omap_hwmod omap34xx_mcspi3 = {
>  	.class		= &omap34xx_mcspi_class,
>  	.dev_attr       = &omap_mcspi3_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  /* SPI4 */
> @@ -1628,6 +1656,7 @@ static struct omap_hwmod omap34xx_mcspi4 = {
>  	.class		= &omap34xx_mcspi_class,
>  	.dev_attr       = &omap_mcspi4_dev_attr,
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +	.select		= true,
>  };
>  
>  static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
> @@ -1670,7 +1699,68 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
>  	NULL,
>  };
>  
> +/**
> + * Set/Clear the select flag for the specified HWMOD
> + */
> +static inline void omap_hwmod_select(struct omap_hwmod *oh, bool flag)
> +{
> +	oh->select = flag;
> +}
> +
> +/**
> + * Select the HWMOD definitions application for AM35xx family
> + */
> +void __init am35xx_hwmod_only(void)
> +{
> +	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> +		return;
> +
> +	omap_hwmod_select(&omap3xxx_iva_hwmod, false);
> +
> +	omap_hwmod_select(&omap34xx_sr1_hwmod, false);
> +	omap_hwmod_select(&omap34xx_sr2_hwmod, false);
> +	omap_hwmod_select(&omap36xx_sr1_hwmod, false);
> +	omap_hwmod_select(&omap36xx_sr2_hwmod, false);
> +
> +	/*
> +	 * TBD: Need to do specifically "select" HWMODs for new peripherals
> +	 *      in AM35xx family. Of course, they need to be defined first.
> +	 */
> +}
> +
> +/**
> + * Select the HWMOD definitions application for OMAP35xx family
> + */
> +void __init omap35xx_hwmod_only(void)
> +{
> +	if (!cpu_is_omap3430())
> +		return;
> +
> +	if (!omap3_has_iva())
> +		omap_hwmod_select(&omap3xxx_iva_hwmod, false);
> +
> +	/* TBD: Need to do same for SGX. Don't see hwmod for it... */
> +}
> +
> +/**
> + * Select the HWMOD definitions application for AM/DM37xx family
> + */
> +void __init am37xx_hwmod_only(void)
> +{
> +	if (!cpu_is_omap3630())
> +		return;
> +
> +	if (!omap3_has_iva())
> +		omap_hwmod_select(&omap3xxx_iva_hwmod, false);
> +
> +	/* TBD: Need to do same for SGX. Don't see hwmod for it... */
> +}
> +
>  int __init omap3xxx_hwmod_init(void)
>  {
> +	am35xx_hwmod_only();
> +	omap35xx_hwmod_only();
> +	am37xx_hwmod_only();
> +
>  	return omap_hwmod_init(omap3xxx_hwmods);
>  }
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 73d91ee..8103a62 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -419,6 +419,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define CHIP_IS_OMAP3630ES1_1           (1 << 9)
>  #define CHIP_IS_OMAP3630ES1_2           (1 << 10)
>  #define CHIP_IS_OMAP4430ES2		(1 << 11)
> +#define CHIP_IS_AM3505			(1 << 12)
>  
>  #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
>  
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1eee85a..52b6a37 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -486,6 +486,7 @@ struct omap_hwmod_class {
>   * @omap_chip: OMAP chips this hwmod is present on
>   * @_lock: spinlock serializing operations on this hwmod
>   * @node: list node for hwmod list (internal use)
> + * @select: indicates whether hwmod is used. Used to target chip variants.
>   *
>   * @main_clk refers to this module's "main clock," which for our
>   * purposes is defined as "the functional clock needed for register
> @@ -533,6 +534,7 @@ struct omap_hwmod {
>  	u8				_state;
>  	u8				_postsetup_state;
>  	const struct omap_chip_id	omap_chip;
> +	u8				select;
>  };
>  
>  int omap_hwmod_init(struct omap_hwmod **ohs);
