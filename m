From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Mon, 18 Apr 2016 14:59:54 +0800
Message-ID: <20160418065954.GB4477@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459865117-7032-10-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 05, 2016 at 05:05:14PM +0300, Roger Quadros wrote:
> The OTG state machine needs a mechanism to start and
> stop the gadget controller. Add usb_gadget_start()
> and usb_gadget_stop().
> 
> Introduce usb_otg_add_gadget_udc() to allow controller drivers
> to register a gadget controller that is part of an OTG instance.
> 
> Register with OTG core when gadget function driver
> is available and unregister when function driver is unbound.
> 
> We need to unlock the usb_lock mutexbefore calling

...mutex before...

> usb_otg_register_gadget() in udc_bind_to_driver() and
> usb_gadget_remove_driver() else it will cause a circular
> locking dependency.
> 
> Ignore softconnect sysfs control when we're in OTG
> mode as OTG FSM takes care of gadget softconnect using
> the b_bus_req mechanism.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c | 166 +++++++++++++++++++++++++++++++++++---
>  include/linux/usb/gadget.h        |   4 +
>  2 files changed, 161 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
> index 4151597..9b9702f 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -28,6 +28,10 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb.h>
> +#include <linux/usb/otg.h>
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  /**
>   * struct usb_udc - describes one usb device controller
> @@ -304,6 +308,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
>   */
>  static inline int usb_gadget_udc_start(struct usb_udc *udc)
>  {
> +	dev_dbg(&udc->dev, "%s\n", __func__);
>  	return udc->gadget->ops->udc_start(udc->gadget, udc->driver);
>  }

You may delete the debug message next time.

>  
> @@ -321,10 +326,81 @@ static inline int usb_gadget_udc_start(struct usb_udc *udc)
>   */
>  static inline void usb_gadget_udc_stop(struct usb_udc *udc)
>  {
> +	dev_dbg(&udc->dev, "%s\n", __func__);
>  	udc->gadget->ops->udc_stop(udc->gadget);
>  }

The same.

>  
>  /**
> + * usb_gadget_start - start the usb gadget controller and connect to bus
> + * @gadget: the gadget device to start
> + *
> + * This is external API for use by OTG core.
> + *
> + * Start the usb device controller and connect to bus (enable pull).
> + */
> +static int usb_gadget_start(struct usb_gadget *gadget)
> +{
> +	int ret;
> +	struct usb_udc *udc = NULL;
> +
> +	dev_dbg(&gadget->dev, "%s\n", __func__);

The same

> +	mutex_lock(&udc_lock);
> +	list_for_each_entry(udc, &udc_list, list)
> +		if (udc->gadget == gadget)
> +			goto found;
> +
> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> +		__func__);
> +	mutex_unlock(&udc_lock);
> +	return -EINVAL;
> +
> +found:
> +	ret = usb_gadget_udc_start(udc);
> +	if (ret)
> +		dev_err(&udc->dev, "USB Device Controller didn't start: %d\n",
> +			ret);
> +	else
> +		usb_udc_connect_control(udc);
> +
> +	mutex_unlock(&udc_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * usb_gadget_stop - disconnect from bus and stop the usb gadget
> + * @gadget: The gadget device we want to stop
> + *
> + * This is external API for use by OTG core.
> + *
> + * Disconnect from the bus (disable pull) and stop the
> + * gadget controller.
> + */
> +static int usb_gadget_stop(struct usb_gadget *gadget)
> +{
> +	struct usb_udc *udc = NULL;
> +
> +	dev_dbg(&gadget->dev, "%s\n", __func__);

The same
	
> +	mutex_lock(&udc_lock);
> +	list_for_each_entry(udc, &udc_list, list)
> +		if (udc->gadget == gadget)
> +			goto found;
> +
> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> +		__func__);
> +	mutex_unlock(&udc_lock);
> +	return -EINVAL;

The above finding gadget code is the same with usb_gadget_start, can we
use one common API to instead of it?

> +
> +found:
> +	usb_gadget_disconnect(udc->gadget);
> +	udc->driver->disconnect(udc->gadget);
> +	usb_gadget_udc_stop(udc);
> +	mutex_unlock(&udc_lock);
> +
> +	return 0;
> +}
> +
> +/**
>   * usb_udc_release - release the usb_udc struct
>   * @dev: the dev member within usb_udc
>   *
> @@ -486,6 +562,48 @@ int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
>  }
>  EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
>  
> +/**
> + * usb_otg_add_gadget_udc - adds a new gadget to the udc class driver list
> + * @parent: the parent device to this udc. Usually the controller
> + * driver's device.
> + * @gadget: the gadget to be added to the list
> + * @otg_dev: the OTG controller device
> + *
> + * If otg_dev is NULL then device tree node is checked
> + * for OTG controller via the otg-controller property.
> + * Returns zero on success, negative errno otherwise.
> + */
> +int usb_otg_add_gadget_udc(struct device *parent, struct usb_gadget *gadget,
> +			   struct device *otg_dev)
> +{
> +	if (!otg_dev) {
> +		struct device_node *np;
> +		struct platform_device *pdev;
> +
> +		np = of_parse_phandle(parent->of_node, "otg-controller", 0);
> +		if (!np) {
> +			dev_err(parent,
> +				"otg_dev is NULL or no otg-controller property in DT\n");
> +			return -EINVAL;
> +		}
> +
> +		pdev = of_find_device_by_node(np);
> +		of_node_put(np);
> +		if (!pdev) {
> +			dev_err(parent, "couldn't get otg-controller device\n");
> +			return -ENODEV;
> +		}
> +
> +		gadget->otg_dev = &pdev->dev;
> +	} else {
> +		gadget->otg_dev = otg_dev;
> +	}

The above the code is duplicated with hcd's. Can we do something common
at usb-otg.c, eg define an API get_usb_otg_dev(struct usb_gadget *gadget, struct
usb_hcd *hcd), in this API we can try to get otg_dev for both gadget and
hcd, and we can call it at controller driver during register otg.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
