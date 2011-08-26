From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: How to handle named resources with DT?
Date: Fri, 26 Aug 2011 23:06:44 +1000
Message-ID: <20110826130644.GN2308@yookeroo.fritz.box>
References: <20110809205723.GE11568@ponder.secretlab.ca>
 <877h6173wm.fsf@ti.com>
 <20110826041200.GD2308@yookeroo.fritz.box>
 <201108261258.32880.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:57245 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab1HZPbU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 11:31:20 -0400
Content-Disposition: inline
In-Reply-To: <201108261258.32880.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Scott Wood <scottwood@freescale.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 26, 2011 at 12:58:32PM +0200, Arnd Bergmann wrote:
> On Friday 26 August 2011, David Gibson wrote:
> > Seriously, how many times do I have to say it?
> > 
> > 
> > Using _byname in drivers DOES NOT require adding names to the DT.
> > 
> > 
> > All it needs is some glue logic to attach names as the device tree is
> > read.  This is properly thought of as part of the code which
> > translates the device tree into struct platform_device, not as part of
> > drivers proper.
> 
> But if you do such code, the only logical place for it to live would
> be in that driver, otherwise you end up with multiple places in the
> kernel source tree that deal with the same devices and need to be
> updated in lock-step. Getting away from this mess is one of the main
> reasons for converting to device tree based probing in the first place.

Obviously it would be in the driver file, but I'd think of it more as
some metadata attached to the driver, rather than truly part of the
driver.

> > FURTHERMORE, even if there were names in the DT, you'd still need
> > this glue logic, so that drivers converted to _byname could still use
> > old device trees.
> 
> I don't think anyone was talking about converting driver /to/ the
> _byname method, the debate is mostly whether we should move away from
> that while we convert drivers to no longer rely on board code but
> instead allow them to be probed from the device tree.
> 
> > Insisting that the names come from the DT is to mistakenly think of
> > the DT as an extension of the kernel's internal interfaces, instead of
> > as the external and OS neutral data structure it actually is.
> 
> Agreed, that was my main point anyway: Getting the name from the
> device tree would be a huge mistake. By comparison, the scenario you
> describe -- adding another identifier to struct resource and initializing
> from the driver that consumes it -- would not be harmful at all, just a
> little silly when you end up with a probe function like

If you open code it this way then yes, it's silly.  But what about
something like this:

static struct of_device_id foodevice_of_match[] __devinitdata = {
	{ .compatible = "foocorp,foodevice1234",
	  .resource_names = {"base_regs", "extra_regs", }, },
	{ .compatible = "foocorp,foodevice1239",
	  .resource_names = {"base_regs", "extra_regs", "more_regs", }, }, 
	{ },
};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
