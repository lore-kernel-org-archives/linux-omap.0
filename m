From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Tue, 2 Sep 2008 10:03:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02C418CAB7@dbde02.ent.ti.com>
References: <1220276228.2680.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33542 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbYIBEdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 00:33:25 -0400
In-Reply-To: <1220276228.2680.9.camel@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao@windriver.com" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of stanley.miao
>
> In RGB565 mode, red and blue color are filtered, so the picture on LCD
> looks green and dark.
> 
> Fix omapfb's problem on OMAP3430sdp.
> 
> Signed-off-by: Stanley Miao <stanley.miao@windriver.com>

Tested by me. I get a nice penguin. But no blue background that I
usually see on TI kernels. I have no expertise on this, so this is
just an observation.

Regards,
Anand

> 
> ---
> diff --git a/drivers/video/omap/lcd_2430sdp.c
> b/drivers/video/omap/lcd_2430sdp.c
> index 9af6cd0..896a236 100644
> --- a/drivers/video/omap/lcd_2430sdp.c
> +++ b/drivers/video/omap/lcd_2430sdp.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/delay.h>
>  #include <linux/i2c/twl4030.h>
>  
>  #include <mach/gpio.h>
> @@ -45,6 +46,10 @@ static unsigned enable_gpio;
>  #define ENABLE_VAUX3_DEDICATED	0x03
>  #define ENABLE_VAUX3_DEV_GRP	0x20
>  
> +#define ENABLE_VPLL2_DEDICATED          0x05
> +#define ENABLE_VPLL2_DEV_GRP            0xE0
> +#define TWL4030_VPLL2_DEV_GRP           0x33
> +#define TWL4030_VPLL2_DEDICATED         0x36
>  
>  #define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
>  
> @@ -76,6 +81,11 @@ static int sdp2430_panel_enable(struct lcd_panel
> *panel)
>  {
>  	u8 ded_val, ded_reg;
>  	u8 grp_val, grp_reg;
> +	
> +	if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
> +		t2_out(PM_RECEIVER, 
> ENABLE_VPLL2_DEDICATED,TWL4030_VPLL2_DEDICATED);
> +		t2_out(PM_RECEIVER, 
> ENABLE_VPLL2_DEV_GRP,TWL4030_VPLL2_DEV_GRP);
> +	}
>  
>  	if (machine_is_omap_3430sdp()) {
>  		ded_reg = TWL4030_VAUX3_DEDICATED;
> @@ -104,6 +114,11 @@ static void sdp2430_panel_disable(struct 
> lcd_panel
> *panel)
>  {
>  	omap_set_gpio_dataout(enable_gpio, 0);
>  	omap_set_gpio_dataout(backlight_gpio, 0);
> +	if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
> +		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
> +		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
> +		mdelay(4);
> +	}
>  }
>  
>  static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 