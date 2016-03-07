From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 17/26] mtd: nand: omap2: Implement NAND ready using
 gpiolib
Date: Mon, 7 Mar 2016 11:11:49 +0200
Message-ID: <56DD45D5.1080204@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-18-git-send-email-rogerq@ti.com>
 <20160305014624.GK55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160305014624.GK55664-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+ Boris

On 05/03/16 03:46, Brian Norris wrote:
> + Boris
> 
> On Fri, Feb 19, 2016 at 11:15:39PM +0200, Roger Quadros wrote:
>> The GPMC WAIT pin status are now available over gpiolib.
>> Update the omap_dev_ready() function to use gpio instead of
>> directly accessing GPMC register space.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 ++
>>  drivers/mtd/nand/omap2.c                           | 29 ++++++++++++++--------
>>  include/linux/platform_data/mtd-nand-omap2.h       |  2 +-
>>  3 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> index 810b87b..256bb86 100644
>> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>> @@ -48,6 +48,7 @@ Optional properties:
>>  		locating ECC errors for BCHx algorithms. SoC devices which have
>>  		ELM hardware engines should specify this device node in .dtsi
>>  		Using ELM for ECC error correction frees some CPU cycles.
>> + - rb-gpios:	GPIO specifier for the ready/busy# pin.
> 
> ^^ Looks better, I think.
> 
> Brian
> 
>>  
>>  For inline partition table parsing (optional):
>>  
>> @@ -78,6 +79,7 @@ Example for an AM33xx board:
>>  			ti,nand-xfer-type = "polled";
>>  			interrupt-parent = <&gpmc>;
>>  			interrupts = <0>, <1>;
>> +			rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
>>  
>>  			gpmc,sync-clk-ps = <0>;
>>  			gpmc,cs-on-ns = <0>;
>> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
>> index 0a637c4..e7939f1 100644
>> --- a/drivers/mtd/nand/omap2.c
>> +++ b/drivers/mtd/nand/omap2.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/dmaengine.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/module.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/jiffies.h>
>> @@ -183,6 +184,8 @@ struct omap_nand_info {
>>  	struct nand_ecclayout		oobinfo;
>>  	/* fields specific for BCHx_HW ECC scheme */
>>  	struct device			*elm_dev;
>> +	/* NAND ready gpio */
>> +	struct gpio_desc		*ready_gpiod;
>>  };
>>  
>>  static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
>> @@ -1024,21 +1027,16 @@ static int omap_wait(struct mtd_info *mtd, struct nand_chip *chip)
>>  }
>>  
>>  /**
>> - * omap_dev_ready - calls the platform specific dev_ready function
>> + * omap_dev_ready - checks the NAND Ready GPIO line
>>   * @mtd: MTD device structure
>> + *
>> + * Returns true if ready and false if busy.
>>   */
>>  static int omap_dev_ready(struct mtd_info *mtd)
>>  {
>> -	unsigned int val = 0;
>>  	struct omap_nand_info *info = mtd_to_omap(mtd);
>>  
>> -	val = readl(info->reg.gpmc_status);
>> -
>> -	if ((val & 0x100) == 0x100) {
>> -		return 1;
>> -	} else {
>> -		return 0;
>> -	}
>> +	return gpiod_get_value(info->ready_gpiod);
>>  }
>>  
>>  /**
>> @@ -1754,7 +1752,9 @@ static int omap_nand_probe(struct platform_device *pdev)
>>  		info->gpmc_cs = pdata->cs;
>>  		info->reg = pdata->reg;
>>  		info->ecc_opt = pdata->ecc_opt;
>> -		info->dev_ready	= pdata->dev_ready;
>> +		if (pdata->dev_ready)
>> +			dev_info(&pdev->dev, "pdata->dev_ready is deprecated\n");
>> +
>>  		info->xfer_type = pdata->xfer_type;
>>  		info->devsize = pdata->devsize;
>>  		info->elm_of_node = pdata->elm_of_node;
>> @@ -1786,6 +1786,13 @@ static int omap_nand_probe(struct platform_device *pdev)
>>  	nand_chip->IO_ADDR_W = nand_chip->IO_ADDR_R;
>>  	nand_chip->cmd_ctrl  = omap_hwcontrol;
>>  
>> +	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "rb",
>> +						    GPIOD_IN);
>> +	if (IS_ERR(info->ready_gpiod)) {
>> +		dev_err(dev, "failed to get ready gpio\n");
>> +		return PTR_ERR(info->ready_gpiod);
>> +	}
>> +
>>  	/*
>>  	 * If RDY/BSY line is connected to OMAP then use the omap ready
>>  	 * function and the generic nand_wait function which reads the status
>> @@ -1793,7 +1800,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>>  	 * chip delay which is slightly more than tR (AC Timing) of the NAND
>>  	 * device and read status register until you get a failure or success
>>  	 */
>> -	if (info->dev_ready) {
>> +	if (info->ready_gpiod) {
>>  		nand_chip->dev_ready = omap_dev_ready;
>>  		nand_chip->chip_delay = 0;
>>  	} else {
>> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
>> index 7f6de53..17d57a1 100644
>> --- a/include/linux/platform_data/mtd-nand-omap2.h
>> +++ b/include/linux/platform_data/mtd-nand-omap2.h
>> @@ -71,7 +71,6 @@ struct omap_nand_platform_data {
>>  	int			cs;
>>  	struct mtd_partition	*parts;
>>  	int			nr_parts;
>> -	bool			dev_ready;
>>  	bool			flash_bbt;
>>  	enum nand_io		xfer_type;
>>  	int			devsize;
>> @@ -82,5 +81,6 @@ struct omap_nand_platform_data {
>>  	/* deprecated */
>>  	struct gpmc_nand_regs	reg;
>>  	struct device_node	*of_node;
>> +	bool			dev_ready;
>>  };
>>  #endif
>> -- 
>> 2.1.4
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
