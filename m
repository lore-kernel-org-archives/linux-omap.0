From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v8 13/14] usb: gadget: udc: adapt to OTG core
Date: Wed, 18 May 2016 11:18:30 +0800
Message-ID: <20160518031829.GA4244@shlinux2.ap.freescale.net>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-14-git-send-email-rogerq@ti.com>
 <20160516070249.GB24609@shlinux2.ap.freescale.net>
 <57398451.2060103@ti.com>
 <20160516092323.GD24609@shlinux2.ap.freescale.net>
 <57399839.90706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57399839.90706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: peter.chen@freescale.com, balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, May 16, 2016 at 12:51:53PM +0300, Roger Quadros wrote:
> On 16/05/16 12:23, Peter Chen wrote:
> > On Mon, May 16, 2016 at 11:26:57AM +0300, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 16/05/16 10:02, Peter Chen wrote:
> >>> On Fri, May 13, 2016 at 01:03:27PM +0300, Roger Quadros wrote:
> >>>> +
> >>>> +static int usb_gadget_connect_control(struct usb_gadget *gadget, bool connect)
> >>>> +{
> >>>> +	struct usb_udc *udc;
> >>>> +
> >>>> +	mutex_lock(&udc_lock);
> >>>> +	udc = usb_gadget_to_udc(gadget);
> >>>> +	if (!udc) {
> >>>> +		dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
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
> >>> usb_udc_vbus_handler directly, and call udc->driver->disconnect
> >>> at usb_gadget_stop.
> >>
> >> We can't assume that this is always called for vbus interrupt so
> >> I decided not to call usb_udc_vbus_handler.
> >>
> >> udc->vbus is really pointless for us. We keep vbus states in our
> >> state machine and leave udc->vbus as ture always.
> >>
> >> Why do you want to move udc->driver->disconnect() to stop?
> >> If USB controller disconnected from bus then the gadget driver
> >> must be notified about the disconnect immediately. The controller
> >> may or may not be stopped by the core.
> >>
> > 
> > Then, would you give some comments when this API will be used?
> > I was assumed it is only used for drd state machine.
> 
> drd_state machine didn't even need this API in the first place :).
> You guys wanted me to separate out start/stop and connect/disconnect for full OTG case.
> Won't full OTG state machine want to use this API? If not what would it use?
> 

Oh, I meant only drd and fully otg state machine needs it. I am
wondering if we need have a new API to do it. Two questions:

- Except for vbus interrupt, any chances this API will be used at
current logic?
- When this API is called but without a coming gadget->stop?

-- 

Best Regards,
Peter Chen
