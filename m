From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 09/26] mtd: nand: omap: Clean up device tree support
Date: Fri, 4 Mar 2016 18:28:23 -0800
Message-ID: <20160305022823.GO55664@google.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-10-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455916548-3441-10-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Sorry, another small thing I noticed.

On Fri, Feb 19, 2016 at 11:15:31PM +0200, Roger Quadros wrote:
> Move NAND specific device tree parsing to NAND driver.
> 
> The NAND controller node must have a compatible id, register space
> resource and interrupt resource.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
[...]

> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 9e99199..0a637c4 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -24,6 +24,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_mtd.h>
>  
>  #include <linux/mtd/nand_bch.h>
>  #include <linux/platform_data/elm.h>
> @@ -177,10 +178,11 @@ struct omap_nand_info {
>  	struct gpmc_nand_regs		reg;
>  	struct gpmc_nand_ops		*ops;
>  	/* generated at runtime depending on ECC algorithm and layout selected */

^^^ I don't think that comment describes the following line. You
probably meant to delete this one?

> +	bool				flash_bbt;
> +	/* generated at runtime depending on ECC algorithm and layout */
>  	struct nand_ecclayout		oobinfo;
>  	/* fields specific for BCHx_HW ECC scheme */
>  	struct device			*elm_dev;
> -	struct device_node		*of_node;
>  };
>  
>  static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)

[...]

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
