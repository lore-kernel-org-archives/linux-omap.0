From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 08/14] usb: otg: add OTG/dual-role core
Date: Sun, 12 Jun 2016 14:26:17 +0800
Message-ID: <20160612062617.GC22054@shlinux2>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com>
 <20160608095336.GA4444@shlinux2>
 <5757EF7A.20604@ti.com>
 <20160608124204.GB10029@shlinux2>
 <575919BC.8080003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <575919BC.8080003-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 09, 2016 at 10:24:44AM +0300, Roger Quadros wrote:
> On 08/06/16 15:42, Peter Chen wrote:
> > On Wed, Jun 08, 2016 at 01:12:10PM +0300, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 08/06/16 12:53, Peter Chen wrote:
> >>> On Wed, Jun 08, 2016 at 12:03:40PM +0300, Roger Quadros wrote:
> >>>> +int usb_otg_unregister(struct device *dev)
> >>>> +{
> >>>> +	struct usb_otg *otg;
> >>>> +
> >>>> +	mutex_lock(&otg_list_mutex);
> >>>> +	otg = usb_otg_get_data(dev);
> >>>> +	if (!otg) {
> >>>> +		dev_err(dev, "otg: %s: device not in otg list\n",
> >>>> +			__func__);
> >>>> +		mutex_unlock(&otg_list_mutex);
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	/* prevent unregister till both host & gadget have unregistered */
> >>>> +	if (otg->host || otg->gadget) {
> >>>> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
> >>>> +			__func__);
> >>>
> >>> You need to call mutex_unlock here
> >>
> >> Indeed. good catch.
> >>>
> >>>> +
> >>>> +int usb_otg_gadget_ready(struct usb_gadget *gadget, bool ready)
> >>>> +{
> >>>
> >>> What this API is for? Why need it in this version?
> >>
> >> we moved gadget to otg registration from udc_bind_to_driver() to usb_add_gadget_udc_release().
> >> This means there is a window when gadget function driver (e.g. g_zero) is not loaded.
> >> We don't want to start the gadget controller in that window.
> >>
> >> usb_otg_gadget_ready() is used by gadget core to notify the otg core when the function driver
> >> is ready or not-ready.
> >>
> > 
> > Why you need to move this from gadget's probe to udc's probe? Currently,
> > the sequence of gadget and udc's probe is random, but udc_bind_to_driver
> > is called when udc is ready.
> > 
> Because we need to support -EPROBE_DEFER at udc probe.
> At udc_bind_to_driver there is no scope for -EPROBE_DEFER.
> 

Why udc_bind_to_driver can't return -EPROBE_DEFER if register to OTG is
failed?

> Another issue is that we need to register with otg and have otg->caps available
> before driver->bind() is called in udc_bind_to_driver(). Else gadget function
> will not have the correct OTG descriptor.
> 

You can do register before calling driver->bind.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
