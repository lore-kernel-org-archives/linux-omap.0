From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sat, 17 Mar 2012 09:42:17 +0000
Message-ID: <20120317094217.6BA143E0908@localhost>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203150922.06379.arnd@arndb.de> <20120315092652.GA16389@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33734 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab2CQPR2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Mar 2012 11:17:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so2560483lbb.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Mar 2012 08:17:27 -0700 (PDT)
In-Reply-To: <20120315092652.GA16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, devicetree-discuss@lists.ozlabs.org, Thierry Reding <thierry.reding@avionic-design.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 15 Mar 2012 09:26:52 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
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

Not well as the current patch set stands.  The xlate function doesn't return
any context for the dma channel number that it returns, so the driver cannot
figure out which DMA controller to use if there are multiple.

g.

