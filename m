From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]ZOOM2: Initialization of SDRC params on Zoom2
Date: Wed, 07 Oct 2009 06:30:04 -0700
Message-ID: <87pr8zmiw3.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3327D9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:47457 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbZJGNaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 09:30:46 -0400
Received: by pxi9 with SMTP id 9so4784760pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 07 Oct 2009 06:30:08 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3327D9@dbde02.ent.ti.com> (Teerth Reddy's message of "Wed\, 7 Oct 2009 14\:37\:42 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> This patch initializes the SDRC params for Zoom2

Not a very useful changelog.  Something about *why* the changes are
neede should be present in each changelog.  Something like the need of
correct SDRC settings for DVFS.

Other than that, looks good.  Thanks.

Kevin

> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  arch/arm/mach-omap2/board-zoom2.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/board-zoom2.c
> +++ linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
> @@ -25,6 +25,7 @@
>  #include <mach/keypad.h>
>  
>  #include "mmc-twl4030.h"
> +#include "sdram-micron-mt46h32m32lf-6.h"
>  
>  /* Zoom2 has Qwerty keyboard*/
>  static int board_keymap[] = {
> @@ -213,7 +214,8 @@ static void __init omap_zoom2_init_irq(v
>  {
>  	omap_board_config = zoom2_config;
>  	omap_board_config_size = ARRAY_SIZE(zoom2_config);
> -	omap2_init_common_hw(NULL, NULL);
> +	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> +				 mt46h32m32lf6_sdrc_params);
>  	omap_init_irq();
>  	omap_gpio_init();
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
