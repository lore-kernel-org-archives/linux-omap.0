From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Tue, 6 Mar 2012 13:38:00 -0800
Message-ID: <20120306213800.GZ12083@atomide.com>
References: <1330994797-17298-1-git-send-email-mgherzan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59662 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758837Ab2CFViD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 16:38:03 -0500
Content-Disposition: inline
In-Reply-To: <1330994797-17298-1-git-send-email-mgherzan@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mircea Gherzan <mgherzan@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Mircea Gherzan <mgherzan@gmail.com> [120305 16:15]:
> The "uim" deamon requires sysfs entries that are filled in using
> this platform data.
> 
> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   23 +++++++++++++++++------
>  include/linux/ti_wilink_st.h           |    2 ++
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index b1d74d6..37b437f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -27,6 +27,7 @@
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
> +#include <linux/ti_wilink_st.h>
>  #include <linux/wl12xx.h>
>  
>  #include <mach/hardware.h>
> @@ -56,15 +57,29 @@
>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
>  
>  /* wl127x BT, FM, GPS connectivity chip */
> -static int wl1271_gpios[] = {46, -1, -1};
> +static struct ti_st_plat_data wilink_platform_data = {
> +        .nshutdown_gpio	= 46,
> +        .dev_name	= "/dev/ttyO1",
> +        .flow_cntrl	= 1,
> +        .baud_rate	= 3000000,
> +	.chip_enable	= NULL,
> +        .suspend	= NULL,
> +        .resume		= NULL,
> +};
> +

Please use tabs above before .xxx instead of spaces.

> +static struct platform_device btwilink_device = {
> +	.name	= "btwilink",
> +	.id	= -1,
> +};
> +
>  static struct gpio_led gpio_leds[] = {
>  	{
>  		.name			= "pandaboard::status1",
> @@ -91,10 +106,6 @@ static struct platform_device leds_gpio = {
>  	},
>  };
>  
> -static struct platform_device btwilink_device = {
> -	.name	= "btwilink",
> -	.id	= -1,
> -};

This change is probably not needed, right?

Regards,

Tony
