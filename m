From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 14 Jun 2012 17:17:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206141537190.30810@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FBAA64A.200@wwwdotorg.org> <4FD24CC3.50700@ti.com> <201206090004.10086.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63176 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab2FNPSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:18:07 -0400
In-Reply-To: <201206090004.10086.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Magnus Damm <magnus.damm@gmail.com>

Hi all

Sorry for jumping in so late in the game. But I think, the model, to which 
this discussion is slowly converging, is not very well suitable for the 
shdma DMACs, present on SH and ARM sh-mobile SoCs. I might be wrong and 
the model is indeed suitable, in which case I'd be grateful, if someone 
could explain, how this model could be used for shdma. Below I'll try to 
describe main properties of shdma served DMACs, I've done this a couple of 
times before during various dmaengine related discussions. Let's see how 
we can use this model for these SoCs.

On Sat, 9 Jun 2012, Arnd Bergmann wrote:

> On Friday 08 June 2012, Jon Hunter wrote:

[snip]

> > It seems to me we were pretty close on alignment. In fact, I was quite
> > happy with Steven's 2nd to last proposal of  ...
> > 
> > simple 1 req:
> > dmas = <0 &dmac1 xxx>;
> > 
> > simple 2 req:
> > dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;
> > 
> > multiple dmacs:
> > dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;

A typical sh-mobile SoC contains several DMAC instances of several 
sub-types, all served by the same driver. Let's take sh7372 to be 
specific (see arch/arm/mach-shmobile/setup-sh7372.c for details). On 
sh7372 we've got 3 generic DMAC instances and 2 dedicated USB DMACs.

Generic DMACs have 6 physical channels each, USB DMACs 2.

Generic DMACs can perform memory-to-memory DMA, USB DMACs cannot.

Generic DMACs can serve any slave (peripheral) request line on any their 
physical channel, USB DMACs only serve fixed USB controller instances. To 
configure (connect) a certain physical DMA channel to s specific 
peripheral request line, a certain value has to be written to a 
configuration register of that physical DMA channel.

To add to complexity, on other SoCs (e.g., SuperH sh7724) some of generic 
DMACs (DMAC0) have external DMA request pins, others don't.

I'm sure there's more to that, but that's about the scope, that's 
currently supported or wants to be supported by the driver.

Currently we do the slave-switching in the following way: platform data 
for each DMAC instance references a table of supported peripherals with 
their IDs and configuration register values. Each peripheral, that wishes 
to use DMA, provides its slave ID to the DMAC driver, by which it checks, 
whether this peripheral is supported and, if so, finds its configuration, 
picks up the next free channel and configures it.

So, with the above in mind, IIUC, the above DT binding proposal would 
require us to reference all 3 generic DMAC instances in each slave dmas 
property? Even if we assume, that for this specific case we don't have to 
map each physical channel, because so far they are "mostly" all equal on 
each DMAC instance. Mostly, because external DMA request lines on sh7724 
can only be used with channels 0 and 1 out of 6 of DMAC0... What we 
certainly don't want to do is specify fixed physical DMA channels or even 
controller instances in slave DMA bindings.

To me it looks like the above proposal would only very suboptimally be 
usable with sh-mobile SoCs...

Thanks
Guennadi

> > Arnd, I know that you had some concerns. However, in the above case I
> > would expect that the 3rd parameter be optional and it can be some sort
> > of match variable. In other words, we don't care how the 32-bits are
> > encoded or what they represent but they would be used appropriately by
> > the xlate function being used. So the xlate and this "match" variable
> > would have to speak the same language.
> 
> I would at least put the &dmac part first to be consistent with other
> bindings that refer to some node. That controller should then be
> able to specify the number of additional cells used to describe the
> dma request. We can define that the first cell after the controller
> phandle is always the same thing, e.g. the direction (in/out/inout)
> or a client-specific ID or a combination of that with other predefined
> bits that are not dependent on dma controller specifics.
> 
> As I said previously, I think just encoding the direction but not
> the client specific ID (meaning we would have to disambiguate
> the more complex cases that Stephen mentioned using a dma-names
> property) would be the best because it keeps the common case simple,
> but I could live with other things going in there too.
> 
> > I think that I prefer the idea of having a 3rd optional match variable
> > than encoding the DMA request ID and match data together in 1 32-bit
> > variable. However, not a big deal either way.
> 
> I agree on that part, I would usually prefer to encode different things
> in separate cells rather than putting them together into a single cell
> just because they require less than 32 bits combined.
> 
> 	Arnd

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
