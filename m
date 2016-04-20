From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Wed, 20 Apr 2016 17:40:58 +0800
Message-ID: <20160420094058.GE27526@shlinux2.ap.freescale.net>
References: <20160418022956.GB32090@shlinux2.ap.freescale.net>
 <Pine.LNX.4.44L0.1604181007240.1775-100000@iolanthe.rowland.org>
 <20160419015622.GH4477@shlinux2.ap.freescale.net>
 <57173AA2.5080204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57173AA2.5080204@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 20, 2016 at 11:15:30AM +0300, Roger Quadros wrote:
> On 19/04/16 04:56, Peter Chen wrote:
> > On Mon, Apr 18, 2016 at 10:11:29AM -0400, Alan Stern wrote:
> >> On Mon, 18 Apr 2016, Peter Chen wrote:
> >>
> >>> On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
> >>>> On 06/04/16 09:09, Felipe Balbi wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Roger Quadros <rogerq@ti.com> writes:
> >>>>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>>>>> index 2ca2cef..6b1930d 100644
> >>>>>> --- a/drivers/usb/core/hcd.c
> >>>>>> +++ b/drivers/usb/core/hcd.c
> >>>>>> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>>>>>  	int retval;
> >>>>>>  	struct usb_device *rhdev;
> >>>>>>  
> >>>>>> +	hcd->flags = 0;
> >>>>>
> >>>>> seems like this would make more sense in usb_del_hcd() instead.
> >>>>>
> >>>>
> >>>> OK, I'll move it there.
> >>>>
> >>>
> >>> It depends on Alan's comments, whether only usb_add_hcd/usb_del_hcd
> >>> pair can be called repeat. If Alan acks it, I have no idea for it.
> >>
> >> Most of the host controller drivers were not written with this in mind,
> >> but I think it would be a good thing to allow.  It would speed up the
> >> host/device role switches.
> >>
> >> This might mean we need to fix up several drivers to make them work 
> >> correctly in an OTG environment.  It should be possible to do this.  Is 
> >> there any particular reason why it would be difficult for Chipidea?
> >>
> > 
> > I just want to do clean remove at OTG environment, like rmmod, so I did
> > this when I worked on chipidea OTG design.
> > I am worried if there are some resources dedicated for host device, eg,
> > clocks, gpio. etc.
> > 
> > If OTG framework can know well hcd's add and remove, it is ok for chipidea
> > just calling usb_add_hcd/usb_del_hcd currently, but I suggested roger
> > adding platform hcd_ops as optional parameter in case the platform
> > has special requirement for hcd_ops.
> > 
> We have 2 users now, omap + dwc3 and sh + EHCI/OHCI and we didn't seem to
> observe any issues with the usb_add/del_hcd approach.
> 
> Let's keep things minimal for now. In the future, if users need something more
> we can always extend the framework.
> 

I agree

-- 

Best Regards,
Peter Chen
