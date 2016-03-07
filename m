From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 13/26] memory: omap-gpmc: Support general purpose input
 for WAITPINs
Date: Mon, 7 Mar 2016 12:02:02 +0200
Message-ID: <56DD519A.3070403@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
 <1455916548-3441-14-git-send-email-rogerq@ti.com>
 <20160307103440.4b9d7a55@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160307103440.4b9d7a55@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Boris,

On 07/03/16 11:34, Boris Brezillon wrote:
> Hi Roger,
> 
> On Fri, 19 Feb 2016 23:15:35 +0200
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
>> OMAPs can have 2 to 4 WAITPINs that can be used as general purpose
>> input if not used for memory wait state insertion.
>>
>> The first user will be the OMAP NAND chip to get the NAND
>> read/busy status using gpiolib.
> 
> Just a comment on this approach. Why do you need to exposed native R/B
> pins as GPIOs? I mean, other NAND controllers are supporting R/B
> detection using dedicated logic, and they do not exposed those pins a
> plain GPIOs. Have you considered adding another property (rb-native ?)
> to deal with this case instead of emulating a GPIO controller?
> Side note: I added an rb-gpios property in my sunxi-nand DT binding
> because in some cases, the board design forces us to use a plain GPIO.

OMAPs can have more than one WAITpins which can be used in multiple ways
- wait state insertion
- general purpose input
- edge detect interrupt

It is not automatically tied to NAND read/busy# mechanism and needs software
to get the read/busy# state.
The register to get WAIT pin status is not situated in the NAND controller
register space but in the parent GPMC controller space.

So we've modelled the WAIT pins as irqchip and gpiochip and users can
use them as they want.

cheers,
-roger

> 
> Anyway, I realize I'm quite late to review this, and I don't want to
> delay even more the inclusion of those patches, so I leave the decision
> to the MTD and TI maintainers.
> 
> Best Regards,
> 
> Boris
> 
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  .../bindings/memory-controllers/omap-gpmc.txt      |   3 +
>>  drivers/memory/Kconfig                             |   1 +
>>  drivers/memory/omap-gpmc.c                         | 115 ++++++++++++++++++---
>>  3 files changed, 107 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> index 704be93..8113a52 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> +++ b/Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>> @@ -32,6 +32,9 @@ Required properties:
>>  			bootloader) are used for the physical address decoding.
>>  			As this will change in the future, filling correct
>>  			values here is a requirement.
>> + - gpio-controller:	The GPMC driver implements a GPIO controller for the
>> +			GPMC WAIT pins that can be used as general purpose inputs.
>> +			0 maps to GPMC_WAIT0 pin.
>>  
>>  Timing properties for child nodes. All are optional and default to 0.
>>  
>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>> index 6f31546..bca24c6 100644
>> --- a/drivers/memory/Kconfig
>> +++ b/drivers/memory/Kconfig
>> @@ -51,6 +51,7 @@ config TI_EMIF
>>  
>>  config OMAP_GPMC
>>  	bool
>> +	select GPIOLIB
>>  	help
>>  	  This driver is for the General Purpose Memory Controller (GPMC)
>>  	  present on Texas Instruments SoCs (e.g. OMAP2+). GPMC allows
>> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
>> index 6c8d85e..f67e5695 100644
>> --- a/drivers/memory/omap-gpmc.c
>> +++ b/drivers/memory/omap-gpmc.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/io.h>
>>  #include <linux/module.h>
>> +#include <linux/gpio/driver.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/platform_device.h>
>> @@ -237,6 +238,7 @@ struct gpmc_device {
>>  	struct device *dev;
>>  	int irq;
>>  	struct irq_chip irq_chip;
>> +	struct gpio_chip gpio_chip;
>>  };
>>  
>>  static struct irq_domain *gpmc_irq_domain;
>> @@ -2034,10 +2036,69 @@ err:
>>  	return ret;
>>  }
>>  
>> +static int gpmc_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
>> +{
>> +	return 1;	/* we're input only */
>> +}
>> +
>> +static int gpmc_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
>> +{
>> +	return 0;	/* we're input only */
>> +}
>> +
>> +static int gpmc_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
>> +				      int value)
>> +{
>> +	return -EINVAL;	/* we're input only */
>> +}
>> +
>> +static void gpmc_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>> +{
>> +}
>> +
>> +static int gpmc_gpio_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +	u32 reg;
>> +
>> +	offset += 8;
>> +
>> +	reg = gpmc_read_reg(GPMC_STATUS) & BIT(offset);
>> +
>> +	return !!reg;
>> +}
>> +
>> +static int gpmc_gpio_init(struct gpmc_device *gpmc)
>> +{
>> +	int ret;
>> +
>> +	gpmc->gpio_chip.parent = gpmc->dev;
>> +	gpmc->gpio_chip.owner = THIS_MODULE;
>> +	gpmc->gpio_chip.label = DEVICE_NAME;
>> +	gpmc->gpio_chip.ngpio = gpmc_nr_waitpins;
>> +	gpmc->gpio_chip.get_direction = gpmc_gpio_get_direction;
>> +	gpmc->gpio_chip.direction_input = gpmc_gpio_direction_input;
>> +	gpmc->gpio_chip.direction_output = gpmc_gpio_direction_output;
>> +	gpmc->gpio_chip.set = gpmc_gpio_set;
>> +	gpmc->gpio_chip.get = gpmc_gpio_get;
>> +	gpmc->gpio_chip.base = -1;
>> +
>> +	ret = gpiochip_add(&gpmc->gpio_chip);
>> +	if (ret < 0) {
>> +		dev_err(gpmc->dev, "could not register gpio chip: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void gpmc_gpio_exit(struct gpmc_device *gpmc)
>> +{
>> +	gpiochip_remove(&gpmc->gpio_chip);
>> +}
>> +
>>  static int gpmc_probe_dt(struct platform_device *pdev)
>>  {
>>  	int ret;
>> -	struct device_node *child;
>>  	const struct of_device_id *of_id =
>>  		of_match_device(gpmc_dt_ids, &pdev->dev);
>>  
>> @@ -2065,6 +2126,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	return 0;
>> +}
>> +
>> +static int gpmc_probe_dt_children(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct device_node *child;
>> +
>>  	for_each_available_child_of_node(pdev->dev.of_node, child) {
>>  
>>  		if (!child->name)
>> @@ -2074,6 +2143,9 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>  			ret = gpmc_probe_onenand_child(pdev, child);
>>  		else
>>  			ret = gpmc_probe_generic_child(pdev, child);
>> +
>> +		if (ret)
>> +			return ret;
>>  	}
>>  
>>  	return 0;
>> @@ -2083,6 +2155,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>  {
>>  	return 0;
>>  }
>> +
>> +static int gpmc_probe_dt_children(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
>>  #endif
>>  
>>  static int gpmc_probe(struct platform_device *pdev)
>> @@ -2129,6 +2206,15 @@ static int gpmc_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  
>> +	if (pdev->dev.of_node) {
>> +		rc = gpmc_probe_dt(pdev);
>> +		if (rc)
>> +			return rc;
>> +	} else {
>> +		gpmc_cs_num = GPMC_CS_NUM;
>> +		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
>> +	}
>> +
>>  	pm_runtime_enable(&pdev->dev);
>>  	pm_runtime_get_sync(&pdev->dev);
>>  
>> @@ -2154,29 +2240,33 @@ static int gpmc_probe(struct platform_device *pdev)
>>  		 GPMC_REVISION_MINOR(l));
>>  
>>  	gpmc_mem_init();
>> +	rc = gpmc_gpio_init(gpmc);
>> +	if (rc)
>> +		goto gpio_init_failed;
>>  
>>  	rc = gpmc_setup_irq(gpmc);
>>  	if (rc) {
>>  		dev_err(gpmc->dev, "gpmc_setup_irq failed\n");
>> -		goto fail;
>> +		goto setup_irq_failed;
>>  	}
>>  
>> -	if (!pdev->dev.of_node) {
>> -		gpmc_cs_num	 = GPMC_CS_NUM;
>> -		gpmc_nr_waitpins = GPMC_NR_WAITPINS;
>> -	}
>> -
>> -	rc = gpmc_probe_dt(pdev);
>> +	rc = gpmc_probe_dt_children(pdev);
>>  	if (rc < 0) {
>> -		dev_err(gpmc->dev, "failed to probe DT parameters\n");
>> -		gpmc_free_irq(gpmc);
>> -		goto fail;
>> +		dev_err(gpmc->dev, "failed to probe DT children\n");
>> +		goto dt_children_failed;
>>  	}
>>  
>>  	return 0;
>>  
>> -fail:
>> +dt_children_failed:
>> +	gpmc_free_irq(gpmc);
>> +setup_irq_failed:
>> +	gpmc_gpio_exit(gpmc);
>> +gpio_init_failed:
>> +	gpmc_mem_exit();
>>  	pm_runtime_put_sync(&pdev->dev);
>> +	pm_runtime_disable(&pdev->dev);
>> +
>>  	return rc;
>>  }
>>  
>> @@ -2185,6 +2275,7 @@ static int gpmc_remove(struct platform_device *pdev)
>>  	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
>>  
>>  	gpmc_free_irq(gpmc);
>> +	gpmc_gpio_exit(gpmc);
>>  	gpmc_mem_exit();
>>  	pm_runtime_put_sync(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
> 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
