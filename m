From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 4 May 2012 14:19:53 -0500
Message-ID: <4FA42BD9.3090705@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FA30604.1030401@wwwdotorg.org> <4FA3F08D.7030603@ti.com> <4FA41E3E.3020303@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274Ab2EDTUR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 15:20:17 -0400
In-Reply-To: <4FA41E3E.3020303@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Stephen,

On 05/04/2012 01:21 PM, Stephen Warren wrote:
> On 05/04/2012 09:06 AM, Jon Hunter wrote:
>> Hi Stephen,
>>
>> On 05/03/2012 05:26 PM, Stephen Warren wrote:
>>> On 04/30/2012 03:17 PM, Jon Hunter wrote:
>>>> From: Jon Hunter <jon-hunter@ti.com>
>>>>
>>>> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
>>>> to add some basic helpers to retrieve a DMA controller device_node and the
>>>> DMA request/channel information.
> ...
>>>> +
>>>> +	sdma: dmaengine@48000000 {
>>>> +		compatible = "ti,omap4-sdma"
>>>> +		reg = <0x48000000 0x1000>;
>>>> +		interrupts = <4>;
>>>> +		#dma-cells = <2>;
>>>> +		#dma-channels = <32>;
>>>> +		#dma-requests = <127>;
>>>> +	};
>>>> +
>>>> +
>>>> +* DMA client
>>>> +
>>>> +Client drivers should specify the DMA property using a phandle to the controller
>>>> +followed by the number of DMA request/channel and the transfer type of the
>>>
>>> What exactly is "request/channel"? Is it a request ID, a channel ID,
>>> both packed into a single integer (which bits are used for each field),
>>> etc.?
>>
>> The thought here was that some DMAs may distinguish between devices by a
>> request ID or a channel ID or both. In the case of say an OMAP4, we have
>> 32 channels and 127 request IDs. From a h/w perspective we need to know
>> both. Each of the 32 channels can be programmed to use any one of the
>> 127 h/w request signals.
> 
> From a HW perspective, do you actually need to know both? I think the HW
> description must specify the request ID, but because any channel can be
> programmed to any request ID, you don't actually care about the channel
> ID; it can be dynamically allocated by the DMA driver when the client
> driver calls dma_request_channel().

>From the perspective of a driver using the DMA, no. However, I thought
that having the number of programmable channels stored in the device
tree could be useful so that the DMA driver could query how many
programmable channels are available. So my point was the DMA driver
needs to know how many channels it has. However, this does not need to
belong in the device tree. I added it for completeness of the DMA
controller description really. Does that make sense?

> Actually, you say the following below, so I guess you already agree here:

Yes.

>> Yes this is the same as OMAPs SDMA. In the case of such DMA controllers
>> you only really care about the request ID and total number of channels
>> that are available to you.
> 
> ...
>>> This is why I think DMA controller should specify the format of their
>>> own DMA specifier in DT, and why they should provide an xlate function
>>> to parse that.
>>
>> Ok fair enough. However, it seems that at a minimum we could provide one
>> or two xlate functions in the generic binding for people to use. One
>> could be the DMA engine xlate binding and another could be the simple
>> xlate binding Nicolas proposed for a DMA controller that returns a
>> single channel/request ID.
>>
>> However, at the same time, may be people would prefer that devices such
>> as tegra, omap, at91, etc, offer their own xlate function for DMA
>> engine. I am not sure, but we could go either way.
> 
> I'd expect the bindings to be written to allow the individual DMA
> controllers to have complete control over the meaning of the DMA specifier.

Ok.

> That said, I would certainly expect some common patterns to emerge, such
> as a single cell to specify the DMA channel ID, or a single cell to
> specify the DMA request/selector ID. We should certainly make sure that
> where different controllers need the same information, they use the same
> way to represent it, and use common utility code to implement the xlate
> functionality. We could perhaps even write these common cases into the
> core DMA bindings as examples to help ensure uniformity. However, we
> just need to do this in a way that allows other cases too.

Yes this makes sense. I could have a go at re-writing next week sometime.

Thanks
Jon
