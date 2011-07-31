From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
 platform_device from omap_device
Date: Sat, 30 Jul 2011 20:58:07 -0600
Message-ID: <20110731025807.GA24334@ponder.secretlab.ca>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
 <1311292338-11830-9-git-send-email-khilman@ti.com>
 <20110730120332.GA15539@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41660 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1GaO01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Jul 2011 10:26:27 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so4859103wwe.1
        for <linux-omap@vger.kernel.org>; Sun, 31 Jul 2011 07:26:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110730120332.GA15539@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Sat, Jul 30, 2011 at 01:03:32PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 21, 2011 at 04:52:18PM -0700, Kevin Hilman wrote:
> > Rather than embedding a struct platform_device inside a struct
> > omap_device, decouple them, leaving only a pointer to the
> > platform_device inside the omap_device.
> > 
> > This patch uses devres to allocate and attach the omap_device to the
> > struct device, so finding an omap_device from a struct device means
> > using devres_find(), and the to_omap_device() helper function was
> > modified accordingly.
> > 
> > RFC/Hack alert:
> > 
> > Currently the driver core (drivers/base/dd.c) doesn't expect any
> > devres resources to exist before the driver's ->probe() is called.  In
> > this patch, I just comment out the warning, but we'll need to
> > understand why that limitation exists, and if it's a real limitation.
> > A first glance suggests that it's not really needed.  If this is a
> > true limitation, we'll need to find some way other than devres to
> > attach an omap_device to a struct device.
> > 
> > On OMAP, we will need an omap_device attached to a struct device
> > before probe because device HW may be disabled in probe and drivers
> > are expected to use runtime PM in ->probe() to activate the hardware
> > before access.  Because the runtime PM API calls use omap_device (via
> > our PM domain layer), we need omap_device attached to a
> > platform_device before probe.
> 
> This feels really wrong to overload devres with this.  devres purpose is
> to provide the device's _drivers_ with a way to allocate and free resources
> in such a way to avoid leaks on .remove or probe failure.  So I think that
> overloading it with something that has a different lifetime is completely
> wrong.

I disagree; extending devres to also handle device lifetime scoped
resources makes perfect sense. It is a clean extension, and struct device
is really getting rather huge.  I certainly prefer re-scoping devres
to adding more elements to struct device.

> We could add a new member to struct dev_archdata or pdev_archdata to carry
> a pointer to this data, which I think would be a far cleaner (and saner)
> way to deal with this.  In much the same way as we already have an of_node
> member in struct device.

Since this is just for omap_device, which by definition is arm-only, I
don't have any strong objection to using pdev_archdata. If it was
cross-architecture, then I'd argue strongly for the devres approach.

g.
