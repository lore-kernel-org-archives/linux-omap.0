From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH-RESEND 2/2] OMAP: OMAP3EVM: Add LCD Backlight
 brightness hookup function
Date: Thu, 15 Apr 2010 17:14:01 +0300
Message-ID: <1271340841.2690.262.camel@tubuntu.research.nokia.com>
References: <hvaibhav@ti.com>
	 <1271340001-19831-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43507 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab0DOOON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 10:14:13 -0400
In-Reply-To: <1271340001-19831-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext hvaibhav@ti.com" <hvaibhav@ti.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 2010-04-15 at 16:00 +0200, ext hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

This looks also ok. This should go through linux-omap.

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tom

> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index f2a52c3..1d1956f 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -253,6 +253,38 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
>  	lcd_enabled = 0;
>  }
> 
> +/*
> + * PWMA/B register offsets (TWL4030_MODULE_PWMA)
> + */
> +#define TWL_LED_EN	0x0
> +#define TWL_LED_PWMON	0x0
> +#define TWL_LED_PWMOFF	0x1
> +
> +static int omap3evm_set_bl_intensity(struct omap_dss_device *dssdev, int level)
> +{
> +	unsigned char c;
> +
> +	if (level > 100)
> +		return -EINVAL;
> +	/*
> +	 * Enable LEDA for backlight
> +	 */
> +	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_EN);
> +
> +	c = ((125 * (100 - level)) / 100);
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
> +		c += 1;
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, TWL_LED_PWMOFF);
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_LED_PWMON);
> +	} else {
> +		c += 2;
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x1, TWL_LED_PWMON);
> +		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_LED_PWMOFF);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct omap_dss_device omap3_evm_lcd_device = {
>  	.name			= "lcd",
>  	.driver_name		= "sharp_ls_panel",
> @@ -260,6 +292,8 @@ static struct omap_dss_device omap3_evm_lcd_device = {
>  	.phy.dpi.data_lines	= 18,
>  	.platform_enable	= omap3_evm_enable_lcd,
>  	.platform_disable	= omap3_evm_disable_lcd,
> +	.max_backlight_level	= 100,
> +	.set_backlight		= omap3evm_set_bl_intensity,
>  };
> 
>  static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
> --
> 1.6.2.4
> 


