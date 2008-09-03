From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Git tree updated to v2.6.27-rc5, some USB diffs still lurking
Date: Thu, 4 Sep 2008 00:27:54 +0100
Message-ID: <20080903232754.GR19980@flint.arm.linux.org.uk>
References: <20080903221218.GD23085@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54835 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957AbYICX2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 19:28:05 -0400
Content-Disposition: inline
In-Reply-To: <20080903221218.GD23085@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>

On Wed, Sep 03, 2008 at 03:12:19PM -0700, Tony Lindgren wrote:
> @@ -2687,7 +2696,7 @@
>  	udc->gadget.name = driver_name;
>  
>  	device_initialize(&udc->gadget.dev);
> -	dev_set_name(&udc->gadget.dev, "gadget");
> +	strcpy (udc->gadget.dev.bus_id, "gadget");

FWIW, this one looks like a mismerge with the change converting direct
accesses to dev.bus_id to use accessors.

> +MODULE_ALIAS("omap-ehci");
> +static struct platform_driver ehci_hcd_omap_driver = {
> +	.probe = ehci_hcd_omap_drv_probe,
> +	.remove = ehci_hcd_omap_drv_remove,
> +	.shutdown = usb_hcd_platform_shutdown,
> +	/*.suspend      = ehci_hcd_omap_drv_suspend, */
> +	/*.resume       = ehci_hcd_omap_drv_resume, */
> +	.driver = {
> +		.name = "ehci-omap",
> +		.bus = &platform_bus_type

No need to set .bus.

> +#ifndef __EHCI_OMAP_H
> +#define __EHCI_OMAP_H
> +
> +#include <mach/hardware.h>
> +#include "../../../arch/arm/mach-omap2/cm.h"
> +#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"

Such includes need to die.

> +#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
> +#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
> +#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
> +	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
> +	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3

And, fyi, gcc may currently accept this, but I seem to remember that
the C standard doesn't permit this - the '#' should always be in
column 0, optionally followed by white space before the directive.

> +#include <mach/memory.h>

Should be asm/memory.h (same for all other occurances.)

And some of these asm/arch/ -> mach/ conversions look like missed stuff
from the includes move, so should be a high priority to get into the
next -rc.  Tony: please sort out a patch and put it in my patch system
for these.
