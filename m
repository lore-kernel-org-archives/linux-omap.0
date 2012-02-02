From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Wed, 1 Feb 2012 21:52:07 -0700
Message-ID: <20120202045207.GH15343@ponder.secretlab.ca>
References: <4F22DEF2.5000807@ti.com>
 <20120128180602.GC2501@ponder.secretlab.ca>
 <4F285C7B.102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55697 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab2BBEwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 23:52:14 -0500
Received: by pbdu11 with SMTP id u11so1697750pbd.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 20:52:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F285C7B.102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 31, 2012 at 10:26:19PM +0100, Cousson, Benoit wrote:
> Hi Grant,
> 
> On 1/28/2012 7:06 PM, Grant Likely wrote:
> >On Fri, Jan 27, 2012 at 06:29:22PM +0100, Cousson, Benoit wrote:
> >>+EXPORT_SYMBOL_GPL(of_dma_to_resource);
> >
> >How do you see this function being used?  I ask because I don't want
> >to add it to the DT device registration code (of_platform_populate()).
> 
> Yep, that was the plan :-)
> 
> >I actually want to reduce the amount of work being done at device
> >registration time and push resolving irqs out to the device drivers.
> >The reason for this is so that drivers can resolve irqs supplied by
> >other device drivers once I've got deferred probe merged.
> 
> That make senses, but that will break all the drivers that are
> expecting IRQ and DMA resources to be already there at probe time.
> These drivers are still relying on the good old
> platform_get_resource() API.
> That will add some extra effort to the drivers migration to DT:-(

They will be broken anyway because there isn't any way for the core
code to decode DMA properties.  There isn't a consistent way that
drivers use DMA resources or any complete data about what dma engine
those resources refer to.  Unlike irqs, there is no global DMA channel
number space available to driver, which makes it really hard to
generically populate DMA channels into the resource table.

It really is much better to resolve it at .probe() time where the
driver can get unambiguous information.  Plus, as I mentioned, it
plays better with deferred probe.

> >This isn't currently possible because a lot of drivers parse the
> >resources table directly.  Those users first need to be migrated to
> >use the platform_get_irq*() APIs.
> 
> But even in that case, the device should still have the resources
> populated before probe. I'm not sure I fully understand what you
> mean here.

Ah, but once it is in an API, hooks can be implemented in the
platform_get_*() APIs to resolve relevant things at call time instead
of at device registration time.

> >DMAs have the same issue, so it is important that device drivers
> >resolve the dma specifier at .probe() time so that it can use dma
> >channels supplied by a dma device driver.
> >
> >I suspect having a common of_parse_named_phandle_with_args() will
> >useful when needing to resolve named dma resources from device
> >drivers.
> 
> So it looks like you really have a plan to deprecate all the
> platform_get_resource APIs usage from driver? At least for DMA and
> IRQ?

I definitely would like to be rid of (or refactor) the DMA get APIs
from drivers because I don't think they provide enough information
about how DMA channels are hooked up (as described above).

However, I actually prefer the platform_get_ API for irqs over
accessing the resource table directly. I can hook into it if/when I
change irqs to be resolved at .probe time.

g.

