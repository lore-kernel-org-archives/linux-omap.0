From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] dma: add __must_check annotation for
 dmaengine_pause()
Date: Tue, 11 Aug 2015 15:28:52 +0530
Message-ID: <20150811095852.GW11789@localhost>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438977619-15488-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, peter@hurleysoftware.com, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 10:00:18PM +0200, Sebastian Andrzej Siewior wrote:
> In 8250-omap I learned it the hard way that ignoring the return code
> of dmaengine_pause() might be bad because the underlying DMA driver
> might not support the function at all and so not doing what one is
> expecting.
> This patch adds the __must_check annotation as suggested by Russell King.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 8ad9a4e839f6..4eac4716bded 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -825,7 +825,7 @@ static inline int dmaengine_terminate_all(struct dma_chan *chan)
>  	return -ENOSYS;
>  }
>  
> -static inline int dmaengine_pause(struct dma_chan *chan)
> +static inline int __must_check dmaengine_pause(struct dma_chan *chan)
>  {
>  	if (chan->device->device_pause)
>  		return chan->device->device_pause(chan);

Give that there are bunch of users of this call which may or maynot be using
this, I think putting this check is too stringent

-- 
~Vinod
