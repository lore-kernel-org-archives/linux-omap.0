From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 18 May 2016 14:46:50 +0000
Message-ID: <AM4PR04MB2130926F9AE8EBFC0D19447689490@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net> <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net> <57399839.90706@ti.com>
 <AM4PR04MB2130E149700361CBA3F6863389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573AD198.6030307@ti.com>
 <AM4PR04MB2130EF68F7ADD64607C6CD4389480@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C6347.6080705@ti.com>
 <AM4PR04MB2130145869480748D06FE6E589490@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <573C719F.5010107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573C719F.5010107@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Peter Chen <hzpeterchen@gmail.com>
Cc: "peter.chen@freescale.com" <peter.chen@freescale.com>, "balbi@kernel.org" <balbi@kernel.org>, "tony@atomide.com" <tony@atomide.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "robh@kernel.org" <robh@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "b-liu@ti.com" <b-liu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org



> >>
> >> I didn't want to have complex Kconfig so decided to have otg as
> >> built-in only.
> >> What do you want me to change in existing code? and why?
> >
> > Remove those stuff which only for pass diff driver config Like every
> > controller driver need a duplicated
> >
> > static struct otg_hcd_ops ci_hcd_ops = {
> >     ...
> > }
> 
> This is an exception only. Every controller driver doesn't need to
> implement hcd_ops. It is implemented in the hcd core.
> 
> >
> > And here is another example, for gadget connect, otg driver can
> > directly call to usb_udc_vbus_handler() in drd state machine, but you
> > create another interface:
> >
> > .connect_control = usb_gadget_connect_control,
> >
> > If the symbol is defined in one driver which is 'm', another driver
> > reference it should be 'm' as well, then there is no this kind of
> > problem as my understanding.
> 
> That is fine as long as all are 'm'. but how do you solve the case when
> Gadget is built in and host is 'm'? OTG has to be built-in and you will
> need an hcd to gadget interface.

Hcd to gadget interface? Or you want to say otg to host interface?

I think hcd and gadget are independent each other, now

Hcd --> otg; and gadget --> otg, (hcd and gadget use otg's symbol)

If you directly call to usb_udc_vbus_handler() in drd state machine

Then:

Hcd --> otg; and gadget <--> otg, (gadget and otg will refer to symbol of each other)

Li Jun

> 
> Do you have any ideas to solve that case?
> 
> cheers,
> -roger
> 
> >>>>>>
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>>  	return 0;
> >>>>>>>>>> @@ -660,9 +830,15 @@ static ssize_t
> >>>>>>>>>> usb_udc_softconn_store(struct
> >>>>>> device *dev,
> >>>>>>>>>>  		return -EOPNOTSUPP;
> >>>>>>>>>>  	}
> >>>>>>>>>>
> >>>>>>>>>> +	/* In OTG mode we don't support softconnect, but
> b_bus_req */
> >>>>>>>>>> +	if (udc->gadget->otg_dev) {
> >>>>>>>>>> +		dev_err(dev, "soft-connect not supported in OTG
> mode\n");
> >>>>>>>>>> +		return -EOPNOTSUPP;
> >>>>>>>>>> +	}
> >>>>>>>>>> +
> >>>>>>>>>
> >>>>>>>>> The soft-connect can be supported at dual-role mode currently,
> >>>>>>>>> we can use b_bus_req entry once it is implemented later.
> >>>>>>>>
> >>>>>>>> Soft-connect should be done via sysfs handling within the OTG
> core.
> >>>>>>>> This can be added later. I don't want anything outside the OTG
> >>>>>>>> core to handle soft-connect behaviour as it will be hard to
> >>>>>>>> keep things in sync.
> >>>>>>>>
> >>>>>>>> I can update the comment to something like this.
> >>>>>>>>
> >>>>>>>> /* In OTG/dual-role mode, soft-connect should be handled by OTG
> >>>>>>>> core */
> >>>>>>>
> >>>>>>> Ok, let's Felipe decide it.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>  	if (sysfs_streq(buf, "connect")) {
> >>>>>>>>>>  		usb_gadget_udc_start(udc);
> >>>>>>>>>> -		usb_gadget_connect(udc->gadget);
> >>>>>>>>>> +		usb_udc_connect_control(udc);
> >>>>>>>>>
> >>>>>>>>> This line seems to be not related with this patch.
> >>>>>>>>>
> >>>>>>>> Right. I'll remove it.
> >>>>>>>>
> >>>>>>>> cheers,
> >>>>>>>> -roger
> >>>>>>>
