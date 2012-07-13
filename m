From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 13 Jul 2012 12:15:07 +0530
Message-ID: <1342161907.1726.26.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201206262027.47817.arnd@arndb.de> <1340804708.1562.253.camel@vkoul-udesk3>
	 <201206271520.49276.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50233 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2GMGpf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 02:45:35 -0400
In-Reply-To: <201206271520.49276.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Wed, 2012-06-27 at 15:20 +0000, Arnd Bergmann wrote:
Back from vacation... so restart the pending discussion

> 
> Sorry, I believe I was just using the wrong terminology, and what I named
> the slave here would just be the client.
> 
> This may have contributed to a lot of confusion before, so let's make
> sure I use the right terms now:
> 
> a) slave == dmac == dmaengine driver
> b) client == device driver, e.g. mmc
> c) common code == dmaengine layer
> 
> Is this correct?
Yup, that is what i use.

> 
> > > > > I think encoding a description for a dma request in a single number is
> > > > > the last thing we want to do here. We've tried that with IRQ and GPIO
> > > > > numbers and it got us into a huge mess that will need a long time to
> > > > > get out of.
> > > > No i wasn't thinking of a number. The mapping shouldn't be a global
> > > > number at all, though that is a very easy but not very scalable
> > > > solution.
> > > > We need to take care of 1:1 mapping of client and channels as well as
> > > > many:1  cases as well. A single global number cannot represent that
> > > > properly.
> > > > 
> > > > My idea is platform gives this information to dmaengine. Clients and
> > > > dmaengine driver do not worry about it. That also paves way for arch
> > > > independent clients and drivers.
> > > 
> > > IMO the platform should have no part in this. I absolutely want to
> > > get rid of any platform-specific hardcoded tables in the kernel for
> > > stuff that can easily be run-time detected from the device tree.
> > > There are cases where hard-coding in the kernel is easier, but I don't
> > > think this is one of them.
> >
> > Again, you got me wrong. We don't want any hardcoded table is kernel.
> > The information in table should come from whatever way that platform can
> > give me. For your case it should be DT.
> 
> Ok, good.
> 
> > We can have the map of which client can use which channel as DT binding
> > of dmaengine core. So dmaengine can easily arbitrate about channel
> > requests. Again this mapping information is not some even linux
> > independent.
> 
> Why can't it be OS independent?
I meant OS independent, didn't come out well :(
> 
> Do you mean there must be a global table, or are you ok with putting
> the information about a channel into the device that uses the channel,
> as we do for most other subsystems (IRQ, GPIO, pinctrl, ...).
> If not, what is the problem with that approach?

Today, we simple ask, "give me dma channel with DMA_SLAVE capability".

If we change it to "give me dma channel which suits my need" and have
additional information in dmaengine to handle this request effectively.

What that would mean is
a) DMA channel either knows which channel to provide, Or
b) Additional arguments provided to dmaengine API to help it find out
which channel to provide.

It would be good to have client ask for a specific channel. But in order
to build generic clients, we face a problem that clients may not know
how they mapped to dmac by SoC designer. Or the mux maybe entirely
flexible on which channel.

If we add this as DT property (which I assume should be platform
specific), then client will know which channel to request.
It can have two levels, dmac and channel. In case mux is flexible enough
then client gets a channel and program the mux for this mapping.

I think this is the most simplistic solution I have for this, thoughts?

-- 
~Vinod

