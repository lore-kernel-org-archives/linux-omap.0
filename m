From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Sun, 12 Jun 2016 17:13:24 +0800
Message-ID: <20160612091324.GF22054@shlinux2>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com>
 <1465564043-27163-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465564043-27163-7-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 10, 2016 at 04:07:15PM +0300, Roger Quadros wrote:
> The OTG core will use struct otg_gadget_ops to
> start/stop the gadget controller.
> 
> The main purpose of this interface is to avoid directly
> calling usb_gadget_start/stop() from the OTG core as they
> wouldn't be defined in the built-in symbol table if
> CONFIG_USB_GADGET is m.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Peter Chen <peter.chen@nxp.com>

> ---
>  include/linux/usb/gadget.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 2dd9e6b..f4fc0aa 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -639,6 +639,22 @@ struct usb_gadget_driver {
>  };
>  
>  
> +/*-------------------------------------------------------------------------*/
> +
> +/**
> + * struct otg_gadget_ops - Interface between OTG core and gadget
> + *
> + * Provided by the gadget core to allow the OTG core to start/stop the gadget
> + *
> + * @start: function to start the gadget
> + * @stop: function to stop the gadget
> + * @connect_control: function to connect/disconnect from the bus
> + */
> +struct otg_gadget_ops {
> +	int (*start)(struct usb_gadget *gadget);
> +	int (*stop)(struct usb_gadget *gadget);
> +	int (*connect_control)(struct usb_gadget *gadget, bool connect);
> +};
>  
>  /*-------------------------------------------------------------------------*/
>  
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
