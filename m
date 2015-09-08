From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Tue, 8 Sep 2015 10:34:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509081031200.1533-100000@iolanthe.rowland.org>
References: <55EED3B5.5030806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55EED3B5.5030806-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 8 Sep 2015, Roger Quadros wrote:

> On 08/09/15 11:31, Peter Chen wrote:
> > On Mon, Sep 07, 2015 at 01:23:01PM +0300, Roger Quadros wrote:
> >> On 07/09/15 04:23, Peter Chen wrote:
> >>> On Mon, Aug 24, 2015 at 04:21:18PM +0300, Roger Quadros wrote:
> >>>> + * This is used by the USB Host stack to register the Host controller
> >>>> + * to the OTG core. Host controller must not be started by the
> >>>> + * caller as it is left upto the OTG state machine to do so.
> >>>> + *
> >>>> + * Returns: 0 on success, error value otherwise.
> >>>> + */
> >>>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
> >>>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
> >>>> +{
> >>>> +	struct usb_otg *otgd;
> >>>> +	struct device *hcd_dev = hcd->self.controller;
> >>>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
> >>>> +
> >>>
> >>> One big problem here is: there are two designs for current (IP) driver
> >>> code, one creates dedicated hcd device as roothub's parent, like dwc3.
> >>> Another one doesn't do this, roothub's parent is core device (or otg device
> >>> in your patch), like chipidea and dwc2.
> >>>
> >>> Then, otg_dev will be glue layer device for chipidea after that.
> >>
> >> OK. Let's add a way for the otg controller driver to provide the host and gadget
> >> information to the otg core for such devices like chipidea and dwc2.
> >>
> > 
> > Roger, not only chipidea and dwc2, I think the musb uses the same
> > hierarchy. If the host, device, and otg share the same register
> > region, host part can't be a platform driver since we don't want
> > to remap the same register region again.
> > 
> > So, in the design, we may need to consider both situations, one
> > is otg/host/device has its own register region, and host is a
> > separate platform device (A), the other is three parts share the
> > same register region, there is only one platform driver (B).
> > 
> > A:
> > 
> > 			IP core device 
> > 			    |
> > 			    |
> > 		      |-----|-----|
> > 		      gadget   host platform device	
> > 		      		|
> > 				roothub
> > 
> > B:
> > 
> > 			IP core device
> > 			    |
> > 			    |
> > 		      |-----|-----|
> > 		      gadget   	 roothub
> > 		      		
> > 
> >> This API must be called before the hcd/gadget-driver is added so that the otg
> >> core knows it's linked to an OTG controller.
> >>
> >> Any better idea?
> >>
> > 
> > A flag stands for this hcd controller is the same with otg controller
> > can be used, this flag can be stored at struct usb_otg_config.
> 
> What if there is another architecture like so?
> 
> C:
> 			[Parent]
> 			   |
> 			   |
> 		|------------------|--------------|
> 	[OTG core]		[gadget]	[host]
> 
> We need a more flexible mechanism to link the gadget and
> host device to the otg core for non DT case.
> 
> How about adding struct usb_otg parameter to usb_otg_register_hcd()?
> 
> e.g.
> int usb_otg_register_hcd(struct usb_otg *otg, struct usb_hcd *hcd, ..)
> 
> If otg is NULL it will try DT otg-controller property or parent to
> get the otg controller.

This seems a lot like something Peter and I discussed recently.  See

	http://marc.info/?l=linux-usb&m=143977568021328&w=2

and the following messages in that thread.

Alan Stern


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
