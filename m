From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: complete the transfer on terminate_all
Date: Tue, 29 Jul 2014 21:06:12 +0200
Message-ID: <53D7F0A4.2050301@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de> <1406660344-25307-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50463 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaG2TGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 15:06:21 -0400
In-Reply-To: <1406660344-25307-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Russell King <rmk+kernel@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org

On 07/29/2014 08:58 PM, Sebastian Andrzej Siewior wrote:
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index b19f04f..81ede01 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -970,6 +970,12 @@ static int omap_dma_terminate_all(struct omap_chan *c)
>  
>  	/* Prevent this channel being scheduled */
>  	spin_lock(&d->lock);
> +	if (!c->desc && !list_empty(&c->node)) {
> +		struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
> +
> +		if (vd)
> +			dma_cookie_complete(&vd->tx);
> +	}

Why is start of the transfer deferred to the tasklet unless it is a
periodic transfer? Couldn't it be started right away?

>  	list_del_init(&c->node);
>  	spin_unlock(&d->lock);
>  

Sebastian
