From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 16 May 2016 15:02:49 +0800
Message-ID: <20160516070249.GB24609@shlinux2.ap.freescale.net>
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
> +
> +static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
> +{
> +	struct usb_udc *udc;
> +
> +	mutex_lock(&udc_lock);
> +	udc = usb_gadget_to_udc(gadget);
> +	if (!udc) {
> +		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> +			__func__);
> +		mutex_unlock(&udc_lock);
> +		return -EINVAL;
> +	}
> +
> +	if (connect) {
> +		if (!gadget->connected)
> +			usb_gadget_connect(udc->gadget);
> +	} else {
> +		if (gadget->connected) {
> +			usb_gadget_disconnect(udc->gadget);
> +			udc->driver->disconnect(udc->gadget);
> +		}
> +	}
> +
> +	mutex_unlock(&udc_lock);
> +
> +	return 0;
> +}
> +

Since this is called for vbus interrupt, why not using
usb_udc_vbus_handler directly, and call udc->driver->disconnect
at usb_gadget_stop.

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

The soft-connect can be supported at dual-role mode currently, we can
use b_bus_req entry once it is implemented later.

>  	if (sysfs_streq(buf, "connect")) {
>  		usb_gadget_udc_start(udc);
> -		usb_gadget_connect(udc->gadget);
> +		usb_udc_connect_control(udc);

This line seems to be not related with this patch.

-- 

Best Regards,
Peter Chen
