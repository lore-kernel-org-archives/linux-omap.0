From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCHv2 5/6] omap3: Add i2c eeprom driver to read EDID on IGEP
 v2.
Date: Mon, 4 Oct 2010 10:21:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE349@dbde02.ent.ti.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
 <1285962353-9586-6-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab0JDEvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 00:51:22 -0400
In-Reply-To: <1285962353-9586-6-git-send-email-eballetbo@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Enric 
> Balletbo i Serra
> Sent: Saturday, October 02, 2010 1:16 AM
> To: linux-omap@vger.kernel.org
> Cc: Enric Balletbo i Serra
> Subject: [PATCHv2 5/6] omap3: Add i2c eeprom driver to read 
> EDID on IGEP v2.
> 
> Add i2c eeprom driver to access monitor EDID binary information
> from user space, something that is required by 'decode-edid' and
> 'parse-edid'.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |   24 +++++++++++++++++-------
>  1 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c 
> b/arch/arm/mach-omap2/board-igep0020.c
> index ec7da7f..c5eaa43 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -539,7 +539,7 @@ static struct twl4030_platform_data 
> igep2_twldata = {
>  
>  };
>  
> -static struct i2c_board_info __initdata igep2_i2c_boardinfo[] = {
> +static struct i2c_board_info __initdata igep2_i2c1_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("twl4030", 0x48),
>  		.flags		= I2C_CLIENT_WAKE,
> @@ -548,13 +548,23 @@ static struct i2c_board_info __initdata 
> igep2_i2c_boardinfo[] = {
>  	},
>  };
>  
> +static struct i2c_board_info __initdata igep2_i2c3_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("eeprom", 0x50),
> +	},
> +};
> +
>  static int __init igep2_i2c_init(void)
>  {
> -	omap_register_i2c_bus(1, 2600, igep2_i2c_boardinfo,
> -			ARRAY_SIZE(igep2_i2c_boardinfo));
> -	/* Bus 3 is attached to the DVI port where devices like 
> the pico DLP
> -	 * projector don't work reliably with 400kHz */
> -	omap_register_i2c_bus(3, 100, NULL, 0);
> +	omap_register_i2c_bus(1, 2600, igep2_i2c1_boardinfo,
> +			ARRAY_SIZE(igep2_i2c1_boardinfo));

Check for return value.

> +	/*
> +	 * Bus 3 is attached to the DVI port where devices like 
> the pico DLP
> +	 * projector don't work reliably with 400kHz
> +	 */
> +	omap_register_i2c_bus(3, 100, igep2_i2c3_boardinfo,
> +			 ARRAY_SIZE(igep2_i2c3_boardinfo));

Check for return value.

> +
>  	return 0;
>  }
>  
> @@ -631,7 +641,7 @@ static void __init igep2_init(void)
>  
>  	/* Get IGEP2 hardware revision */
>  	igep2_get_revision();
> -
> +	/* Register I2C busses and drivers */
>  	igep2_i2c_init();
>  	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
>  	omap_serial_init();
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 