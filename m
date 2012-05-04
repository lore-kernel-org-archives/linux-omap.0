From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 12:19:10 -0500
Message-ID: <4FA40F8E.5010204@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205041556.38918.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2EDRT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 13:19:28 -0400
In-Reply-To: <201205041556.38918.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>

Hi Arnd,

On 05/04/2012 10:56 AM, Arnd Bergmann wrote:
> On Monday 30 April 2012, Jon Hunter wrote:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
>> to add some basic helpers to retrieve a DMA controller device_node and the
>> DMA request/channel information.
> 
> Thanks for picking this up again, I very much appreciate it as not
> having the binding is blocking a number of other activities.

No problem.

>> Design of DMA helpers
>>
>> 1. Supporting devices with multiple DMA controllers
>>
>>    In the case of DMA controllers that are using DMA Engine, requesting a
>>    channel is performed by calling the following function.
>>
>> 	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
>> 			dma_filter_fn filter_fn,
>> 			void *filter_param);
>>
>>    The mask variable is used to identify the device controller in a list of
>>    controllers. The filter_fn and filter_param are used to identify the
>>    required dma channel and return a handle to the dma channel of type
>>    dma_chan. From the examples I have seen, the mask and filter_fn are constant
>>    for a given DMA controller.
> 
> I believe this is not entirely correct: sometimes the filter_fn is provided
> by the slave driver, sometimes by the master driver.

Ok, but in the master case I assume they still use the same API?

> Also, the mask does not identify a specific controller, AFAICT it just
> provides certain constraints. There are cases where a driver can pick
> from a multitude of dma engine controllers, as long as the channel
> the constraints are resolved.

True, but this should still work in that case.

> This could be expressed in the device tree by listing multiple dma
> request lines (one per controller) in the device using it, or the
> author of the device tree can pick one.
> 
>>    Therefore, when registering a DMA controller with
>>    device tree we can pass these parameters and store them so that a device can
>>    request them when requesting a channel. Hence, based upon this our register
>>    function for the DMA controller now looks like this.
>>
>> 	int of_dma_controller_register(struct device_node *np,
>> 		dma_cap_mask_t *mask, dma_filter_fn fn);
> 
> This changes the behavior for drivers that provide their own filter
> functions, which may or may not be a problem.
> For examples, have a look at some of these:
> 
> drivers/spi/spi-ep93xx.c
> drivers/mmc/host/tmio_mmc_dma.c
> drivers/usb/renesas_usbhs/fifo.c

Ok, thanks for the references! That makes life a little more tricky!

>> 2. Supporting legacy devices not using DMA Engine
>>
>>    These devices present a problem, as there may not be a uniform way to easily
>>    support them with regard to device tree. However, _IF_ legacy devices that
>>    are not using DMA Engine, only have a single DMA controller, then this
>>    problem is a lot simpler. For example, if we look at the previously proposed
>>    API for registering a DMA controller (where we pass the mask and function
>>    pointer to the DMA Engine filter function) we can simply pass NULL and hence,
>>    a driver requesting the DMA channel information would receive NULL for the
>>    DMA Engine specific parameters. Then for legacy devices we simply need a
>>    means to return the channel information (more on this later). If there are
>>    legacy devices that do have multiple DMA controllers, then maybe they need to
>>    be converted to support DMA Engine. I am not sure if this is unreasonable???
> 
> I think it's even simpler: any device that uses another interface instead
> of dmaengine will just have to parse the DT information itself. We should
> make sure that it uses the same binding though, so we can later migrate
> to the dmaengine API without having to change the device trees.

Yes agreed.

>> 3. Representing and requesting channel information
>>
>>    From a hardware perspective, a DMA channel could be represented as ...
>>
>>    i. channel index/number
>>    ii. channel transfer type (optional)
>>    iii. DMA interrupt mapping (optional)
>>
>>   Please note that the transfer type is used to indicate if the transfer is to
>>   device from memory, to memory from device, to memory from memory, etc. This
>>   can be useful when there is a device such as an MMC device that uses two DMA
>>   channels, one for reading (RX) and one for writing (TX).
>>
>>   Forgetting device tree for now, some drivers use strings to represent a
>>   DMA channel instead of using an integer. I assume that these drivers then
>>   employ some sort of look-up table to convert the string into a channel
>>   number/index that the hardware understands. If this assumption is correct
>>   then when moving to a device tree implementation having such look-up tables
>>   in the driver should no longer be necessary as the device tree will provide
>>   the mapping of channel index/number to the device. Furthermore, it makes
>>   sense that device tree uses integers to represent channel as opposed to
>>   strings to save the driver having to convert the string into a integer at
>>   some later stage.
>>
>>   Next we need to think about how the DMA controller and channels are described
>>   in the device tree itself. The following device tree node example describes
>>   the properties of the DMA controller that includes, the register address
>>   range, number of interrupt supported, number of channels and number of request
>>   signals. This has been enhanced from the previous versions by adding number of
>>   channels and number of request signals.
> 
> I think you can actually use strings, too, as long as you use a fixed number
> of cells.
> 
> Wouldn't something like this work:?
> 
> 	dma-controller1: dma1 {
> 		compatible = "something-using-strings";
> 		#dma-cells = <1>;
> 	};
> 
> 	dma-controller2: dma2 {
> 		compatible = "something-using-integers";
> 		#dma-cells = <3>
> 	};
> 
> 	some-device {
> 		compatible = "something";
> 		dmas = <&dma-controller1>, "some-dma",
> 			<&dma-controller2 1 2 3>;
> 	}
> 
> The only hard requirement is that the format of the attributes is
> what the binding specific to that controller understands.

Yes it could. My point was why do this, if at the end of the day you
need to resolve the string into a number at some point in the driver?
However, this may make the migration easier for those using strings.

>>    A driver can now request the DMA channel information by calling the following
>>    function.
>>
>> 	int of_get_dma_channel_info(struct device_node *np, int type,
>> 		       struct of_dma_channel_info *info)
>>
>>    Where type represents the transfer-type (again the DMA Engine
>>    dma_transfer_direction enumeration can be used here regardless of if DMA
>>    Engine is used) and of_dma_channel_info is defined as follows.
>>
>> 	struct of_dma_channel_info {
>> 		int		dma_channel;
>> 		dma_cap_mask_t	dma_cap;
>> 		dma_filter_fn	dma_filter_func;
>> 	};
>>
>>    Here dma_channel will always be valid and the other fields are optional
>>    depending on whether DMA Engine is used.
> 
> I think a better interface for the device driver would be something that combines
> your of_get_dma_channel_info() function with the dma_request_channel() function,
> like
> 
> 	struct dma_chan *of_dma_request_channel(struct device_node *dn, int index);
> 
> When we have the device tree, the driver using that channel doesn't actually have
> to care about the specific of how the channel is defined any more, it just needs
> to say which one it's interested in, out of the list of channels defined for that
> device node.

Yes true. I was trying to avoid any changes to DMA engine itself. Plus
in the feedback from Stephen his preference was to isolate the binding
from DMA engine.

So in your example, is index passed via dma_request_channel()? I assume
that of_dma_request_channel() get called in the context of
dma_request_channel somewhere???

By the way, have you looked at the pl330_filter() function
(drivers/dma/pl330.c)? They parse the device-tree in the filter function
itself. The index could be passed as the filter_param. In this type of
implementation there would be no need for a generic dma binding.
However, would only work for devices supporting DMA engine.

Cheers
Jon
