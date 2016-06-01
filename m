From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 1 Jun 2016 15:38:04 +0800
Message-ID: <20160601073804.GC15045@shlinux2>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463133808-10630-14-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
> @@ -530,6 +683,8 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
>  	}
>  	mutex_unlock(&udc_lock);
>  
> +	mutex_unlock(&udc_lock);
> +

Here, you have one more mutex_unlock.

Peter
>  	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
>  	flush_work(&gadget->work);
>  	device_unregister(&udc->dev);
> @@ -539,6 +694,13 @@ EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
>  
>  /* ------------------------------------------------------------------------- */
>  
> +struct otg_gadget_ops otg_gadget_intf = {
> +	.start = usb_gadget_start,
> +	.stop = usb_gadget_stop,
> +	.connect_control = usb_gadget_connect_control,
> +};
> +
> +/* udc_lock must be held */
>  static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *driver)
>  {
>  	int ret;
> @@ -553,12 +715,20 @@ static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_driver *dri
>  	ret = driver->bind(udc->gadget, driver);
>  	if (ret)
>  		goto err1;
> -	ret = usb_gadget_udc_start(udc);
> -	if (ret) {
> -		driver->unbind(udc->gadget);
> -		goto err1;
> +
> +	/* If OTG, the otg core starts the UDC when needed */
> +	if (udc->gadget->otg_dev) {
> +		mutex_unlock(&udc_lock);
> +		usb_otg_register_gadget(udc->gadget, &otg_gadget_intf);
> +		mutex_lock(&udc_lock);
> +	} else {
> +		ret = usb_gadget_udc_start(udc);
> +		if (ret) {
> +			driver->unbind(udc->gadget);
> +			goto err1;
> +		}
> +		usb_udc_connect_control(udc);
>  	}
> -	usb_udc_connect_control(udc);
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>  	return 0;
> @@ -660,9 +830,15 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* In OTG mode we don't support softconnect, but b_bus_req */
> +	if (udc->gadget->otg_dev) {
> +		dev_err(dev, "soft-connect not supported in OTG mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (sysfs_streq(buf, "connect")) {
>  		usb_gadget_udc_start(udc);
> -		usb_gadget_connect(udc->gadget);
> +		usb_udc_connect_control(udc);
>  	} else if (sysfs_streq(buf, "disconnect")) {
>  		usb_gadget_disconnect(udc->gadget);
>  		udc->driver->disconnect(udc->gadget);
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 3ecfddd..79d654f 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -1162,6 +1162,10 @@ extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
>  extern void usb_del_gadget_udc(struct usb_gadget *gadget);
>  extern char *usb_get_gadget_udc_name(void);
>  
> +extern int usb_otg_add_gadget_udc(struct device *parent,
> +				  struct usb_gadget *gadget,
> +				  struct device *otg_dev);
> +
>  /*-------------------------------------------------------------------------*/
>  
>  /* utility to simplify dealing with string descriptors */
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
