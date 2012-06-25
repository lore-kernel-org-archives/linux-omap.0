From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 25 Jun 2012 20:30:55 +0000
Message-ID: <201206252030.56025.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55070 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab2FYUbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jun 2012 16:31:12 -0400
In-Reply-To: <1340647463.1562.127.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Monday 25 June 2012, Vinod Koul wrote:
> On Mon, 2012-06-25 at 11:51 -0500, Jon Hunter wrote:
> > Hi Russell,

> > Dan, Vinod, in this thread we have been discussing the addition of a
> > generic device-tree binding for DMA controllers. In the below, we were
> > discussing the addition of a device-tree API, which would work as a
> > wrapper to the dma-engine dma_request_channel() API. I apologise for
> > adding you late into the discussion. If you have any questions/comments
> > let me know.
> Looks like this a long discussion, I will try to go through archives.
> 
> But am still unsure about about dmaengine part. If we have DT binding
> for dma controllers, why it they worry about dma_request_channel()
> IMO, the problem of channel mapping is not DT specific, it need to be
> solved at dmaengine and possibly the required mapping can come from DT
> among other mechanisms for various platforms.
> 
> This is what google told me about this patch set:

dma_request_channel is called with some information about the channel
provided in its arguments, and the driver might get that from a number
of places.

In the case of having a fully populated device tree with this binding,
the driver calling (of_)dma_request_channel does not need to know about
any of that information because we should be able to encapsulate that
completely in device tree data. It does not replace the regular interface
but wraps around it to provide a higher abstraction level where possible.

Of course if you think we should not be doing that but instead
have of_dma_request_channel() live besides dma_request_channel()
rather than calling it, that should be absolutely fine too.

> >    In the case of DMA controllers that are using DMA Engine, requesting a
> >    channel is performed by calling the following function.
> > 
> > 	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
> > 			dma_filter_fn filter_fn,
> > 			void *filter_param);
> > 
> >    The mask variable is used to identify the device controller in a list of
> >    controllers. The filter_fn and filter_param are used to identify the
> >    required dma channel and return a handle to the dma channel of type
> >    dma_chan. From the examples I have seen, the mask and filter_fn are constant
> >    for a given DMA controller. Therefore, when registering a DMA controller with
> >    device tree we can pass these parameters and store them so that a device can
> >    request them when requesting a channel. Hence, based upon this our register
> >    function for the DMA controller now looks like this.
> > 
> > 	int of_dma_controller_register(struct device_node *np,
> > 		dma_cap_mask_t *mask, dma_filter_fn fn);
> IMO we should do away with filter functions.
> If we solve the mapping problem, then we don't need a filer.

The channel data in the device tree is still in a format
that is specific to that dmaengine driver and interpreted
by it. Using the regular dma_filter_fn prototype is not
necessary, but it would be convenient because the dmaengine
code already knows how to deal with it. If we don't use this
method, how about adding another callback to struct dma_device
like

bool (*device_match)(struct dma_chan *chan, struct property *req);

> > 2. Supporting legacy devices not using DMA Engine
> > 
> >    These devices present a problem, as there may not be a uniform way to easily
> >    support them with regard to device tree. However, _IF_ legacy devices that
> >    are not using DMA Engine, only have a single DMA controller, then this
> >    problem is a lot simpler. For example, if we look at the previously proposed
> >    API for registering a DMA controller (where we pass the mask and function
> >    pointer to the DMA Engine filter function) we can simply pass NULL and hence,
> >    a driver requesting the DMA channel information would receive NULL for the
> >    DMA Engine specific parameters. Then for legacy devices we simply need a
> >    means to return the channel information (more on this later). If there are
> >    legacy devices that do have multiple DMA controllers, then maybe they need to
> >    be converted to support DMA Engine. I am not sure if this is unreasonable???
>
> Why should these be supported? They should be converted to use dmaengine
> over a reasonable amount of time.

I agree, at least for the long run. However, that is a separate issue to work on.
Right now we need a generic way to represent dma requests independent of how
they are used in the kernel. The device tree binding is supposed to be
operating system independent so there should be nothing in it that requires
the use of the linux dmaengine code.

For drivers that do not use dmaengine, we have to make a decision whether
it's worth adding support for the DT binding first and converting the driver
and its users to dmaengine later, or whether it's better to use the dmaengine
API right away to avoid having to do changes twice.

> > 3. Representing and requesting channel information
> > 
> >    From a hardware perspective, a DMA channel could be represented as ...
> > 
> >    i. channel index/number
> >    ii. channel transfer type (optional)
> >    iii. DMA interrupt mapping (optional)
> > 
> >   Please note that the transfer type is used to indicate if the transfer is to
> >   device from memory, to memory from device, to memory from memory, etc. This
> >   can be useful when there is a device such as an MMC device that uses two DMA
> >   channels, one for reading (RX) and one for writing (TX).
> >From a dma controller perspective, it can service both with single
> channel.
> I have dma controller which can talk to three peripherals on both
> transmit and receive direction. The point is that 1:1 mapping of dma
> channel does not exist. So any representation which tries to do this may
> not work. 

In the device tree, we know both the dmaengine and its slave, so we also know
whether to put one or more requests in there.

> > 
> > 	struct of_dma_channel_info {
> > 		int		dma_channel;
> > 		dma_cap_mask_t	dma_cap;
> > 		dma_filter_fn	dma_filter_func;
> > 	};
> > 
> >    Here dma_channel will always be valid and the other fields are optional
> >    depending on whether DMA Engine is used.
> > 
> > This implementation has been tested on OMAP4430 using Russell King's latest
> > DMA Engine series for OMAP [3] and with Benoit Cousson latest DT changes for
> > OMAP4 [4]. I have validated that MMC is working on the PANDA board with this
> > implementation. I have not included all the changes for PANDA board here but
> > just wished to share the implementation.
> I am still unclear on how this attempts to solve mapping problem? Maybe
> i need more coffee at midnight break!

I believe we have moved on from this proposal to a simpler one,
doing away with the of_dma_channel_info.

> > > On Fri, Jun 22, 2012 at 05:52:08PM -0500, Jon Hunter wrote:
> > >>>
> > >>> 1. chan = of_dma_request_channel(dev->of_node, 0);
> > >>> 2. chan = of_dma_request_channel(dev->of_node, 0);
> > >>> 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> > >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > >>> 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> > >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> > >>> 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> > >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> > >>> 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> > >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> > >>
> > >> In the above examples, did you imply that the of_dma_request_channel()
> > >> function would return a type of "struct dma_chan" and so be calling
> > >> dma_request_channel() underneath?
> > >>
> > >> I am been prototyping something, but wanted to make sure I am completely
> > >> aligned on this :-)

This is what I think we need to be heading to.

	Arnd
