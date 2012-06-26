From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 26 Jun 2012 23:20:19 +0530
Message-ID: <1340733019.1562.242.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201206252030.56025.arnd@arndb.de> <1340703613.1562.202.camel@vkoul-udesk3>
	 <201206261459.40766.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44999 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab2FZR7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 13:59:44 -0400
In-Reply-To: <201206261459.40766.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, 2012-06-26 at 14:59 +0000, Arnd Bergmann wrote:
> On Tuesday 26 June 2012, Vinod Koul wrote:
> > Today, we just ask for a channel with specific mask. Further filtering
> > is done in filter function as we request a channel, not a specific one.
> > In most slave cases, we need a specific channel from a specific
> > controller, and that is where DT can play a role. In addition to DMA
> > resources for dma and client driver, I would expect DT to provide the
> > channel mapping information, which is anyway known only by platform.
> 
> Can you describe what you mean by "channel mapping information"?
> Is that not what we pass into the filter function?
Today many dmaengine drivers have a filter function which is exported
and then used by clients to filter out the channel. That is not a right
way to do, so any future plan which is based on filter is not correct.
IMHO dmaengine driver should *not* know anything about mapping. By
mapping I refer to platform information which tells me which client can
use which channel from which dmac.
If the dmaengine hardware has mux then we have flexible mapping, other
cases would be where request lines are hard wired, so mapping is pretty
much static.
This information if provided to dmaengine can result in dmaengine doing
proper allocation of dma channels.
One of the proposals we discussed sometime back:
https://lkml.org/lkml/2012/3/8/26

> > That should be a dmaengine binding and not client or controller
> > specific. For different platforms this information can come from DT or
> > something else.
> > Then, once a channel is requested dmaengine knows what to provide.
> > And as you see the filter becomes redundant.
> 
> But what code interprets the channel mapping then?
only dmaengine. In this case the mapping comes from DT.

> I think encoding a description for a dma request in a single number is
> the last thing we want to do here. We've tried that with IRQ and GPIO
> numbers and it got us into a huge mess that will need a long time to
> get out of.
No i wasn't thinking of a number. The mapping shouldn't be a global
number at all, though that is a very easy but not very scalable
solution.
We need to take care of 1:1 mapping of client and channels as well as
many:1  cases as well. A single global number cannot represent that
properly.

My idea is platform gives this information to dmaengine. Clients and
dmaengine driver do not worry about it. That also paves way for arch
independent clients and drivers.
> 
> Some platforms actually use IORESOURCE_DMA, which was useful to describe
> ISA DMA channels, for encoding some form of channel or request number,
> but this causes all sorts of problems. These are almost exclusively
> used by those platforms that don't have a dmaengine driver yet, so I'd
> hope that we can remove this as we convert those platforms over to
> dmaengine and device tree.
> 
> The representation in device tree as we have it now is a combination of
> a pointer to the dmaengine and a description of the request line in it,
> typically a single small integer number local to the dmaengine. We should
> not try to make that a global integer number again that just serves the
> purpose of looking up the dmaengine and local number again.
> 
> IMHO no device driver should be bothered with any artificial resource
> information, but instead I want all the DT parsing to happen in the
> dmaengine code (or some wrapper around it) where it gets used. The only
> thing that a device driver needs to know is that it wants to use a
> channel based on what is described in the device tree.
Sure, but I would expect the clients and dmacs to find information about
their devices from DT?
dmaengine should get only mapping information used for allocating
channel to client.

-- 
~Vinod

