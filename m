From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC][PATCH v2 03/13] usb: otg-fsm: Prevent build warning "VDBG"
 redefined
Date: Thu, 16 Apr 2015 19:41:53 +0800
Message-ID: <20150416114152.GC3181@shlinux2>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
 <1429008120-5395-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429008120-5395-4-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 14, 2015 at 01:41:50PM +0300, Roger Quadros wrote:
> If usb/otg-fsm.h and usb/composite.h are included together
> then it results in the build warning [1].
> 
> Prevent that by moving the VDBG defination into the
> usb-otg-fsm.c file where it is used.
> 
> Also get rid of MPC_LOC which doesn't seem to be used
> by anyone.
> 
> [1] - warning fixed by this patch:
> 
>    In file included from drivers/usb/dwc3/core.h:33,
>                     from drivers/usb/dwc3/ep0.c:33:
>    include/linux/usb/otg-fsm.h:30:1: warning: "VDBG" redefined
>    In file included from drivers/usb/dwc3/ep0.c:31:
>    include/linux/usb/composite.h:615:1: warning: this is the location of the previous definition
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/common/usb-otg-fsm.c |  9 +++++++++
>  include/linux/usb/otg-fsm.h      | 15 ---------------
>  2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
> index 0caa37b..35f311a 100644
> --- a/drivers/usb/common/usb-otg-fsm.c
> +++ b/drivers/usb/common/usb-otg-fsm.c
> @@ -30,6 +30,15 @@
>  #include <linux/usb/otg.h>
>  #include <linux/usb/otg-fsm.h>
>  
> +#undef VDBG
> +
> +#ifdef VERBOSE
> +#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
> +				 __func__, ## args)
> +#else
> +#define VDBG(stuff...)	do {} while (0)
> +#endif
> +

It is obsolete too, we may use dev_vdbg instead of it.

>  /* Change USB protocol when there is a protocol change */
>  static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
>  {
> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
> index 85a9150..73136aa 100644
> --- a/include/linux/usb/otg-fsm.h
> +++ b/include/linux/usb/otg-fsm.h
> @@ -21,21 +21,6 @@
>  #include <linux/mutex.h>
>  #include <linux/errno.h>
>  
> -#undef VERBOSE
> -
> -#ifdef VERBOSE
> -#define VDBG(fmt, args...) pr_debug("[%s]  " fmt , \
> -				 __func__, ## args)
> -#else
> -#define VDBG(stuff...)	do {} while (0)
> -#endif
> -
> -#ifdef VERBOSE
> -#define MPC_LOC printk("Current Location [%s]:[%d]\n", __FILE__, __LINE__)
> -#else
> -#define MPC_LOC do {} while (0)
> -#endif
> -
>  #define PROTO_UNDEF	(0)
>  #define PROTO_HOST	(1)
>  #define PROTO_GADGET	(2)
> -- 
> 2.1.0
> 

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
