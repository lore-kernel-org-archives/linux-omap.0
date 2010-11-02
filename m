From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v2] McBSP: Fix the free variable update at remove.
Date: Tue, 2 Nov 2010 16:04:01 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D399831@dbde02.ent.ti.com>
References: <1288693488-10200-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36718 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab0KBKeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 06:34:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oA2AY3vf017682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Nov 2010 05:34:05 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oA2AY3qn003637
	for <linux-omap@vger.kernel.org>; Tue, 2 Nov 2010 16:04:03 +0530 (IST)
In-Reply-To: <1288693488-10200-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> Sent: Tuesday, November 02, 2010 3:55 PM
> To: linux-omap@vger.kernel.org
> Cc: Datta, Shubhrajyoti
> Subject: [PATCH v2] McBSP: Fix the free variable update at remove.
> 
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> At remove the free variable is wrongly updated.Attempting to solve the
> same.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> -[v2] Instead of using 0/1 use a macro
> 
>  arch/arm/plat-omap/include/plat/mcbsp.h |    3 +++
>  arch/arm/plat-omap/mcbsp.c              |   10 +++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-
> omap/include/plat/mcbsp.h
> index b87d83c..8988733 100644
> --- a/arch/arm/plat-omap/include/plat/mcbsp.h
> +++ b/arch/arm/plat-omap/include/plat/mcbsp.h
> @@ -37,6 +37,9 @@ static struct platform_device omap_mcbsp##port_nr = {	\
>  	.id	= OMAP_MCBSP##port_nr,			\
>  }
> 
> +#define TRUE			1
> +#define FALSE			0
> +

Why do you redefine them? They are already available.

>  #define OMAP7XX_MCBSP1_BASE	0xfffb1000
>  #define OMAP7XX_MCBSP2_BASE	0xfffb1800
> 
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index eac4b97..438b3c7 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -755,7 +755,7 @@ int omap_mcbsp_request(unsigned int id)
>  		goto err_kfree;
>  	}
> 
> -	mcbsp->free = 0;
> +	mcbsp->free = FALSE;
>  	mcbsp->reg_cache = reg_cache;
>  	spin_unlock(&mcbsp->lock);
> 
> @@ -815,7 +815,7 @@ err_clk_disable:
>  	clk_disable(mcbsp->iclk);
> 
>  	spin_lock(&mcbsp->lock);
> -	mcbsp->free = 1;
> +	mcbsp->free = TRUE;
>  	mcbsp->reg_cache = NULL;
>  err_kfree:
>  	spin_unlock(&mcbsp->lock);
> @@ -858,7 +858,7 @@ void omap_mcbsp_free(unsigned int id)
>  	if (mcbsp->free)
>  		dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
>  	else
> -		mcbsp->free = 1;
> +		mcbsp->free = TRUE;
>  	mcbsp->reg_cache = NULL;
>  	spin_unlock(&mcbsp->lock);
> 
> @@ -1771,7 +1771,7 @@ static int __devinit omap_mcbsp_probe(struct
> platform_device *pdev)
> 
>  	spin_lock_init(&mcbsp->lock);
>  	mcbsp->id = id + 1;
> -	mcbsp->free = 1;
> +	mcbsp->free = TRUE;

During probe this should not be TRUE as it becomes TRUE during 
a omap_mcbsp_request().

The changes should actually make this flag a boolean one and then
do these changes. You might also need to consider changing the code
in places where this flag is being used.
example:
if (mcbsp->free == TRUE)
	....

>  	mcbsp->dma_tx_lch = -1;
>  	mcbsp->dma_rx_lch = -1;
> 
> @@ -1845,7 +1845,7 @@ static int __devexit omap_mcbsp_remove(struct
> platform_device *pdev)
> 
>  		mcbsp->fclk = NULL;
>  		mcbsp->iclk = NULL;
> -		mcbsp->free = 0;
> +		mcbsp->free = TRUE;
>  		mcbsp->dev = NULL;
>  	}
> 
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
