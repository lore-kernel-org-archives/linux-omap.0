From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 15 Jun 2012 11:18:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206151107480.11729@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <Pine.LNX.4.64.1206141537190.30810@axis700.grange> <4FDA5D0A.1040105@ti.com>
 <201206150900.50866.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62104 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab2FOJTc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 05:19:32 -0400
In-Reply-To: <201206150900.50866.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Arnd

On Fri, 15 Jun 2012, Arnd Bergmann wrote:

> On Thursday 14 June 2012, Jon Hunter wrote:
> 
> > > Generic DMACs can perform memory-to-memory DMA, USB DMACs cannot.
> > > 
> > > Generic DMACs can serve any slave (peripheral) request line on any their 
> > > physical channel, USB DMACs only serve fixed USB controller instances. To 
> > > configure (connect) a certain physical DMA channel to s specific 
> > > peripheral request line, a certain value has to be written to a 
> > > configuration register of that physical DMA channel.
> > 
> > Do you still need to specify a request line for the USB DMACs or are
> > these fixed? In other words, what purpose would the DMA binding serve
> > for the USB DMACs?
> 
> If I understood Guennadi right, the DMA engines are the same kind as the
> other ones, so we really want to use the same bindings for each instance.

Exactly, at least they are compatible and are presently handles by the 
same dma-engine driver. There are some differences in the register layout, 
I think, which we might need to handle at some point, maybe by specifying 
different "compatible" identifiers or by some other means.

> > > To add to complexity, on other SoCs (e.g., SuperH sh7724) some of generic 
> > > DMACs (DMAC0) have external DMA request pins, others don't.
> > 
> > OMAP also has this. To me an request line going to an external pin can
> > be handled in the same way as one going to a internal peripheral.
> > However, what happens to that pin externally is a different story.
> 
> Right, I don't see a problem here with any of the proposed binding.
> 
> > > I'm sure there's more to that, but that's about the scope, that's 
> > > currently supported or wants to be supported by the driver.
> > > 
> > > Currently we do the slave-switching in the following way: platform data 
> > > for each DMAC instance references a table of supported peripherals with 
> > > their IDs and configuration register values. Each peripheral, that wishes 
> > > to use DMA, provides its slave ID to the DMAC driver, by which it checks, 
> > > whether this peripheral is supported and, if so, finds its configuration, 
> > > picks up the next free channel and configures it.
> > > 
> > > So, with the above in mind, IIUC, the above DT binding proposal would 
> > > require us to reference all 3 generic DMAC instances in each slave dmas 
> > > property? 
> > 
> > You could if you wanted to have the ability to select 1 out of the 3.
> > However, I would not say it is a hard requirement. You could just
> > provide one. Or you could list all 3, but use some form of match
> > variable to indicate a default DMAC for a given peripheral.
> 
> Right. From the description above, it seems that shmobile is actually
> simpler than some of the others because the slave ID is always the
> same for each of the controllers.

Exactly.

> In the common case, you could have one device connected to the third
> slave ID of the first controller but the fifth slave ID of the
> second controller. In this case, you really have to specify each
> controller with its slave ID separately, even if that means a lot
> of duplicate data for shmobile.

So, you don't think it's worth making a short-cut possible to specify a 
DMAC type instead of each instance phandle? It really would mean __a lot__ 
of duplication - with 3 generic controllers on (some) current chips and 
possibly more on those, that I'm not aware about.

> I'm not sure I understand what the "configuration register values"
> above are.

As I explained in an earlier mail, those include transfer size and other 
parameters, but cannot be completely calculated in device drivers, because 
they also vary between SoCs.

> Most likely, those should all be part of the slave ID,
> which would then span multiple 32-bit values in the "dmas" property.

Yes, we could do that.

> Conveniently, that also takes care of removing the DMAC platform data.

Right, my only concern so far is a huge redundancy, that accepting and 
using the proposed scheme would incur.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
