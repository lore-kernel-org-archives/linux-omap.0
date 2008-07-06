From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: Re: [PATCH 1/4] omap_udc: fix compilation with debug enabled
Date: Sun, 6 Jul 2008 13:28:42 +0300
Message-ID: <20080706102841.GA20019@kedavra.cpe.vivax.com.br>
References: <20080706102553.GA29914@doriath.ww600.siemens.net>
Reply-To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080706102553.GA29914-nIupHZaCssqR2kOLt6zJ8ErlnG4Plg33XqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 06, 2008 at 02:25:53PM +0400, Dmitry Baryshkov wrote:
> Signed-off-by: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/usb/gadget/omap_udc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 881d74c..b3cee6f 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -54,6 +54,7 @@
>  
>  #include <asm/arch/dma.h>
>  #include <asm/arch/usb.h>
> +#include <asm/arch/control.h>
>  
>  #include "omap_udc.h"
>  
> @@ -2289,7 +2290,7 @@ static int proc_otg_show(struct seq_file *s)
>  	tmp = OTG_REV_REG;
>  	if (cpu_is_omap24xx()) {
>  		ctrl_name = "control_devconf";
> -		trans = CONTROL_DEVCONF_REG;
> +		trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
>  	} else {
>  		ctrl_name = "tranceiver_ctrl";
>  		trans = USB_TRANSCEIVER_CTRL_REG;

Good patch, should go via linux-omap, I suppose.

-- 
Best Regards,

Felipe Balbi
me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
http://blog.felipebalbi.com
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
