From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 03/11] AM3517: rename the i2c boardinfo to make it more
 readable
Date: Tue, 13 Apr 2010 21:59:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E054200@dbde02.ent.ti.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
 <1271151118-12999-4-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39285 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab0DMQ3e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 12:29:34 -0400
In-Reply-To: <1271151118-12999-4-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Tuesday, April 13, 2010 3:02 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com
> Subject: [PATCH 03/11] AM3517: rename the i2c boardinfo to make it more
> readable
> 
> There are three i3c buses on am3517, 
[Hiremath, Vaibhav] Please correct the typo here.

> now rename these three boardinfo
> structure name to am3517evm_i2c1_boardinfo, am3517evm_i2c2_boardinfo,
> and am3517evm_i2c3_boardinfo, to make it more readable.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index db542b2..5abf333 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -152,7 +152,7 @@ void am3517_evm_ethernet_init(struct emac_platform_data
> *pdata)
>  	return ;
>   }
> 
> -static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
> +static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("s35390a", 0x30),
>  		.type		= "s35390a",
> @@ -182,7 +182,7 @@ static void __init am3517_evm_rtc_init(void)
>  		gpio_free(GPIO_RTCS35390A_IRQ);
>  		return;
>  	}
> -	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
> +	am3517evm_i2c1_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
>  }
> 
>  /*
> @@ -193,7 +193,7 @@ static void __init am3517_evm_rtc_init(void)
>  static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  };
> -static struct i2c_board_info __initdata am3517evm_tca6416_info_0[] = {
> +static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("tca6416", 0x21),
>  		.platform_data = &am3517evm_gpio_expander_info_0,
> @@ -207,7 +207,7 @@ static struct pca953x_platform_data
> am3517evm_ui_gpio_expander_info_1 = {
>  static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
>  };
> -static struct i2c_board_info __initdata am3517evm_ui_tca6416_info[] = {
> +static struct i2c_board_info __initdata am3517evm_i2c3_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("tca6416", 0x20),
>  		.platform_data = &am3517evm_ui_gpio_expander_info_1,
> @@ -221,10 +221,10 @@ static struct i2c_board_info __initdata
> am3517evm_ui_tca6416_info[] = {
>  static int __init am3517_evm_i2c_init(void)
>  {
>  	omap_register_i2c_bus(1, 400, NULL, 0);
> -	omap_register_i2c_bus(2, 400, am3517evm_tca6416_info_0,
> -			ARRAY_SIZE(am3517evm_tca6416_info_0));
> -	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6416_info,
> -			ARRAY_SIZE(am3517evm_ui_tca6416_info));
> +	omap_register_i2c_bus(2, 400, am3517evm_i2c2_boardinfo,
> +			ARRAY_SIZE(am3517evm_i2c2_boardinfo));
> +	omap_register_i2c_bus(3, 400, am3517evm_i2c3_boardinfo,
> +			ARRAY_SIZE(am3517evm_i2c3_boardinfo));
> 
>  	return 0;
>  }
> @@ -425,8 +425,8 @@ static void __init am3517_evm_init(void)
>  	/* RTC - S35390A */
>  	am3517_evm_rtc_init();
> 
> -	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
> -				ARRAY_SIZE(am3517evm_i2c_boardinfo));
> +	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
> +				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
>  }
[Hiremath, Vaibhav] personally I like the idea of specifying explicitly the I2C instance here which you did, I have seen other board files using slave device name while defining the I2C board info. I am not sure about whether we have any standard thing to follow here. 

Let's take opinion from other folks here; if they are ok with this approach then I think we can merge this patch.

Thanks,
Vaibhav

> 
>  static void __init am3517_evm_map_io(void)
> --
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
