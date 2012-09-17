From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a
 slave DMA channel
Date: Mon, 17 Sep 2012 09:03:25 +0530
Message-ID: <1347852805.1943.130.camel@vkoul-udesk3>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
	 <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8940 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387Ab2IQDh0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Sep 2012 23:37:26 -0400
In-Reply-To: <1347662517-4210-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>

On Fri, 2012-09-14 at 17:41 -0500, Jon Hunter wrote:
> +/**
> + * dma_request_slave_channel - try to allocate an exclusive slave
> channel
> + * @dev:       pointer to client device structure
> + * @name:      slave channel name
> + */
> +struct dma_chan *dma_request_slave_channel(struct device *dev, char *name)
> +{
> +       /* If device-tree is present get slave info from here */
> +       if (dev->of_node)
> +               return of_dma_request_slave_channel(dev->of_node, name);
> +
Shouldn't this be conditionally compiled only when OF is built. I think
this might be problematic for systems which doesn't have device tree.
Or perhaps you can declare these symbols as dummy in of_dma.h when
device tree is not selected.
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(dma_request_slave_channel); 
-- 
~Vinod

