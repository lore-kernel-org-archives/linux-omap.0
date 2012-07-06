From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Sat, 7 Jul 2012 00:49:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1207070019510.29809@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
 <201206252030.56025.arnd@arndb.de> <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
 <20120706205731.GA31585@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59844 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab2GFWt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 18:49:29 -0400
In-Reply-To: <20120706205731.GA31585@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, 6 Jul 2012, Russell King - ARM Linux wrote:

> On Fri, Jul 06, 2012 at 01:36:32PM +0200, Guennadi Liakhovetski wrote:
> > I like this idea, but why don't we extend it to also cover the non-DT 
> > case? I.e., why don't we add the above callback (call it "match" or 
> > "filter" or anything else) to dmaengine operations and inside (the 
> > extended) dma_request_channel(), instead of calling the filter function, 
> > passed as a parameter, we loop over all registered DMAC devices and call 
> > their filter callbacks, until one of them returns true? In fact, it goes 
> > back to my earlier proposal from 
> > http://thread.gmane.org/gmane.linux.kernel/1246957
> > which I, possibly, failed to explain properly. So, the transformation 
> > chain from today's API would be (all code is approximate):
> > 
> > (today)
> > 
> > <client driver>
> > 	dma_request_channel(mask, filter, filter_arg);
> > 
> > <dmaengine_core>
> > 	for_each_channel() {
> > 		ret = (*filter)(chan, filter_arg);
> > 		if (ret) {
> > 			ret = chan->device->device_alloc_chan_resources(chan);
> > 			if (!ret)
> > 				return chan;
> > 			else
> > 				return NULL;
> > 		}
> > 	}
> > 
> > (can be transformed to)
> > 
> > <client driver>
> > 	dma_request_channel(mask, filter_arg);
> > 
> > <dmaengine_core>
> > 	for_each_channel() {
> > 		ret = chan->device->filter(chan, filter_arg);
> > 		if (ret) {
> > 			<same as above>
> > 		}
> > 	}
> > 
> > (which further could be simplified to)
> > 
> > <client driver>
> > 	dma_request_channel(mask, filter_arg);
> > 
> > <dmaengine_core>
> > 	for_each_channel() {
> > 		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);
> 
> This looks like you're re-purposing a perfectly good API for something that
> it wasn't designed to do, namely providing a channel selection mechanism,
> rather than "allocating channel resources".  The hint is in the bloody
> name, please take a look sometime!
> 
> If you want to call into the DMA engine driver for channel selection,
> then create an _explicit_ API for it.  Don't bugger around with existing
> APIs.

Sure, it's better to create a new call-back.

> Moreover, the *big* problem that your proposal above creates is this.
> What _type_ is filter_arg?  If it's void *, then your suggestion is
> nonsense, even if you associate it with a size argument.  You have no
> idea what the bytestream that would be passed via that pointer means,
> even if the size just happens to look like it's what you expect.

Right, thanks to you and Arnd, who has pointed this out too.

Then it seems to me, that we need to introduce a notion of a mux device. 
We could of course try to just use some strings instead, arrays of 
acceptable DMA devices and channels, and most likely we would even be able 
to find such an approach, that would work for all existing configurations. 
But it still wouldn't be really fully generic, right? Whereas creating a 
mux driver we really could cover all possible cases. DMA clients in this 
case would always be hard wired to only one pin of such a mux, the DMA 
device on the other side also only has to care about its physical 
channels. The dmaengine core would then query the mux driver, where it can 
route specific client request lines?

A separate mux is needed, because several clients can have their DMA 
handshake lines routed to several DMAC instances, so, this muxing 
functionality can neither reside on the client nor on the CMAC.

Is this a right direction now? Shall I try to prototype such a DMA mux 
API?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
