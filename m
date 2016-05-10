From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Tue, 10 May 2016 11:14:01 +0800
Message-ID: <20160510031401.GA3748@shlinux2.ap.freescale.net>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-4-git-send-email-rogerq@ti.com>
 <20160506094103.GF32359@shlinux2.ap.freescale.net>
 <57305C42.90300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57305C42.90300-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 09, 2016 at 12:45:38PM +0300, Roger Quadros wrote:
> On 06/05/16 12:41, Peter Chen wrote:
> > On Mon, May 02, 2016 at 03:18:46PM +0300, Roger Quadros wrote:
> >> The OTG core will use struct otg_hcd_ops to interface
> >> with the HCD controller.
> >>
> >> The main purpose of this interface is to avoid directly
> >> calling HCD APIs from the OTG core as they
> >> wouldn't be defined in the built-in symbol table if
> >> CONFIG_USB is m.
> >>
> >> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> >> Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > 
> > Roger, after thinking more, I still think current dependency between
> > OTG, HCD and gadget are too complicated. Since the OTG can't work
> > if it is built as module, I suggest letting OTG depends on HCD &&
> > USB_GADGET, and it is a boolean, in that case, we don't need to
> > export any HCD and gadget ops, things will be much simpler.
> > What's your opinion?
> 
> How will it work if HCD and USB_GADGET are modules and OTG is built-in?
> 

The OTG will not be compiled at this situation, since it is boolean.
In fact, like I mentioned at above, OTG or USB function can't work if
it is built as module.

Peter
> cheers,
> -roger
> 
> > 
> > Peter
> > 
> >> ---
> >>  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >>
> >> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> >> index b98f831..861ccaa 100644
> >> --- a/include/linux/usb/hcd.h
> >> +++ b/include/linux/usb/hcd.h
> >> @@ -399,6 +399,30 @@ struct hc_driver {
> >>  
> >>  };
> >>  
> >> +/**
> >> + * struct otg_hcd_ops - Interface between OTG core and HCD
> >> + *
> >> + * Provided by the HCD core to allow the OTG core to interface with the HCD
> >> + *
> >> + * @add: function to add the HCD
> >> + * @remove: function to remove the HCD
> >> + * @usb_bus_start_enum: function to immediately start bus enumeration
> >> + * @usb_control_msg: function to build and send of a control urb
> >> + * @usb_hub_find_child: function to get pointer to the child device
> >> + */
> >> +struct otg_hcd_ops {
> >> +	int (*add)(struct usb_hcd *hcd,
> >> +		   unsigned int irqnum, unsigned long irqflags);
> >> +	void (*remove)(struct usb_hcd *hcd);
> >> +	int (*usb_bus_start_enum)(struct usb_bus *bus, unsigned int port_num);
> >> +	int (*usb_control_msg)(struct usb_device *dev, unsigned int pipe,
> >> +			       __u8 request, __u8 requesttype, __u16 value,
> >> +			       __u16 index, void *data, __u16 size,
> >> +			       int timeout);
> >> +	struct usb_device * (*usb_hub_find_child)(struct usb_device *hdev,
> >> +						  int port1);
> >> +};
> >> +
> >>  static inline int hcd_giveback_urb_in_bh(struct usb_hcd *hcd)
> >>  {
> >>  	return hcd->driver->flags & HCD_BH;
> >> -- 
> >> 2.7.4
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
