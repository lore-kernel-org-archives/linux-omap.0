From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/5] dmaengine: edma: Implement protection for invalid
 max_burst
Date: Thu, 21 Sep 2017 22:40:18 +0530
Message-ID: <20170921171018.GE30097@localhost>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
 <20170912104424.18495-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170912104424.18495-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 12, 2017 at 01:44:20PM +0300, Peter Ujfalusi wrote:
> Set the device's max_burst to 32767 (CIDX is 16bit signed value) so clients
> can take this into consideration when setting up the trasnfer.

/s/trasnfer/transfer

> 
> During slave transfer preparation check if the requested maxburst is valid.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/edma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 3879f80a4815..6970355abdc9 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -891,6 +891,10 @@ static int edma_slave_config(struct dma_chan *chan,
>  	    cfg->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
>  		return -EINVAL;
>  
> +	if (cfg->src_maxburst > chan->device->max_burst ||
> +	    cfg->dst_maxburst > chan->device->max_burst)
> +		return -EINVAL;
> +
>  	memcpy(&echan->cfg, cfg, sizeof(echan->cfg));
>  
>  	return 0;
> @@ -1855,6 +1859,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
>  	s_ddev->dst_addr_widths = EDMA_DMA_BUSWIDTHS;
>  	s_ddev->directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
>  	s_ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	s_ddev->max_burst = SZ_32K - 1; /* CIDX: 16bit signed */
>  
>  	s_ddev->dev = ecc->dev;
>  	INIT_LIST_HEAD(&s_ddev->channels);
> -- 
> 2.14.1
> 
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 

-- 
~Vinod
