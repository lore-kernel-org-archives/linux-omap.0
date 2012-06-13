From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 2/5] ARM: OMAP3EVM: Adding USB internal LDOs board
 file
Date: Wed, 13 Jun 2012 11:16:23 +0300
Message-ID: <4FD84C57.5000605@compulab.co.il>
References: <zumeng.chen@gmail.com> <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com> <1339551850-20827-3-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1339551850-20827-3-git-send-email-zumeng.chen@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/13/12 04:44, Zumeng Chen wrote:
> From: Zumeng Chen <zumeng.chen@windriver.com>
> 
> EHCI PHY requires these regulators:
>         EVM Rev >=E  --> VAUX2
>         EVM Rev < E  --> VUSB1V5, VUSB1V8
> 
> Adding USB internal LDOs (vusb1v5 & vusb1v8) and VAUX2 to omap3evm
> board file. Also removing vaux2_{1/2/3} supplies as they are not
> used on omap3 evm.
> 
> But we need not to add vaux2 in twl4030_platform_data since it will
> be added conditionally.
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 0b83d0e..3c91534 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -466,6 +466,30 @@ struct wl12xx_platform_data omap3evm_wlan_data __initdata = {
>  };
>  #endif
>  
> +/* VAUX2 for USB */
> +static struct regulator_consumer_supply omap3evm_vaux2_supplies[] = {
> +	REGULATOR_SUPPLY("VDD_CSIPHY1", "omap3isp"),	/* OMAP ISP */
> +	REGULATOR_SUPPLY("VDD_CSIPHY2", "omap3isp"),	/* OMAP ISP */
> +	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
> +	{
> +		.supply		= "vaux2",
> +	}

This too can use the REGULATOR_SUPPLY() macro, why not use it?

> +};
> +
> +static struct regulator_init_data omap3evm_vaux2 = {
> +	.constraints = {
> +		.min_uV		= 2800000,
> +		.max_uV		= 2800000,
> +		.apply_uV	= true,
> +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies		= ARRAY_SIZE(omap3evm_vaux2_supplies),
> +	.consumer_supplies		= omap3evm_vaux2_supplies,
> +};
> +
>  static struct twl4030_platform_data omap3evm_twldata = {
>  	/* platform_data for children goes here */
>  	.keypad		= &omap3evm_kp_data,
> @@ -659,6 +683,9 @@ static void __init omap3_evm_init(void)
>  	omap_mux_init_gpio(63, OMAP_PIN_INPUT);
>  	omap_hsmmc_init(mmc);
>  
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> +		omap3evm_twldata.vaux2 = &omap3evm_vaux2;
> +
>  	omap3_evm_i2c_init();
>  
>  	omap_display_init(&omap3_evm_dss_data);

-- 
Regards,
Igor.
