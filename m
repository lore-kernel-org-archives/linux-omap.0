From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Wed, 3 Sep 2008 16:52:25 -0700
Message-ID: <20080903235223.GI23085@atomide.com>
References: <20080903221218.GD23085@atomide.com> <20080903232754.GR19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64825 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbYICXwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 19:52:35 -0400
Content-Disposition: inline
In-Reply-To: <20080903232754.GR19980@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Nishant Kamat <nskamat@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080903 16:28]:
> On Wed, Sep 03, 2008 at 03:12:19PM -0700, Tony Lindgren wrote:
> > @@ -2687,7 +2696,7 @@
> >  	udc->gadget.name = driver_name;
> >  
> >  	device_initialize(&udc->gadget.dev);
> > -	dev_set_name(&udc->gadget.dev, "gadget");
> > +	strcpy (udc->gadget.dev.bus_id, "gadget");
> 
> FWIW, this one looks like a mismerge with the change converting direct
> accesses to dev.bus_id to use accessors.

OK thanks, fixed in l-o tree to use dev_set_name like mainline kernel
does.

> > +MODULE_ALIAS("omap-ehci");
> > +static struct platform_driver ehci_hcd_omap_driver = {
> > +	.probe = ehci_hcd_omap_drv_probe,
> > +	.remove = ehci_hcd_omap_drv_remove,
> > +	.shutdown = usb_hcd_platform_shutdown,
> > +	/*.suspend      = ehci_hcd_omap_drv_suspend, */
> > +	/*.resume       = ehci_hcd_omap_drv_resume, */
> > +	.driver = {
> > +		.name = "ehci-omap",
> > +		.bus = &platform_bus_type
> 
> No need to set .bus.
> 
> > +#ifndef __EHCI_OMAP_H
> > +#define __EHCI_OMAP_H
> > +
> > +#include <mach/hardware.h>
> > +#include "../../../arch/arm/mach-omap2/cm.h"
> > +#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
> 
> Such includes need to die.
> 
> > +#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
> > +#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
> > +#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
> > +	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
> > +	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
> 
> And, fyi, gcc may currently accept this, but I seem to remember that
> the C standard doesn't permit this - the '#' should always be in
> column 0, optionally followed by white space before the directive.

Vikram & Nishant, can you please fix the above comments for your echi-omap
patch for linux-usb?

> > +#include <mach/memory.h>
> 
> Should be asm/memory.h (same for all other occurances.)
> 
> And some of these asm/arch/ -> mach/ conversions look like missed stuff
> from the includes move, so should be a high priority to get into the
> next -rc.  Tony: please sort out a patch and put it in my patch system
> for these.

OK, fixed for l-o tree. Felipe has the include fixes patch in Greg's
queue, but looks like that needs updating too. Felipe, can you take
care of that?

Thanks,

Tony
