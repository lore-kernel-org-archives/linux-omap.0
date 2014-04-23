From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: No need save/restore interrupt flags
 during spin_lock in IRQ
Date: Wed, 23 Apr 2014 11:21:41 +0530
Message-ID: <20140423055141.GA32284@intel.com>
References: <1397714313-26561-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36557 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbaDWGDR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 02:03:17 -0400
Content-Disposition: inline
In-Reply-To: <1397714313-26561-1-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: dan.j.williams@intel.com, nsekhar@ti.com, dmaengine@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Apr 17, 2014 at 12:58:33AM -0500, Joel Fernandes wrote:
> The vchan lock in edma_callback is acquired in hard interrupt context. As
> interrupts are already disabled, there's no point in save/restoring interrupt
> mask bit or cpsr flags.
> 
> Get rid of flags local variable and use spin_lock instead of spin_lock_irqsave.

Applied, thanks

-- 
~Vinod

> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/dma/edma.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 91849aa..25a75e2 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -638,7 +638,6 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
>  	struct edma_chan *echan = data;
>  	struct device *dev = echan->vchan.chan.device->dev;
>  	struct edma_desc *edesc;
> -	unsigned long flags;
>  	struct edmacc_param p;
>  
>  	edesc = echan->edesc;
> @@ -649,7 +648,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
>  
>  	switch (ch_status) {
>  	case EDMA_DMA_COMPLETE:
> -		spin_lock_irqsave(&echan->vchan.lock, flags);
> +		spin_lock(&echan->vchan.lock);
>  
>  		if (edesc) {
>  			if (edesc->cyclic) {
> @@ -665,11 +664,11 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
>  			}
>  		}
>  
> -		spin_unlock_irqrestore(&echan->vchan.lock, flags);
> +		spin_unlock(&echan->vchan.lock);
>  
>  		break;
>  	case EDMA_DMA_CC_ERROR:
> -		spin_lock_irqsave(&echan->vchan.lock, flags);
> +		spin_lock(&echan->vchan.lock);
>  
>  		edma_read_slot(EDMA_CHAN_SLOT(echan->slot[0]), &p);
>  
> @@ -700,7 +699,7 @@ static void edma_callback(unsigned ch_num, u16 ch_status, void *data)
>  			edma_trigger_channel(echan->ch_num);
>  		}
>  
> -		spin_unlock_irqrestore(&echan->vchan.lock, flags);
> +		spin_unlock(&echan->vchan.lock);
>  
>  		break;
>  	default:
> -- 
> 1.7.9.5
> 

-- 
