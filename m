From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 26 Jun 2012 20:27:47 +0000
Message-ID: <201206262027.47817.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206261459.40766.arnd@arndb.de> <1340733019.1562.242.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab2FZU1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 16:27:53 -0400
In-Reply-To: <1340733019.1562.242.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Tuesday 26 June 2012, Vinod Koul wrote:
> On Tue, 2012-06-26 at 14:59 +0000, Arnd Bergmann wrote:
> > On Tuesday 26 June 2012, Vinod Koul wrote:
> > > Today, we just ask for a channel with specific mask. Further filtering
> > > is done in filter function as we request a channel, not a specific one.
> > > In most slave cases, we need a specific channel from a specific
> > > controller, and that is where DT can play a role. In addition to DMA
> > > resources for dma and client driver, I would expect DT to provide the
> > > channel mapping information, which is anyway known only by platform.
> > 
> > Can you describe what you mean by "channel mapping information"?
> > Is that not what we pass into the filter function?
>
> Today many dmaengine drivers have a filter function which is exported
> and then used by clients to filter out the channel. That is not a right
> way to do, so any future plan which is based on filter is not correct.

I agree that exporting a filter function from the dmaengine driver is
very wrong and should not be done because it requires that the device
driver knows which engine is used and that is contrary to the idea
of having an abstraction layer.

We were talking about using a filter function because that would be
easy to do without changing the core dmaengine code. However, in the
proposal, there would actually just be a single filter function that
gets used by all drivers that have DT bindings, and it can be
completely encapsulated in the of_dma_request_channel() function
so it does not have to be a global symbol.

If we instead modify the dmaengine code itself to know about DT
rather than wrapping around it, we would not need this filter
function, but we should still have a probe() function that is
called by dmaengine code to interpret the data that is specific
to one dmaengine driver.

> IMHO dmaengine driver should *not* know anything about mapping. By
> mapping I refer to platform information which tells me which client can
> use which channel from which dmac.

Agreed too. That information shoudd be part of the slave device-node
in DT, as I have argued in this thread already. The slave device driver
does not need to care about the format or the contents of it,
but we need some code to interpret the contents. From all I can tell,
the structure of this data cannot be completely generic because of
all the special cases, so the code to interpret it would live in the
probe() function I mentioned about that the dmaengine driver provides.

> > I think encoding a description for a dma request in a single number is
> > the last thing we want to do here. We've tried that with IRQ and GPIO
> > numbers and it got us into a huge mess that will need a long time to
> > get out of.
> No i wasn't thinking of a number. The mapping shouldn't be a global
> number at all, though that is a very easy but not very scalable
> solution.
> We need to take care of 1:1 mapping of client and channels as well as
> many:1  cases as well. A single global number cannot represent that
> properly.
> 
> My idea is platform gives this information to dmaengine. Clients and
> dmaengine driver do not worry about it. That also paves way for arch
> independent clients and drivers.

IMO the platform should have no part in this. I absolutely want to
get rid of any platform-specific hardcoded tables in the kernel for
stuff that can easily be run-time detected from the device tree.
There are cases where hard-coding in the kernel is easier, but I don't
think this is one of them.

> > Some platforms actually use IORESOURCE_DMA, which was useful to describe
> > ISA DMA channels, for encoding some form of channel or request number,
> > but this causes all sorts of problems. These are almost exclusively
> > used by those platforms that don't have a dmaengine driver yet, so I'd
> > hope that we can remove this as we convert those platforms over to
> > dmaengine and device tree.
> > 
> > The representation in device tree as we have it now is a combination of
> > a pointer to the dmaengine and a description of the request line in it,
> > typically a single small integer number local to the dmaengine. We should
> > not try to make that a global integer number again that just serves the
> > purpose of looking up the dmaengine and local number again.
> > 
> > IMHO no device driver should be bothered with any artificial resource
> > information, but instead I want all the DT parsing to happen in the
> > dmaengine code (or some wrapper around it) where it gets used. The only
> > thing that a device driver needs to know is that it wants to use a
> > channel based on what is described in the device tree.
> Sure, but I would expect the clients and dmacs to find information about
> their devices from DT?
> dmaengine should get only mapping information used for allocating
> channel to client.

Let's take a look at a concrete example. The
arch/arm/mach-ux500/board-mop500-sdi.c file defines dma channel
configuration for the mmc devices on the ux500 platform that looks
like

static struct stedma40_chan_cfg mop500_sdi2_dma_cfg_tx = {
        .mode = STEDMA40_MODE_LOGICAL,
        .dir = STEDMA40_MEM_TO_PERIPH,
        .src_dev_type = STEDMA40_DEV_SRC_MEMORY,
        .dst_dev_type = DB8500_DMA_DEV28_SD_MM2_TX,
        .src_info.data_width = STEDMA40_WORD_WIDTH,
        .dst_info.data_width = STEDMA40_WORD_WIDTH,
};

I want to move this information to the device tree in a way that the
device driver does not have to care about it. With the proposed
binding, this would mean we get an mmci device node with a property
containing something like

	dma-requests = <&dma40  /* pointer to dma engine */
			0x01    /* logical, mem to dev */
			28      /* DEV28_SD_MM2_TX */
			32>,	/* 32 bit width */
		       <&dma40 0x02 32 32>; /* dev to mem channel */ 

The fact that this dmaengine driver requires two cells (request number
and data width) should only be known to the code that deals with that
one driver and that should interpret those two cells, while the first
two cells (pointer to dma-engine and direction) can be handled
by the common dmaengine layer.

In order to do that, we need some code in the dmaengine driver that
gets the property data as its argument.

	Arnd
