From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 6 Jul 2012 22:01:30 +0100
Message-ID: <20120706210130.GB31585@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206252030.56025.arnd@arndb.de> <Pine.LNX.4.64.1207061315470.29809@axis700.grange> <201207061528.58291.arnd@arndb.de> <Pine.LNX.4.64.1207061737410.29809@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39885 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab2GFVCN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 17:02:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1207061737410.29809@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 06, 2012 at 05:43:38PM +0200, Guennadi Liakhovetski wrote:
> Hi Arnd
> 
> On Fri, 6 Jul 2012, Arnd Bergmann wrote:
> > How would the individual driver know the size of the filter_arg?
> 
> In exactly the same way as most dmaengine drivers do it today: they don't 
> touch filter_arg until they're sure this is one of their channels. And 
> this they typically do by comparing the driver pointer, e.g.:
> 
> bool sa11x0_dma_filter_fn(struct dma_chan *chan, void *param)
> {
> 	if (chan->device->dev->driver == &sa11x0_dma_driver.driver) {

That's utter rubbish, I'm afraid.

Let's say you move that code into sa11x0's alloc_chan_resources() function.
It will _never_ be called for a channel which isn't owned by the sa11x0
DMA driver - look at what __dma_request_channel() does:

        list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {

This walks the list of DMA devices.

                chan = private_candidate(mask, device, fn, fn_param);

This walks the channels _on_ _that_ dma device.  Those channels can only
be owned by the DMA device, which is in turn owned by the driver, which
in turn is owned by the struct driver that the above filter function
is checking.

So, all in all, this check inside chan_alloc_resources() tells you
absolutely _nothing_ about the suitability of dereferencing your
filter_arg data.  At all.
