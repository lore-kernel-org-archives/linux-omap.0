From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 26 Jun 2012 14:59:40 +0000
Message-ID: <201206261459.40766.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206252030.56025.arnd@arndb.de> <1340703613.1562.202.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58510 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902Ab2FZO7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 10:59:54 -0400
In-Reply-To: <1340703613.1562.202.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tuesday 26 June 2012, Vinod Koul wrote:
> Today, we just ask for a channel with specific mask. Further filtering
> is done in filter function as we request a channel, not a specific one.
> In most slave cases, we need a specific channel from a specific
> controller, and that is where DT can play a role. In addition to DMA
> resources for dma and client driver, I would expect DT to provide the
> channel mapping information, which is anyway known only by platform.

Can you describe what you mean by "channel mapping information"?
Is that not what we pass into the filter function?

> That should be a dmaengine binding and not client or controller
> specific. For different platforms this information can come from DT or
> something else.
> Then, once a channel is requested dmaengine knows what to provide.
> And as you see the filter becomes redundant.

But what code interprets the channel mapping then?

> On Mon, 2012-06-25 at 20:30 +0000, Arnd Bergmann wrote:
> > I agree, at least for the long run. However, that is a separate issue to work on.
> > Right now we need a generic way to represent dma requests independent of how
> > they are used in the kernel. The device tree binding is supposed to be
> > operating system independent so there should be nothing in it that requires
> > the use of the linux dmaengine code.
> > 
> > For drivers that do not use dmaengine, we have to make a decision whether
> > it's worth adding support for the DT binding first and converting the driver
> > and its users to dmaengine later, or whether it's better to use the dmaengine
> > API right away to avoid having to do changes twice.
> Latter please :)

I'd always leave that decision up to the author of each driver that gets
converted. Fortunately there are very few left that are not already using
the dmaengine interfaces.

> > > > > On Fri, Jun 22, 2012 at 05:52:08PM -0500, Jon Hunter wrote:
> > > > >>>
> > > > >>> 1. chan = of_dma_request_channel(dev->of_node, 0);
> > > > >>> 2. chan = of_dma_request_channel(dev->of_node, 0);
> > > > >>> 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> > > > >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > > > >>> 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> > > > >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > > > >>> 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> > > > >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> > > > >>> 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> > > > >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> > > > >>
> > > > >> In the above examples, did you imply that the of_dma_request_channel()
> > > > >> function would return a type of "struct dma_chan" and so be calling
> > > > >> dma_request_channel() underneath?
> > > > >>
> > > > >> I am been prototyping something, but wanted to make sure I am completely
> > > > >> aligned on this :-)
> > 
> > This is what I think we need to be heading to.
> I am not sure about this, maybe haven't understood all details yet.
> 
> But, I was hoping the DT binding will be "hidden". DMAengine driver will
> get resource information from DT. Clients will get DMA resource
> information from DT. And if possible dmaengine gets mapping information
> from DT.
> So then why should we have xx_dma_xxx apis?

I think encoding a description for a dma request in a single number is
the last thing we want to do here. We've tried that with IRQ and GPIO
numbers and it got us into a huge mess that will need a long time to
get out of.

Some platforms actually use IORESOURCE_DMA, which was useful to describe
ISA DMA channels, for encoding some form of channel or request number,
but this causes all sorts of problems. These are almost exclusively
used by those platforms that don't have a dmaengine driver yet, so I'd
hope that we can remove this as we convert those platforms over to
dmaengine and device tree.

The representation in device tree as we have it now is a combination of
a pointer to the dmaengine and a description of the request line in it,
typically a single small integer number local to the dmaengine. We should
not try to make that a global integer number again that just serves the
purpose of looking up the dmaengine and local number again.

IMHO no device driver should be bothered with any artificial resource
information, but instead I want all the DT parsing to happen in the
dmaengine code (or some wrapper around it) where it gets used. The only
thing that a device driver needs to know is that it wants to use a
channel based on what is described in the device tree.

	Arnd
