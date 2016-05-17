From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Tue, 17 May 2016 07:38:46 +0000
Message-ID: <AM4PR04MB2130E149700361CBA3F6863389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net> <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net> <57399839.90706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57399839.90706@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

Hi

> -----Original Message-----
> From: Roger Quadros [mailto:rogerq@ti.com]
> Sent: Monday, May 16, 2016 5:52 PM
> To: Peter Chen <hzpeterchen@gmail.com>
> Cc: peter.chen@freescale.com; balbi@kernel.org; tony@atomide.com;
> gregkh@linuxfoundation.org; dan.j.williams@intel.com;
> mathias.nyman@linux.intel.com; Joao.Pinto@synopsys.com;
> sergei.shtylyov@cogentembedded.com; jun.li@freescale.com;
> grygorii.strashko@ti.com; yoshihiro.shimoda.uh@renesas.com;
> robh@kernel.org; nsekhar@ti.com; b-liu@ti.com; linux-usb@vger.kernel.org;
> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
> 
> On 16/05/16 12:23, Peter Chen wrote:
> > On Mon, May 16, 2016 at 11:26:57AM +0300, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 16/05/16 10:02, Peter Chen wrote:
> >>> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
> >>>> +
> >>>> +static int usb_gadget_connect_control(struct usb_gadget *gadget,
> >>>> +bool connect) {
> >>>> +	struct usb_udc *udc;
> >>>> +
> >>>> +	mutex_lock(&udc_lock);
> >>>> +	udc = usb_gadget_to_udc(gadget);
> >>>> +	if (!udc) {
> >>>> +		dev_err(gadget->dev.parent, "%s: gadget not
> registered.\n",
> >>>> +			__func__);
> >>>> +		mutex_unlock(&udc_lock);
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	if (connect) {
> >>>> +		if (!gadget->connected)
> >>>> +			usb_gadget_connect(udc->gadget);
> >>>> +	} else {
> >>>> +		if (gadget->connected) {
> >>>> +			usb_gadget_disconnect(udc->gadget);
> >>>> +			udc->driver->disconnect(udc->gadget);
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>> +	mutex_unlock(&udc_lock);
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>
> >>> Since this is called for vbus interrupt, why not using
> >>> usb_udc_vbus_handler directly, and call udc->driver->disconnect at
> >>> usb_gadget_stop.
> >>
> >> We can't assume that this is always called for vbus interrupt so I
> >> decided not to call usb_udc_vbus_handler.
> >>
> >> udc->vbus is really pointless for us. We keep vbus states in our
> >> state machine and leave udc->vbus as ture always.
> >>
> >> Why do you want to move udc->driver->disconnect() to stop?
> >> If USB controller disconnected from bus then the gadget driver must
> >> be notified about the disconnect immediately. The controller may or
> >> may not be stopped by the core.
> >>
> >
> > Then, would you give some comments when this API will be used?
> > I was assumed it is only used for drd state machine.
> 
> drd_state machine didn't even need this API in the first place :).
> You guys wanted me to separate out start/stop and connect/disconnect for
> full OTG case.
> Won't full OTG state machine want to use this API? If not what would it
> use?

Instead create those new interfaces/symbol here and there just aim to
address build problems in diff configures, Could we only allow meaningful
combination of those 3 drivers configures?

Hcd=y, gadget=y, otg=y or
Hcd=m, gadget=m, otg=m

Li Jun

> 
> cheers,
> -roger
> 
> >
> >>>
> >>>>  	return 0;
> >>>> @@ -660,9 +830,15 @@ static ssize_t usb_udc_softconn_store(struct
> device *dev,
> >>>>  		return -EOPNOTSUPP;
> >>>>  	}
> >>>>
> >>>> +	/* In OTG mode we don't support softconnect, but b_bus_req */
> >>>> +	if (udc->gadget->otg_dev) {
> >>>> +		dev_err(dev, "soft-connect not supported in OTG mode\n");
> >>>> +		return -EOPNOTSUPP;
> >>>> +	}
> >>>> +
> >>>
> >>> The soft-connect can be supported at dual-role mode currently, we
> >>> can use b_bus_req entry once it is implemented later.
> >>
> >> Soft-connect should be done via sysfs handling within the OTG core.
> >> This can be added later. I don't want anything outside the OTG core
> >> to handle soft-connect behaviour as it will be hard to keep things in
> >> sync.
> >>
> >> I can update the comment to something like this.
> >>
> >> /* In OTG/dual-role mode, soft-connect should be handled by OTG core
> >> */
> >
> > Ok, let's Felipe decide it.
> >
> >>
> >>>
> >>>>  	if (sysfs_streq(buf, "connect")) {
> >>>>  		usb_gadget_udc_start(udc);
> >>>> -		usb_gadget_connect(udc->gadget);
> >>>> +		usb_udc_connect_control(udc);
> >>>
> >>> This line seems to be not related with this patch.
> >>>
> >> Right. I'll remove it.
> >>
> >> cheers,
> >> -roger
> >
