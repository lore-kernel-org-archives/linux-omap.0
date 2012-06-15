From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 15 Jun 2012 08:40:32 +0000
Message-ID: <201206150840.33347.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206141148.20371.arnd@arndb.de> <4FDA05A4.5090301@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65457 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877Ab2FOJB3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 05:01:29 -0400
In-Reply-To: <4FDA05A4.5090301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thursday 14 June 2012, Jon Hunter wrote:
> 
> On 06/14/2012 06:48 AM, Arnd Bergmann wrote:
> > On Wednesday 13 June 2012, Jon Hunter wrote:
> >> So in that case, I don't see why the first cell after the phandle could
> >> not be an index which could be either a direction or request-id and then
> >> the next cell after that be a secondary match variable.
> >>
> >> So simple case with just a index (either req-id or direction) ...
> >>
> >> dmas = <&dmac0 index>
> >>
> >> More complex case ...
> >>
> >> dmas = <&dmac0 index match>
> >>
> >> For example, for OMAP index = req-id and match = direction ...
> >>
> >> dmas = <&dmac0 req-id direction>
> >>
> >> Or am I way off the page?
> > 
> > The intention was instead to remove the need for the /index/ in those
> > cases, because having a client-specific index in here makes it inconsistent
> > with other similar bindings (reg, interrupts, gpios, ...) that people
> > are familiar with. They use an implicit index by counting the
> > fields in the respective properties.
> 
> So maybe "index" was not the right term to use here. What I meant was
> that this is really the req/chan-id associated with this device. It is
> not an arbitrary index that in turn gets resolved into the req-id. So in
> other words, just like gpio where you have the gpio number, here you
> have the dma req-id.

Ok, we're on the same page then.

I got confused because you were quoting Stephen's example of

multiple dmacs:
dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;

which used an aribitrary slave-side index (0, 1), the dmaengine phandle
and the dmaengine specific request id (xxx,yyy,zzz).

Leaving out the index means that we require at least one of "dma-names"
strings or adding the direction.

> > The existing method we have for avoiding index numbers is to use
> > named fields, like
> > 
> > 	dmas = <&dmac0 matchA>, <dmac1 matchB>, <dmac2 matchC>;
> > 	dma-names = "rx", "rx", "tx";
> > 
> > This is similar to how we use named interrupt and mmio resources, but
> > it requires that we always request the dma lines by name, which is
> > slightly more complex than we might want it to be.
> 
> Ok, but how do you get the req-id from the above binding? Doesn't it
> need to be stored there somewhere even for the most simplest case? Or
> are you saying that in this case you are just returning a name and the
> dma driver resolves that into a req-id?

the req-id is what I called matchA, matchB, matchC here, it could be
a set of multiple cells, the number of which gets determined by the
dmaengine's #dma-cells property.

> > Because the vast majority of cases just use a single channel, or one
> > channel per direction, my idea was to encode the direction in the
> > dmas property, which lets us request a dma channel by direction from
> > the driver side, without explicitly encoding the name.
> 
> Yes, thats fine and so the direction is really the match criteria in
> this case.

No, it's not :(

> > This would let us handle the following cases very easily:
> > 
> > 1. one read-write channel
> > 
> > 	dmas = <&dmac 0x3 match>;
> 
> Where 0x3 is the req-id? Just to confirm ;-)
> 
> Why not have match after the phandle to be consistent with the simple
> example using name fields above?

The 0x3 is the direction, 1 for read, 2 for write, and 3 for read-write
in this example. Sorry for being unclear.

The direction has to come before the dma-engine specific request ID
data so that the common code can interpret it, while the variable-length
data after it is only interpreted by the dmaengine driver.

	Arnd

