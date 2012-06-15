From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 15 Jun 2012 10:41:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206150928260.11729@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FBAA64A.200@wwwdotorg.org> <4FD24CC3.50700@ti.com> <201206090004.10086.arnd@arndb.de>
 <Pine.LNX.4.64.1206141537190.30810@axis700.grange> <4FDA5D0A.1040105@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab2FOIl2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 04:41:28 -0400
In-Reply-To: <4FDA5D0A.1040105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Magnus Damm <magnus.damm@gmail.com>

On Thu, 14 Jun 2012, Jon Hunter wrote:

> 
> On 06/14/2012 10:17 AM, Guennadi Liakhovetski wrote:
> > Hi all
> > 
> > Sorry for jumping in so late in the game. But I think, the model, to which 
> > this discussion is slowly converging, is not very well suitable for the 
> > shdma DMACs, present on SH and ARM sh-mobile SoCs. I might be wrong and 
> > the model is indeed suitable, in which case I'd be grateful, if someone 
> > could explain, how this model could be used for shdma. Below I'll try to 
> > describe main properties of shdma served DMACs, I've done this a couple of 
> > times before during various dmaengine related discussions. Let's see how 
> > we can use this model for these SoCs.
> > 
> > On Sat, 9 Jun 2012, Arnd Bergmann wrote:
> > 
> >> On Friday 08 June 2012, Jon Hunter wrote:
> > 
> > [snip]
> > 
> >>> It seems to me we were pretty close on alignment. In fact, I was quite
> >>> happy with Steven's 2nd to last proposal of  ...
> >>>
> >>> simple 1 req:
> >>> dmas = <0 &dmac1 xxx>;
> >>>
> >>> simple 2 req:
> >>> dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;
> >>>
> >>> multiple dmacs:
> >>> dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;
> > 
> > A typical sh-mobile SoC contains several DMAC instances of several 
> > sub-types, all served by the same driver. Let's take sh7372 to be 
> > specific (see arch/arm/mach-shmobile/setup-sh7372.c for details). On 
> > sh7372 we've got 3 generic DMAC instances and 2 dedicated USB DMACs.
> > 
> > Generic DMACs have 6 physical channels each, USB DMACs 2.
> 
> For OMAP we also have dedicated DMAC for the USB controllers. However,
> these DMAC are very much integrated into the USB controller itself.
> Hence, in the of OMAP we would only be using the binding really to
> handle the generic DMAC. However, I would not like to think that this is
> limited to only generic DMAC.
> 
> > Generic DMACs can perform memory-to-memory DMA, USB DMACs cannot.
> > 
> > Generic DMACs can serve any slave (peripheral) request line on any their 
> > physical channel, USB DMACs only serve fixed USB controller instances. To 
> > configure (connect) a certain physical DMA channel to s specific 
> > peripheral request line, a certain value has to be written to a 
> > configuration register of that physical DMA channel.
> 
> Do you still need to specify a request line for the USB DMACs or are
> these fixed?

I personally haven't worked with the renesas_usbhs USB driver or with the 
respective DMA driver part, but from what I can see, no "slave-select" 
values are required, i.e., request lines seem to be fixed.

> In other words, what purpose would the DMA binding serve
> for the USB DMACs?

The USB driver has to tell the dmaengine which DMAC instances are suitable 
for it, and which are not.

> > To add to complexity, on other SoCs (e.g., SuperH sh7724) some of generic 
> > DMACs (DMAC0) have external DMA request pins, others don't.
> 
> OMAP also has this. To me an request line going to an external pin can
> be handled in the same way as one going to a internal peripheral.
> However, what happens to that pin externally is a different story.

As has been discussed before, the presence of external DMA request lines 
makes specifying fixed DMA channel maps in SoC dtsi files impossible.

> > I'm sure there's more to that, but that's about the scope, that's 
> > currently supported or wants to be supported by the driver.
> > 
> > Currently we do the slave-switching in the following way: platform data 
> > for each DMAC instance references a table of supported peripherals with 
> > their IDs and configuration register values. Each peripheral, that wishes 
> > to use DMA, provides its slave ID to the DMAC driver, by which it checks, 
> > whether this peripheral is supported and, if so, finds its configuration, 
> > picks up the next free channel and configures it.
> > 
> > So, with the above in mind, IIUC, the above DT binding proposal would 
> > require us to reference all 3 generic DMAC instances in each slave dmas 
> > property? 
> 
> You could if you wanted to have the ability to select 1 out of the 3.
> However, I would not say it is a hard requirement. You could just
> provide one. Or you could list all 3, but use some form of match
> variable to indicate a default DMAC for a given peripheral.

Sorry, I don't think artificially limiting the flexibility to just 1 
controller is a good option. The option of listing all 3 in each device 
doesn't seem too good to me either. What if a future SoC version has 5 of 
them? I really would prefer to have a list of "generic" DMAC instances 
somewhere and be able to omit any explicit references to specific DMACs in 
device DMA bindings. I can also imagine a possibility, that in the future 
we won't have just one "generic" DMAC type, but, say, 2 DMAC groups, 
serving different, but possibly intersecting, sets of devices. In that 
case I'd just like to be able to specify "use group A" in the binding. Do 
I understand correctly, that with the proposed scheme this is impossible?

> > Even if we assume, that for this specific case we don't have to 
> > map each physical channel, because so far they are "mostly" all equal on 
> > each DMAC instance. Mostly, because external DMA request lines on sh7724 
> > can only be used with channels 0 and 1 out of 6 of DMAC0... What we 
> > certainly don't want to do is specify fixed physical DMA channels or even 
> > controller instances in slave DMA bindings.
> 
> You could just use the binding to return a handle to one DMAC and then
> just request a channel. I don't see that the binding would require you
> to specify fixed channels.

That's good, but as I said above, I'd also like to be more flexible in the 
selection of DMACs.

> > To me it looks like the above proposal would only very suboptimally be 
> > usable with sh-mobile SoCs...
> 
> I guess I don't see that, but then again I am not familiar with the all
> the details of the SH devices.
> 
> However, thinking about it some more, if a DMAC is this generic, what
> information do you want the binding to provide?

Configuration data for the DMAC. Currently this consists (apart from FIFO 
access register addresses) of 2 values: a magic value, specifying a 
certain slave (DMA request line selection), and a value for a 
configuration register. The latter contains information about transfer 
sizes, repeat / reload modes, address incrementing policies etc. These 
seem to be computable, but they are at least partially SoC-specific too.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
