From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/5] dmaengine: omap-dma: Implement protection for
 invalid max_burst
Date: Thu, 21 Sep 2017 22:42:08 +0530
Message-ID: <20170921171208.GF30097@localhost>
References: <20170912104424.18495-1-peter.ujfalusi@ti.com>
 <20170912104424.18495-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170912104424.18495-3-peter.ujfalusi@ti.com>
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

On Tue, Sep 12, 2017 at 01:44:21PM +0300, Peter Ujfalusi wrote:
> Set the device's max_burst to 16777215 (EN is 24bit unsigned value) so
> clients can take this into consideration when setting up the trasnfer.

ditto :D

> 
> During slave transfer preparation check if the requested maxburst is valid.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 8c1665c8fe33..f6dd849159d8 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -1288,6 +1288,10 @@ static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config
>  	    cfg->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
>  		return -EINVAL;
>  
> +	if (cfg->src_maxburst > chan->device->max_burst ||
> +	    cfg->dst_maxburst > chan->device->max_burst)
> +		return -EINVAL;
> +
>  	memcpy(&c->cfg, cfg, sizeof(c->cfg));
>  
>  	return 0;
> @@ -1482,6 +1486,7 @@ static int omap_dma_probe(struct platform_device *pdev)
>  	od->ddev.dst_addr_widths = OMAP_DMA_BUSWIDTHS;
>  	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>  	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	od->ddev.max_burst = SZ_16M - 1; /* CCEN: 24bit unsigned */
>  	od->ddev.dev = &pdev->dev;
>  	INIT_LIST_HEAD(&od->ddev.channels);
>  	spin_lock_init(&od->lock);
> -- 
> 2.14.1
> 
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 

-- 
~Vinod
