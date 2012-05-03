From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 03 May 2012 16:26:12 -0600
Message-ID: <4FA30604.1030401@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:53328 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab2ECW0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 18:26:17 -0400
In-Reply-To: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 04/30/2012 03:17 PM, Jon Hunter wrote:
> From: Jon Hunter <jon-hunter@ti.com>
> 
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

I'll reply to the binding documentation first; perhaps that'll set the
scene for my questions better.

> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +    - #dma-cells: Number elements to describe DMA channel information. Must be
> +                  2 with current implementation but in future we could allow
> +		  more than 2 to describe interrupt mapping as well.

That makes sense.

> +    - #dma-channels: Number of DMA channels supported by the controller.
> +    - #dma-requests: Number of DMA requests signals supported by the controller.

I don't see why those properties would be mandatory in device tree. They
don't appear to be involved in parsing a DMA client's DMA specifier.
Shouldn't this information be provided at run-time by the DMA controller
driver. If it supports different HW models with different capabilities,
then it certainly could represent those values in DT, but I don't think
this should be required.

> +Example:
> +
> +	sdma: dmaengine@48000000 {
> +		compatible = "ti,omap4-sdma"
> +		reg = <0x48000000 0x1000>;
> +		interrupts = <4>;
> +		#dma-cells = <2>;
> +		#dma-channels = <32>;
> +		#dma-requests = <127>;
> +	};
> +
> +
> +* DMA client
> +
> +Client drivers should specify the DMA property using a phandle to the controller
> +followed by the number of DMA request/channel and the transfer type of the

What exactly is "request/channel"? Is it a request ID, a channel ID,
both packed into a single integer (which bits are used for each field),
etc.?

If this is up to the individual controller binding, then I think the
description should just specify that there is a phandle followed by a
DMA specifier, and the DMA specifier contains #dma-cells from the
phandle node. See other similar bindings for suitable wording.

> +channel (eg. device-to-memory, memory-to-device, memory-to-memory, etc). Drivers
> +should use the DMA Engine enum dma_transfer_direction (eg. DMA_DEV_TO_MEM,
> +DMA_MEM_TO_DEV, etc) for specifying the transfer type.

The binding document should stand alone; you shouldn't need to go look
up values in any particular OS/driver's source code. In other words,
this should explicitly enumerate the values for DMA_DEV_TO_MEM etc.
here. That said, I'm not sure it's appropriate to mandate that every DMA
controller's DMA specifier actually include this information in DT (a
controller might only support DEV_TO_MEM for example, and hence not need
this information in DT at all).

The DMA client's binding should specify how many entries it needs in the
dma property and what they mean, e.g. it should know that dma property
index 0 is the TX DMA specifier, and index 1 is the RX specifier.

> +Required property:
> +    - dma: List of phandle + dma-request/channel + transfer-type,
> +      one group per request "line".
> +
> +Example:
> +
> +	i2c1: i2c@1 {
> +		...
> +		dma = <&sdma 2 1 &sdma 3 2>;

Should that be "dmas" (plural) to be consistency with interrupts, gpios,
...?


Back to pieces of your patch description:

> v3: - avoid passing an xlate function and instead pass DMA engine parameters
>     - define number of dma channels and requests in dma-controller node

Perhaps I lack context of previous discussion, but that seems the wrong
direction, and doesn't allow DMA controllers to define the format of
their DMA specifiers.

I'd expect the process to work just like other DT bindings:

* Client calls dma_request(index)
* OF DMA core gets property, does the following until it hits index:
** Get phandle
** Get provider node for phandle
** Parses #dma-cells from provider node
** If at appropriate index:
*** call xlate/get function to convert the DMA specifier to something
that could be passed to e.g. dma_request_channel.
*** else skip that many cells and loop

Now, the structure returned from the xlate function could encompass
filter_fn and filter_param if required.

In fact, I'd expect that all xlate return something like:

struct of_dma_filter_param {
    struct device_node *node;
    dma_filter_fn filter_fn;
    void *filter_param;
};

and the following filter function to always be used for the DT case:

bool of_dma_filter_func(...)
{
    struct of_dma_filter_param *p = ...;

    /* First, only match the controller of the DT node that parsed this
       filter data */
    if (p->node != xxx->node)
        return false;

    /* Then let the individual controller do whatever match it needs */
    return p->filter_fn(xxx, p->filter_param);
}

> 3. Representing and requesting channel information
> 
>    From a hardware perspective, a DMA channel could be represented as ...
> 
>    i. channel index/number
>    ii. channel transfer type (optional)
>    iii. DMA interrupt mapping (optional)

I think the representation should be down to the individual DMA controller.

For example, Tegra has n identical DMA channels, and each can be used
with any peripheral. However, when allocating the channel, you have to
specify which peripheral request to use on that channel. So, you need to
specify DMA request ID for Tegra, not DMA channel ID.

I can imagine another DMA controller where each channel is dedicated to
one particular piece of HW (e.g. I2S controller 0 TX FIFO). In this
case, you'd need to specify DMA channel ID here, not request ID (well, I
guess they're equivalent 1:1)

This is why I think DMA controller should specify the format of their
own DMA specifier in DT, and why they should provide an xlate function
to parse that.
