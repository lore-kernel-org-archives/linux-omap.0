From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v11 13/14] usb: gadget: udc: adapt to OTG core
Date: Mon, 13 Jun 2016 15:56:32 +0800
Message-ID: <20160613075632.GE19728@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-14-git-send-email-rogerq@ti.com>
 <575E66E0.1060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575E66E0.1060503@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 13, 2016 at 10:55:12AM +0300, Roger Quadros wrote:
>  err1:
> -	if (ret != -EISNAM)
> +	if ((ret != -EISNAM))

Since you do not need above change.

Expect above, I am ok with this patch.

Acked-by: Peter Chen <peter.chen@nxp.com>

>  		dev_err(&udc->dev, "failed to start %s: %d\n",
>  			udc->driver->function, ret);
>  	udc->driver = NULL;
> @@ -1389,6 +1565,12 @@ static ssize_t usb_udc_softconn_store(struct device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* In OTG/dual-role mode, soft-connect should be handled by OTG core */
> +	if (udc->gadget->otg_dev) {
> +		dev_err(dev, "soft-connect not supported in OTG mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (sysfs_streq(buf, "connect")) {
>  		usb_gadget_udc_start(udc);
>  		usb_gadget_connect(udc->gadget);
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 1d74fb8..8c6880d 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -701,6 +701,10 @@ extern int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
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
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
