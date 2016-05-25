From: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
Date: Wed, 25 May 2016 03:19:30 +0000
Message-ID: <AM4PR04MB21300F71EFFD3BF73871A85389400@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-9-git-send-email-rogerq@ti.com> <574422CA.8080002@ti.com>
 <20160525024427.GA31142@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160525024427.GA31142@shlinux2>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Wednesday, May 25, 2016 10:44 AM
> To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org; balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org;
> sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org; jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org;
> grygorii.strashko-l0cyMroinI0@public.gmane.org; yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org;
> robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; nsekhar-l0cyMroinI0@public.gmane.org; b-liu-l0cyMroinI0@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
> 
> On Tue, May 24, 2016 at 12:45:46PM +0300, Roger Quadros wrote:
> > Hi Peter,
> >
> > I have one question here. Please see below.
> >
> > On 13/05/16 13:03, Roger Quadros wrote:
> > > It provides APIs for the following tasks
> > >
> > > - Registering an OTG/dual-role capable controller
> > > - Registering Host and Gadget controllers to OTG core
> > > - Providing inputs to and kicking the OTG state machine
> > >
> > > Provide a dual-role device (DRD) state machine.
> > > DRD mode is a reduced functionality OTG mode. In this mode we don't
> > > support SRP, HNP and dynamic role-swap.
> > >
> > > In DRD operation, the controller mode (Host or Peripheral) is
> > > decided based on the ID pin status. Once a cable plug (Type-A or
> > > Type-B) is attached the controller selects the state and doesn't
> > > change till the cable in unplugged and a different cable type is
> > > inserted.
> > >
> > > As we don't need most of the complex OTG states and OTG timers we
> > > implement a lean DRD state machine in usb-otg.c.
> > > The DRD state machine is only interested in 2 hardware inputs 'id'
> > > and 'b_sess_vld'.
> > >
> > > Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > > ---
> > >  drivers/usb/common/Makefile  |    2 +-
> > >  drivers/usb/common/usb-otg.c | 1042
> ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/usb/core/Kconfig     |    4 +-
> > >  include/linux/usb/gadget.h   |    2 +
> > >  include/linux/usb/hcd.h      |    1 +
> > >  include/linux/usb/otg-fsm.h  |    7 +
> > >  include/linux/usb/otg.h      |  154 ++++++-
> > >  7 files changed, 1206 insertions(+), 6 deletions(-)  create mode
> > > 100644 drivers/usb/common/usb-otg.c
> > >
> >
> > <snip>
> >
> > > +
> > > +/**
> > > + * usb_otg_register() - Register the OTG/dual-role device to OTG
> > > +core
> > > + * @dev: OTG/dual-role controller device.
> > > + * @config: OTG configuration.
> > > + *
> > > + * Registers the OTG/dual-role controller device with the USB OTG
> core.
> > > + *
> > > + * Return: struct usb_otg * if success, ERR_PTR() if error.
> > > + */
> > > +struct usb_otg *usb_otg_register(struct device *dev,
> > > +				 struct usb_otg_config *config) {
> > > +	struct usb_otg *otg;
> > > +	struct otg_wait_data *wait;
> > > +	int ret = 0;
> > > +
> > > +	if (!dev || !config || !config->fsm_ops)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	/* already in list? */
> > > +	mutex_lock(&otg_list_mutex);
> > > +	if (usb_otg_get_data(dev)) {
> > > +		dev_err(dev, "otg: %s: device already in otg list\n",
> > > +			__func__);
> > > +		ret = -EINVAL;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	/* allocate and add to list */
> > > +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
> > > +	if (!otg) {
> > > +		ret = -ENOMEM;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	otg->dev = dev;
> > > +	otg->caps = config->otg_caps;
> >
> > Here, we should be checking if user needs to disable any OTG features.
> > So,
> >
> > 	if (dev->of_node)
> > 		of_usb_update_otg_caps(dev->of_node, &otg->caps);
> >
> > Do you agree?
> > This means we need to change otg->caps from 'struct usb_otg_caps *caps;'
> > to 'struct usb_otg_caps caps;' so that we can modify the local copy
> > instead of the one passed by the OTG controller.
> 
> Why can't modify the one from OTG controller directly?

Yes, if user wants to disable any OTG features, this should have been
done in 'config->otg_caps', if not, 'config->otg_caps' from controller
driver is invalid and making no sense.

> 
> >
> > We can also move of_usb_update_otg_caps() to otg.h.
> >
> > We will also need to modify the udc-core code so that it sets
> > gadget->otg_caps to the modified otg_caps from the OTG core. This will
> > ensure that the right OTG descriptors are sent.
> >
> > So we will have to introduce an API.
> >
> > struct usb_otg_caps *usb_otg_get_otg_caps(struct device *otg_dev)
> >
> > And in udc-core.c,
> >
> > static int udc_bind_to_driver(struct usb_udc *udc, struct
> > usb_gadget_driver *driver) { ..
> >         ret = driver->bind(udc->gadget, driver);
> >         if (ret)
> >                 goto err1;
> >
> >         /* If OTG, the otg core starts the UDC when needed */
> >         if (udc->gadget->otg_dev) {
> > +		udc->gadget->is_otg = true;
> 
> gadget->is_otg is only set to true if fully OTG is supported and it
> needs to send OTG descriptors at this case. DRD devices should not send
> OTG descriptors.
> 
> > +		udc->gadget->otg_caps = usb_otg_get_otg_caps(udc->gadget-
> >otg_dev);
> 
> Getting otg capabilities should be prior to driver->bind since
> usb_otg_descriptor_init is called at that. Besides, Gadget driver may be
> probed before otg driver is registered
> 
> I am wonder if we can implement defer probe for gadget/udc/host driver if
> otg driver is not probed, in that case, some designs can be simpler like
> wait list in otg driver.

I even don't see much benefit of this kind of random order of OTG/HCD/GADGET
registration, anyway OTG register can be done firstly.
HCD and GADGET are both separated drivers, but OTG is newly added
and what we need is just a registration in controller driver.
  
> 
> >                 mutex_unlock(&udc_lock);
> >                 usb_otg_register_gadget(udc->gadget, &otg_gadget_intf);
> >                 mutex_lock(&udc_lock);
> >         } else {
> >                 ret = usb_gadget_udc_start(udc);
> >                 if (ret) {
> >                         driver->unbind(udc->gadget);
> >                         goto err1;
> >                 }
> >                 usb_udc_connect_control(udc);
> >         }
> > ..
> > }
> >
> > What do you say?
> >
> > regards,
> > -roger
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> 
> Best Regards,
> Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
