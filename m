From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Wed, 4 May 2016 11:35:23 +0800
Message-ID: <20160504033523.GD31013@shlinux2.ap.freescale.net>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5728C76E.9010405@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Jun Li <jun.li@nxp.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
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

Just talked with Jun, he is worried if loc_conn != pullup_dp at some
situations. So, how about only calling start gadget at usb_start_gadget,
and pullup_dp at drd_set_state (see below).


static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
{
	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);

	if (otg->state == new_state)
		return;

	fsm->state_changed = 1;
	dev_dbg(otg->dev, "otg: set state: %s\n",
		usb_otg_state_string(new_state));
	switch (new_state) {
	case OTG_STATE_B_IDLE:
+		usb_udc_vbus_handler(gadget, false);
		drd_set_protocol(fsm, PROTO_UNDEF);
		otg_drv_vbus(otg, 0);
		break;
	case OTG_STATE_B_PERIPHERAL:
		drd_set_protocol(fsm, PROTO_GADGET);
+		usb_udc_vbus_handler(gadget, true);
		otg_drv_vbus(otg, 0);
		break;
	......
	};
	
}

When the OTG FSM is added to this framework, it can keep usb_fsm->ops->loc_conn,
and using the current FSM.

-- 

Best Regards,
Peter Chen
