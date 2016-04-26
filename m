From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Tue, 26 Apr 2016 00:07:00 +0000
Message-ID: <AM4PR04MB2130B0F024C0B275514020DE89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130ACE0588E64EA723987E3896E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <571E23D7.5070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571E23D7.5070501@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi

> -----Original Message-----
> From: Roger Quadros [mailto:rogerq@ti.com]
> Sent: Monday, April 25, 2016 10:04 PM
> To: Jun Li <jun.li@nxp.com>; stern@rowland.harvard.edu; balbi@kernel.org;
> gregkh@linuxfoundation.org; peter.chen@freescale.com
> Cc: dan.j.williams@intel.com; jun.li@freescale.com;
> mathias.nyman@linux.intel.com; tony@atomide.com; Joao.Pinto@synopsys.com;
> abrestic@chromium.org; r.baldyga@samsung.com; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
> 
> Hi,
> 
> On 21/04/16 09:38, Jun Li wrote:
> > Hi,
> >
> > ...
> >>
> >>  /**
> >> + * usb_gadget_start - start the usb gadget controller and connect to
> >> +bus
> >> + * @gadget: the gadget device to start
> >> + *
> >> + * This is external API for use by OTG core.
> >> + *
> >> + * Start the usb device controller and connect to bus (enable pull).
> >> + */
> >> +static int usb_gadget_start(struct usb_gadget *gadget) {
> >> +	int ret;
> >> +	struct usb_udc *udc = NULL;
> >> +
> >> +	dev_dbg(&gadget->dev, "%s\n", __func__);
> >> +	mutex_lock(&udc_lock);
> >> +	list_for_each_entry(udc, &udc_list, list)
> >> +		if (udc->gadget == gadget)
> >> +			goto found;
> >> +
> >> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> >> +		__func__);
> >> +	mutex_unlock(&udc_lock);
> >> +	return -EINVAL;
> >> +
> >> +found:
> >> +	ret = usb_gadget_udc_start(udc);
> >> +	if (ret)
> >> +		dev_err(&udc->dev, "USB Device Controller didn't start: %d\n",
> >> +			ret);
> >> +	else
> >> +		usb_udc_connect_control(udc);
> >
> > For drd, it's fine, but for real otg, gadget connect should be done by
> > loc_conn() instead of gadget start.
> 
> It is upto the OTG state machine to call gadget_start() when it needs to
> connect to the bus (i.e. loc_conn()). I see no point in calling gadget
> start before.
> 
> Do you see any issue in doing so?

This is what OTG state machine does:
case OTG_STATE_B_PERIPHERAL:
     otg_chrg_vbus(otg, 0);
     otg_loc_sof(otg, 0);
     otg_set_protocol(fsm, PROTO_GADGET);
     otg_loc_conn(otg, 1);
     break;

You intend to abstract something common in this api when start gadget,
which should be called by otg_set_protocol(fsm, PROTO_GADGET); and
drd_set_protocol(fsm, PROTO_GADGET); right?

So you may move usb_udc_connect_control(IMO usb_gadget_connect()
is better)out of usb_gadget_start(), then for drd:

case OTG_STATE_B_PERIPHERAL:
     drd_set_protocol(fsm, PROTO_GADGET);
     otg_drv_vbus(otg, 0);
     usb_gadget_connect();

Li Jun

> 
> cheers,
> -roger
> 
> >
> >> +
> >> +	mutex_unlock(&udc_lock);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +/**
> >> + * usb_gadget_stop - disconnect from bus and stop the usb gadget
> >> + * @gadget: The gadget device we want to stop
> >> + *
> >> + * This is external API for use by OTG core.
> >> + *
> >> + * Disconnect from the bus (disable pull) and stop the
> >> + * gadget controller.
> >> + */
> >> +static int usb_gadget_stop(struct usb_gadget *gadget) {
> >> +	struct usb_udc *udc = NULL;
> >> +
> >> +	dev_dbg(&gadget->dev, "%s\n", __func__);
> >> +	mutex_lock(&udc_lock);
> >> +	list_for_each_entry(udc, &udc_list, list)
> >> +		if (udc->gadget == gadget)
> >> +			goto found;
> >> +
> >> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
> >> +		__func__);
> >> +	mutex_unlock(&udc_lock);
> >> +	return -EINVAL;
> >> +
> >> +found:
> >> +	usb_gadget_disconnect(udc->gadget);
> >
> > Likewise, gadget disconnect also should be done by loc_conn() instead
> > of gadget stop.
> >
> >> +	udc->driver->disconnect(udc->gadget);
> >> +	usb_gadget_udc_stop(udc);
> >> +	mutex_unlock(&udc_lock);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >
> > Li Jun
> >
