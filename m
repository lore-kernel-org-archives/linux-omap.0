From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Fri, 8 Apr 2016 09:01:30 +0800
Message-ID: <20160408010130.GA9070@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-2-git-send-email-rogerq@ti.com>
 <87zit72rqz.fsf@intel.com>
 <5704AD76.9080806@ti.com>
 <20160407094246.GA9963@shlinux2.ap.freescale.net>
 <57063915.7000700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57063915.7000700-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 07, 2016 at 01:40:21PM +0300, Roger Quadros wrote:
> On 07/04/16 12:42, Peter Chen wrote:
> > On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
> >> On 06/04/16 09:09, Felipe Balbi wrote:
> >>>
> >>> Hi,
> >>>
> >>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> >>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>>> index 2ca2cef..6b1930d 100644
> >>>> --- a/drivers/usb/core/hcd.c
> >>>> +++ b/drivers/usb/core/hcd.c
> >>>> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>>>  	int retval;
> >>>>  	struct usb_device *rhdev;
> >>>>  
> >>>> +	hcd->flags = 0;
> >>>
> > 
> > I am not sure if this usb_add(remove)_hcd pair is safe and clean enough
> > for start/stop host role. From my point, we may need to do like
> > .probe/.remove host platform driver interface. In that case, we can make
> 
> probe and remove are meant to be called from bus layer.
> I do not see a way how OTG framework can call probe/remove of HCD driver.
> Some HCDs may be platform devices, some PCI, so different entities are calling
> the HCD .probe hook.
> 
> > sure the clocks and regulators are off, and hcd will be zero-initialized
> 
> why can't we make that sure that is taken care of within the hcd_ops?
> Why should some driver keep its regulators and clocks enabled when hcd is stopped?
> It doesn't need to. If it is doing so now, it needs to be fixed.
> 

Well, you may misunderstand me. I mean your hcd_ops->start or ->stop
is hard to be a general one which only calls usb_hcd_add or
usb_hcd_remove. It needs to implement like .probe or .remove at platform
driver, some example code like host_start and host_stop at
drivers/usb/chipidea/host.c.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
