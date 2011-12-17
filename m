From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAPDSS: HDMI: HPD support in boardfile
Date: Fri, 16 Dec 2011 17:34:48 -0800
Message-ID: <20111217013448.GE6464@atomide.com>
References: <1323782698-24428-1-git-send-email-mythripk@ti.com>
 <1323782698-24428-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56039 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab1LQBeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 20:34:50 -0500
Content-Disposition: inline
In-Reply-To: <1323782698-24428-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* mythripk@ti.com <mythripk@ti.com> [111213 05:01]:
> From: Mythri P K <mythripk@ti.com>
> 
> Add support for HPD GPIO configuration in board file.
> Also remove the enabling  of GPIO's required for HDMI from
> hdmi driver file to display.c based on the GPIO #'s sent from
> board file.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>

Few cosmetic comments below, otherwise this one looks OK
for Tomi to queue when he's happy with it:

Acked-by: Tony Lindgren <tony@atomide.com>

> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -52,8 +52,9 @@
>  #define ETH_KS8851_QUART		138
>  #define OMAP4_SFH7741_SENSOR_OUTPUT_GPIO	184
>  #define OMAP4_SFH7741_ENABLE_GPIO		188
> -#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
> +#define HDMI_GPIO_CT_CP_HPD 60 /* Hot plug pin for HDMI */
>  #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
> +#define HDMI_GPIO_HPD 63
>  #define DISPLAY_SEL_GPIO	59	/* LCD2/PicoDLP switch */
>  #define DLP_POWER_ON_GPIO	40
>  
> @@ -596,27 +597,11 @@ static void __init omap_sfh7741prox_init(void)
>  }
>  
>  static struct gpio sdp4430_hdmi_gpios[] = {
> -	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
> -	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
> +	{HDMI_GPIO_CT_CP_HPD,  GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ct_cp_hpd" },
> +	{HDMI_GPIO_LS_OE,      GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ls_oe" },
> +	{HDMI_GPIO_HPD,  GPIOF_DIR_IN,    "hdmi_gpio_hpd" },
>  };

Please add the trailing comma to the array entries. Also check the
spacing, now there's no space in the beginning but one at the end?
  
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -51,8 +51,9 @@
>  #define GPIO_HUB_NRESET		62
>  #define GPIO_WIFI_PMENA		43
>  #define GPIO_WIFI_IRQ		53
> -#define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
> +#define HDMI_GPIO_CT_CP_HPD 60 /* Hot plug pin for HDMI */
>  #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
> +#define HDMI_GPIO_HPD 63
>  
>  /* wl127x BT, FM, GPS connectivity chip */
>  static int wl1271_gpios[] = {46, -1, -1};
> @@ -479,35 +480,17 @@ int __init omap4_panda_dvi_init(void)
>  }
>  
>  static struct gpio panda_hdmi_gpios[] = {
> -	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
> -	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
> +	{HDMI_GPIO_CT_CP_HPD,  GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ct_cp_hpd" },
> +	{HDMI_GPIO_LS_OE,      GPIOF_OUT_INIT_HIGH,    "hdmi_gpio_ls_oe" },
> +	{HDMI_GPIO_HPD,  GPIOF_DIR_IN,    "hdmi_gpio_hpd" },
>  };

Here too.
  
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -29,6 +29,7 @@
>  #include <plat/omap-pm.h>
>  #include <plat/common.h>
>  
> +#include <linux/gpio.h>
>  #include "mux.h"
>  #include "control.h"
>  #include "display.h"

This one will cause a merge conflict with common.h, but Tomi
already knows how to deal with that ;)

Regards,

Tony
