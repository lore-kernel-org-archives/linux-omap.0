From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 22 Jun 2012 17:52:08 -0500
Message-ID: <4FE4F718.3080204@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206090004.10086.arnd@arndb.de> <4FD914F6.6000402@ti.com> <201206141148.20371.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59148 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab2FVWwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 18:52:38 -0400
In-Reply-To: <201206141148.20371.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Arnd,

On 06/14/2012 06:48 AM, Arnd Bergmann wrote:

[snip]

> This would let us handle the following cases very easily:
> 
> 1. one read-write channel
> 
> 	dmas = <&dmac 0x3 match>;
> 
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

In the above examples, did you imply that the of_dma_request_channel()
function would return a type of "struct dma_chan" and so be calling
dma_request_channel() underneath?

I am been prototyping something, but wanted to make sure I am completely
aligned on this :-)

Cheers
Jon
