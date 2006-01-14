From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] 24xx dma patch
Date: Fri, 13 Jan 2006 16:49:53 -0800
Message-ID: <20060114004952.GL5499@atomide.com>
References: <0ISN000DPUB62T@mmp2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <0ISN000DPUB62T@mmp2.samsung.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Kyungmin Park <kyungmin.park@samsung.com> [060105 23:37]:
> Hi 
> 
> It reads DMA status too early and use callback function.
> It's make dma error on 24xx when playing the music.
> 
> Regards,
> 
> Kyungmin Park
> 
> --
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -866,8 +866,10 @@ static int omap2_dma_handle_ch(int ch)
>  	val = 1 << (ch);
>  	omap_writel(val, OMAP_DMA4_IRQSTATUS_L0);
>  
> -	if (likely(dma_chan[ch].callback != NULL))
> +	if (likely(dma_chan[ch].callback != NULL)) {
> +		status = OMAP_DMA_CSR_REG(ch);
>  		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
> +	}
>  
>  	return 0;
>  }

I don't quite understand this patch; Why does the status need to be read
again?

Tony
