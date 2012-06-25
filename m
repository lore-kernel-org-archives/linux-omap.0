From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 25 Jun 2012 23:34:23 +0530
Message-ID: <1340647463.1562.127.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201206090004.10086.arnd@arndb.de> <4FD914F6.6000402@ti.com>
	 <201206141148.20371.arnd@arndb.de> <4FE4F718.3080204@ti.com>
	 <20120622231222.GB2426@n2100.arm.linux.org.uk>  <4FE896F9.2020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60971 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab2FYSNd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 14:13:33 -0400
In-Reply-To: <4FE896F9.2020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, 2012-06-25 at 11:51 -0500, Jon Hunter wrote:
> Hi Russell,
> 
> On 06/22/2012 06:12 PM, Russell King - ARM Linux wrote:
> > Before this goes much further... one fairly obvious and important point
> > must be made.
> > 
> > You're designing an API here.  You're designing it *WITHOUT* involving
> > the two most important people in its design that there are.  The
> > DMA engine maintainers.  Is this how we go about designing APIs - behind
> > maintainers backs and then presenting it to the maintainers as a fait
> > accompli?
> 
> Absolutely not, this was not the intent and your point is well
> understood. I have added Dan and Vinod, and will ensure that he is added
> in future.
> 
> > There's 86 messages in this thread, none of which have been copied to
> > them in any way.  Why aren't they involved?
> 
> Initially this binding was not dma-engine centric. However, I should
> have included them in this version from the beginning as I had evolved
> it in that direction.
> 
> Dan, Vinod, in this thread we have been discussing the addition of a
> generic device-tree binding for DMA controllers. In the below, we were
> discussing the addition of a device-tree API, which would work as a
> wrapper to the dma-engine dma_request_channel() API. I apologise for
> adding you late into the discussion. If you have any questions/comments
> let me know.
Looks like this a long discussion, I will try to go through archives.

But am still unsure about about dmaengine part. If we have DT binding
for dma controllers, why it they worry about dma_request_channel()
IMO, the problem of channel mapping is not DT specific, it need to be
solved at dmaengine and possibly the required mapping can come from DT
among other mechanisms for various platforms.

This is what google told me about this patch set:


> Design of DMA helpers
> 
> 1. Supporting devices with multiple DMA controllers
> 
>    In the case of DMA controllers that are using DMA Engine, requesting a
>    channel is performed by calling the following function.
> 
> 	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
> 			dma_filter_fn filter_fn,
> 			void *filter_param);
> 
>    The mask variable is used to identify the device controller in a list of
>    controllers. The filter_fn and filter_param are used to identify the
>    required dma channel and return a handle to the dma channel of type
>    dma_chan. From the examples I have seen, the mask and filter_fn are constant
>    for a given DMA controller. Therefore, when registering a DMA controller with
>    device tree we can pass these parameters and store them so that a device can
>    request them when requesting a channel. Hence, based upon this our register
>    function for the DMA controller now looks like this.
> 
> 	int of_dma_controller_register(struct device_node *np,
> 		dma_cap_mask_t *mask, dma_filter_fn fn);
IMO we should do away with filer functions.
If we solve the mapping problem, then we don't need a filer.
> 
> 2. Supporting legacy devices not using DMA Engine
> 
>    These devices present a problem, as there may not be a uniform way to easily
>    support them with regard to device tree. However, _IF_ legacy devices that
>    are not using DMA Engine, only have a single DMA controller, then this
>    problem is a lot simpler. For example, if we look at the previously proposed
>    API for registering a DMA controller (where we pass the mask and function
>    pointer to the DMA Engine filter function) we can simply pass NULL and hence,
>    a driver requesting the DMA channel information would receive NULL for the
>    DMA Engine specific parameters. Then for legacy devices we simply need a
>    means to return the channel information (more on this later). If there are
>    legacy devices that do have multiple DMA controllers, then maybe they need to
>    be converted to support DMA Engine. I am not sure if this is unreasonable???
Why should these be supported? They should be converted to use dmaengine
over a reasonable amount of time.
> 
> 3. Representing and requesting channel information
> 
>    From a hardware perspective, a DMA channel could be represented as ...
> 
>    i. channel index/number
>    ii. channel transfer type (optional)
>    iii. DMA interrupt mapping (optional)
> 
>   Please note that the transfer type is used to indicate if the transfer is to
>   device from memory, to memory from device, to memory from memory, etc. This
>   can be useful when there is a device such as an MMC device that uses two DMA
>   channels, one for reading (RX) and one for writing (TX).
>From a dma controller perspective, it can service both with single
channel.
I have dma controller which can talk to three peripherals on both
transmit and receive direction. The point is that 1:1 mapping of dma
channel does not exist. So any representation which tries to do this may
not work. 
> 
>   Forgetting device tree for now, some drivers use strings to represent a
>   DMA channel instead of using an integer. I assume that these drivers then
>   employ some sort of look-up table to convert the string into a channel
>   number/index that the hardware understands. If this assumption is correct
>   then when moving to a device tree implementation having such look-up tables
>   in the driver should no longer be necessary as the device tree will provide
>   the mapping of channel index/number to the device. Furthermore, it makes
>   sense that device tree uses integers to represent channel as opposed to
>   strings to save the driver having to convert the string into a integer at
>   some later stage.
> 
>   Next we need to think about how the DMA controller and channels are described
>   in the device tree itself. The following device tree node example describes
>   the properties of the DMA controller that includes, the register address
>   range, number of interrupt supported, number of channels and number of request
>   signals. This has been enhanced from the previous versions by adding number of
>   channels and number of request signals.
> 
> 	sdma: dma-controller@4A056000 {
> 		compatible = "ti,omap4-sdma";
> 		reg = <0x4A056000 0x1000>;
> 		interrupts = <4>;
> 		#dma-cells = <2>;
> 		#dma-channels = <32>;
> 		#dma-requests = <127>;
> 	};
> 
>   Given the above controller definition, DMA resources for a device, such as an
>   MMC that uses two DMA channels, can be declared as follows.
> 
> 	mmc1: mmc@4809c000 {
> 		...
> 		dma = <&sdma 61 1 &sdma 62 2>;
> 		...
> 	};
> 
>    The above syntax to represent each DMA resource is "controller-phandle +
>    dma-channel + transfer-type". The transfer-type here is defined to match the
>    types in DMA Engine dma_transfer_direction enumeration
>    (see include/linux/dmaengine.h). Hence, a "1" means DMA_MEM_TO_DEV and a "2"
>    means "DMA_DEV_TO_MEM". This will be helpful later when requesting the
>    channel information. You will also notice here that there is no entry for
>    representing the interrupt used by the DMA channel and this is because this
>    version has not added this capability. I believe that this will be important
>    to define in the device tree, but at the moment this has been left out purely
>    because passing this information was not supported for the device (OMAP) that
>    I was using to implement this. This could be easily added if people find this
>    implementation acceptable.
> 
>    A driver can now request the DMA channel information by calling the following
>    function.
> 
> 	int of_get_dma_channel_info(struct device_node *np, int type,
> 		       struct of_dma_channel_info *info)
> 
>    Where type represents the transfer-type (again the DMA Engine
>    dma_transfer_direction enumeration can be used here regardless of if DMA
>    Engine is used) and of_dma_channel_info is defined as follows.
> 
> 	struct of_dma_channel_info {
> 		int		dma_channel;
> 		dma_cap_mask_t	dma_cap;
> 		dma_filter_fn	dma_filter_func;
> 	};
> 
>    Here dma_channel will always be valid and the other fields are optional
>    depending on whether DMA Engine is used.
> 
> This implementation has been tested on OMAP4430 using Russell King's latest
> DMA Engine series for OMAP [3] and with Benoit Cousson latest DT changes for
> OMAP4 [4]. I have validated that MMC is working on the PANDA board with this
> implementation. I have not included all the changes for PANDA board here but
> just wished to share the implementation.
I am still unclear on how this attempts to solve mapping problem? Maybe
i need more coffee at midnight break!


> > On Fri, Jun 22, 2012 at 05:52:08PM -0500, Jon Hunter wrote:
> >> Hi Arnd,
> >>
> >> On 06/14/2012 06:48 AM, Arnd Bergmann wrote:
> >>
> >> [snip]
> >>
> >>> This would let us handle the following cases very easily:
> >>>
> >>> 1. one read-write channel
> >>>
> >>> 	dmas = <&dmac 0x3 match>;
> >>>
> >>> 2. a choice of two read-write channels:
> >>>
> >>> 	dmas = <&dmacA 0x3 matchA>, <&dmacB 0x3 matchB>;
> >>>
> >>> 3. one read-channel, one write channel:
> >>>
> >>> 	dmas = <&dmac 0x1 match-read>, <&dmac 0x2 match-write>;
> >>>
> >>> 4. a choice of two read channels and one write channel:
> >>>
> >>> 	dmas = <&dmacA 0x1 match-readA>, <&dmacA 0x2 match-write> 
> >>> 			<&dmacB match-readB>;
> >>>
> >>> And only the cases where we have more multiple channels that differ
> >>> in more aspects would require named properties:
> >>>
> >>> 5. two different channels
> >>>
> >>> 	dmas = <&dmac 0x3 match-rwdata>, <&dmac 0x1 match-status>;
> >>> 	dma-names = "rwdata", "status";
> >>>
> >>> 6. same as 5, but with a choice of channels:
> >>>
> >>> 	dmas = <&dmacA 0x3 match-rwdataA>, <&dmacA 0x1 match-status>;
> >>> 		<dmacB 0x3 match-rwdataB>;
> >>> 	dma-names = "rwdata", "status", "rwdata";
> >>>
> >>>
> >>> With a definition like that, we can implement a very simple device
> >>> driver interface for the common cases, and a slightly more complex
> >>> one for the more complex cases:
> >>>
> >>> 1. chan = of_dma_request_channel(dev->of_node, 0);
> >>> 2. chan = of_dma_request_channel(dev->of_node, 0);
> >>> 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> >>> 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
> >>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> >>> 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> >>> 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
> >>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> >>
> >> In the above examples, did you imply that the of_dma_request_channel()
> >> function would return a type of "struct dma_chan" and so be calling
> >> dma_request_channel() underneath?
> >>
> >> I am been prototyping something, but wanted to make sure I am completely
> >> aligned on this :-)
> >>
> >> Cheers
> >> Jon
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod

