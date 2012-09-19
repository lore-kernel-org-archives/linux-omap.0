From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 10:07:05 -0400
Message-ID: <20120919140705.GB16522@beef>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com>
 <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47495 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792Ab2ISOF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 10:05:29 -0400
Received: by ieak13 with SMTP id k13so1539305iea.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 07:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> new file mode 100644
> index 0000000..a4f59a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -0,0 +1,81 @@
> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +- #dma-cells: 		Must be at least 1. Used to provide DMA controller
> +			specific information. See DMA client binding below for
> +			more details.
> +
> +Optional properties:
> +- #dma-channels: 	Number of DMA channels supported by the controller.
> +- #dma-requests: 	Number of DMA requests signals supported by the
> +			controller.

Shouldn't these two optional properties drop the prefix #?  By
convention adopted from the various original OF/ePAPR/etc specs, the
only properties I would expect to see with this prefix are the
"*-cells" cell sizes. A quick search indicates this is the case
throughout all the current bindings.

-Matt
