From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 0/8] dmaengine/dra7x: DMA router (crossbar support)
Date: Sat, 9 May 2015 17:14:23 +0530
Message-ID: <20150509114423.GK3521@localhost>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43044 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbbEILnn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 May 2015 07:43:43 -0400
Content-Disposition: inline
In-Reply-To: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com

On Thu, Apr 09, 2015 at 12:35:46PM +0300, Peter Ujfalusi wrote:
> Vinod: is it OK if I send the Documnetation/dmanegine/ update a bit later when
> I have finished it?
> 
> Changes since v4:
> - Comments from Maxime Ripard addressed:
>  - long line fixed in of-dma.c
>  - node leaks has been fixed in ti-dma-crossbar
>  - Using devm_ioremap_resource() in ti-dma-crossbar
>  - u16 casting has been addressed
> - Router drivers are expected to return with ERR_PTR in case their
>   of_dma_route_allocate() callback fails.
> 
> Changes since v3:
> - Comments from Russell:
>  - Warnings removed in case of non DT boot when taking the DMA request number
>  - Reduced the number of channels presented to DMAengine
>  - removed the dma_sig parameter from omap_dma_chan_init()
> - Comments from Arnd:
>  - dma-device property renamed to dma-masters
>  - Allow list of phandes in dma-masters
> 
> Changes since v2:
> - not using regmap for the TI crossbar driver.
> 
> Changes since v1:
> - Comments from Russell King and  Paul Bolle addressed:
>  - Use the added defined in the omap-dma changes
>  - MODULE_* removed from the ti-dma-crossbar driver.
> - DMA router documentation: do not limit the #dma-cells to be the same as the
>   dma controller's #dma-cells. It might be possible to have a router which needs
>   more information than the DMA controller (direct request pairing for example)
> - Use defines in the ti-dma-crossbar driver
> - Binding document for the ti-dma-crossbar driver
> 
> Intro mail from v1:
> 
> The series adds support for DMA router type of devices. They are used in SoCs
> which has more peripherals with DMA request lines than the DMA controller can
> handle.
> The router itself is not part of the DMA controller and it's operation should be
> transparent (as it is in the HW) for the SW stack.
> 
> This series takes into accound the comments Sricharan received for his version
> of the crossbar driver:
> https://lkml.org/lkml/2014/3/7/199
> 
> This implementation is not tied to any DMA driver so it is possible to use the
> framework by other vendors, also ACPI version of binding can be easy enough to
> be added.
I have applied all but last change to topic/omap

Thanks
-- 
~Vinod
