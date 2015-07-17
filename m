From: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v3 05/11] usb: hcd.h: Add OTG to HCD interface
Date: Fri, 17 Jul 2015 08:30:22 +0800
Message-ID: <20150717003021.GB3609@shlinux2>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>
 <1436350777-28056-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436350777-28056-6-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 08, 2015 at 01:19:31PM +0300, Roger Quadros wrote:
> The OTG core will use struct otg_hcd_ops to
> add/remove the HCD controller.
> 
> The main purpose of this interface is to avoid directly
> calling usb_add/remove_hcd() from the OTG core as they
> wouldn't be defined in the built-in symbol table if
> CONFIG_USB is m.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  include/linux/usb/hcd.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index c9aa779..4108288 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -386,6 +386,20 @@ struct hc_driver {
>  
>  };
>  
> +/**
> + * struct otg_hcd_ops - Interface between OTG core and HCD
> + *
> + * Provided by the HCD core to allow the OTG core to start/stop the HCD
> + *
> + * @add: function to add the HCD
> + * @remove: function to remove the HCD
> + */
> +struct otg_hcd_ops {
> +	int (*add)(struct usb_hcd *hcd,
> +		   unsigned int irqnum, unsigned long irqflags);
> +	void (*remove)(struct usb_hcd *hcd);
> +};
> +
>  static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
>  {
>  	return hcd->driver->flags & HCD_BH;
> -- 
> 2.1.4
> 

Reviewed-by: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
