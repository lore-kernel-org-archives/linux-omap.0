From: Tony Lindgren <tony@atomide.com>
Subject: Re: Add MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags in omap.c
Date: Fri, 10 Nov 2006 02:36:53 +0200
Message-ID: <20061110003653.GX16172@atomide.com>
References: <454F8B75.5030401@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <454F8B75.5030401@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [061106 21:23]:
> Hi Tony and folks,
> 
> Following previous comments from Juha and Pierre, this patch add
> MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags in omap.c
> 
> BR,
> 
> Carlos.
> 
> -- 
> Carlos Eduardo
> Nokia Institute of Technology - INdT
> Embedded Linux Laboratory - 10LE
> Phone: +55 92 2126-1079
> Mobile: +55 92 8127-1797
> E-mail: carlos.aguiar@indt.org.br
> 

> Add MMC_CAP_{MULTIWRITE,BYTEBLOCK} flags
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
> 
> Index: linux-omap-git/drivers/mmc/omap.c
> ===================================================================
> --- linux-omap-git.orig/drivers/mmc/omap.c	2006-11-06 13:20:29.000000000 -0400
> +++ linux-omap-git/drivers/mmc/omap.c	2006-11-06 13:50:28.000000000 -0400
> @@ -1088,8 +1088,8 @@ static int __init mmc_omap_probe(struct 
>  	mmc->ops = &mmc_omap_ops;
>  	mmc->f_min = 400000;
>  	mmc->f_max = 24000000;
> -	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_CAP_MULTIWRITE
> -				| MMC_CAP_BYTEBLOCK;
> +	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +	mmc->caps = MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
>  
>  	if (minfo->wire4)
>  		 mmc->caps |= MMC_CAP_4_BIT_DATA;


Pushing today.

Tony
