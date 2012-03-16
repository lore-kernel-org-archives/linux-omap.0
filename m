From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Fri, 16 Mar 2012 12:04:19 +0000
Message-ID: <201203161204.19800.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <201203161003.02163.arnd@arndb.de> <4F6321DB.50600@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64453 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758693Ab2CPMEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 08:04:40 -0400
In-Reply-To: <4F6321DB.50600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On Friday 16 March 2012, Cousson, Benoit wrote:
> And it seems that other ARM SoCs are using it for the same purpose. 
> There are at least 230+ IORESOURCE_DMA instances in the kernel today.

These tend to be the ones that don't use dmaengine but either the
ISA dma api or a platform specific variant of that, right?

Also, I think that most of those definitions are for the same few
devices. The number that I see is much lower:

$ git grep -l IORESOURCE_DMA drivers/ sound/ | wc -l
     51

Out of those, a quite number are mips or blackfin or xtensa based, or are
for legacy ISA devices, which leaves 29 drivers for ARM. 

> For the moment it is still used in a lot of places, and without any 
> other better API yet, it is still useful. As written it is there only 
> for simple single DMA controller case.
> 
> By maintaining that IORESOURCE_DMA for the moment we can adapt some 
> driver to DT without having to change the way they are retrieving 
> information. By using IORESOURCE_IRQ and IORESOURCE_MEM, we had the same 
> advantage.

The main difference to IORESOURCE_IRQ and IORESOURCE_MEM that I see
is that those are going to start for any forseeable time and are actually
helpful in a lot of ways. We are not going to remove the single number
space for interrupts in the next few years. For DMA, the dmaengine API
has already moved away from the flat number space of the ISA API.

> Otherwise how are we supposed to get the DMA channel for non-DT boot 
> until we have migrated everything to DT? A bunch of ARM SoC are using 
> IORESOURCE_DMA for the same purpose.
> 
> The goal here is really to maintain that during the transition phase 
> only. As soon as the full DT support is there, we can switch to the of_ API.
> 
> Ideally, we should define and use a generic API non dependent of DT. 
> AFAIK, that does not exist so far.
> And since most drivers are not using dmaengine, we do not even have a 
> common DMA fmwk to define an API on top.
> 
> I fully agree that this IORESOURCE_DMA is not scalable for multiple 
> controller, ugly, and must be avoided like the plague.
> But what other options do we have during the transition?

We could use the same binding for the nonstandard controllers, but
keep the dma channel number lookup separate for those, and let them
call of_get_dma_request directly.

Since there are not too many drivers using those controllers with
dma resources today, it's fairly easy to go through those as we write
the driver bindings and just do

	err = of_get_dma_request(pdev->dev.of_node, 0, &dma);
	if (err) {
		struct resource *r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
		if (r)
			dma = r->start;
	}

For the drivers that we convert to DT before we convert them to dmaengine,
and not do anything if we convert them to dmaengine first.

	Arnd
