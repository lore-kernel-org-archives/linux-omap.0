From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] video/omap: remove mux.h include
Date: Mon, 4 Oct 2010 11:47:36 -0700
Message-ID: <20101004184736.GA3117@atomide.com>
References: <20101004174344.21577085@absol.kitzblitz>
 <20101004175429.GW3117@atomide.com>
 <20101004203842.088b0cb2@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55924 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0JDSrr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:47:47 -0400
Content-Disposition: inline
In-Reply-To: <20101004203842.088b0cb2@absol.kitzblitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Kaiser <nikai@nikai.net>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Nicolas Kaiser <nikai@nikai.net> [101004 11:32]:
> Including mux.h should no longer be needed for omap2/3/4 SoCs
> outside arch/arm/mach-omap2 files.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Thanks,

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/video/omap/lcd_omap3beagle.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
> index ca75cc2..d7c6c3e 100644
> --- a/drivers/video/omap/lcd_omap3beagle.c
> +++ b/drivers/video/omap/lcd_omap3beagle.c
> @@ -25,8 +25,6 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c/twl.h>
>  
> -#include <plat/mux.h>
> -#include <plat/mux.h>
>  #include <asm/mach-types.h>
>  
>  #include "omapfb.h"
> -- 
> 1.7.2.2
