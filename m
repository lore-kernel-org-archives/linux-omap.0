From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/12] mtd: nand: omap2: rely on generic DT
 parsing done in nand_scan_ident()
Date: Mon, 4 Apr 2016 10:23:04 +0300
Message-ID: <57021658.5060901@ti.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-4-git-send-email-boris.brezillon@free-electrons.com>
Reply-To: rogerq-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD45J6OZZMOBB5NMRC4AKGQEP7OH3WQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459515272-31011-4-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Zhou Wang <wan>
List-Id: linux-omap@vger.kernel.org

On 01/04/16 15:54, Boris Brezillon wrote:
> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

cheers,
-roger

> ---
>  drivers/memory/omap-gpmc.c | 7 -------
>  drivers/mtd/nand/omap2.c   | 9 ++++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 21825dd..85aa85e 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -25,7 +25,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_mtd.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/omap-gpmc.h>
> @@ -1876,12 +1875,6 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  				break;
>  			}
>  
> -	gpmc_nand_data->flash_bbt = of_get_nand_on_flash_bbt(child);
> -
> -	val = of_get_nand_bus_width(child);
> -	if (val == 16)
> -		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
> -
>  	gpmc_read_timings_dt(child, &gpmc_t);
>  	gpmc_nand_init(gpmc_nand_data, &gpmc_t);
>  
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 0749ca1..8921283 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1704,9 +1704,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pdata->flash_bbt)
> -		nand_chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
> -	else
> -		nand_chip->options |= NAND_SKIP_BBTSCAN;
> +		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
>  	/* scan NAND device connected to chip controller */
>  	nand_chip->options |= pdata->devsize & NAND_BUSWIDTH_16;
> @@ -1716,6 +1714,11 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		goto return_error;
>  	}
>  
> +	if (nand_chip->bbt_options & NAND_BBT_USE_FLASH)
> +		nand_chip->bbt_options |= NAND_BBT_NO_OOB;
> +	else
> +		nand_chip->options |= NAND_SKIP_BBTSCAN;
> +
>  	/* re-populate low-level callbacks based on xfer modes */
>  	switch (pdata->xfer_type) {
>  	case NAND_OMAP_PREFETCH_POLLED:
> 
