From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Fri, 16 Mar 2012 10:03:01 +0000
Message-ID: <201203161003.02163.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55911 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492Ab2CPKDK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 06:03:10 -0400
In-Reply-To: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>

On Thursday 15 March 2012, Nicolas Ferre wrote:
> For legacy reason another API will export the DMA request number into a
> Linux resource of type IORESOURCE_DMA.

Can you explain which legacy scenarios you think this is going to help with?

> +/**
> + * of_dma_to_resource - Decode a node's DMA and return it as a resource
> + * @dev: pointer to device tree node
> + * @index: zero-based index of the DMA request
> + * @r: pointer to resource structure to return result into.
> + *
> + * Using a resource to export a DMA request number to a driver should
> + * be used only for legacy purpose and on system when only one DMA controller
> + * is present.
> + * The proper and only scalable way is to use the native of_get_dma_request API
> + * in order retrieve both the DMA controller device node and the DMA request
> + * line for that controller.
> + */
> +int of_dma_to_resource(struct device_node *dev, int index, struct resource *r)
> +{

I think a better way to discourage the use of IORESOURCE_DMA is to not provide
this function at all, especially given that it's not really well-defined what
it will do when you have more than one cell for the dma channel identifier or
when you have multiple DMA engines, so any driver relying on it is inherently
nonportable.

	Arnd
