From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 14/16] mtd: onenand: omap2: Configure driver from DT
Date: Wed, 15 Nov 2017 13:04:22 +0200
Message-ID: <d9b85025-4889-106e-e346-115e7d960705@ti.com>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212742.m5t4rf5k47kikouu@lenoch>
 <27bb610f-b30a-cd4c-ccd5-06c0d9e205b7@ti.com>
 <20171115105357.3jkk5eyxst5limj3@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171115105357.3jkk5eyxst5limj3@lenoch>
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
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 15/11/17 12:53, Ladislav Michl wrote:
> On Wed, Nov 15, 2017 at 12:40:14PM +0200, Roger Quadros wrote:
>> On 11/11/17 23:27, Ladislav Michl wrote:
>>> Move away from platform data configuration and use pure DT approach.
>>>
>>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>>> ---
>>>  Changes:
>>>  -v2: move cleanups into separate patches
>>>       simplify dma setup
>>>       fix checkpatch error
>>>       print info about otimized timings in sync mode only
>>>  -v3: remove 'ti,omap3-onenand' compatible as it is not needed anymore
>>>  -v4: none
>>>
>>>  drivers/mtd/onenand/omap2.c | 264 +++++++++++++++++++++++++++-----------------
>>>  1 file changed, 162 insertions(+), 102 deletions(-)
>>>
>>> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
>>> index 62e4ede918c4..9ebbbf297993 100644
>>> --- a/drivers/mtd/onenand/omap2.c
>>> +++ b/drivers/mtd/onenand/omap2.c
>>> @@ -28,6 +28,8 @@
>>>  #include <linux/mtd/mtd.h>
>>>  #include <linux/mtd/onenand.h>
>>>  #include <linux/mtd/partitions.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/omap-gpmc.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/interrupt.h>
>>>  #include <linux/delay.h>
>>> @@ -35,10 +37,9 @@
>>>  #include <linux/dmaengine.h>
>>>  #include <linux/io.h>
>>>  #include <linux/slab.h>
>>> -#include <linux/gpio.h>
>>> +#include <linux/gpio/consumer.h>
>>>  
>>>  #include <asm/mach/flash.h>
>>> -#include <linux/platform_data/mtd-onenand-omap2.h>
>>>  
>>>  #define DRIVER_NAME "omap2-onenand"
>>>  
>>> @@ -48,15 +49,12 @@ struct omap2_onenand {
>>>  	struct platform_device *pdev;
>>>  	int gpmc_cs;
>>>  	unsigned long phys_base;
>>> -	unsigned int mem_size;
>>> -	int gpio_irq;
>>> +	struct gpio_desc *ready_gpiod;
>>
>> Is this the RDY pin or the INT pin?
>> If it is the INT pin then I'd keep the name as int_gpiod.
> 
> It is INT pin, so I'll use int_gpiod. Also shall we use int-gpios
> DT bindings then? Note, there can be two DPP devices in one die.

Yes int-gpios is better.
We'll leave the more than one devices case to be implemented whenever
someone has a real device.

> 
>>>  	struct mtd_info mtd;
>>>  	struct onenand_chip onenand;
>>>  	struct completion irq_done;
>>>  	struct completion dma_done;
>>>  	struct dma_chan *dma_chan;
>>> -	int freq;
>>> -	int (*setup)(void __iomem *base, int *freq_ptr);
>>>  };
>>>  
>>>  static void omap2_onenand_dma_complete_func(void *completion)
>>> @@ -84,6 +82,65 @@ static inline void write_reg(struct omap2_onenand *c, unsigned short value,
>>>  	writew(value, c->onenand.base + reg);
>>>  }
>>>  
>>> +static int omap2_onenand_set_cfg(struct omap2_onenand *c,
>>> +				 bool sr, bool sw,
>>> +				 int latency, int burst_len)
>>> +{
>>> +	unsigned short reg = ONENAND_SYS_CFG1_RDY | ONENAND_SYS_CFG1_INT;
>>> +
>>> +	reg |= latency << ONENAND_SYS_CFG1_BRL_SHIFT;
>>> +
>>> +	switch (burst_len) {
>>> +	case 0:		/* continuous */
>>> +		break;
>>> +	case 4:
>>> +		reg |= ONENAND_SYS_CFG1_BL_4;
>>> +		break;
>>> +	case 8:
>>> +		reg |= ONENAND_SYS_CFG1_BL_8;
>>> +		break;
>>> +	case 16:
>>> +		reg |= ONENAND_SYS_CFG1_BL_16;
>>> +		break;
>>> +	case 32:
>>> +		reg |= ONENAND_SYS_CFG1_BL_32;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (latency > 5)
>>> +		reg |= ONENAND_SYS_CFG1_HF;
>>> +	if (latency > 7)
>>> +		reg |= ONENAND_SYS_CFG1_VHF;
>>> +	if (sr)
>>> +		reg |= ONENAND_SYS_CFG1_SYNC_READ;
>>> +	if (sw)
>>> +		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
>>> +
>>> +	write_reg(c, reg, ONENAND_REG_SYS_CFG1);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int omap2_onenand_get_freq(int ver)
>>> +{
>>> +	switch ((ver >> 4) & 0xf) {
>>> +	case 0:
>>> +		return 40;
>>> +	case 1:
>>> +		return 54;
>>> +	case 2:
>>> +		return 66;
>>> +	case 3:
>>> +		return 83;
>>> +	case 4:
>>> +		return 104;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>>  static void wait_err(char *msg, int state, unsigned int ctrl, unsigned int intr)
>>>  {
>>>  	printk(KERN_ERR "onenand_wait: %s! state %d ctrl 0x%04x intr 0x%04x\n",
>>> @@ -152,12 +209,12 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
>>>  		}
>>>  
>>>  		reinit_completion(&c->irq_done);
>>> -		result = gpio_get_value(c->gpio_irq);
>>> +		result = gpiod_get_value(c->ready_gpiod);
>>>  		if (result < 0) {
>>>  			ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
>>>  			intr = read_reg(c, ONENAND_REG_INTERRUPT);
>>>  			wait_err("gpio error", state, ctrl, intr);
>>> -			return -EIO;
>>> +			return result;
>>>  		} else if (result == 0) {
>>>  			int retry_cnt = 0;
>>>  retry:
>>> @@ -431,8 +488,6 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>>>  	return 0;
>>>  }
>>>  
>>> -static struct platform_driver omap2_onenand_driver;
>>> -
>>>  static void omap2_onenand_shutdown(struct platform_device *pdev)
>>>  {
>>>  	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
>>> @@ -446,108 +501,124 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
>>>  
>>>  static int omap2_onenand_probe(struct platform_device *pdev)
>>>  {
>>> -	struct omap_onenand_platform_data *pdata;
>>> -	struct omap2_onenand *c;
>>> -	struct onenand_chip *this;
>>> -	int r;
>>> +	u32 val;
>>> +	dma_cap_mask_t mask;
>>> +	int freq, latency, r;
>>> +	unsigned int mem_size;
>>>  	struct resource *res;
>>> +	struct omap2_onenand *c;
>>> +	struct gpmc_onenand_info info;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *np = dev->of_node;
>>>  
>>> -	pdata = dev_get_platdata(&pdev->dev);
>>> -	if (pdata == NULL) {
>>> -		dev_err(&pdev->dev, "platform data missing\n");
>>> -		return -ENODEV;
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!res) {
>>> +		dev_err(dev, "error getting memory resource\n");
>>> +		return -EINVAL;
>>>  	}
>>>  
>>> -	c = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
>>
>> We should error out if np is NULL before beginning to read DT properties?
> 
> of_property_read_u32 will fail then, so I do not think it is worth adding
> explicit test for NULL here.
> 

But the error message would be wrong in that case.
I'm trying to tackle the case where driver was probed using legacy methods
where device tree/node isn't present.

>>> +	r = of_property_read_u32(np, "reg", &val);
>>> +	if (r) {
>>> +		dev_err(dev, "reg not found in DT\n");
>>> +		return r;
>>> +	}
>>> +
>>> +	c = devm_kzalloc(dev, sizeof(struct omap2_onenand), GFP_KERNEL);
>>>  	if (!c)
>>>  		return -ENOMEM;
>>>  
>>>  	init_completion(&c->irq_done);
>>>  	init_completion(&c->dma_done);
>>> -	c->gpmc_cs = pdata->cs;
>>> -	c->gpio_irq = pdata->gpio_irq;
>>> -	if (pdata->dma_channel < 0) {
>>> -		/* if -1, don't use DMA */
>>> -		c->gpio_irq = 0;
>>> -	}
>>> +	c->gpmc_cs = val;
>>> +	c->phys_base = res->start;
>>
>> Above 2 lines could be moved to just after where val and res is found respectively.
> 
> Nope, we do not have 'c' allocated at that time.
> 
indeed. silly me :)

>>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

<snip>

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
