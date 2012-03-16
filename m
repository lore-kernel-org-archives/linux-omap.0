From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Fri, 16 Mar 2012 12:19:55 +0100
Message-ID: <4F6321DB.50600@ti.com>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203161003.02163.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422683Ab2CPLUV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 07:20:21 -0400
In-Reply-To: <201203161003.02163.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On 3/16/2012 11:03 AM, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Nicolas Ferre wrote:
>> For legacy reason another API will export the DMA request number into a
>> Linux resource of type IORESOURCE_DMA.
>
> Can you explain which legacy scenarios you think this is going to help with?

We do have a bunch of drivers that are using IORESOURCE_DMA today to 
retrieve the DMA request. Since we do have an unique DMA controller it 
was easy and convenient.
And it seems that other ARM SoCs are using it for the same purpose. 
There are at least 230+ IORESOURCE_DMA instances in the kernel today.

>> +/**
>> + * of_dma_to_resource - Decode a node's DMA and return it as a resource
>> + * @dev: pointer to device tree node
>> + * @index: zero-based index of the DMA request
>> + * @r: pointer to resource structure to return result into.
>> + *
>> + * Using a resource to export a DMA request number to a driver should
>> + * be used only for legacy purpose and on system when only one DMA controller
>> + * is present.
>> + * The proper and only scalable way is to use the native of_get_dma_request API
>> + * in order retrieve both the DMA controller device node and the DMA request
>> + * line for that controller.
>> + */
>> +int of_dma_to_resource(struct device_node *dev, int index, struct resource *r)
>> +{
>
> I think a better way to discourage the use of IORESOURCE_DMA is to not provide
> this function at all, especially given that it's not really well-defined what
> it will do when you have more than one cell for the dma channel identifier or
> when you have multiple DMA engines, so any driver relying on it is inherently
> nonportable.

For the moment it is still used in a lot of places, and without any 
other better API yet, it is still useful. As written it is there only 
for simple single DMA controller case.

By maintaining that IORESOURCE_DMA for the moment we can adapt some 
driver to DT without having to change the way they are retrieving 
information. By using IORESOURCE_IRQ and IORESOURCE_MEM, we had the same 
advantage.

Otherwise how are we supposed to get the DMA channel for non-DT boot 
until we have migrated everything to DT? A bunch of ARM SoC are using 
IORESOURCE_DMA for the same purpose.

The goal here is really to maintain that during the transition phase 
only. As soon as the full DT support is there, we can switch to the of_ API.

Ideally, we should define and use a generic API non dependent of DT. 
AFAIK, that does not exist so far.
And since most drivers are not using dmaengine, we do not even have a 
common DMA fmwk to define an API on top.

I fully agree that this IORESOURCE_DMA is not scalable for multiple 
controller, ugly, and must be avoided like the plague.
But what other options do we have during the transition?

Regards,
Benoit
