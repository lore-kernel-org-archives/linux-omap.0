From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] tsub6010: fix omap compile
Date: Thu, 22 Jan 2009 18:10:52 -0800
Message-ID: <20090123021051.GM7172@atomide.com>
References: <20090122131602.18315.84862.stgit@tikku> <20090122131913.18315.73478.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57771 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbZAWCKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 21:10:54 -0500
Content-Disposition: inline
In-Reply-To: <20090122131913.18315.73478.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Kalle Valo <kalle.valo@nokia.com> [090122 05:21]:
> drivers/usb/musb/tusb6010_omap.c:18:26: error: asm/arch/dma.h: No such file or directory
> drivers/usb/musb/tusb6010_omap.c:19:26: error: asm/arch/mux.h: No such file or directory

Not touching this, Felipe needs to queue this up via linux-usb list.

Tony

> 
> Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
> ---
> 
>  drivers/usb/musb/tusb6010_omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index 52f7f29..7e073a0 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -15,8 +15,8 @@
>  #include <linux/usb.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> -#include <asm/arch/dma.h>
> -#include <asm/arch/mux.h>
> +#include <mach/dma.h>
> +#include <mach/mux.h>
>  
>  #include "musb_core.h"
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
