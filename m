From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 4/5] OMAP4: Panda: Update panda board file to use DT
Date: Wed, 6 Jul 2011 13:01:24 -0600
Message-ID: <20110706190124.GM4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45347 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab1GFTB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 15:01:27 -0400
Received: by pzk9 with SMTP id 9so197166pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 12:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309426647-31587-5-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jun 30, 2011 at 03:07:26PM +0500, G, Manjunath Kondaiah wrote:
> 
> The OMAP4 panda board file is updated to use i2c nodes from device
> tree data structures.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index c9d1e13..b3151a0 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -22,12 +22,15 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/leds.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
>  #include <linux/gpio.h>
>  #include <linux/usb/otg.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/wl12xx.h>
> +#include <linux/irq.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/omap4-common.h>
> @@ -410,6 +413,7 @@ static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
>  static int __init omap4_panda_i2c_init(void)
>  {
>  	omap4_pmic_init("twl6030", &omap4_panda_twldata);
> +#if !defined(CONFIG_OF)
>  	omap_register_i2c_bus(2, 400, NULL, 0);
>  	/*
>  	 * Bus 3 is attached to the DVI port where devices like the pico DLP
> @@ -418,6 +422,7 @@ static int __init omap4_panda_i2c_init(void)
>  	omap_register_i2c_bus(3, 100, panda_i2c_eeprom,
>  					ARRAY_SIZE(panda_i2c_eeprom));
>  	omap_register_i2c_bus(4, 400, NULL, 0);
> +#endif

Yeah, don't do this.  Anything we merge to mainline we want to make
sure that a kernel image will still support both DT and non-DT boots.
That won't work if you #ifdef out blocks of code.

>  	return 0;
>  }
>  
> @@ -681,9 +686,25 @@ void omap4_panda_display_init(void)
>  	omap_display_init(&omap4_panda_dss_data);
>  }
>  
> +static struct of_device_id omap_dt_gic_match[] __initdata = {
> +	{ .compatible = "ti,omap-gic", },
> +	{}
> +};
> +
> +static struct of_device_id omap_dt_match_table[] __initdata = {
> +	{ .compatible = "ti,omap4-panda", },
> +	{}
> +};
> +
>  static void __init omap4_panda_init(void)
>  {
>  	int package = OMAP_PACKAGE_CBS;
> +	struct device_node *node;
> +
> +	node = of_find_matching_node_by_address(NULL, omap_dt_gic_match,
> +						OMAP44XX_GIC_DIST_BASE);
> +	if (node)
> +		irq_domain_add_simple(node, 0);
>  
>  	if (omap_rev() == OMAP4430_REV_ES1_0)
>  		package = OMAP_PACKAGE_CBL;
> @@ -700,6 +721,7 @@ static void __init omap4_panda_init(void)
>  	omap4_ehci_init();
>  	usb_musb_init(&musb_board_data);
>  	omap4_panda_display_init();
> +	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>  }
>  
>  static void __init omap4_panda_map_io(void)
> -- 
> 1.7.4.1
> 
