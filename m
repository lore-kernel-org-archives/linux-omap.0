From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Fri, 16 Mar 2012 14:28:32 +0100
Message-ID: <4F634000.8010408@ti.com>
References: <4F22DEF2.5000807@ti.com> <201203161003.02163.arnd@arndb.de> <4F6321DB.50600@ti.com> <201203161204.19800.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46392 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2CPN26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 09:28:58 -0400
In-Reply-To: <201203161204.19800.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On 3/16/2012 1:04 PM, Arnd Bergmann wrote:
> On Friday 16 March 2012, Cousson, Benoit wrote:
>> And it seems that other ARM SoCs are using it for the same purpose.
>> There are at least 230+ IORESOURCE_DMA instances in the kernel today.
>
> These tend to be the ones that don't use dmaengine but either the
> ISA dma api or a platform specific variant of that, right?
>
> Also, I think that most of those definitions are for the same few
> devices. The number that I see is much lower:
>
> $ git grep -l IORESOURCE_DMA drivers/ sound/ | wc -l
>       51

Gosh, good point... I've just done a dumb grep, but most of them are in 
the device creation inside arch code:-(

Assuming OMAP driver does contains omap in the name, the result is 
indeed way smaller.

git grep -l IORESOURCE_DMA drivers/ sound/ | grep omap

drivers/crypto/omap-aes.c
drivers/crypto/omap-sham.c
drivers/spi/spi-omap2-mcspi.c
drivers/tty/serial/omap-serial.c
sound/soc/omap/omap-dmic.c
sound/soc/omap/omap-hdmi.c

We do have 127 DMA requests and only 6 drivers are using them, that's a 
pity...

> Out of those, a quite number are mips or blackfin or xtensa based, or are
> for legacy ISA devices, which leaves 29 drivers for ARM.
>
>> For the moment it is still used in a lot of places, and without any
>> other better API yet, it is still useful. As written it is there only
>> for simple single DMA controller case.
>>
>> By maintaining that IORESOURCE_DMA for the moment we can adapt some
>> driver to DT without having to change the way they are retrieving
>> information. By using IORESOURCE_IRQ and IORESOURCE_MEM, we had the same
>> advantage.
>
> The main difference to IORESOURCE_IRQ and IORESOURCE_MEM that I see
> is that those are going to start for any forseeable time and are actually
> helpful in a lot of ways. We are not going to remove the single number
> space for interrupts in the next few years. For DMA, the dmaengine API
> has already moved away from the flat number space of the ISA API.
>
>> Otherwise how are we supposed to get the DMA channel for non-DT boot
>> until we have migrated everything to DT? A bunch of ARM SoC are using
>> IORESOURCE_DMA for the same purpose.
>>
>> The goal here is really to maintain that during the transition phase
>> only. As soon as the full DT support is there, we can switch to the of_ API.
>>
>> Ideally, we should define and use a generic API non dependent of DT.
>> AFAIK, that does not exist so far.
>> And since most drivers are not using dmaengine, we do not even have a
>> common DMA fmwk to define an API on top.
>>
>> I fully agree that this IORESOURCE_DMA is not scalable for multiple
>> controller, ugly, and must be avoided like the plague.
>> But what other options do we have during the transition?
>
> We could use the same binding for the nonstandard controllers, but
> keep the dma channel number lookup separate for those, and let them
> call of_get_dma_request directly.
>
> Since there are not too many drivers using those controllers with
> dma resources today, it's fairly easy to go through those as we write
> the driver bindings and just do
>
> 	err = of_get_dma_request(pdev->dev.of_node, 0,&dma);
> 	if (err) {
> 		struct resource *r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> 		if (r)
> 			dma = r->start;
> 	}
>
> For the drivers that we convert to DT before we convert them to dmaengine,
> and not do anything if we convert them to dmaengine first.

Considering the small amount of OMAP drivers really using 
IORESOURCE_DMA, I guess this is fair enough.

Bottom-line, I do not have any more issue removing this of_dma_to_resource.


Nico,
Is that OK for you to repost the patch without this function?

Thanks,
Benoit
