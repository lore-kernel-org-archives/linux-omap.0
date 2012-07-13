From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 13 Jul 2012 23:52:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1207132335110.5711@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206262027.47817.arnd@arndb.de> <1340804708.1562.253.camel@vkoul-udesk3>
 <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:60459 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2GMVx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jul 2012 17:53:27 -0400
In-Reply-To: <1342161907.1726.26.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Vinod

On Fri, 13 Jul 2012, Vinod Koul wrote:

> On Wed, 2012-06-27 at 15:20 +0000, Arnd Bergmann wrote:

[snip]

> > Do you mean there must be a global table, or are you ok with putting
> > the information about a channel into the device that uses the channel,
> > as we do for most other subsystems (IRQ, GPIO, pinctrl, ...).
> > If not, what is the problem with that approach?
> 
> Today, we simple ask, "give me dma channel with DMA_SLAVE capability".
> 
> If we change it to "give me dma channel which suits my need" and have
> additional information in dmaengine to handle this request effectively.
> 
> What that would mean is
> a) DMA channel either knows which channel to provide, Or
> b) Additional arguments provided to dmaengine API to help it find out
> which channel to provide.
> 
> It would be good to have client ask for a specific channel. But in order
> to build generic clients, we face a problem that clients may not know
> how they mapped to dmac by SoC designer. Or the mux maybe entirely
> flexible on which channel.
> 
> If we add this as DT property (which I assume should be platform
> specific), then client will know which channel to request.
> It can have two levels, dmac and channel. In case mux is flexible enough
> then client gets a channel and program the mux for this mapping.
> 
> I think this is the most simplistic solution I have for this, thoughts?

How about this my idea:

http://thread.gmane.org/gmane.linux.ports.arm.omap/75828/focus=15501

A small correction to it would be, that it shouldn't (necessarily) be a 
separate driver, because in some cases the mux resides on the DMAC, they 
share registers, so, it shouldn't really be a separate device and a 
separate driver, don't think it's worth an MFD set up or anything similar. 
So, I am trying ATM to implement something along the lines of

struct dma_chan *dma_request_slave_channel(struct device *dev,
		enum dma_transfer_direction direction, const char *name);

The connection between clients and the mux is always static, so, the 
dmaengine core can always just pass to the mux a client-side "pad" 
specifier (dev + direction + (optionally) name). The mux call-back will 
then see, where it can connect that pad and return a suitable channel 
descriptor - possibly with the help of the DMAC driver proper.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
