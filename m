From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 25 Jun 2012 11:51:05 -0500
Message-ID: <4FE896F9.2020806@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206090004.10086.arnd@arndb.de> <4FD914F6.6000402@ti.com> <201206141148.20371.arnd@arndb.de> <4FE4F718.3080204@ti.com> <20120622231222.GB2426@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46660 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658Ab2FYQv0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 12:51:26 -0400
In-Reply-To: <20120622231222.GB2426@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, dan.j.williams@intel.com, vinod.koul@intel.com

Hi Russell,

On 06/22/2012 06:12 PM, Russell King - ARM Linux wrote:
> Before this goes much further... one fairly obvious and important point
> must be made.
> 
> You're designing an API here.  You're designing it *WITHOUT* involving
> the two most important people in its design that there are.  The
> DMA engine maintainers.  Is this how we go about designing APIs - behind
> maintainers backs and then presenting it to the maintainers as a fait
> accompli?

Absolutely not, this was not the intent and your point is well
understood. I have added Dan and Vinod, and will ensure that he is added
in future.

> There's 86 messages in this thread, none of which have been copied to
> them in any way.  Why aren't they involved?

Initially this binding was not dma-engine centric. However, I should
have included them in this version from the beginning as I had evolved
it in that direction.

Dan, Vinod, in this thread we have been discussing the addition of a
generic device-tree binding for DMA controllers. In the below, we were
discussing the addition of a device-tree API, which would work as a
wrapper to the dma-engine dma_request_channel() API. I apologise for
adding you late into the discussion. If you have any questions/comments
let me know.

Jon

> On Fri, Jun 22, 2012 at 05:52:08PM -0500, Jon Hunter wrote:
>> Hi Arnd,
>>
>> On 06/14/2012 06:48 AM, Arnd Bergmann wrote:
>>
>> [snip]
>>
>>> This would let us handle the following cases very easily:
>>>
>>> 1. one read-write channel
>>>
>>> 	dmas = <&dmac 0x3 match>;
>>>
>>> 2. a choice of two read-write channels:
>>>
>>> 	dmas = <&dmacA 0x3 matchA>, <&dmacB 0x3 matchB>;
>>>
>>> 3. one read-channel, one write channel:
>>>
>>> 	dmas = <&dmac 0x1 match-read>, <&dmac 0x2 match-write>;
>>>
>>> 4. a choice of two read channels and one write channel:
>>>
>>> 	dmas = <&dmacA 0x1 match-readA>, <&dmacA 0x2 match-write> 
>>> 			<&dmacB match-readB>;
>>>
>>> And only the cases where we have more multiple channels that differ
>>> in more aspects would require named properties:
>>>
>>> 5. two different channels
>>>
>>> 	dmas = <&dmac 0x3 match-rwdata>, <&dmac 0x1 match-status>;
>>> 	dma-names = "rwdata", "status";
>>>
>>> 6. same as 5, but with a choice of channels:
>>>
>>> 	dmas = <&dmacA 0x3 match-rwdataA>, <&dmacA 0x1 match-status>;
>>> 		<dmacB 0x3 match-rwdataB>;
>>> 	dma-names = "rwdata", "status", "rwdata";
>>>
>>>
>>> With a definition like that, we can implement a very simple device
>>> driver interface for the common cases, and a slightly more complex
>>> one for the more complex cases:
>>>
>>> 1. chan = of_dma_request_channel(dev->of_node, 0);
>>> 2. chan = of_dma_request_channel(dev->of_node, 0);
>>> 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
>>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
>>> 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
>>>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
>>> 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
>>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
>>> 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
>>>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
>>
>> In the above examples, did you imply that the of_dma_request_channel()
>> function would return a type of "struct dma_chan" and so be calling
>> dma_request_channel() underneath?
>>
>> I am been prototyping something, but wanted to make sure I am completely
>> aligned on this :-)
>>
>> Cheers
>> Jon

