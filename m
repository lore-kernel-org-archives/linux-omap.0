From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Wed, 4 May 2016 09:47:05 +0800
Message-ID: <20160504014705.GC31013@shlinux2.ap.freescale.net>
References: <1459865117-7032-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130ACE0588E64EA723987E3896E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <571E23D7.5070501@ti.com>
 <AM4PR04MB2130B0F024C0B275514020DE89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5720A106.1030702@ti.com>
 <5721DDE5.7060708@ti.com>
 <AM4PR04MB213098D1AD7E63D227AD23B289650@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5722008A.3020902@ti.com>
 <AM4PR04MB213005276AC61A0BF5AF89BD897A0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5728C76E.9010405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5728C76E.9010405-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 03, 2016 at 06:44:46PM +0300, Roger Quadros wrote:
> Hi,
> 
> On 03/05/16 10:06, Jun Li wrote:
> > Hi
> > 
> >>>>>>>>>  /**
> >>>>>>>>> + * usb_gadget_start - start the usb gadget controller and
> >>>>>>>>> +connect to bus
> >>>>>>>>> + * @gadget: the gadget device to start
> >>>>>>>>> + *
> >>>>>>>>> + * This is external API for use by OTG core.
> >>>>>>>>> + *
> >>>>>>>>> + * Start the usb device controller and connect to bus (enable
> >> pull).
> >>>>>>>>> + */
> >>>>>>>>> +static int usb_gadget_start(struct usb_gadget *gadget) {
> >>>>>>>>> +	int ret;
> >>>>>>>>> +	struct usb_udc *udc = NULL;
> >>>>>>>>> +
> >>>>>>>>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
> >>>>>>>>> +	mutex_lock(&udc_lock);
> >>>>>>>>> +	list_for_each_entry(udc, &udc_list, list)
> >>>>>>>>> +		if (udc->gadget == gadget)
> >>>>>>>>> +			goto found;
> >>>>>>>>> +
> >>>>>>>>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> >>>>>>>>> +		__func__);
> >>>>>>>>> +	mutex_unlock(&udc_lock);
> >>>>>>>>> +	return -EINVAL;
> >>>>>>>>> +
> >>>>>>>>> +found:
> >>>>>>>>> +	ret = usb_gadget_udc_start(udc);
> >>>>>>>>> +	if (ret)
> >>>>>>>>> +		dev_err(&udc->dev, "USB Device Controller didn't
> >>>> start: %d\n",
> >>>>>>>>> +			ret);
> >>>>>>>>> +	else
> >>>>>>>>> +		usb_udc_connect_control(udc);
> >>>>>>>>
> >>>>>>>> For drd, it's fine, but for real otg, gadget connect should be
> >>>>>>>> done by
> >>>>>>>> loc_conn() instead of gadget start.
> >>>>>>>
> >>>>>>> It is upto the OTG state machine to call gadget_start() when it
> >>>>>>> needs to connect to the bus (i.e. loc_conn()). I see no point in
> >>>>>>> calling gadget start before.
> >>>>>>>
> >>>>>>> Do you see any issue in doing so?
> >>>>>>
> >>>>>> This is what OTG state machine does:
> >>>>>> case OTG_STATE_B_PERIPHERAL:
> >>>>>>      otg_chrg_vbus(otg, 0);
> >>>>>>      otg_loc_sof(otg, 0);
> >>>>>>      otg_set_protocol(fsm, PROTO_GADGET);
> >>>>>>      otg_loc_conn(otg, 1);
> >>>>>>      break;
> >>>>
> >>>> On second thoughts, after seen the OTG state machine.
> >>>> otg_set_protocol(fsm, PROTO_GADGET); is always followed by
> >>>> otg_loc_conn(otg, 1); And whenever protocol changes to anything other
> >>>> the PROTO_GADGET, we use otg_loc_conn(otg, 0);
> >>>>
> >>>> So otg_loc_conn seems redundant. Can we just get rid of it?
> >>>>
> >>>> usb_gadget_start() implies that gadget controller starts up and
> >>>> enables pull.
> >>>> usb_gadget_stop() implies that gadget controller disables pull and
> >> stops.
> >>>>
> >>>>
> >>>> Can you please explain why just these 2 APIs are not sufficient for
> >>>> full OTG?
> >>>>
> >>>> Do we want anything to happen between gadget controller start/stop
> >>>> and pull on/off?
> >>>
> >>> "loc_conn" is a standard output parameter in OTG spec, it deserves a
> >>> separate api, yes, current implementation of OTG state machine code
> >>> seems allow you to combine the 2 things into one, but don't do that,
> >>> because they do not always happen together, e.g. for peripheral only B
> >>> device (also a part OTG spec: section 7.3), will be fixed in gadget
> >>> mode, but it will do gadget connect and disconnect in its diff states,
> >>> so, to make the framework common, let's keep them separated.
> >>
> >> I'm sorry but I didn't understand your comment about "it will do gadget
> >> connect and disconnect in its diff states"
> > 
> > Gadget connect means loc_conn(1).
> > 
> >>
> >> I am reading the OTG v2.0 specification and loc_conn is always true when
> >> b_peripheral or a_peripheral is true and false otherwise.
> > 
> > If you only talk about these 2 states, yes, loc_conn is ture.
> > 
> >>
> >> loc_conn is just an internal state variable and it corresponds to our
> >> gadget_start/stop() state.
> > 
> > It's not an internal variable, there are OTG state machine
> > parameters tables(table 7-x) in OTG spec which have clear lists
> > which are "internal variable", which are "input", which are "output"...
> > 
> > Those APIs are driven directly from OTG spec, easily understood so
> > code reader can know what's those APIs for. For real OTG, I don't
> > see the benefit if get rid of it.
> 
> OK, no issues if we don't get rid of it. But I am still in favor of
> doing a connect in usb_gadget_start(), because
> 
> 1) If we split connect/disconnect() and usb_gadget_start/stop() then there is
> additional overhead of keeping track whether connect was called or not during
> usb_gadget_stop(). Plus we need to take care that users don't call connect/disconnect
> outside of start/stop. It is just complicating things.
> 
> 2) for many controllers there is no difference between run/stop and
> connect/disconnect. i.e. a single register bit controls both.
> 
> 3) it fits well with the OTG specification. OTG specification says
> that loc_conn *variable* must be true *after* the device has signalled a connect.
> So OTG state machine can safely set loc_conn variable to true after doing
> otg_set_protocol(fsm, PROTO_GADGET); and set it to false otherwise.
> 
> Note, OTG specification does not say to take any action based on loc_conn.
> It is just a connect indicator variable. So we might have to fix this in the
> OTG state machine.
> 
> My suggestion is to keep it simple for now. Try the OTG implementation,
> and later if we find issues then extend it as required.
> 

I agree with you, roger.

loc_conn action is only needed for peripheral, we can't do real !loc_conn
at host mode. Besides, loc_conn is the output, we need to set/clear it after
state has changed, and current gadget framework already takes well for
connection and disconnection state, so it is better to delete loc_conn
action at otg_fsm->ops, and only keeps it as indicator for OTG FSM
reference.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
