From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 14 Jun 2012 10:39:16 -0500
Message-ID: <4FDA05A4.5090301@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206090004.10086.arnd@arndb.de> <4FD914F6.6000402@ti.com> <201206141148.20371.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50077 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755930Ab2FNPjc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 11:39:32 -0400
In-Reply-To: <201206141148.20371.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 06/14/2012 06:48 AM, Arnd Bergmann wrote:
> On Wednesday 13 June 2012, Jon Hunter wrote:
> 
>>> As I said previously, I think just encoding the direction but not
>>> the client specific ID (meaning we would have to disambiguate
>>> the more complex cases that Stephen mentioned using a dma-names
>>> property) would be the best because it keeps the common case simple,
>>> but I could live with other things going in there too.
>>
>> Ok, so you are saying that there are some DMA controllers where there is
>> no channel/request ID and only a direction is needed? So an even simpler
>> case than what I had imagined.
> 
> No, that was not the case I was thinking about.

Ok, good because that would be the most simple dma controller I have
heard about ;-)

>> So in that case, I don't see why the first cell after the phandle could
>> not be an index which could be either a direction or request-id and then
>> the next cell after that be a secondary match variable.
>>
>> So simple case with just a index (either req-id or direction) ...
>>
>> dmas = <&dmac0 index>
>>
>> More complex case ...
>>
>> dmas = <&dmac0 index match>
>>
>> For example, for OMAP index = req-id and match = direction ...
>>
>> dmas = <&dmac0 req-id direction>
>>
>> Or am I way off the page?
> 
> The intention was instead to remove the need for the /index/ in those
> cases, because having a client-specific index in here makes it inconsistent
> with other similar bindings (reg, interrupts, gpios, ...) that people
> are familiar with. They use an implicit index by counting the
> fields in the respective properties.

So maybe "index" was not the right term to use here. What I meant was
that this is really the req/chan-id associated with this device. It is
not an arbitrary index that in turn gets resolved into the req-id. So in
other words, just like gpio where you have the gpio number, here you
have the dma req-id.

> The existing method we have for avoiding index numbers is to use
> named fields, like
> 
> 	dmas = <&dmac0 matchA>, <dmac1 matchB>, <dmac2 matchC>;
> 	dma-names = "rx", "rx", "tx";
> 
> This is similar to how we use named interrupt and mmio resources, but
> it requires that we always request the dma lines by name, which is
> slightly more complex than we might want it to be.

Ok, but how do you get the req-id from the above binding? Doesn't it
need to be stored there somewhere even for the most simplest case? Or
are you saying that in this case you are just returning a name and the
dma driver resolves that into a req-id?

> Because the vast majority of cases just use a single channel, or one
> channel per direction, my idea was to encode the direction in the
> dmas property, which lets us request a dma channel by direction from
> the driver side, without explicitly encoding the name.

Yes, thats fine and so the direction is really the match criteria in
this case.

> This would let us handle the following cases very easily:
> 
> 1. one read-write channel
> 
> 	dmas = <&dmac 0x3 match>;

Where 0x3 is the req-id? Just to confirm ;-)

Why not have match after the phandle to be consistent with the simple
example using name fields above?

> 2. a choice of two read-write channels:
> 
> 	dmas = <&dmacA 0x3 matchA>, <&dmacB 0x3 matchB>;
> 
> 3. one read-channel, one write channel:
> 
> 	dmas = <&dmac 0x1 match-read>, <&dmac 0x2 match-write>;
> 
> 4. a choice of two read channels and one write channel:
> 
> 	dmas = <&dmacA 0x1 match-readA>, <&dmacA 0x2 match-write> 
> 			<&dmacB match-readB>;
> 
> And only the cases where we have more multiple channels that differ
> in more aspects would require named properties:
> 
> 5. two different channels
> 
> 	dmas = <&dmac 0x3 match-rwdata>, <&dmac 0x1 match-status>;
> 	dma-names = "rwdata", "status";
> 
> 6. same as 5, but with a choice of channels:
> 
> 	dmas = <&dmacA 0x3 match-rwdataA>, <&dmacA 0x1 match-status>;
> 		<dmacB 0x3 match-rwdataB>;
> 	dma-names = "rwdata", "status", "rwdata";
> 
> 
> With a definition like that, we can implement a very simple device
> driver interface for the common cases, and a slightly more complex
> one for the more complex cases:
> 
> 1. chan = of_dma_request_channel(dev->of_node, 0);
> 2. chan = of_dma_request_channel(dev->of_node, 0);
> 3. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> 4. rxchan = of_dma_request_channel(dev->of_node, DMA_MEM_TO_DEV);
>    txchan = of_dma_request_channel(dev->of_node, DMA_DEV_TO_MEM);
> 5. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);
> 6. chan = of_dma_request_named_channel(dev->of_node, "rwdata", 0);
>    auxchan = of_dma_request_named_channel(dev->of_node, "status", DMA_DEV_TO_MEM);

Yes, that looks good to me.

Cheers
Jon
