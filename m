From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 3/3] Regulator: Added board-dependent code for TPS65023
Date: Mon, 18 May 2009 17:52:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A13F4@dbde02.ent.ti.com>
References: <1241795536-15758-1-git-send-email-anuj.aggarwal@ti.com>
 <20090508201503.GA11873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbZERMXM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:23:12 -0400
In-Reply-To: <20090508201503.GA11873@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Pillai, Manikandan" <mani.pillai@ti.com>

> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk]
> Sent: Saturday, May 09, 2009 1:45 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; lrg@slimlogic.co.uk
> Subject: Re: [PATCH 3/3] Regulator: Added board-dependent code for
> TPS65023
> 
> On Fri, May 08, 2009 at 08:42:16PM +0530, Anuj Aggarwal wrote:
> > Added OMAP3 EVM specific code for TPS65023 in pmic.c file.
> >
> > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> 
> CCing in Liam again.
> 
> > ---
> >  drivers/regulator/pmic.c |   92
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 92 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/regulator/pmic.c b/drivers/regulator/pmic.c
> > index 36ed341..6e7276a 100644
> > --- a/drivers/regulator/pmic.c
> > +++ b/drivers/regulator/pmic.c
> > @@ -29,6 +29,96 @@
> >  /*
> >   * Definitions specific to TPS65023
> >   */
> > +#if defined(CONFIG_OMAP3EVM_TPS65023)
> > +/* MPU voltage regulator of DCDC type */
> > +struct regulator_consumer_supply tps65023_mpu_consumers = {
> > +	.supply = "vdd1",
> > +};
> 
> This comes back to my questions about pmic.c but I'd expect this all to
> appear in the OMAP3 EVM code.
[Aggarwal, Anuj] Same reason given in my other email. Just to avoid duplication of the code, I have created this file and moved all the code from board-*.c to this place.
The same file will be populated for other PMICs, coming on OMAP based platforms in future.
> 
> > +
> > +/* CORE voltage regulator of DCDC type */
> > +struct regulator_consumer_supply tps65023_core_consumers = {
> > +	.supply = "vdd2",
> > +};
> > +
> > +/* SRAM/MEM/WKUP_BG voltage regulator of DCDC type */
> > +struct regulator_consumer_supply tps65023_vdds_consumers = {
> > +	.supply = "vdds",
> > +};
> > +
> > +/* DPLL voltage regulator of LDO type */
> > +struct regulator_consumer_supply tps65023_dpll_consumers = {
> > +	.supply = "dpll",
> > +};
> > +
> > +/* MMC voltage regulator of LDO type */
> > +struct regulator_consumer_supply tps65023_mmc_consumers = {
> > +	.supply = "mmc",
> > +};
> > +
> > +struct regulator_init_data tps65023_regulator_data[] = {
> > +	{
> > +		.constraints = {
> > +			.min_uV = 800000,
> > +			.max_uV = 1600000,
> > +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> > +				REGULATOR_CHANGE_STATUS),
> > +			.boot_on = 1,
> > +		},
> > +		.num_consumer_supplies  = 1,
> > +		.consumer_supplies      = &tps65023_mpu_consumers,
> > +	},
> > +	{
> > +		.constraints = {
> > +			.min_uV = 1800000,
> > +			.max_uV = 3300000,
> > +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +			.boot_on = 1,
> > +		},
> > +		.num_consumer_supplies  = 1,
> > +		.consumer_supplies      = &tps65023_core_consumers,
> > +	},
> > +	{
> > +		.constraints = {
> > +			.min_uV = 1800000,
> > +			.max_uV = 3300000,
> > +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > +			.boot_on = 1,
> > +		},
> > +		.num_consumer_supplies  = 1,
> > +		.consumer_supplies      = &tps65023_vdds_consumers,
> > +	},
> > +	{
> > +		.constraints = {
> > +			.min_uV = 1000000,
> > +			.max_uV = 3150000,
> > +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> > +				REGULATOR_CHANGE_STATUS),
> > +			.boot_on = 1,
> > +		},
> > +		.num_consumer_supplies  = 1,
> > +		.consumer_supplies      = &tps65023_dpll_consumers,
> > +	},
> > +	{
> > +		.constraints = {
> > +			.min_uV = 1050000,
> > +			.max_uV = 3300000,
> > +			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
> > +				REGULATOR_CHANGE_STATUS),
> > +			.boot_on = 1,
> > +		},
> > +		.num_consumer_supplies  = 1,
> > +		.consumer_supplies      = &tps65023_mmc_consumers,
> > +	},
> > +};
> > +
> > +static struct i2c_board_info __initdata board_tps65023_instances[] = {
> > +	{
> > +		I2C_BOARD_INFO("tps65023", 0x48),
> > +		.flags = I2C_CLIENT_WAKE,
> > +		.platform_data = &tps65023_regulator_data[0],
> > +	},
> > +};
> > +#endif
> >
> >  static int flag_pmic_twl4030;
> >  static int flag_pmic_tps6235x;
> > @@ -96,6 +186,8 @@ int pmic_init(void)
> >
> >  #if defined(CONFIG_OMAP3EVM_TPS65023)
> >  	/* do stuff specific to TPS65023 */
> > +	omap_register_i2c_bus(1, 400, board_tps65023_instances,
> > +		ARRAY_SIZE(board_tps65023_instances));
> >  #endif
> >
> >  	return 0;
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> "You grabbed my hand and we fell into it, like a daydream - or a fever."

