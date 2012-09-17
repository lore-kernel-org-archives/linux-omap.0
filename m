From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a
	slave DMA channel
Date: Mon, 17 Sep 2012 23:36:19 +0100
Message-ID: <20120917223619.GC12445@n2100.arm.linux.org.uk>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-3-git-send-email-jon-hunter@ti.com> <1347852805.1943.130.camel@vkoul-udesk3> <201209171159.27359.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34646 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab2IQWgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Sep 2012 18:36:54 -0400
Content-Disposition: inline
In-Reply-To: <201209171159.27359.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Jon Hunter <jon-hunter@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <djbw@fb.com>

On Mon, Sep 17, 2012 at 11:59:27AM +0000, Arnd Bergmann wrote:
> On Monday 17 September 2012, Vinod Koul wrote:
> > On Fri, 2012-09-14 at 17:41 -0500, Jon Hunter wrote:
> > > +/**
> > > + * dma_request_slave_channel - try to allocate an exclusive slave
> > > channel
> > > + * @dev:       pointer to client device structure
> > > + * @name:      slave channel name
> > > + */
> > > +struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
> > > +{
> > > +       /* If device-tree is present get slave info from here */
> > > +       if (dev->of_node)
> > > +               return of_dma_request_slave_channel(dev->of_node, name);
> > > +
> > Shouldn't this be conditionally compiled only when OF is built. I think
> > this might be problematic for systems which doesn't have device tree.
> > Or perhaps you can declare these symbols as dummy in of_dma.h when
> > device tree is not selected.
> 
> Right, good point. I'd prefer the dummy functions, since that is in line
> with what a lot of other subsystems do:
> 
> #ifdef CONFIG_OF
> extern int of_dma_controller_register(struct device_node *np,
>                struct dma_chan *(*of_dma_xlate)
>                (struct of_phandle_args *, struct of_dma *),
>                void *data);
> extern void of_dma_controller_free(struct device_node *np);
> extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>                                                     char *name);
> extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>                struct of_dma *ofdma);
> #else
> static inline int of_dma_controller_register(struct device_node *np,
>                struct dma_chan *(*of_dma_xlate)
>                (struct of_phandle_args *, struct of_dma *),
>                void *data)
> {
> 	return -ENODEV;
> }
> static inline void of_dma_controller_free(struct device_node *np)
> {
> }
> static inline struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>                                                     char *name)
> {
> 	return NULL;
> }
> static inline struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>                struct of_dma *ofdma)
> {
> 	return NULL;
> }
> #endif
> 
> I believe that Jon is on vacation this week, so if this is the only issue
> holding up the merge, maybe you can change this in his patch directly, or
> I can send an updated version if you prefer.

I worry that too much is going on here too quickly.  We have some people
working on changing the way DMA engine selects channels.  Meanwhile we
have other people trying to create an OF DMA engine API.

It seems that Vinod's working on a way for platforms to specify bindings
to the DMA engine code, and the DMA engine code itself selects the
appropriate channel.  This patch, on the other hand, introduces a set of
translation functions which need to be provided by platform code,
which returns the dma_chan pointer.

This sounds like a recipe for a total abortion of interfaces.  Only one
of those two activities should be going on at any one time, or if they
have to occur, they need coordination so that the we don't end up with
two totally different schemes.

In the mad rush to DTify everything, don't make hasty decisions, because
it is very difficult to change it later - especially something like this
which defines how DT encodes this information.
