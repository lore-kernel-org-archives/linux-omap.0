From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]ZOOM2: Initialization of SDRC params on Zoom2
Date: Fri, 09 Oct 2009 09:32:51 -0700
Message-ID: <87pr8wwmrw.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D05E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:44329 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933963AbZJIQeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 12:34:07 -0400
Received: by pzk7 with SMTP id 7so2197814pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 09 Oct 2009 09:32:53 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D05E3@dbde02.ent.ti.com> (Teerth Reddy's message of "Thu\, 8 Oct 2009 13\:56\:02 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> This patch initializes the correct SDRC settings required 
> for DVFS on Zoom2.
>
> Signed-off-by: Teerth Reddy <teerth@ti.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tony, this could get queued in -fixes too.

Thanks,

Kevin

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
