From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH] musb: fix tusb6010_omap compilation errors
Date: Fri, 23 Jan 2009 20:16:21 +0200
Message-ID: <20090123181620.GT440@frodo>
References: <20090123160037.7547.71504.stgit@tikku>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123160037.7547.71504.stgit@tikku>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 23, 2009 at 06:00:37PM +0200, Kalle Valo wrote:
> drivers/usb/musb/tusb6010_omap.c:18:26: error: asm/arch/dma.h:
>   No such file or directory
> drivers/usb/musb/tusb6010_omap.c:19:26: error: asm/arch/mux.h:
>   No such file or directory
> 
> Signed-off-by: Kalle Valo <kalle.valo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Acked-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

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
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
