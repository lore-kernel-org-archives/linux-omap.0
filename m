From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 7/7] WIP: HACK/RFC: omap_device: begin to decouple
	platform_device from omap_device
Date: Tue, 2 Aug 2011 00:09:45 +0100
Message-ID: <20110801230945.GB21535@n2100.arm.linux.org.uk>
References: <1311292338-11830-9-git-send-email-khilman@ti.com> <20110730120332.GA15539@n2100.arm.linux.org.uk> <20110731025807.GA24334@ponder.secretlab.ca> <20110731150540.GA3019@n2100.arm.linux.org.uk> <871ux5nnop.fsf@ti.com> <CACxGe6t4tNeD-Pn6WFt1XOMC=_Q0cf4uD3kRkOckKH+S1JUJDA@mail.gmail.com> <20110801185009.GA5217@legolas.emea.dhcp.ti.com> <20110801200743.GA21535@n2100.arm.linux.org.uk> <87pqkon5n6.fsf@ti.com> <20110801225554.GC6244@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53630 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1HAXKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 19:10:02 -0400
Content-Disposition: inline
In-Reply-To: <20110801225554.GC6244@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, "G. Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Tue, Aug 02, 2011 at 01:55:55AM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Aug 01, 2011 at 03:11:57PM -0700, Kevin Hilman wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > Help the typechecker do its job.  As we have only one (at the moment...)
> > > And make it:
> > >
> > > +struct omap_device;
> > >
> > >  struct pdev_archdata {
> > > +#ifdef CONFIG_ARCH_OMAP
> > > +	struct omap_device *omap;
> > > +#endif
> > >  };
> > >
> > > for bonus points, so we only get the additional pointer for OMAP.
> > 
> > OK, will do it this way.
> 
> this has the tendency to grow larger, no ? What if all other ARMs decide
> to add their own pointers there too ?

Their pointers for what?  It's only OMAP which has this special omap_device
thing.  Should that spread, instead of adding more pointers here, the work
should be to consolidate between those various implementations.
