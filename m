From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 14/16] mtd: onenand: omap2: Configure driver from DT
Date: Wed, 15 Nov 2017 12:40:14 +0200
Message-ID: <27bb610f-b30a-cd4c-ccd5-06c0d9e205b7@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212742.m5t4rf5k47kikouu@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212742.m5t4rf5k47kikouu@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

On 11/11/17 23:27, Ladislav Michl wrote:
> Move away from platform data configuration and use pure DT approach.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v2: move cleanups into separate patches
>       simplify dma setup
>       fix checkpatch error
>       print info about otimized timings in sync mode only
>  -v3: remove 'ti,omap3-onenand' compatible as it is not needed anymore
>  -v4: none
> 
>  drivers/mtd/onenand/omap2.c | 264 +++++++++++++++++++++++++++-----------------
>  1 file changed, 162 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 62e4ede918c4..9ebbbf297993 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -28,6 +28,8 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/onenand.h>
>  #include <linux/mtd/partitions.h>
> +#include <linux/of_device.h>
> +#include <linux/omap-gpmc.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -35,10 +37,9 @@
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <asm/mach/flash.h>
> -#include <linux/platform_data/mtd-onenand-omap2.h>
>  
>  #define DRIVER_NAME "omap2-onenand"
>  
> @@ -48,15 +49,12 @@ struct omap2_onenand {
>  	struct platform_device *pdev;
>  	int gpmc_cs;
>  	unsigned long phys_base;
> -	unsigned int mem_size;
> -	int gpio_irq;
> +	struct gpio_desc *ready_gpiod;

Is this the RDY pin or the INT pin?
If it is the INT pin then I'd keep the name as int_gpiod.

>  	struct mtd_info mtd;
>  	struct onenand_chip onenand;
>  	struct completion irq_done;
>  	struct completion dma_done;
>  	struct dma_chan *dma_chan;
> -	int freq;
> -	int (*setup)(void __iomem *base, int *freq_ptr);
>  };
>  
>  static void omap2_onenand_dma_complete_func(void *completion)
> @@ -84,6 +82,65 @@ static inline void write_reg(struct omap2_onenand *c, unsigned short value,
>  	writew(value, c->onenand.base + reg);
>  }
>  
> +static int omap2_onenand_set_cfg(struct omap2_onenand *c,
> +				 bool sr, bool sw,
> +				 int latency, int burst_len)
> +{
> +	unsigned short reg = ONENAND_SYS_CFG1_RDY | ONENAND_SYS_CFG1_INT;
> +
> +	reg |= latency << ONENAND_SYS_CFG1_BRL_SHIFT;
> +
> +	switch (burst_len) {
> +	case 0:		/* continuous */
> +		break;
> +	case 4:
> +		reg |= ONENAND_SYS_CFG1_BL_4;
> +		break;
> +	case 8:
> +		reg |= ONENAND_SYS_CFG1_BL_8;
> +		break;
> +	case 16:
> +		reg |= ONENAND_SYS_CFG1_BL_16;
> +		break;
> +	case 32:
> +		reg |= ONENAND_SYS_CFG1_BL_32;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (latency > 5)
> +		reg |= ONENAND_SYS_CFG1_HF;
> +	if (latency > 7)
> +		reg |= ONENAND_SYS_CFG1_VHF;
> +	if (sr)
> +		reg |= ONENAND_SYS_CFG1_SYNC_READ;
> +	if (sw)
> +		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
> +
> +	write_reg(c, reg, ONENAND_REG_SYS_CFG1);
> +
> +	return 0;
> +}
> +
> +static int omap2_onenand_get_freq(int ver)
> +{
> +	switch ((ver >> 4) & 0xf) {
> +	case 0:
> +		return 40;
> +	case 1:
> +		return 54;
> +	case 2:
> +		return 66;
> +	case 3:
> +		return 83;
> +	case 4:
> +		return 104;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static void wait_err(char *msg, int state, unsigned int ctrl, unsigned int intr)
>  {
>  	printk(KERN_ERR "onenand_wait: %s! state %d ctrl 0x%04x intr 0x%04x\n",
> @@ -152,12 +209,12 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
>  		}
>  
>  		reinit_completion(&c->irq_done);
> -		result = gpio_get_value(c->gpio_irq);
> +		result = gpiod_get_value(c->ready_gpiod);
>  		if (result < 0) {
>  			ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
>  			intr = read_reg(c, ONENAND_REG_INTERRUPT);
>  			wait_err("gpio error", state, ctrl, intr);
> -			return -EIO;
> +			return result;
>  		} else if (result == 0) {
>  			int retry_cnt = 0;
>  retry:
> @@ -431,8 +488,6 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  	return 0;
>  }
>  
> -static struct platform_driver omap2_onenand_driver;
> -
>  static void omap2_onenand_shutdown(struct platform_device *pdev)
>  {
>  	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
> @@ -446,108 +501,124 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
>  
>  static int omap2_onenand_probe(struct platform_device *pdev)
>  {
> -	struct omap_onenand_platform_data *pdata;
> -	struct omap2_onenand *c;
> -	struct onenand_chip *this;
> -	int r;
> +	u32 val;
> +	dma_cap_mask_t mask;
> +	int freq, latency, r;
> +	unsigned int mem_size;
>  	struct resource *res;
> +	struct omap2_onenand *c;
> +	struct gpmc_onenand_info info;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (pdata == NULL) {
> -		dev_err(&pdev->dev, "platform data missing\n");
> -		return -ENODEV;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "error getting memory resource\n");
> +		return -EINVAL;
>  	}
>  
> -	c = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);

We should error out if np is NULL before beginning to read DT properties?

> +	r = of_property_read_u32(np, "reg", &val);
> +	if (r) {
> +		dev_err(dev, "reg not found in DT\n");
> +		return r;
> +	}
> +
> +	c = devm_kzalloc(dev, sizeof(struct omap2_onenand), GFP_KERNEL);
>  	if (!c)
>  		return -ENOMEM;
>  
>  	init_completion(&c->irq_done);
>  	init_completion(&c->dma_done);
> -	c->gpmc_cs = pdata->cs;
> -	c->gpio_irq = pdata->gpio_irq;
> -	if (pdata->dma_channel < 0) {
> -		/* if -1, don't use DMA */
> -		c->gpio_irq = 0;
> -	}
> +	c->gpmc_cs = val;
> +	c->phys_base = res->start;

Above 2 lines could be moved to just after where val and res is found respectively.

>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (res == NULL) {
> -		r = -EINVAL;
> -		dev_err(&pdev->dev, "error getting memory resource\n");
> -		goto err_kfree;
> -	}
> +	mem_size = resource_size(res);
> +	if (!devm_request_mem_region(dev, c->phys_base, mem_size,
> +				     dev->driver->name)) {
>  
> -	c->phys_base = res->start;
> -	c->mem_size = resource_size(res);
> -
> -	if (request_mem_region(c->phys_base, c->mem_size,
> -			       pdev->dev.driver->name) == NULL) {
> -		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
> -						c->phys_base, c->mem_size);
> -		r = -EBUSY;
> -		goto err_kfree;
> -	}
> -	c->onenand.base = ioremap(c->phys_base, c->mem_size);
> -	if (c->onenand.base == NULL) {
> -		r = -ENOMEM;
> -		goto err_release_mem_region;
> +		dev_err(dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
> +			c->phys_base, mem_size);
> +		return -EBUSY;
>  	}
>  
> -	if (pdata->onenand_setup != NULL) {
> -		r = pdata->onenand_setup(c->onenand.base, &c->freq);
> -		if (r < 0) {
> -			dev_err(&pdev->dev, "Onenand platform setup failed: "
> -				"%d\n", r);
> -			goto err_iounmap;
> -		}
> -		c->setup = pdata->onenand_setup;
> -	}
> +	c->onenand.base = devm_ioremap(dev, c->phys_base, mem_size);
> +	if (!c->onenand.base)
> +		return -ENOMEM;

How about doing request and ioremap in one shot?

	c->onenand.base = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(base))
		return PTR_ERR(base);

>  
> -	if (c->gpio_irq) {
> -		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
> -			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
> -				"OneNAND\n", c->gpio_irq);
> -			goto err_iounmap;
> -		}
> -		gpio_direction_input(c->gpio_irq);
> +	c->ready_gpiod = devm_gpiod_get_optional(dev, "rb", GPIOD_IN);

I'd keep the name "onenand int" if it is the INT pin.

> +	if (IS_ERR(c->ready_gpiod)) {
> +		r = PTR_ERR(c->ready_gpiod);
> +		/* Just try again if this happens */
> +		if (r != -EPROBE_DEFER)
> +			dev_err(dev, "error getting gpio: %d\n", r);
> +		return r;
> +	}
>  
> -		if ((r = request_irq(gpio_to_irq(c->gpio_irq),
> -				     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
> -				     pdev->dev.driver->name, c)) < 0)
> -			goto err_release_gpio;
> +	if (c->ready_gpiod) {
> +		r = devm_request_irq(dev, gpiod_to_irq(c->ready_gpiod),
> +				     omap2_onenand_interrupt,
> +				     IRQF_TRIGGER_RISING, "OneNAND", c);

"onenand" to be consistent with onenand_base.c?

> +		if (r)
> +			return r;
>  
> -		this->wait = omap2_onenand_wait;
> +		c->onenand.wait = omap2_onenand_wait;
>  	}
>  
> -	if (pdata->dma_channel >= 0) {
> -		dma_cap_mask_t mask;
> -
> -		dma_cap_zero(mask);
> -		dma_cap_set(DMA_MEMCPY, mask);
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
>  
> -		c->dma_chan = dma_request_channel(mask, NULL, NULL);
> +	c->dma_chan = dma_request_channel(mask, NULL, NULL);
> +	if (c->dma_chan) {
> +		c->onenand.read_bufferram = omap2_onenand_read_bufferram;
> +		c->onenand.write_bufferram = omap2_onenand_write_bufferram;
>  	}
>  
> -	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
> -		 "base %p, freq %d MHz, %s mode\n", c->gpmc_cs, c->phys_base,
> -		 c->onenand.base, c->freq, c->dma_chan ? "DMA" : "PIO");
> -
>  	c->pdev = pdev;
>  	c->mtd.priv = &c->onenand;
> +	c->mtd.dev.parent = dev;
> +	mtd_set_of_node(&c->mtd, dev->of_node);
>  
> -	c->mtd.dev.parent = &pdev->dev;
> -	mtd_set_of_node(&c->mtd, pdata->of_node);
> -
> -	this = &c->onenand;
> -	if (c->dma_chan) {
> -		this->read_bufferram = omap2_onenand_read_bufferram;
> -		this->write_bufferram = omap2_onenand_write_bufferram;
> -	}
> +	dev_info(dev, "initializing on CS%d (0x%08lx), va %p, %s mode\n",
> +		 c->gpmc_cs, c->phys_base, c->onenand.base,
> +		 c->dma_chan ? "DMA" : "PIO");
>  
>  	if ((r = onenand_scan(&c->mtd, 1)) < 0)
>  		goto err_release_dma;
>  
> +	freq = omap2_onenand_get_freq(c->onenand.version_id);
> +	if (freq > 0) {
> +		switch (freq) {
> +		case 104:
> +			latency = 7;
> +			break;
> +		case 83:
> +			latency = 6;
> +			break;
> +		case 66:
> +			latency = 5;
> +			break;
> +		case 56:
> +			latency = 4;
> +			break;
> +		default:	/* 40 MHz or lower */
> +			latency = 3;
> +			break;
> +		}
> +
> +		r = gpmc_omap_onenand_set_timings(dev, c->gpmc_cs,
> +						  freq, latency, &info);
> +		if (r)
> +			goto err_release_onenand;
> +
> +		r = omap2_onenand_set_cfg(c, info.sync_read, info.sync_write,
> +					  latency, info.burst_len);
> +		if (r)
> +			goto err_release_onenand;
> +
> +		if (info.sync_read || info.sync_write)
> +			dev_info(dev, "optimized timings for %d MHz\n", freq);
> +	}
> +
>  	r = mtd_device_register(&c->mtd, NULL, 0);
>  	if (r)
>  		goto err_release_onenand;
> @@ -561,17 +632,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
>  err_release_dma:
>  	if (c->dma_chan)
>  		dma_release_channel(c->dma_chan);
> -	if (c->gpio_irq)
> -		free_irq(gpio_to_irq(c->gpio_irq), c);
> -err_release_gpio:
> -	if (c->gpio_irq)
> -		gpio_free(c->gpio_irq);
> -err_iounmap:
> -	iounmap(c->onenand.base);
> -err_release_mem_region:
> -	release_mem_region(c->phys_base, c->mem_size);
> -err_kfree:
> -	kfree(c);
>  
>  	return r;
>  }
> @@ -584,23 +644,23 @@ static int omap2_onenand_remove(struct platform_device *pdev)
>  	if (c->dma_chan)
>  		dma_release_channel(c->dma_chan);
>  	omap2_onenand_shutdown(pdev);
> -	if (c->gpio_irq) {
> -		free_irq(gpio_to_irq(c->gpio_irq), c);
> -		gpio_free(c->gpio_irq);
> -	}
> -	iounmap(c->onenand.base);
> -	release_mem_region(c->phys_base, c->mem_size);
> -	kfree(c);
>  
>  	return 0;
>  }
>  
> +static const struct of_device_id omap2_onenand_id_table[] = {
> +	{ .compatible = "ti,omap2-onenand", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap2_onenand_id_table);
> +
>  static struct platform_driver omap2_onenand_driver = {
>  	.probe		= omap2_onenand_probe,
>  	.remove		= omap2_onenand_remove,
>  	.shutdown	= omap2_onenand_shutdown,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
> +		.of_match_table = omap2_onenand_id_table,
>  	},
>  };
>  
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
