From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Wed, 27 Jun 2012 15:20:48 +0000
Message-ID: <201206271520.49276.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206262027.47817.arnd@arndb.de> <1340804708.1562.253.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58339 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537Ab2F0PVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 11:21:19 -0400
In-Reply-To: <1340804708.1562.253.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Wednesday 27 June 2012, Vinod Koul wrote:
> On Tue, 2012-06-26 at 20:27 +0000, Arnd Bergmann wrote:
> > On Tuesday 26 June 2012, Vinod Koul wrote:
> > > On Tue, 2012-06-26 at 14:59 +0000, Arnd Bergmann wrote:
> > If we instead modify the dmaengine code itself to know about DT
> > rather than wrapping around it, we would not need this filter
> > function, but we should still have a probe() function that is
> > called by dmaengine code to interpret the data that is specific
> > to one dmaengine driver.
> I was hoping we can have dmaengine binding, that way dmaengine core code
> knows about what to do when some client requests a channel.
> > 
> > > IMHO dmaengine driver should *not* know anything about mapping. By
> > > mapping I refer to platform information which tells me which client can
> > > use which channel from which dmac.
> > 
> > Agreed too. That information shoudd be part of the slave device-node
> > in DT, as I have argued in this thread already. The slave device driver
> > does not need to care about the format or the contents of it,
> > but we need some code to interpret the contents. From all I can tell,
> > the structure of this data cannot be completely generic because of
> > all the special cases, so the code to interpret it would live in the
> > probe() function I mentioned about that the dmaengine driver provides.
> rather than slave driver, why dont we keep this binding within
> dmaengine. That would make slave and clients completely independent.

Sorry, I believe I was just using the wrong terminology, and what I named
the slave here would just be the client.

This may have contributed to a lot of confusion before, so let's make
sure I use the right terms now:

a) slave == dmac == dmaengine driver
b) client == device driver, e.g. mmc
c) common code == dmaengine layer

Is this correct?

> > > > I think encoding a description for a dma request in a single number is
> > > > the last thing we want to do here. We've tried that with IRQ and GPIO
> > > > numbers and it got us into a huge mess that will need a long time to
> > > > get out of.
> > > No i wasn't thinking of a number. The mapping shouldn't be a global
> > > number at all, though that is a very easy but not very scalable
> > > solution.
> > > We need to take care of 1:1 mapping of client and channels as well as
> > > many:1  cases as well. A single global number cannot represent that
> > > properly.
> > > 
> > > My idea is platform gives this information to dmaengine. Clients and
> > > dmaengine driver do not worry about it. That also paves way for arch
> > > independent clients and drivers.
> > 
> > IMO the platform should have no part in this. I absolutely want to
> > get rid of any platform-specific hardcoded tables in the kernel for
> > stuff that can easily be run-time detected from the device tree.
> > There are cases where hard-coding in the kernel is easier, but I don't
> > think this is one of them.
>
> Again, you got me wrong. We don't want any hardcoded table is kernel.
> The information in table should come from whatever way that platform can
> give me. For your case it should be DT.

Ok, good.

> We can have the map of which client can use which channel as DT binding
> of dmaengine core. So dmaengine can easily arbitrate about channel
> requests. Again this mapping information is not some even linux
> independent.

Why can't it be OS independent?

Do you mean there must be a global table, or are you ok with putting
the information about a channel into the device that uses the channel,
as we do for most other subsystems (IRQ, GPIO, pinctrl, ...).
If not, what is the problem with that approach?

	Arnd
