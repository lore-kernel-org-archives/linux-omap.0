From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [OMAP2 CAM] Changes init_timer to setup_timer
Date: Mon, 17 Sep 2007 11:37:05 -0700
Message-ID: <20070917183704.GA5614@atomide.com>
References: <1189690721400-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1189690721400-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Eduardo Valentin <edubezval@gmail.com> [070913 06:43]:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This simple patch changes init_timer call to setup_timer.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  drivers/media/video/omap24xxcam-dma.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/video/omap24xxcam-dma.c b/drivers/media/video/omap24xxcam-dma.c
> index a995b47..5de0b6b 100644
> --- a/drivers/media/video/omap24xxcam-dma.c
> +++ b/drivers/media/video/omap24xxcam-dma.c
> @@ -597,7 +597,5 @@ void omap24xxcam_sgdma_init(struct omap24xxcam_sgdma *sgdma,
>  	}
>  
>  	omap24xxcam_dma_init(&sgdma->dma, base);
> -	init_timer(&sgdma->reset_timer);
> -	sgdma->reset_timer.function = reset_callback;
> -	sgdma->reset_timer.data = reset_callback_data;
> +	setup_timer(&sgdma->reset_timer, reset_callback, reset_callback_data);
>  }

Pushing today.

Tony
