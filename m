From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/9] dmaengine: edma: Use enum for eDMA binding type (legacy vs TPCC)
Date: Wed, 21 Sep 2016 12:31:52 +0200
Message-ID: <7753810.Z3F41qkFaI@wuerfel>
References: <20160921102637.24845-1-peter.ujfalusi@ti.com> <20160921102637.24845-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160921102637.24845-3-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 21, 2016 1:26:30 PM CEST Peter Ujfalusi wrote:
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index c2098a4b4dcf..4c8818278fcc 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -261,8 +261,11 @@ static const struct edmacc_param dummy_paramset = {
>         .ccnt = 1,
>  };
>  
> -#define EDMA_BINDING_LEGACY    0
> -#define EDMA_BINDING_TPCC      1
> +enum edma_binding_type {
> +       EDMA_BINDING_LEGACY = 0,
> +       EDMA_BINDING_TPCC,
> +};
> +
>  static const struct of_device_id edma_of_ids[] = {
>         {
>                 .compatible = "ti,edma3",
> @@ -2184,7 +2187,8 @@ static int edma_probe(struct platform_device *pdev)
>                 const struct of_device_id *match;
>  
>                 match = of_match_node(edma_of_ids, node);
> -               if (match && (u32)match->data == EDMA_BINDING_TPCC)
> +               if (match &&
> +                   (enum edma_binding_type)match->data == EDMA_BINDING_TPCC)
>                         legacy_mode = false;
>  
>                 info = edma_setup_info_from_dt(dev, legacy_mode);
> -- 
> 2.10.0
> 

Are you sure this works on all architectures? IIRC the size of an enum
is implementation defined, so this could still fail sometimes.

I tend to use 'uintptr_t' for the cast instead.

	Arnd
