From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Tue, 3 May 2016 07:06:09 +0000
Message-ID: <AM4PR04MB213005276AC61A0BF5AF89BD897A0@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130ACE0588E64EA723987E3896E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <571E23D7.5070501@ti.com>
 <AM4PR04MB2130B0F024C0B275514020DE89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5720A106.1030702@ti.com> <5721DDE5.7060708@ti.com>
 <AM4PR04MB213098D1AD7E63D227AD23B289650@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5722008A.3020902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5722008A.3020902@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

> >>>>>>>  /**
> >>>>>>> + * usb_gadget_start - start the usb gadget controller and
> >>>>>>> +connect to bus
> >>>>>>> + * @gadget: the gadget device to start
> >>>>>>> + *
> >>>>>>> + * This is external API for use by OTG core.
> >>>>>>> + *
> >>>>>>> + * Start the usb device controller and connect to bus (enable
> pull).
> >>>>>>> + */
> >>>>>>> +static int usb_gadget_start(struct usb_gadget *gadget) {
> >>>>>>> +	int ret;
> >>>>>>> +	struct usb_udc *udc = NULL;
> >>>>>>> +
> >>>>>>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
> >>>>>>> +	mutex_lock(&udc_lock);
> >>>>>>> +	list_for_each_entry(udc, &udc_list, list)
> >>>>>>> +		if (udc->gadget == gadget)
> >>>>>>> +			goto found;
> >>>>>>> +
> >>>>>>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> >>>>>>> +		__func__);
> >>>>>>> +	mutex_unlock(&udc_lock);
> >>>>>>> +	return -EINVAL;
> >>>>>>> +
> >>>>>>> +found:
> >>>>>>> +	ret = usb_gadget_udc_start(udc);
> >>>>>>> +	if (ret)
> >>>>>>> +		dev_err(&udc->dev, "USB Device Controller didn't
> >> start: %d\n",
> >>>>>>> +			ret);
> >>>>>>> +	else
> >>>>>>> +		usb_udc_connect_control(udc);
> >>>>>>
> >>>>>> For drd, it's fine, but for real otg, gadget connect should be
> >>>>>> done by
> >>>>>> loc_conn() instead of gadget start.
> >>>>>
> >>>>> It is upto the OTG state machine to call gadget_start() when it
> >>>>> needs to connect to the bus (i.e. loc_conn()). I see no point in
> >>>>> calling gadget start before.
> >>>>>
> >>>>> Do you see any issue in doing so?
> >>>>
> >>>> This is what OTG state machine does:
> >>>> case OTG_STATE_B_PERIPHERAL:
> >>>>      otg_chrg_vbus(otg, 0);
> >>>>      otg_loc_sof(otg, 0);
> >>>>      otg_set_protocol(fsm, PROTO_GADGET);
> >>>>      otg_loc_conn(otg, 1);
> >>>>      break;
> >>
> >> On second thoughts, after seen the OTG state machine.
> >> otg_set_protocol(fsm, PROTO_GADGET); is always followed by
> >> otg_loc_conn(otg, 1); And whenever protocol changes to anything other
> >> the PROTO_GADGET, we use otg_loc_conn(otg, 0);
> >>
> >> So otg_loc_conn seems redundant. Can we just get rid of it?
> >>
> >> usb_gadget_start() implies that gadget controller starts up and
> >> enables pull.
> >> usb_gadget_stop() implies that gadget controller disables pull and
> stops.
> >>
> >>
> >> Can you please explain why just these 2 APIs are not sufficient for
> >> full OTG?
> >>
> >> Do we want anything to happen between gadget controller start/stop
> >> and pull on/off?
> >
> > "loc_conn" is a standard output parameter in OTG spec, it deserves a
> > separate api, yes, current implementation of OTG state machine code
> > seems allow you to combine the 2 things into one, but don't do that,
> > because they do not always happen together, e.g. for peripheral only B
> > device (also a part OTG spec: section 7.3), will be fixed in gadget
> > mode, but it will do gadget connect and disconnect in its diff states,
> > so, to make the framework common, let's keep them separated.
> 
> I'm sorry but I didn't understand your comment about "it will do gadget
> connect and disconnect in its diff states"

Gadget connect means loc_conn(1).

> 
> I am reading the OTG v2.0 specification and loc_conn is always true when
> b_peripheral or a_peripheral is true and false otherwise.

If you only talk about these 2 states, yes, loc_conn is ture.

> 
> loc_conn is just an internal state variable and it corresponds to our
> gadget_start/stop() state.

It's not an internal variable, there are OTG state machine
parameters tables(table 7-x) in OTG spec which have clear lists
which are "internal variable", which are "input", which are "output"...

Those APIs are driven directly from OTG spec, easily understood so
code reader can know what's those APIs for. For real OTG, I don't
see the benefit if get rid of it.

> 
> As per 7.4.2.3
> "loc_conn
> The "local connect" (loc_conn) variable is TRUE when the local device has
> signaled that it is connected to the bus. This variable is FALSE when the
> local device has signaled that it is disconnected from the bus"
> 
> Can you please point me in the specification if there is any place where
> loc_conn is false and b_peripheral/a_peripheral is true?
> 
> cheers,
> -roger
