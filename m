From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 13 Jul 2012 12:21:12 +0530
Message-ID: <1342162272.1726.29.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
	 <201206252030.56025.arnd@arndb.de>
	 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12724 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2GMGvj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 02:51:39 -0400
In-Reply-To: <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, 2012-07-06 at 13:36 +0200, Guennadi Liakhovetski wrote:
> On Mon, 25 Jun 2012, Arnd Bergmann wrote:
> 
> [snip]
> 
> > The channel data in the device tree is still in a format
> > that is specific to that dmaengine driver and interpreted
> > by it. Using the regular dma_filter_fn prototype is not
> > necessary, but it would be convenient because the dmaengine
> > code already knows how to deal with it. If we don't use this
> > method, how about adding another callback to struct dma_device
> > like
> > 
> > bool (*device_match)(struct dma_chan *chan, struct property *req);
> 
> I like this idea, but why don't we extend it to also cover the non-DT 
> case? I.e., why don't we add the above callback (call it "match" or 
> "filter" or anything else) to dmaengine operations and inside (the 
> extended) dma_request_channel(), instead of calling the filter function, 
> passed as a parameter, we loop over all registered DMAC devices and call 
> their filter callbacks, 
And I have told you many times, that dmacs should not know anything
about clients. They should be totally agnostic to it.

Clients need to request a specific channel, and that is where changes
should come for. Not having dmac provide one.


-- 
~Vinod

