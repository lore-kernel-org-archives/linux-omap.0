From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 18/27] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Mon, 26 Oct 2015 13:49:00 -0700
Message-ID: <20151026204900.GI13239@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-19-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442588029-13769-19-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Harvey Hunt <harvey.hunt-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+ others

A few comments below.

On Fri, Sep 18, 2015 at 05:53:40PM +0300, Roger Quadros wrote:
> The GPMC WAIT pin status are now available over gpiolib.
> Update the omap_dev_ready() function to use gpio instead of
> directly accessing GPMC register space.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mtd/nand/omap2.c                     | 29 +++++++++++++++++-----------
>  include/linux/platform_data/mtd-nand-omap2.h |  2 +-
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 228f498..d0f2620 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -12,6 +12,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
> @@ -184,6 +185,8 @@ struct omap_nand_info {
>  	/* fields specific for BCHx_HW ECC scheme */
>  	struct device			*elm_dev;
>  	struct device_node		*of_node;
> +	/* NAND ready gpio */
> +	struct gpio_desc		*ready_gpiod;
>  };
>  
>  /**
> @@ -1047,22 +1050,17 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
>  }
>  
>  /**
> - * omap_dev_ready - calls the platform specific dev_ready function
> + * omap_dev_ready - checks the NAND Ready GPIO line
>   * @mtd: MTD device structure
> + *
> + * Returns true if ready and false if busy.
>   */
>  static int omap_dev_ready(struct mtd_info *mtd)
>  {
> -	unsigned int val = 0;
>  	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
>  							mtd);
>  
> -	val = readl(info->reg.gpmc_status);
> -
> -	if ((val & 0x100) == 0x100) {
> -		return 1;
> -	} else {
> -		return 0;
> -	}
> +	return gpiod_get_value(info->ready_gpiod);
>  }
>  
>  /**
> @@ -1782,7 +1780,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		info->reg = pdata->reg;
>  		info->of_node = pdata->of_node;
>  		info->ecc_opt = pdata->ecc_opt;
> -		info->dev_ready	= pdata->dev_ready;
> +		if (pdata->dev_ready)
> +			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
> +
>  		info->xfer_type = pdata->xfer_type;
>  		info->devsize = pdata->devsize;
>  		info->elm_of_node = pdata->elm_of_node;
> @@ -1815,6 +1815,13 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
>  	nand_chip->cmd_ctrl  = omap_hwcontrol;
>  
> +	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "ready",
> +						    GPIOD_IN);

Others have been looking at using GPIOs for the ready/busy pin too. At a
minimum, we need an updated DT binding doc for this, since I see you're
adding this via device tree in a later patch (I don't see any DT binding
patch for this; but I could just be overlooking it). It'd also be great
if this support was moved to nand_dt_init() so other platforms can
benefit, but I won't require that.

Also, previous [0] proposers had suggested 'rb-gpios', not 'ready-gpio'
(the hardware docs typically call it 'rb' for ready/busy, FWIW). I don't
really care, but the name should be going into a doc, so we can choose
the same one everywhere.

EDIT: looks like the discussion was partly here [1] and it seems we're
landing on "rb-gpios" in the latest version [2]. Can we stick with that?

Regards,
Brian

[0] "Previous" may be subject to debate, as both series have been going
    for several revisions.
[1] http://patchwork.ozlabs.org/patch/515327/
[2] http://patchwork.ozlabs.org/patch/526819/

> +	if (IS_ERR(info->ready_gpiod)) {
> +		dev_err(dev, "failed to get ready gpio\n");
> +		return PTR_ERR(info->ready_gpiod);
> +	}
> +
>  	/*
>  	 * If RDY/BSY line is connected to OMAP then use the omap ready
>  	 * function and the generic nand_wait function which reads the status
> @@ -1822,7 +1829,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	 * chip delay which is slightly more than tR (AC Timing) of the NAND
>  	 * device and read status register until you get a failure or success
>  	 */
> -	if (info->dev_ready) {
> +	if (info->ready_gpiod) {
>  		nand_chip->dev_ready = omap_dev_ready;
>  		nand_chip->chip_delay = 0;
>  	} else {
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index ff27e5a..19e509d 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -70,7 +70,6 @@ struct omap_nand_platform_data {
>  	int			cs;
>  	struct mtd_partition	*parts;
>  	int			nr_parts;
> -	bool			dev_ready;
>  	bool			flash_bbt;
>  	enum nand_io		xfer_type;
>  	int			devsize;
> @@ -81,5 +80,6 @@ struct omap_nand_platform_data {
>  	/* deprecated */
>  	struct gpmc_nand_regs	reg;
>  	struct device_node	*of_node;
> +	bool			dev_ready;
>  };
>  #endif
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
