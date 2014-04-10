From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 08/14] DMA: edma: Use different eventq for cyclic
	channels
Date: Thu, 10 Apr 2014 11:36:30 -0500
Message-ID: <5346C88E.8010504@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1396357575-30585-9-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/01/2014 08:06 AM, Peter Ujfalusi wrote:
> To improve latency with cyclic DMA operation it is preferred to
> use different eventq/tc than the default which is used by all
> other drivers (mmc, spi, i2c, etc).
> When preparing the cyclic dma ask for non default queue for the
> channel which is going to be used with cyclic mode.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/dma/edma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 1dd9e8806975..10048b40fac8 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -628,6 +628,9 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  		edesc->pset[i].opt |= TCINTEN;
>  	}
>  
> +	/* Use different eventq/tc for cyclic DMA to reduce latency */
> +	edma_request_non_default_queue(echan->ch_num);
> +
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>  }
>  
> 

Is there any way to guarantee that the non-default queue is of the
highest priority, or in other words default queue is of lowest priority.
I know you set queue 1 as default because by default 0 is higher
priority. And then assigning non-default queue.

When assigning default to Queue 1, it would be good to also call
assign_priority_to_queue and set QUEPRI to 7 for Queue 1. Since 0, 2 and
4 are all non-defaults.

Thanks,
-Joel
