From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 5/7] mfd: TWL4030: changes for TRITON Errata 27 workaround
Date: Mon, 07 Mar 2011 13:14:36 -0800
Message-ID: <87bp1m4oqr.fsf@ti.com>
References: <1299072653-13414-1-git-send-email-leslyam@ti.com>
	<1299072653-13414-6-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49876 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab1CGVOn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 16:14:43 -0500
Received: by pwi3 with SMTP id 3so820681pwi.9
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 13:14:39 -0800 (PST)
In-Reply-To: <1299072653-13414-6-git-send-email-leslyam@ti.com> (Lesly A. M.'s
	message of "Wed, 2 Mar 2011 19:00:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Lesly,

Lesly A M <leslyam@ti.com> writes:

> Workaround for TWL5030 Silicon Errata 27 & 28:
> 	27 - VDD1, VDD2, may have glitches when their output value is updated.
> 	28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock
> 		is switched from internal to external.
>
> Errata 27:
> 	If the DCDC regulators is running on their internal oscillator,
> 	negative glitches may occur on VDD1, VDD2 output when voltage is changed.
> 	The OMAP device may reboot if the VDD1 or VDD2 go below the
> 	core minimum operating voltage.
>
> 	WORKAROUND
> 	Set up the TWL5030 DC-DC power supplies to use the HFCLKIN instead of
> 	the internal oscillator.
>
> Errata 28:
> 	VDD1/VDD2 clock system may hang during switching the clock source from
> 	internal oscillator to external. VDD1/VDD2 output voltages may collapse
> 	if clock stops.
>
> 	WORKAROUND
> 	If HFCLK is disabled in OFFMODE, modify the sleep/wakeup sequence and
> 	setuptimes to make sure the switching will happen only when HFCLKIN is stable.
> 	Also use the TWL5030 watchdog to safeguard the first switching from
> 	internal oscillator to HFCLKIN during the TWL5030 init.
>
> 	IMPACT
> 	power sequence is changed.
> 	sleep/wakeup time values will be changed.
>
> The workaround changes are called from twl4030_power_init(), since we have to
> make some i2c_read calls to check the TRITON version & the i2c will not be
> initialized in the early stage.
>
> This workaround is required for TWL5030 Silicon version less than ES1.2
> The power script & setup time changes are recommended by TI HW team.
>
> http://omapedia.org/wiki/TWL4030_power_scripts
>
> Changes taken from TRITON Errata27 workaround patch by Nishanth Menon.
>
> Signed-off-by: Lesly A M <leslyam@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Some minor comments below,

> ---
>  arch/arm/mach-omap2/twl4030.c |  114 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/twl4030-power.c   |   64 +++++++++++++++++++++++
>  include/linux/i2c/twl.h       |    1 +
>  3 files changed, 179 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/twl4030.c b/arch/arm/mach-omap2/twl4030.c
> index ff344b3..87de049 100644
> --- a/arch/arm/mach-omap2/twl4030.c
> +++ b/arch/arm/mach-omap2/twl4030.c
> @@ -137,9 +137,123 @@ static struct twl4030_resconfig twl4030_rconfig[] = {
>  	{ 0, 0},
>  };
>  
> +/*
> + * Active to Sleep sequence, which is executed upon P1/P2/P3
> + * transition for sleep.
> + *
> + * The sleep sequence is adjusted to do the switching of VDD1/VDD2/VIO OSC from
> + * HFCLKIN to internal oscillator when the HFCLKIN is stable.
> + */
> +static struct twl4030_ins __initdata sleep_on_seq_errata27[] = {
> +	/*
> +	 * Singular message to disable HCLKOUT.
> +	 * Wait for ~488.32 uS to do the switching of VDD1/VDD2/VIO OSC from
> +	 * HFCLKIN to internal oscillator before disabling HFCLKIN.
> +	 */
> +	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_SLEEP), 20},
> +	/* Broadcast message to put res(TYPE2 = 1) to sleep */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_SLEEP), 2},
> +	/* Broadcast message to put res(TYPE2 = 2) to sleep, disable HFCLKIN */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_SLEEP), 2},
> +};
> +
> +static struct twl4030_script sleep_on_script_errata27 __initdata = {
> +	.script	= sleep_on_seq_errata27,
> +	.size	= ARRAY_SIZE(sleep_on_seq_errata27),
> +	.flags	= TWL4030_SLEEP_SCRIPT,
> +};
> +
> +/*
> + * Sleep to Active sequence, which is executed upon P1/P2/P3
> + * transition for wakeup.
> + *
> + * The wakeup sequence is adjusted to do the VDD1/VDD2 voltage rampup
> + * only after HFCLKIN is stabilized and the HFCLKOUT is enabled.
> + */
> +static struct twl4030_ins wakeup_seq_errata27[] __initdata = {
> +	/*
> +	 * Broadcast message to put res(TYPE2 = 2) to active.
> +	 * Wait for ~10 mS (rampup time for OSC on the board)
> +	 * after HFCLKIN is enabled
> +	 */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE), 55},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE), 55},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE), 54},
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R2,
> +							RES_STATE_ACTIVE), 1},
> +	/* Singular message to enable HCLKOUT after HFCLKIN is stabilized */
> +	{MSG_SINGULAR(DEV_GRP_NULL, RES_HFCLKOUT, RES_STATE_ACTIVE), 1},
> +	/*
> +	 * Broadcast message to put res(TYPE2 = 1) to active.
> +	 * VDD1/VDD2 rampup after HFCLKIN is stable and HFCLKOUT is enabled.
> +	 */
> +	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_R0, RES_TYPE2_R1,
> +							RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wakeup_script_errata27 __initdata = {
> +	.script	= wakeup_seq_errata27,
> +	.size	= ARRAY_SIZE(wakeup_seq_errata27),
> +	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
> +};
> +
> +/* TRITON script for sleep, wakeup & warm_reset */
> +static struct twl4030_script *twl4030_scripts_errata27[] __initdata = {
> +	&sleep_on_script_errata27,
> +	&wakeup_script_errata27,
> +	&wrst_script,
> +};
> +
> +/*
> + * VDD1/VDD2/VPLL are assigned to P1 and P3, to have better control
> + * during OFFMODE. HFCLKOUT is assigned to P1 and P3 (*p2) to turn off
> + * only during OFFMODE.
> + * (*P2 is included if the platform uses it for modem/some other processor)
> + */
> +static struct twl4030_resconfig twl4030_rconfig_errata27[] = {
> +	{ .resource = RES_VPLL1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VINTANA1, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTANA2, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VINTDIG, .devgroup = DEV_GRP_ALL, .type = 1,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VIO, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 4, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 3, .type2 = 1, .remap_sleep = RES_STATE_OFF },
> +	{ .resource = RES_REGEN, .devgroup = DEV_GRP_ALL, .type = 2,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_NRES_PWRON, .devgroup = DEV_GRP_ALL, .type = 0,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_CLKEN, .devgroup = DEV_GRP_ALL, .type = 3,
> +		.type2 = 2, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_SYSEN, .devgroup = DEV_GRP_ALL, .type = 6,
> +		.type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P1 | DEV_GRP_P3,
> +		.type = 0, .type2 = 1, .remap_sleep = RES_STATE_SLEEP },
> +	{ 0, 0},
> +};
> +
> +void twl5030_script_errata27(void)

static

> +{
> +	twl4030_generic_script.scripts = twl4030_scripts_errata27;
> +	twl4030_generic_script.num = ARRAY_SIZE(twl4030_scripts_errata27);
> +	twl4030_generic_script.resource_config = twl4030_rconfig_errata27;
> +}
> +
>  struct twl4030_power_data __initdata twl4030_generic_script = {
>  	.scripts	= twl4030_scripts,
>  	.num		= ARRAY_SIZE(twl4030_scripts),
>  	.resource_config = twl4030_rconfig,
> +	.twl5030_errata27wa_script = twl5030_script_errata27,
>  };
>  #endif
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 8373d79..db24d09 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -63,6 +63,14 @@ static u8 twl4030_start_script_address = 0x2b;
>  #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
>  #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
>  
> +#define R_VDD1_OSC		0x5C
> +#define R_VDD2_OSC		0x6A
> +#define R_VIO_OSC		0x52
> +#define EXT_FS_CLK_EN		(0x1 << 6)
> +

BIT(6)

> +#define R_WDT_CFG		0x03
> +#define WDT_WRK_TIMEOUT		0x03
> +
>  /* resource configuration registers
>     <RESOURCE>_DEV_GRP   at address 'n+0'
>     <RESOURCE>_TYPE      at address 'n+1'
> @@ -511,6 +519,53 @@ int twl4030_remove_script(u8 flags)
>  	return err;
>  }
>  
> +/**
> + * twl_errata27_workaround() - Workaround for TWL5030 Silicon Errata 27 & 28:
> + * 27 - VDD1, VDD2, may have glitches when their output value is updated.
> + * 28 - VDD1 and / or VDD2 DCDC clock may stop working when internal clock is
> + * switched from internal to external.
> + *
> + * Workaround requires the TWL DCDCs to use HFCLK instead of
> + * internal oscillator. Also enable TWL watchdog before switching the osc
> + * to recover if the VDD1/VDD2 stop working.
> + */
> +static void __init twl_errata27_workaround(void)
> +{
> +	u8 val;
> +	u8 smps_osc_reg[] = {R_VDD1_OSC, R_VDD2_OSC, R_VIO_OSC};
> +	u8 wdt_counter_val = 0;
> +	int i;
> +	int err;
> +
> +	/* Setup the twl wdt to take care of borderline failure case */
> +	err = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &wdt_counter_val,
> +			R_WDT_CFG);
> +	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, WDT_WRK_TIMEOUT,
> +			R_WDT_CFG);
> +
> +	for (i = 0; i < sizeof(smps_osc_reg); i++) {
> +		err |= twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &val,
> +							smps_osc_reg[i]);
> +		val |= EXT_FS_CLK_EN;
> +		err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
> +							smps_osc_reg[i]);
> +	}
> +
> +	/* restore the original value */
> +	err |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, wdt_counter_val,
> +			R_WDT_CFG);
> +	if (err)
> +		pr_warning("TWL4030: workaround setup failed!\n");
> +}
> +
> +bool is_twl5030_errata27wa_required(void)

static

> +{
> +	if (twl_get_si_type() == TWL_SIL_5030)
> +		return (twl_get_si_version() < TWL5030_REV_1_2);
> +
> +	return 0;
> +}
> +
>  void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
>  {
>  	int err = 0;
> @@ -530,6 +585,15 @@ void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
>  	if (err)
>  		goto unlock;
>  
> +	/* Applying TWL5030 Errata 27 WA based on Si revision &
> +	 * flag updated from board file*/
> +	if (is_twl5030_errata27wa_required()) {
> +		pr_info("TWL5030: Enabling workaround for Si Errata 27\n");
> +		twl_errata27_workaround();
> +		if (twl4030_scripts->twl5030_errata27wa_script)
> +			twl4030_scripts->twl5030_errata27wa_script();
> +	}
> +
>  	for (i = 0; i < twl4030_scripts->num; i++) {
>  		err = load_twl4030_script(twl4030_scripts->scripts[i], address);
>  		if (err)
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index d3cc2ac..d114229 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -672,6 +672,7 @@ struct twl4030_power_data {
>  	struct twl4030_script **scripts;
>  	unsigned num;
>  	struct twl4030_resconfig *resource_config;
> +	void (*twl5030_errata27wa_script)(void);
>  #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
>  };

Kevin
