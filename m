From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/9] dmaengine: edma: Use enum for eDMA binding type (legacy vs TPCC)
Date: Wed, 21 Sep 2016 13:38:02 +0200
Message-ID: <4786368.2BtHOp8jmm@wuerfel>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com> <7753810.Z3F41qkFaI@wuerfel> <bbd248d1-223c-00a9-3d2a-33df085c4f68@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bbd248d1-223c-00a9-3d2a-33df085c4f68@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 21, 2016 2:07:22 PM CEST Peter Ujfalusi wrote:
> > 
> > I tend to use 'uintptr_t' for the cast instead.
> 
> What about keeping the defines and:
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 3e9606b08340..493fdf30e8b8 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -263,14 +263,19 @@ static const struct edmacc_param dummy_paramset = {
> 
>  #define EDMA_BINDING_LEGACY    0
>  #define EDMA_BINDING_TPCC      1
> +static const u32 edma_binding_type[] = {
> +       [EDMA_BINDING_LEGACY] = EDMA_BINDING_LEGACY,
> +       [EDMA_BINDING_TPCC] = EDMA_BINDING_TPCC,
> +};
> +
>  static const struct of_device_id edma_of_ids[] = {
>         {
>                 .compatible = "ti,edma3",
> -               .data = (void *)EDMA_BINDING_LEGACY,
> +               .data = (void *)&edma_binding_type[EDMA_BINDING_LEGACY],
>         },
>         {
>                 .compatible = "ti,edma3-tpcc",
> -               .data = (void *)EDMA_BINDING_TPCC,
> +               .data = (void *)&edma_binding_type[EDMA_BINDING_TPCC],
>         },
>         {}

You can drop the cast to (void *) here, otherwise looks good.

	Arnd
