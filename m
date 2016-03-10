From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 1/6] memory: omap-gpmc: Store handle to GPMC dev
Date: Thu, 10 Mar 2016 14:40:00 +0200
Message-ID: <56E16B20.5070001@ti.com>
References: <1457582861-20619-1-git-send-email-fcooper@ti.com>
 <1457582861-20619-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457582861-20619-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Franklin,

On 10/03/16 06:07, Franklin S Cooper Jr wrote:
> The dma channel information is located within the GPMC node. The NAND
> driver requires a handle to the GPMC's dev to properly parse the DMA
> properties. Therefore, store a handle to the dev so it can be referenced
> within the NAND driver.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/memory/omap-gpmc.c                   | 1 +
>  include/linux/platform_data/mtd-nand-omap2.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index 6515dfc..2932d13 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -1796,6 +1796,7 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  
>  	gpmc_nand_data->cs = val;
>  	gpmc_nand_data->of_node = child;
> +	gpmc_nand_data->gpmc_dev = &pdev->dev;
>  
>  	/* Detect availability of ELM module */
>  	gpmc_nand_data->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index 090bbab..534b984 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -80,5 +80,7 @@ struct omap_nand_platform_data {
>  	/* for passing the partitions */
>  	struct device_node	*of_node;
>  	struct device_node	*elm_of_node;
> +
> +	struct device		*gpmc_dev;
>  };
>  #endif
> 

Why do you need this? Can't we just use dev->parent in the omap2-nand driver?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
