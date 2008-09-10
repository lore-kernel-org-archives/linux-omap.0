From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Wed, 10 Sep 2008 10:46:08 -0700
Message-ID: <20080910174607.GC21163@atomide.com>
References: <1220841751.28777.9.camel@localhost> <1220844597.28777.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56656 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYIJRqM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 13:46:12 -0400
Content-Disposition: inline
In-Reply-To: <1220844597.28777.12.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* stanley.miao <stanley.miao@windriver.com> [080907 20:28]:
> Prune off a empty line.
> 
> Fix omapfb's problem on OMAP3430sdp.

Pushing today.

Tony

> 
> ---
>  drivers/video/omap/lcd_2430sdp.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_2430sdp.c
> b/drivers/video/omap/lcd_2430sdp.c
> index 9af6cd0..b456e02 100644
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
> @@ -82,6 +87,13 @@ static int sdp2430_panel_enable(struct lcd_panel
> *panel)
>  		ded_val = ENABLE_VAUX3_DEDICATED;
>  		grp_reg = TWL4030_VAUX3_DEV_GRP;
>  		grp_val = ENABLE_VAUX3_DEV_GRP;
> +
> +		if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
> +					TWL4030_VPLL2_DEDICATED);
> +			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
> +					TWL4030_VPLL2_DEV_GRP);
> +		}
>  	} else {
>  		ded_reg = TWL4030_VAUX2_DEDICATED;
>  		ded_val = ENABLE_VAUX2_DEDICATED;
> @@ -104,6 +116,11 @@ static void sdp2430_panel_disable(struct lcd_panel
> *panel)
>  {
>  	omap_set_gpio_dataout(enable_gpio, 0);
>  	omap_set_gpio_dataout(backlight_gpio, 0);
> +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> +		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
> +		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
> +		mdelay(4);
> +	}
>  }
>  
>  static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
> -- 
> 1.5.6.3
> 
