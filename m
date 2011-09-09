From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 08/10] gpio/omap: Adapt GPIO driver to DT
Date: Fri, 9 Sep 2011 03:48:33 +0200
Message-ID: <4E697071.6040804@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-9-git-send-email-b-cousson@ti.com>
	<20110908181507.GG2967@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908181507.GG2967@ponder.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Hilman, Kevin" <khilman@ti.com>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

On 9/8/2011 8:15 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:14PM +0200, Benoit Cousson wrote:
>> Adapt the GPIO driver to retrieve information from a DT file.
>> Note that since the driver is currently under cleanup, some hacks
>> will have to be removed after.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Charulatha V<charu@ti.com>
>> Cc: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>
> Mostly looks good.  Comments below.
>
>> ---
>>   drivers/gpio/gpio-omap.c |  103 ++++++++++++++++++++++++++++++++++++++++++----
>>   1 files changed, 94 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 0599854..96d19d7 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -21,6 +21,7 @@
>>   #include<linux/io.h>
>>   #include<linux/slab.h>
>>   #include<linux/pm_runtime.h>
>> +#include<linux/of_platform.h>
>>
>>   #include<mach/hardware.h>
>>   #include<asm/irq.h>
>> @@ -521,7 +522,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
>>   	unsigned long flags;
>>
>>   	if (bank->non_wakeup_gpios&  gpio_bit) {
>> -		dev_err(bank->dev,
>> +		dev_err(bank->dev,
>
> nit: unrelated whitespace change
>
>>   			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
>>   		return -EINVAL;
>>   	}
>> @@ -1150,6 +1151,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
>>   	irq_set_handler_data(bank->irq, bank);
>>   }
>>
>> +static const struct of_device_id omap_gpio_match[];
>> +
>>   static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>   {
>>   	static int gpio_init_done;
>> @@ -1157,11 +1160,25 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>>   	struct resource *res;
>>   	int id;
>>   	struct gpio_bank *bank;
>> +	struct device_node *node = pdev->dev.of_node;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_device(omap_gpio_match,&pdev->dev);
>> +	if (match) {
>> +		pdata = match->data;
>> +		/* XXX: big hack until the bank_count is removed */
>> +		of_property_read_u32(node, "bank_count",&gpio_bank_count);
>
> Nit: by convention, '-' is preferred over '_' in DT property names.
>
>> +		if (of_property_read_u32(node, "id",&id))
>> +			return -EINVAL;
>> +		/* XXX: maybe the id in DT should be zero based to avoid that */
>> +		id -= 1;
>
> Actually, the reason it is -1 based, is that when using the DT, gpio
> number are dynamically assigned.  Since the gpio numbers are resolved
> entirely within the core DT gpio support code, the number used by
> linux isn't actually important for building a .dts file.

I'm not sure about that. The six controllers are handled as banks, so 
the order does matters. In fact it should be considered as a big GPIO 
controller with 192 entries. And this is that global number that the HW 
documentation, board definition and even pin mux use.
The user does not even have a clue about the controller used without 
doing a little bit of math.

Here is for example how a beagle board is using the gpio global number.

static struct gpio omap3_beagle_rev_gpios[] __initdata = {
	{ 171, GPIOF_IN, "rev_id_0"    },
	{ 172, GPIOF_IN, "rev_id_1" },
	{ 173, GPIOF_IN, "rev_id_2"    },
};

The current GPIO usage will force us doing that:

node {
	gpios = <&gpio6 11 0>,
		<&gpio6 12 0>,
		<&gpio6 13 0>;
};

It looks to me that this kind of conversion tends to be error prone.

I guess that this is a quite standard organization, so is there a way to 
handle that global number? Like that for example:

node {
	gpios = <&omap_gpio 171 0>,
		<&omap_gpio 172 0>,
		<&omap_gpio 173 0>;
};


Benoit
