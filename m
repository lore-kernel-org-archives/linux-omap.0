From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 26 Jul 2012 12:12:40 +0530
Message-ID: <1343284960.1726.8978.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
	 <201207200839.24259.arnd@arndb.de> <1342777047.1726.435.camel@vkoul-udesk3>
	 <500EF27F.6050905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20674 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab2GZGmN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jul 2012 02:42:13 -0400
In-Reply-To: <500EF27F.6050905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2012-07-24 at 14:07 -0500, Jon Hunter wrote:
> Hi Vinod,
> >>>> Required property:
> >>>>     dmas: list of one or more dma specifiers, each consisting of
> >>>>      - phandle pointing to dma controller node
> >>>>      - flags word, a bit map that can hold these flags
> >>>>        * 0x00000001 channel can be used for transfer from device
> >>>>        * 0x00000002 channel can be user for transfer to device
> >>>
> >>> Is this for identifying which channel is for TX and RX? If not I am not
> >>> sure I understood it well
> >>
> >> Yes, but we can potentially add more flags here.
> >>
> >> The argument we had when coming up with this was roughly:
> >>
> >> * we need to identify which specifiers are referring to the same
> >>   conceptual channel and can be used as alternatives
> >> * this could be done just using the dma-names property, but making
> >>   dma-names mandatory adds complexity for everyone.
> >> * Most devices have just one or two channels, and if they have two,
> >>   there is usually one input and one output.
> >>
> >> => if the common dmaengine code can find out whether a channel is
> >>   input or output without looking at the dmac driver specific configuration,
> >>   we don't need to add dma-names in most cases, but just let the client
> >>   driver ask for "give me a channel with these flags".
> > No we don't export the direction of the channel and usually channel can
> > be configured either way.
> 
> So yes I can see that a channel itself could be configured to support a
> given direction, but when we ask for a channel via dma_request_channel()
> we are going to get a channel that matches the criteria we pass using
> the filter parameter. So here the thinking was that "flags" is a filter
> parameter that the user could specify and one example being direction
> but it could be something else too.
Yes that can be done, but I am leaning towards clients not have to do
anything :) DMAEngine needs to know mapping and when
dma_request_channel() is called it _always_ gives you the right channel.

Maybe for slave case we need to create dma_request_slave_channel() which
has additional arguments for dmaengine to do the filtering.


> > But from a client POV it makes sense as with the given direction you
> > would need a specific request line for a channel. So this is right.
> > But direction is something I don't expect to be used for "give me a
> > channel" 
> 
> Ok. The thought was that the user would have the following means of
> requesting a channel ...
> 
> 1. By name
Bare name maynot be enough. In a dmac we have many channels which one to
choose?
> 2. By a filter parameter (flags)
Even with direction same problem can arise
> 3. By name and a filter parameter
Additionally we need to say which channel, or making dmaengine already
aware will help here

> 
> So we would have the following APIs ...
> 
> struct dma_chan
> *of_dma_request_channel(struct device_node *node, unsigned int flags);
> struct dma_chan
> *of_dma_request_named channel(struct device_node *node, char *name,
> unsigned int flags);
> 
> In both of these the filter parameter flags is optional.
> 
> Let me know your thoughts on this.
I would call them dma_request_slave_channel and try to add to it for
additional filtering



-- 
~Vinod

