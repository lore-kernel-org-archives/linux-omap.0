From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 12/14] usb: hcd: Adapt to OTG core
Date: Wed, 11 May 2016 16:57:18 +0800
Message-ID: <20160511085718.GJ16910@shlinux2.ap.freescale.net>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-13-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462191537-10314-13-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 02, 2016 at 03:18:55PM +0300, Roger Quadros wrote:
> Introduce usb_otg_add/remove_hcd() for use by host
> controllers that are part of OTG/dual-role port.
> 
> Non Device tree platforms can use the otg_dev argument
> to specify the OTG controller device. If otg_dev is NULL
> then the device tree node's otg-controller property is used to
> get the otg_dev device.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>

> ---
>  drivers/usb/core/hcd.c  | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb/hcd.h |  4 ++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 9484539..cfc8232 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -46,6 +46,11 @@
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
>  #include <linux/usb/phy.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/of.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  #include "usb.h"
>  
> @@ -3013,6 +3018,56 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>  }
>  EXPORT_SYMBOL_GPL(usb_remove_hcd);
>  
> +static struct otg_hcd_ops otg_hcd_intf = {
> +	.add = usb_add_hcd,
> +	.remove = usb_remove_hcd,
> +	.usb_bus_start_enum = usb_bus_start_enum,
> +	.usb_control_msg = usb_control_msg,
> +	.usb_hub_find_child = usb_hub_find_child,
> +};
> +
> +/**
> + * usb_otg_add_hcd - Register the HCD with OTG core.
> + * @hcd: the usb_hcd structure to initialize
> + * @irqnum: Interrupt line to allocate
> + * @irqflags: Interrupt type flags
> + * @otg_dev: OTG controller device managing this HCD
> + *
> + * Registers the HCD with OTG core. OTG core will call usb_add_hcd()
> + * or usb_remove_hcd() as necessary.
> + * If otg_dev is NULL then device tree node is checked for OTG
> + * controller device via the otg-controller property.
> + */
> +int usb_otg_add_hcd(struct usb_hcd *hcd,
> +		    unsigned int irqnum, unsigned long irqflags,
> +		    struct device *otg_dev)
> +{
> +	struct device *dev = hcd->self.controller;
> +
> +	if (!otg_dev) {
> +		hcd->otg_dev = of_usb_get_otg(dev->of_node);
> +		if (!hcd->otg_dev)
> +			return -ENODEV;
> +	} else {
> +		hcd->otg_dev = otg_dev;
> +	}
> +
> +	return usb_otg_register_hcd(hcd, irqnum, irqflags, &otg_hcd_intf);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_add_hcd);
> +
> +/**
> + * usb_otg_remove_hcd - Unregister the HCD with OTG core.
> + * @hcd: the usb_hcd structure to remove
> + *
> + * Unregisters the HCD from the OTG core.
> + */
> +void usb_otg_remove_hcd(struct usb_hcd *hcd)
> +{
> +	usb_otg_unregister_hcd(hcd);
> +}
> +EXPORT_SYMBOL_GPL(usb_otg_remove_hcd);
> +
>  void
>  usb_hcd_platform_shutdown(struct platform_device *dev)
>  {
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 2017cd4..adcf2e7 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -472,6 +472,10 @@ extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
>  extern int usb_add_hcd(struct usb_hcd *hcd,
>  		unsigned int irqnum, unsigned long irqflags);
>  extern void usb_remove_hcd(struct usb_hcd *hcd);
> +extern int usb_otg_add_hcd(struct usb_hcd *hcd,
> +			   unsigned int irqnum, unsigned long irqflags,
> +			   struct device *otg_dev);
> +extern void usb_otg_remove_hcd(struct usb_hcd *hcd);
>  extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
>  
>  struct platform_device;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
