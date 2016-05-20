From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Fri, 20 May 2016 09:39:31 +0800
Message-ID: <20160520013931.GA10896@shlinux2>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net>
 <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net>
 <57399839.90706@ti.com>
 <20160518031829.GA4244@shlinux2.ap.freescale.net>
 <573C63D7.9050200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <573C63D7.9050200-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 18, 2016 at 03:45:11PM +0300, Roger Quadros wrote:
> On 18/05/16 06:18, Peter Chen wrote:
> > On Mon, May 16, 2016 at 12:51:53PM +0300, Roger Quadros wrote:
> >> On 16/05/16 12:23, Peter Chen wrote:
> >>> On Mon, May 16, 2016 at 11:26:57AM +0300, Roger Quadros wrote:
> >>>> Hi,
> >>>>
> >>>> On 16/05/16 10:02, Peter Chen wrote:
> >>>>> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
> >>>>>> +
> >>>>>> +static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
> >>>>>> +{
> >>>>>> +	struct usb_udc *udc;
> >>>>>> +
> >>>>>> +	mutex_lock(&udc_lock);
> >>>>>> +	udc = usb_gadget_to_udc(gadget);
> >>>>>> +	if (!udc) {
> >>>>>> +		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> >>>>>> +			__func__);
> >>>>>> +		mutex_unlock(&udc_lock);
> >>>>>> +		return -EINVAL;
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	if (connect) {
> >>>>>> +		if (!gadget->connected)
> >>>>>> +			usb_gadget_connect(udc->gadget);
> >>>>>> +	} else {
> >>>>>> +		if (gadget->connected) {
> >>>>>> +			usb_gadget_disconnect(udc->gadget);
> >>>>>> +			udc->driver->disconnect(udc->gadget);
> >>>>>> +		}
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	mutex_unlock(&udc_lock);
> >>>>>> +
> >>>>>> +	return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>
> >>>>> Since this is called for vbus interrupt, why not using
> >>>>> usb_udc_vbus_handler directly, and call udc->driver->disconnect
> >>>>> at usb_gadget_stop.
> >>>>
> >>>> We can't assume that this is always called for vbus interrupt so
> >>>> I decided not to call usb_udc_vbus_handler.
> >>>>
> >>>> udc->vbus is really pointless for us. We keep vbus states in our
> >>>> state machine and leave udc->vbus as ture always.
> >>>>
> >>>> Why do you want to move udc->driver->disconnect() to stop?
> >>>> If USB controller disconnected from bus then the gadget driver
> >>>> must be notified about the disconnect immediately. The controller
> >>>> may or may not be stopped by the core.
> >>>>
> >>>
> >>> Then, would you give some comments when this API will be used?
> >>> I was assumed it is only used for drd state machine.
> >>
> >> drd_state machine didn't even need this API in the first place :).
> >> You guys wanted me to separate out start/stop and connect/disconnect for full OTG case.
> >> Won't full OTG state machine want to use this API? If not what would it use?
> >>
> > 
> > Oh, I meant only drd and fully otg state machine needs it. I am
> > wondering if we need have a new API to do it. Two questions:
> 
> OK.
> > 
> > - Except for vbus interrupt, any chances this API will be used at
> > current logic?
> 
> I don't think so. But we can't assume caller behaviour for any API.
> 
> > - When this API is called but without a coming gadget->stop?
> > 
> Never for DRD case. But we want to catch wrong users.
> 

In future, otg_start_gadget will be used for both DRD and fully OTG FSM.
There is no otg_loc_conn at current DRD FSM, but there is
otg_loc_conn at current OTG FSM, see below.

DRD FSM:
	case OTG_STATE_B_IDLE:
		drd_set_protocol(fsm, PROTO_UNDEF);
		otg_drv_vbus(otg, 0);
		break;
	case OTG_STATE_B_PERIPHERAL:
		drd_set_protocol(fsm, PROTO_GADGET);
		otg_drv_vbus(otg, 0);
		break;

OTG FSM:
	case OTG_STATE_B_IDLE:
		otg_drv_vbus(otg, 0);
		otg_chrg_vbus(otg, 0);
		otg_loc_conn(otg, 0);
		otg_loc_sof(otg, 0);
		/*
		 * Driver is responsible for starting ADP probing
		 * if ADP sensing times out.
		 */
		otg_start_adp_sns(otg);
		otg_set_protocol(fsm, PROTO_UNDEF);
		otg_add_timer(otg, B_SE0_SRP);
		break;
	case OTG_STATE_B_PERIPHERAL:
		otg_chrg_vbus(otg, 0);
		otg_loc_sof(otg, 0);
		otg_set_protocol(fsm, PROTO_GADGET);
		otg_loc_conn(otg, 1);
		break;

My original suggestion is to have an API to do pull dp and this API
will be used at both DRD and OTG FSM, and called at otg_loc_conn.
The (de)initialize is the same for both two FSMs, it both includes
init peripheral mode and pull up dp, and can be done by drd_set_protocol(fsm, PROTO_GADGET)
otg_loc_conn(otg, 1);

What do you think?

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
