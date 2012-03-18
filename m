From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 09:08:41 +0000
Message-ID: <20120318090841.DC4973E060A@localhost>
References: <4F22DEF2.5000807@ti.com> <20120315092652.GA16389@n2100.arm.linux.org.uk> <20120317094217.6BA143E0908@localhost> <201203171603.02230.arnd@arndb.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57493 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab2CRJIr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Mar 2012 05:08:47 -0400
Received: by wibhj6 with SMTP id hj6so2598860wib.1
        for <linux-omap@vger.kernel.org>; Sun, 18 Mar 2012 02:08:46 -0700 (PDT)
In-Reply-To: <201203171603.02230.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Thierry Reding <thierry.reding@avionic-design.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 17 Mar 2012 16:03:02 +0000, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 17 March 2012, Grant Likely wrote:
> > On Thu, 15 Mar 2012 09:26:52 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > > On Thu, Mar 15, 2012 at 09:22:06AM +0000, Arnd Bergmann wrote:
> > > > On Thursday 15 March 2012, Nicolas Ferre wrote:
> > > > > Add some basic helpers to retrieve a DMA controller device_node and the
> > > > > DMA request specifications. By making DMA controllers register a generic
> > > > > translation function, we allow the management of any type of DMA requests
> > > > > specification.
> > > > > The void * output of an of_dma_xlate() function that will be implemented
> > > > > by the DMA controller can carry any type of "dma-request" argument.
> > > > > 
> > > > > The DMA client will search its associated DMA controller in the list and
> > > > > call the registered of_dam_xlate() function to retrieve the request values.
> > > > > 
> > > > > One simple xlate function is provided for the "single number" type of
> > > > > request binding.
> > > > > 
> > > > > This implementation is independent from dmaengine so it can also be used
> > > > > by legacy drivers.
> > > > > 
> > > > > For legacy reason another API will export the DMA request number into a
> > > > > Linux resource of type IORESOURCE_DMA.
> > > > 
> > > > This looks very good. I missed the first version of this patch, but was
> > > > thinking of very similar bindings.
> > > 
> > > There's one issue which is concerning me - when we switch OMAP to use
> > > DMA engine, it won't use numeric stuff anymore but the DMA engine way
> > > of requesting a channel (match function + data).
> > > 
> > > How does that fit into this scheme?
> > 
> > Not well as the current patch set stands.  The xlate function doesn't return
> > any context for the dma channel number that it returns, so the driver cannot
> > figure out which DMA controller to use if there are multiple.
> 
> Shouldn't that be part of the data returned by xlate? I was under the impression
> that this would be the data that you would pass into dma_request_channel, together
> with a filter function that find the instance from the data.

Yes, that's my point.  The patch as it is currently written doesn't do
what it needs to.

g.

