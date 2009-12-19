From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] omap: zoom3: enable ehci support
Date: Sat, 19 Dec 2009 16:43:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031DB9AC76@dbde02.ent.ti.com>
References: <1261165300-25985-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44264 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbZLSLN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 06:13:58 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBJBDtdn023166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 19 Dec 2009 05:13:57 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBJBDtjD006662
	for <linux-omap@vger.kernel.org>; Sat, 19 Dec 2009 16:43:55 +0530 (IST)
In-Reply-To: <1261165300-25985-1-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Zoom3 board has omap3630 EHCI port2 connected to a ULPI phy.
> GPIO_64 is connected to the PHY reset pin.
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Gadiyar, Anand <gadiyar@ti.com>

Except for one comment (see below),

Acked-by: Anand Gadiyar <gadiyar@ti.com>

> ---
>  arch/arm/mach-omap2/board-zoom3.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
> index a9fe918..a5e8036 100644
> --- a/arch/arm/mach-omap2/board-zoom3.c
> +++ b/arch/arm/mach-omap2/board-zoom3.c
> @@ -20,6 +20,8 @@
>  
>  #include <plat/common.h>
>  #include <plat/board.h>
> +#include <plat/usb.h>
> +#include <plat/mux.h>

I don't think you need plat/mux.h here?

The omap_mux_init_gpio() call that you added, is declared
in mux.h, that's included on the next line.

>  
>  #include "mux.h"
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> @@ -51,11 +53,25 @@ static struct omap_board_mux board_mux[] __initdata = {
>  #define board_mux	NULL
>  #endif
>  
> +static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
> +	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> +	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = -EINVAL,
> +	.reset_gpio_port[1]  = 64,
> +	.reset_gpio_port[2]  = -EINVAL
> +};
> +
>  static void __init omap_zoom_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
>  	zoom_peripherals_init();
>  	zoom_debugboard_init();
> +
> +	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
> +	usb_ehci_init(&ehci_pdata);
>  }
>  
>  MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
> -- 
> 1.6.6.rc0.66.ge160d
> 
> 