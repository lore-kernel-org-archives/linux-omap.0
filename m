From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 11/16] mtd: onenand: omap2: Do not make delay for GPIO
 OMAP3 specific
Date: Wed, 15 Nov 2017 11:31:54 +0200
Message-ID: <ddbdbb7b-3238-b2a8-ecdd-45539aa4a22f@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212406.lgqpj57o4ckxbx4i@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212406.lgqpj57o4ckxbx4i@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:24, Ladislav Michl wrote:
> Second commit in driver history (782b7a367d81: "[MTD] [OneNAND] OMAP3:
> add delay for GPIO") added quirk for waiting until GPIO line settle.
> As DMA was disabled for OMAP2 boards, chances are this problem was
> not OMAP3 specific and as it is just one register read, previous
> test for SoC type is approximately as expensive as read itself.
> Make delay unconditional, which allows removing SoC specific code
> alltogether.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>  Changes:
>  -v3: new patch
>  -v4: none
> 
>  drivers/mtd/onenand/omap2.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index c9ff67100ef4..e4857a41760d 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -57,7 +57,6 @@ struct omap2_onenand {
>  	struct dma_chan *dma_chan;
>  	int freq;
>  	int (*setup)(void __iomem *base, int *freq_ptr);
> -	u8 flags;
>  };
>  
>  static void omap2_onenand_dma_complete_func(void *completion)
> @@ -148,9 +147,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
>  		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
>  			syscfg |= ONENAND_SYS_CFG1_IOBE;
>  			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
> -			if (c->flags & ONENAND_IN_OMAP34XX)
> -				/* Add a delay to let GPIO settle */
> -				syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
> +			/* Add a delay to let GPIO settle */
> +			syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
>  		}
>  
>  		reinit_completion(&c->irq_done);
> @@ -470,7 +468,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>  
>  	init_completion(&c->irq_done);
>  	init_completion(&c->dma_done);
> -	c->flags = pdata->flags;
>  	c->gpmc_cs = pdata->cs;
>  	c->gpio_irq = pdata->gpio_irq;
>  	if (pdata->dma_channel < 0) {
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
