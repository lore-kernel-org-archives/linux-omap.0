From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP: WiLink platform data for the PandaBoard
Date: Fri, 9 Mar 2012 10:31:51 -0800
Message-ID: <20120309183150.GH12083@atomide.com>
References: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33893 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab2CISby (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 13:31:54 -0500
Content-Disposition: inline
In-Reply-To: <1331074504-22683-1-git-send-email-mgherzan@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mircea Gherzan <mgherzan@gmail.com>, Luciano Coelho <coelho@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Luca,

* Mircea Gherzan <mgherzan@gmail.com> [120306 14:23]:
> The "uim" deamon requires sysfs entries that are filled in using
> this platform data.
> 
> Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   14 ++++++++++++--
>  include/linux/ti_wilink_st.h           |    2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index b1d74d6..339e781 100644
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
> @@ -56,12 +57,21 @@
>  #define HDMI_GPIO_HPD  63 /* Hotplug detect */
>  
>  /* wl127x BT, FM, GPS connectivity chip */
> -static int wl1271_gpios[] = {46, -1, -1};
> +static struct ti_st_plat_data wilink_platform_data = {
> +	.nshutdown_gpio	= 46,
> +	.dev_name	= "/dev/ttyO1",
> +	.flow_cntrl	= 1,
> +	.baud_rate	= 3000000,
> +	.chip_enable	= NULL,
> +	.suspend	= NULL,
> +	.resume		= NULL,
> +};
> +
>  static struct platform_device wl1271_device = {
>  	.name	= "kim",
>  	.id	= -1,
>  	.dev	= {
> -		.platform_data	= &wl1271_gpios,
> +		.platform_data	= &wilink_platform_data,
>  	},
>  };
>  
> diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
> index 2ef4385..3ca0269 100644
> --- a/include/linux/ti_wilink_st.h
> +++ b/include/linux/ti_wilink_st.h
> @@ -25,6 +25,8 @@
>  #ifndef TI_WILINK_ST_H
>  #define TI_WILINK_ST_H
>  
> +#include <linux/skbuff.h>
> +
>  /**
>   * enum proto-type - The protocol on WiLink chips which share a
>   *	common physical interface like UART.
> -- 

Just checking.. Can you please take a look at this patch
and confirm that this is how things are supposed to be done?

To me passing some third driver's dev_name in pdata seems
pretty weird.. But then again maybe I just don't know how
this is supposed to work.

Regards,

Tony
