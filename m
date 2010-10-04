From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCHv2 3/6] omap3: Introduce function to detect the IGEP v2
 hardware revision.
Date: Mon, 4 Oct 2010 10:19:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE345@dbde02.ent.ti.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
 <1285962353-9586-4-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52165 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab0JDEtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 00:49:22 -0400
In-Reply-To: <1285962353-9586-4-git-send-email-eballetbo@gmail.com>
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
> Subject: [PATCHv2 3/6] omap3: Introduce function to detect 
> the IGEP v2 hardware revision.
> 
> There are currently two versions of IGEP v2 board, this patch 
> introduces a
> function to detect the hardware revision of IGEP board.
> 
>   --------------------------
>  | Id. | Hw Rev. | GPIO 28  |
>   --------------------------
>  |  0  |   B/C   |   high   |
>  |  1  |   C     |   low    |
>   --------------------------
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |   47 
> ++++++++++++++++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c 
> b/arch/arm/mach-omap2/board-igep0020.c
> index 9f25d0d..a386425 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -45,6 +45,49 @@
>  #define IGEP2_GPIO_WIFI_NPD 	94
>  #define IGEP2_GPIO_WIFI_NRESET 	95
>  
> +/*
> + * IGEP2 Hardware Revision Table
> + *
> + *  --------------------------
> + * | Id. | Hw Rev. | HW0 (28) |
> + *  --------------------------
> + * |  0  |   B/C   |   high   |
> + * |  1  |   C     |   low    |
> + *  --------------------------
> + */
> +
> +#define IGEP2_BOARD_HWREV_B	0
> +#define IGEP2_BOARD_HWREV_C	1
> +
> +static u8 hwrev;
> +
> +static void __init igep2_get_revision(void)
> +{
> +	u8 ret;
> +
> +	omap_mux_init_gpio(IGEP2_GPIO_LED1_RED, OMAP_PIN_INPUT);
> +
> +	if ((gpio_request(IGEP2_GPIO_LED1_RED, "GPIO_HW0_REV") == 0) &&
> +	    (gpio_direction_input(IGEP2_GPIO_LED1_RED) == 0)) {
> +		ret = gpio_get_value(IGEP2_GPIO_LED1_RED);
> +		if (hwrev == 0) {
> +			pr_info("IGEP2: Hardware Revision C 
> (B-NON compatible)\n");
> +			hwrev = IGEP2_BOARD_HWREV_C;
> +		} else if (hwrev ==  1) {
> +			pr_info("IGEP2: Hardware Revision B/C 
> (B compatible)\n");
> +			hwrev = IGEP2_BOARD_HWREV_B;
> +		} else {
> +			pr_err("IGEP2: Unknow Hardware Revision\n");

typo - Unknow 

> +			hwrev = -1;
> +		}
> +	} else {
> +		pr_warning("IGEP2: Could not obtain gpio 
> GPIO_HW0_REV\n");
> +		pr_err("IGEP2: Unknow Hardware Revision\n");

Need both the prints?

> +	}

typo - Unknow 

> +
> +	gpio_free(IGEP2_GPIO_LED1_RED);
> +}
> +
>  #if defined(CONFIG_MTD_ONENAND_OMAP2) || \
>  	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
>  
> @@ -535,6 +578,10 @@ static struct omap_board_mux board_mux[] 
> __initdata = {
>  static void __init igep2_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +
> +	/* Get IGEP2 hardware revision */
> +	igep2_get_revision();
> +
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