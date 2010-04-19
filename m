From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH 4/9] AM3517: Add platform init code for regulator driver
Date: Mon, 19 Apr 2010 21:50:37 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03228A270A@dbde02.ent.ti.com>
References: <1271672447-3639-1-git-send-email-stanley.miao@windriver.com>
 <1271672447-3639-5-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58073 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab0DSQUo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 12:20:44 -0400
In-Reply-To: <1271672447-3639-5-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Monday, April 19, 2010 3:51 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hiremath, Vaibhav; Govindarajan, Sriramakrishnan
> Subject: [PATCH 4/9] AM3517: Add platform init code for regulator driver
> 
> Add platform init code for regulator driver.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |  122
> +++++++++++++++++++++++++++++++++
>  1 files changed, 122 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index 3acfcae..41f766c 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c/pca953x.h>
> +#include <linux/regulator/machine.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/am35xx.h>
> @@ -46,6 +47,122 @@ static struct i2c_board_info __initdata
> am3517evm_i2c1_boardinfo[] = {
>  	},
>  };
> 
> +/* TPS65023 specific initialization */
> +/* VDCDC1 -> VDD_CORE */
> +static struct regulator_consumer_supply am3517_evm_vdcdc1_supplies[] = {
> +	{
> +		.supply = "vdd_core",
> +	},
> +};
> +
> +/* VDCDC2 -> VDDSHV */
> +static struct regulator_consumer_supply am3517_evm_vdcdc2_supplies[] = {
> +	{
> +		.supply = "vddshv",
> +	},
> +};
> +
> +/* VDCDC2 |-> VDDS
> +	   |-> VDDS_SRAM_CORE_BG
> +	   |-> VDDS_SRAM_MPU */
> +static struct regulator_consumer_supply am3517_evm_vdcdc3_supplies[] = {
> +	{
> +		.supply = "vdds",
> +	},
> +	{
> +		.supply = "vdds_sram_core_bg",
> +	},
> +	{
> +		.supply = "vdds_sram_mpu",
> +	},
> +};
> +
> +/* LDO1 |-> VDDA1P8V_USBPHY
> +	 |-> VDDA_DAC */
> +static struct regulator_consumer_supply am3517_evm_ldo1_supplies[] = {
> +	{
> +		.supply = "vdda1p8v_usbphy",
> +	},
> +	{
> +		.supply = "vdda_dac",
> +	},
> +};
> +
> +/* LDO2 -> VDDA3P3V_USBPHY */
> +static struct regulator_consumer_supply am3517_evm_ldo2_supplies[] = {
> +	{
> +		.supply = "vdda3p3v_usbphy",
> +	},
> +};
> +
> +static struct regulator_init_data am3517_evm_regulator_data[] = {
> +	/* DCDC1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1200000,
> +			.max_uV = 1200000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies =
> ARRAY_SIZE(am3517_evm_vdcdc1_supplies),
> +		.consumer_supplies = am3517_evm_vdcdc1_supplies,
> +	},
> +	/* DCDC2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies =
> ARRAY_SIZE(am3517_evm_vdcdc2_supplies),
> +		.consumer_supplies = am3517_evm_vdcdc2_supplies,
> +	},
> +	/* DCDC3 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies =
> ARRAY_SIZE(am3517_evm_vdcdc3_supplies),
> +		.consumer_supplies = am3517_evm_vdcdc3_supplies,
> +	},
> +	/* LDO1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_ldo1_supplies),
> +		.consumer_supplies = am3517_evm_ldo1_supplies,
> +	},
> +	/* LDO2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_evm_ldo2_supplies),
> +		.consumer_supplies = am3517_evm_ldo2_supplies,
> +	},
> +};
> +
>  /*
>   * RTC - S35390A
>   */
> @@ -103,6 +220,11 @@ static struct i2c_board_info __initdata
> am3517evm_i2c3_boardinfo[] = {
>  		I2C_BOARD_INFO("tca6416", 0x21),
>  		.platform_data = &am3517evm_ui_gpio_expander_info_2,
>  	},
> +	{
> +		I2C_BOARD_INFO("tps65023", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &am3517_evm_regulator_data[0],
> +	},
>  };
> 
>  static int __init am3517_evm_i2c_init(void)

[Aggarwal, Anuj] I can see an exactly same patch at:

http://arago-project.org/git/projects/?p=linux-omap3.git;a=commit;h=4ff9cb47c50dc6df362702ad3ae69b70de098372 

(Commit id 4ff9cb47c on http://arago-project.org/git/projects/?p=linux-omap3.git) 

Can you help me understand what changes you have done in this patch?

Please make sure that you give due credit to the original owner of 
the patch on basis of which you are deriving/submitting your patches.

