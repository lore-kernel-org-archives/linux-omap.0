From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: edma: fix memory leak when terminating
 running transfers
Date: Mon, 30 Mar 2015 23:18:27 +0530
Message-ID: <20150330174827.GL7192@intel.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427456155-28990-2-git-send-email-peter.ujfalusi@ti.com>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux@arm.linux.org.uk, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Petr Kulhavy <petr@barix.com>, stable@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 27, 2015 at 01:35:51PM +0200, Peter Ujfalusi wrote:
> From: Petr Kulhavy <petr@barix.com>
> 
> If edma_terminate_all() was called while a transfer was running (i.e. after
> edma_execute() but before edma_callback()) the echan->edesc was not freed.
> 
> This was due to the fact that a running transfer is on none of the
> vchan lists: desc_submitted, desc_issued, desc_completed (edma_execute()
> removes it from the desc_issued list), so the vchan_dma_desc_free_list()
> called at the end of edma_terminate_all() didn't find it and didn't free it.
> 
> This bug was found on an AM1808 based hardware (very similar to da850evm,
> however using the second MMC/SD controller), where intense operations on the SD
> card wasted the device 128MB RAM within a couple of days.
> 
> Peter Ujfalusi:
> The issue is even more severe since it affects cyclic (audio) transfers as
> well. In this case starting/stopping audio will results memory leak.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: <stable@vger.kernel.org>
> CC: <linux-omap@vger.kernel.org>
Applied, thanks

-- 
~Vinod

> ---
>  drivers/dma/edma.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 741baa68365c..984c2b12dae3 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -268,6 +268,13 @@ static int edma_terminate_all(struct dma_chan *chan)
>  	 */
>  	if (echan->edesc) {
>  		int cyclic = echan->edesc->cyclic;
> +
> +		/*
> +		 * free the running request descriptor
> +		 * since it is not in any of the vdesc lists
> +		 */
> +		edma_desc_free(&echan->edesc->vdesc);
> +
>  		echan->edesc = NULL;
>  		edma_stop(echan->ch_num);
>  		/* Move the cyclic channel back to default queue */
> -- 
> 2.3.3
> 

-- 
