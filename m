From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 08/12] usb: hcd: Adapt to OTG core
Date: Tue, 19 Apr 2016 16:14:46 +0800
Message-ID: <20160419081446.GA15789@shlinux2.ap.freescale.net>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-9-git-send-email-rogerq@ti.com>
 <20160418062937.GA4477@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160418062937.GA4477@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 18, 2016 at 02:29:37PM +0800, Peter Chen wrote:
> On Tue, Apr 05, 2016 at 05:05:13PM +0300, Roger Quadros wrote:
> > Introduce usb_otg_add/remove_hcd() for use by host
> > controllers that are part of OTG/dual-role port.
> > 
> > Non Device tree platforms can use the otg_dev argument
> > to specify the OTG controller device. If otg_dev is NULL
> > then the device tree node's otg-controller property is used to
> > get the otg_dev device.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  drivers/usb/core/hcd.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/usb/hcd.h |  4 +++
> >  2 files changed, 75 insertions(+)
> > 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 6b1930d..6a80193 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -46,6 +46,10 @@
> >  #include <linux/usb.h>
> >  #include <linux/usb/hcd.h>
> >  #include <linux/usb/phy.h>
> > +#include <linux/usb/otg.h>
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> >  
> >  #include "usb.h"
> >  
> > @@ -3013,6 +3017,73 @@ void usb_remove_hcd(struct usb_hcd *hcd)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_remove_hcd);
> >  
> > +
> > +static struct otg_hcd_ops otg_hcd_intf = {
> > +	.add = usb_add_hcd,
> > +	.remove = usb_remove_hcd,
> > +	.usb_bus_start_enum = usb_bus_start_enum,
> > +	.usb_control_msg = usb_control_msg,
> > +	.usb_hub_find_child = usb_hub_find_child,
> > +};
> > +
> > +/**
> > + * usb_otg_add_hcd - Register the HCD with OTG core.
> > + * @hcd: the usb_hcd structure to initialize
> > + * @irqnum: Interrupt line to allocate
> > + * @irqflags: Interrupt type flags
> > + * @otg_dev: OTG controller device manging this HCD
> 
> %s/manging/managing
> 
> > + *
> > + * Registers the HCD with OTG core. OTG core will call usb_add_hcd()
> > + * or usb_remove_hcd() as necessary.
> > + * If otg_dev is NULL then device tree node is checked for OTG
> > + * controller device via the otg-controller property.
> > + */
> > +int usb_otg_add_hcd(struct usb_hcd *hcd,
> > +		    unsigned int irqnum, unsigned long irqflags,
> > +		    struct device *otg_dev)
> > +{
> 
> Some users may not want to use default otg_hcd_ops, would you please
> add one more parameter (eg, hcd_ops) for that? If hcd_ops is NULL, just
> use the default one.
> 

I forgot there is .start_host at otg fsm API when reviewing, so it is
ok to have a unified hcd_ops, the user can do platform things at
fsm.start_host.

-- 

Best Regards,
Peter Chen
