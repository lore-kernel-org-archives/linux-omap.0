From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 6 Jul 2012 13:36:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
 <201206252030.56025.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54514 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632Ab2GFLhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 07:37:09 -0400
In-Reply-To: <201206252030.56025.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Mon, 25 Jun 2012, Arnd Bergmann wrote:

[snip]

> The channel data in the device tree is still in a format
> that is specific to that dmaengine driver and interpreted
> by it. Using the regular dma_filter_fn prototype is not
> necessary, but it would be convenient because the dmaengine
> code already knows how to deal with it. If we don't use this
> method, how about adding another callback to struct dma_device
> like
> 
> bool (*device_match)(struct dma_chan *chan, struct property *req);

I like this idea, but why don't we extend it to also cover the non-DT 
case? I.e., why don't we add the above callback (call it "match" or 
"filter" or anything else) to dmaengine operations and inside (the 
extended) dma_request_channel(), instead of calling the filter function, 
passed as a parameter, we loop over all registered DMAC devices and call 
their filter callbacks, until one of them returns true? In fact, it goes 
back to my earlier proposal from 
http://thread.gmane.org/gmane.linux.kernel/1246957
which I, possibly, failed to explain properly. So, the transformation 
chain from today's API would be (all code is approximate):

(today)

<client driver>
	dma_request_channel(mask, filter, filter_arg);

<dmaengine_core>
	for_each_channel() {
		ret = (*filter)(chan, filter_arg);
		if (ret) {
			ret = chan->device->device_alloc_chan_resources(chan);
			if (!ret)
				return chan;
			else
				return NULL;
		}
	}

(can be transformed to)

<client driver>
	dma_request_channel(mask, filter_arg);

<dmaengine_core>
	for_each_channel() {
		ret = chan->device->filter(chan, filter_arg);
		if (ret) {
			<same as above>
		}
	}

(which further could be simplified to)

<client driver>
	dma_request_channel(mask, filter_arg);

<dmaengine_core>
	for_each_channel() {
		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);
		if (!ret)
			return chan;
		else if (ret != -ENODEV)
			return ret;
		/* -ENODEV - try the next channel */
	}

Which is quite similar to my above mentioned proposal. Wouldn't this both 
improve the present API and prepare it for DT?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
