From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
Date: Sat, 30 Jul 2011 13:03:32 +0100
Message-ID: <20110730120332.GA15539@n2100.arm.linux.org.uk>
References: <1311292338-11830-1-git-send-email-khilman@ti.com> <1311292338-11830-9-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42335 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab1G3MDq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Jul 2011 08:03:46 -0400
Content-Disposition: inline
In-Reply-To: <1311292338-11830-9-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Grant Likely <grant.likely@secretlab.ca>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Jul 21, 2011 at 04:52:18PM -0700, Kevin Hilman wrote:
> Rather than embedding a struct platform_device inside a struct
> omap_device, decouple them, leaving only a pointer to the
> platform_device inside the omap_device.
> 
> This patch uses devres to allocate and attach the omap_device to the
> struct device, so finding an omap_device from a struct device means
> using devres_find(), and the to_omap_device() helper function was
> modified accordingly.
> 
> RFC/Hack alert:
> 
> Currently the driver core (drivers/base/dd.c) doesn't expect any
> devres resources to exist before the driver's ->probe() is called.  In
> this patch, I just comment out the warning, but we'll need to
> understand why that limitation exists, and if it's a real limitation.
> A first glance suggests that it's not really needed.  If this is a
> true limitation, we'll need to find some way other than devres to
> attach an omap_device to a struct device.
> 
> On OMAP, we will need an omap_device attached to a struct device
> before probe because device HW may be disabled in probe and drivers
> are expected to use runtime PM in ->probe() to activate the hardware
> before access.  Because the runtime PM API calls use omap_device (via
> our PM domain layer), we need omap_device attached to a
> platform_device before probe.

This feels really wrong to overload devres with this.  devres purpose is
to provide the device's _drivers_ with a way to allocate and free resources
in such a way to avoid leaks on .remove or probe failure.  So I think that
overloading it with something that has a different lifetime is completely
wrong.

We could add a new member to struct dev_archdata or pdev_archdata to carry
a pointer to this data, which I think would be a far cleaner (and saner)
way to deal with this.  In much the same way as we already have an of_node
member in struct device.
