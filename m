From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 10:09:23 +0000
Message-ID: <201203151009.24161.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203150922.06379.arnd@arndb.de> <20120315092652.GA16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53048 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761064Ab2COKJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 06:09:31 -0400
In-Reply-To: <20120315092652.GA16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Thierry Reding <thierry.reding@avionic-design.de>

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 09:22:06AM +0000, Arnd Bergmann wrote:
> > On Thursday 15 March 2012, Nicolas Ferre wrote:
> > > Add some basic helpers to retrieve a DMA controller device_node and the
> > > DMA request specifications. By making DMA controllers register a generic
> > > translation function, we allow the management of any type of DMA requests
> > > specification.
> > > The void * output of an of_dma_xlate() function that will be implemented
> > > by the DMA controller can carry any type of "dma-request" argument.
> > > 
> > > The DMA client will search its associated DMA controller in the list and
> > > call the registered of_dam_xlate() function to retrieve the request values.
> > > 
> > > One simple xlate function is provided for the "single number" type of
> > > request binding.
> > > 
> > > This implementation is independent from dmaengine so it can also be used
> > > by legacy drivers.
> > > 
> > > For legacy reason another API will export the DMA request number into a
> > > Linux resource of type IORESOURCE_DMA.
> > 
> > This looks very good. I missed the first version of this patch, but was
> > thinking of very similar bindings.
> 
> There's one issue which is concerning me - when we switch OMAP to use
> DMA engine, it won't use numeric stuff anymore but the DMA engine way
> of requesting a channel (match function + data).
> 
> How does that fit into this scheme?

I haven't looked at the omap dma driver much, but if it just uses a
channel number, then I'd assume the data would be a single u32 cell
with that number, and the match function would be trivial.

Is that what you are asking about or am I missing the point?

	Arnd
