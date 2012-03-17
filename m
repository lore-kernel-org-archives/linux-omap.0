From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sat, 17 Mar 2012 16:03:02 +0000
Message-ID: <201203171603.02230.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <20120315092652.GA16389@n2100.arm.linux.org.uk> <20120317094217.6BA143E0908@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59320 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab2CQQDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Mar 2012 12:03:30 -0400
In-Reply-To: <20120317094217.6BA143E0908@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Thierry Reding <thierry.reding@avionic-design.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday 17 March 2012, Grant Likely wrote:
> On Thu, 15 Mar 2012 09:26:52 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Thu, Mar 15, 2012 at 09:22:06AM +0000, Arnd Bergmann wrote:
> > > On Thursday 15 March 2012, Nicolas Ferre wrote:
> > > > Add some basic helpers to retrieve a DMA controller device_node and the
> > > > DMA request specifications. By making DMA controllers register a generic
> > > > translation function, we allow the management of any type of DMA requests
> > > > specification.
> > > > The void * output of an of_dma_xlate() function that will be implemented
> > > > by the DMA controller can carry any type of "dma-request" argument.
> > > > 
> > > > The DMA client will search its associated DMA controller in the list and
> > > > call the registered of_dam_xlate() function to retrieve the request values.
> > > > 
> > > > One simple xlate function is provided for the "single number" type of
> > > > request binding.
> > > > 
> > > > This implementation is independent from dmaengine so it can also be used
> > > > by legacy drivers.
> > > > 
> > > > For legacy reason another API will export the DMA request number into a
> > > > Linux resource of type IORESOURCE_DMA.
> > > 
> > > This looks very good. I missed the first version of this patch, but was
> > > thinking of very similar bindings.
> > 
> > There's one issue which is concerning me - when we switch OMAP to use
> > DMA engine, it won't use numeric stuff anymore but the DMA engine way
> > of requesting a channel (match function + data).
> > 
> > How does that fit into this scheme?
> 
> Not well as the current patch set stands.  The xlate function doesn't return
> any context for the dma channel number that it returns, so the driver cannot
> figure out which DMA controller to use if there are multiple.

Shouldn't that be part of the data returned by xlate? I was under the impression
that this would be the data that you would pass into dma_request_channel, together
with a filter function that find the instance from the data.

That's why I suggested adding another helper function that would provide a
generic filter function for the dt binding doing just that.

	Arnd
