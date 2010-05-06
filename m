From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 17/18] omap: rx51: Add supplies for the tlv320aic3x
 codec driver
Date: Thu, 6 May 2010 09:57:16 +0300
Message-ID: <20100506065716.GA16262@besouro.research.nokia.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
 <20100505193323.21568.32626.stgit@baageli.muru.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55567 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0EFGzB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 02:55:01 -0400
Content-Disposition: inline
In-Reply-To: <20100505193323.21568.32626.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>

Hello Jarkko,

Just minor comments on this one, sorry for being late for that.

On Wed, May 05, 2010 at 09:33:23PM +0200, ext Tony Lindgren wrote:
> From: Jarkko Nikula <jhnikula@gmail.com>
> 
> Upcoming change to tlv320aic3x codec driver require four supplies.
> Implement this by connecting analogic supplies to TWL4030 VMMC2 and digital
> supplies to TWL4030 VIO.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   60 +++++++++++++++++++++++---
>  1 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 3addfe6..8179d55 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -277,7 +277,7 @@ static struct regulator_consumer_supply rx51_vmmc1_supply = {
>  	.dev_name = "mmci-omap-hs.0",
>  };
>  
> -static struct regulator_consumer_supply rx51_vmmc2_supply = {
> +static struct regulator_consumer_supply rx51_vaux3_supply = {
>  	.supply   = "vmmc",
>  	.dev_name = "mmci-omap-hs.1",
>  };
> @@ -287,6 +287,35 @@ static struct regulator_consumer_supply rx51_vsim_supply = {
>  	.dev_name = "mmci-omap-hs.1",
>  };
>  
> +static struct regulator_consumer_supply rx51_vmmc2_supplies[] = {
> +	/* tlv320aic3x analog supplies */
> +	{
> +		.supply		= "AVDD",
> +		.dev_name	= "2-0018",
> +	},
> +	{
> +		.supply		= "DRVDD",
> +		.dev_name	= "2-0018",
> +	},
> +	/* Keep vmmc as last item. It is not iterated for newer boards */
> +	{
> +		.supply		= "vmmc",
> +		.dev_name	= "mmci-omap-hs.1",
> +	},
> +};
> +
> +static struct regulator_consumer_supply rx51_vio_supplies[] = {
> +	/* tlv320aic3x digital supplies */
> +	{
> +		.supply		= "IOVDD",
> +		.dev_name	= "2-0018"
> +	},
> +	{
> +		.supply		= "DVDD",
> +		.dev_name	= "2-0018"
> +	},
> +};


This isn't mandatory, but I find the code more readable if you use the REGULATOR_SUPPLY macro,
which kinda suitable for cases like yours, where you are passing the pair supply&dev_name.
> +
>  static struct regulator_init_data rx51_vaux1 = {
>  	.constraints = {
>  		.name			= "V28",
> @@ -338,7 +367,7 @@ static struct regulator_init_data rx51_vaux3_mmc = {
>  					| REGULATOR_CHANGE_STATUS,
>  	},
>  	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &rx51_vmmc2_supply,
> +	.consumer_supplies	= &rx51_vaux3_supply,
>  };
>  
>  static struct regulator_init_data rx51_vaux4 = {
> @@ -380,8 +409,8 @@ static struct regulator_init_data rx51_vmmc2 = {
>  					| REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &rx51_vmmc2_supply,
> +	.num_consumer_supplies	= ARRAY_SIZE(rx51_vmmc2_supplies),
> +	.consumer_supplies	= rx51_vmmc2_supplies,
>  };
>  
>  static struct regulator_init_data rx51_vsim = {
> @@ -411,6 +440,20 @@ static struct regulator_init_data rx51_vdac = {
>  	},
>  };
>  
> +static struct regulator_init_data rx51_vio = {
> +	.constraints = {
> +		.min_uV			= 1800000,
> +		.max_uV			= 1800000,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE

I'm not sure if we would ever change voltage level in VIO in rx51 case.
It could enter sleep mode. But even there it wouldn't change voltage level.
Except, of cource, during off mode transition. But then, the regfw wouldn't care.


> +					| REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies	= ARRAY_SIZE(rx51_vio_supplies),
> +	.consumer_supplies	= rx51_vio_supplies,
> +};
> +
>  static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
>  {
>  	/* FIXME this gpio setup is just a placeholder for now */
> @@ -618,6 +661,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
>  	.vmmc1			= &rx51_vmmc1,
>  	.vsim			= &rx51_vsim,
>  	.vdac			= &rx51_vdac,
> +	.vio			= &rx51_vio,
>  };
>  
>  static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_1[] = {
> @@ -638,12 +682,14 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
>  static int __init rx51_i2c_init(void)
>  {
>  	if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
> -	    system_rev >= SYSTEM_REV_B_USES_VAUX3)
> +	    system_rev >= SYSTEM_REV_B_USES_VAUX3) {
>  		rx51_twldata.vaux3 = &rx51_vaux3_mmc;
> -	else {
> +		/* Only older boards use VMMC2 for internal MMC */
> +		rx51_vmmc2.num_consumer_supplies--;
> +	} else {
>  		rx51_twldata.vaux3 = &rx51_vaux3_cam;
> -		rx51_twldata.vmmc2 = &rx51_vmmc2;
>  	}
> +	rx51_twldata.vmmc2 = &rx51_vmmc2;
>  	omap_register_i2c_bus(1, 2200, rx51_peripherals_i2c_board_info_1,
>  			      ARRAY_SIZE(rx51_peripherals_i2c_board_info_1));
>  	omap_register_i2c_bus(2, 100, rx51_peripherals_i2c_board_info_2,
> 
