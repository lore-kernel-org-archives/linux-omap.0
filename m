From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 26 Jul 2012 16:58:03 +0530
Message-ID: <1343302083.1726.9027.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
	 <201207260714.34540.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41303 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab2GZL1c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 07:27:32 -0400
In-Reply-To: <201207260714.34540.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-26 at 07:14 +0000, Arnd Bergmann wrote:
> On Thursday 26 July 2012, Vinod Koul wrote:
> > > > But from a client POV it makes sense as with the given direction you
> > > > would need a specific request line for a channel. So this is right.
> > > > But direction is something I don't expect to be used for "give me a
> > > > channel" 
> > > 
> > > Ok. The thought was that the user would have the following means of
> > > requesting a channel ...
> > > 
> > > 1. By name
> > Bare name maynot be enough. In a dmac we have many channels which one to
> > choose?
> 
> The name is what is associated with the property in the client device
> node, which describes everything the dmac driver needs to know.
> If the dmac needs to pick a specific channel, it can find out from the
> "dmas" property in combination with that name. If it is allowed to
> pick any channel, it doesn't need to bother.
dmac doesn't pick a channel. They don't come into picture till dmaengine
and client have agreed on channel. And then channel callback in invoked,
still it doesn't know which client.
> 
> > > 2. By a filter parameter (flags)
> > Even with direction same problem can arise
> 
> Again this is just identifying which dma specifier from the "dmas"
> property to pick. The use case is the very common one that there
> is at most one "read" and one "write" channel. In this case all
> the client has to know is that it wants a channel that fits the
> description given in DT for the direction it's looking for.
client knows but that needs to be propagated to dmaengine (not dmac) and
dmaengine filters this based on new information it has
> 
> > > 3. By name and a filter parameter
> > Additionally we need to say which channel, or making dmaengine already
> > aware will help here.
> 
> The channel is still described in the specifier, the client should
> not care about it.
> 
> 	Arnd


-- 
~Vinod

