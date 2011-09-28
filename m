From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 02/13] gpio/omap: Adapt GPIO driver to DT
Date: Wed, 28 Sep 2011 10:15:47 +0200
Message-ID: <4E82D7B3.6080909@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-3-git-send-email-b-cousson@ti.com>
	<4E8161C7.7020404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E8161C7.7020404@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Rajendra,

On 9/27/2011 7:40 AM, Nayak, Rajendra wrote:
> On Monday 26 September 2011 10:20 PM, Benoit Cousson wrote:
>> Adapt the GPIO driver to retrieve information from a DT file.
>> Note that since the driver is currently under cleanup, some hacks
>> will have to be removed after.
>>
>> Add documentation for GPIO properties specific to OMAP.
>>
>> Remove an un-needed whitespace.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Charulatha V<charu@ti.com>
>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> ---
>>    .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++
>>    drivers/gpio/gpio-omap.c                           |  108 ++++++++++++++++++--
>>    2 files changed, 132 insertions(+), 9 deletions(-)
>>    create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> new file mode 100644
>> index 0000000..bdd63de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
>> @@ -0,0 +1,33 @@
>> +OMAP GPIO controller
>> +
>> +Required properties:
>> +- compatible:
>> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
>
> Would it be more readable to have
> "ti,omap2-gpio" for OMAP2 controllers and
> "ti,omap3-gpio" for OMAP3 controllers?
>
>> +  - "ti,omap4-gpio" for OMAP4 controller
>> +- #gpio-cells : Should be two.
>> +  - first cell is the pin number
>> +  - second cell is used to specify optional parameters (unused)
>> +- gpio-controller : Marks the device node as a GPIO controller.
>> +
>> +OMAP specific properties:
>> +- ti,hwmods: Name of the hwmod associated to the GPIO
>> +- id: 32 bits to identify the id (1 based index)
>> +- bank-width: number of pin supported by the controller (16 or 32)
>> +- debounce: set if the controller support the debouce funtionnality
>> +- bank-count: number of controller support by the SoC. This is a temporary
>> +  hack until the bank_count is removed from the driver.
>
> Is there a general rule to be followed as to when to use
> "ti,<prop-name>" and when to use just"<prop-name>".
> Since all these are OMAP specific properties, shouldn't all
> of them be "ti,<prop-name>"?

To be honest, I was wondering as well about this rule.
I think that a property that is not purely OMAP specific and that 
represents some standard HW information does not have to be prefixed by 
"ti,XXX".
So hwmods must be "ti,hwmods", but bank-witdh and bank-count seems to me 
quite generic.

>> +Example:
>> +
>> +gpio4: gpio4 {
>> +    compatible = "ti,omap4-gpio", "ti,omap-gpio";
>> +    ti,hwmods = "gpio4";
>> +    id =<4>;
>> +    bank-width =<32>;
>> +    debounce;
>> +    no_idle_on_suspend;
>> +    #gpio-cells =<2>;
>> +    gpio-controller;
>> +};
>> +
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 0599854..f878fa4 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -21,6 +21,8 @@
>>    #include<linux/io.h>
>>    #include<linux/slab.h>
>>    #include<linux/pm_runtime.h>
>> +#include<linux/of.h>
>> +#include<linux/of_device.h>
>>
>>    #include<mach/hardware.h>
>>    #include<asm/irq.h>
>> @@ -521,7 +523,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>>    	unsigned long flags;
>>
>>    	if (bank->non_wakeup_gpios&   gpio_bit) {
>> -		dev_err(bank->dev,
>> +		dev_err(bank->dev,
>
> Stray change?

Not anymore, it is part of the changelog :-)

>
>>    			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
>>    		return -EINVAL;
>>    	}
>> @@ -1150,6 +1152,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
>>    	irq_set_handler_data(bank->irq, bank);
>>    }
>>
>> +static const struct of_device_id omap_gpio_match[];
>> +
>>    static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>    {
>>    	static int gpio_init_done;
>> @@ -1157,11 +1161,31 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>    	struct resource *res;
>>    	int id;
>>    	struct gpio_bank *bank;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_device(omap_gpio_match,&pdev->dev);
>> +	if (match) {
>> +		pdata = match->data;
>> +		/* XXX: big hack until the bank_count is removed */
>> +		of_property_read_u32(node, "bank-count",&gpio_bank_count);
>> +		if (of_property_read_u32(node, "id",&id))
>
> id should be u32.

Oops, good point.

>
>> +			return -EINVAL;
>> +		/*
>> +		 * In an ideal world, the id should not be needed, but since
>> +		 * the OMAP TRM consider the multiple GPIO controllers as
>> +		 * multiple banks, the GPIO number is based on the whole set
>> +		 * of banks. Hence the need to provide an id in order to
>> +		 * respect the order and the correct GPIO number.
>> +		 */
>> +		id -= 1;
>> +	} else {
>> +		if (!pdev->dev.platform_data)
>> +			return -EINVAL;
>>
>> -	if (!pdev->dev.platform_data)
>> -		return -EINVAL;
>> -
>> -	pdata = pdev->dev.platform_data;
>> +		pdata = pdev->dev.platform_data;
>> +		id = pdev->id;
>> +	}
>>
>>    	if (!gpio_init_done) {
>>    		int ret;
>> @@ -1171,7 +1195,6 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>    			return ret;
>>    	}
>>
>> -	id = pdev->id;
>>    	bank =&gpio_bank[id];
>>
>>    	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> @@ -1181,12 +1204,19 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>    	}
>>
>>    	bank->irq = res->start;
>> -	bank->virtual_irq_start = pdata->virtual_irq_start;
>>    	bank->method = pdata->bank_type;
>>    	bank->dev =&pdev->dev;
>> -	bank->dbck_flag = pdata->dbck_flag;
>>    	bank->stride = pdata->bank_stride;
>> -	bank->width = pdata->bank_width;
>> +	if (match) {
>> +		of_property_read_u32(node, "bank-width",&bank->width);
>
> Bank width should be u32.
>
>> +		if (of_get_property(node, "debounce", NULL))
>
> of_find_property() should suffice.

Yes, indeed.

Thanks,
Benoit
