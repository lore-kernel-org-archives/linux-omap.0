From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/7] ARM: OMAP2+: gpmc-nand: Set omap2-nand's parent
 dev to GPMC dev
Date: Fri, 11 Mar 2016 15:52:55 +0200
Message-ID: <56E2CDB7.2080306@ti.com>
References: <1457654203-20856-1-git-send-email-fcooper@ti.com>
 <1457654203-20856-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457654203-20856-2-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Franklin,

On 11/03/16 01:56, Franklin S Cooper Jr wrote:
> The dma channel information is located within the GPMC node which is the
> NAND's parent node. The NAND driver requires a handle to the GPMC's dev
> to properly parse the DMA properties. Therefore, set the NAND's parent dev
> to the GPMC's dev so it can be referenced within the driver.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> ---
> Version 4 changes:
> Instead of storing the GPMC dev in a new property simply grab a reference
> to it and set omap2-nand's dev.parent to it.
> 
>  arch/arm/mach-omap2/gpmc-nand.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 72918c4..77e453c 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -15,6 +15,7 @@
>  #include <linux/omap-gpmc.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/platform_data/mtd-nand-omap2.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/mach/flash.h>
>  
> @@ -77,6 +78,9 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  	int err	= 0;
>  	struct gpmc_settings s;
>  	struct platform_device *pdev;
> +	struct platform_device *gpmc_dev;
> +	struct device_node *gpmc_node;
> +
>  	struct resource gpmc_nand_res[] = {
>  		{ .flags = IORESOURCE_MEM, },
>  		{ .flags = IORESOURCE_IRQ, },
> @@ -134,8 +138,18 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  	if (pdev) {
>  		err = platform_device_add_resources(pdev, gpmc_nand_res,
>  						    ARRAY_SIZE(gpmc_nand_res));
> -		if (!err)
> +		if (!err) {
>  			pdev->dev.platform_data = gpmc_nand_data;
> +
> +			gpmc_node = of_get_parent(gpmc_nand_data->of_node);

I'm afraid that we can't use this method as we want to restrict
gpmc_nand_init() to non-DT boots.

> +
> +			if (gpmc_node) {
> +				gpmc_dev = of_find_device_by_node(gpmc_node);
> +
> +				if (gpmc_dev)
> +					pdev->dev.parent = &gpmc_dev->dev;
> +			}
> +		}
>  	} else {
>  		err = -ENOMEM;
>  	}
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
