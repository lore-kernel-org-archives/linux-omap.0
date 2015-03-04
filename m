From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dma: cppi41: add missing directions bitfield
Date: Wed, 4 Mar 2015 18:13:23 +0530
Message-ID: <20150304124323.GR2613@intel.com>
References: <1424904842-27902-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10601 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbbCDMqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Mar 2015 07:46:36 -0500
Content-Disposition: inline
In-Reply-To: <1424904842-27902-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: dmaengine@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>

On Wed, Feb 25, 2015 at 04:54:02PM -0600, Felipe Balbi wrote:
> Without those we will see a kernel WARN()
> when loading musb on am335x devices.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/dma/cppi41.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/cppi41.c b/drivers/dma/cppi41.c
> index 512cb8e2805e..4e9cc8e8100c 100644
> --- a/drivers/dma/cppi41.c
> +++ b/drivers/dma/cppi41.c
> @@ -926,6 +926,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>  	cdd->ddev.device_issue_pending = cppi41_dma_issue_pending;
>  	cdd->ddev.device_prep_slave_sg = cppi41_dma_prep_slave_sg;
>  	cdd->ddev.device_terminate_all = cppi41_stop_chan;
> +	cdd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	cdd->ddev.dev = dev;
>  	INIT_LIST_HEAD(&cdd->ddev.channels);
>  	cpp41_dma_info.dma_cap = cdd->ddev.cap_mask;
Along with this please set src/dstn_addr_widths and residue_granularity
please

-- 
~Vinod

