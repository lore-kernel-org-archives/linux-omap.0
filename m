From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Tue, 2 Apr 2013 11:38:28 -0500
Message-ID: <515B0984.7050803@ti.com>
References: <1364631689.3767.7.camel@mars>  <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>  <1364834508.3939.74.camel@mars>  <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com> <1364918124.5935.145.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab3DBQiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 12:38:51 -0400
In-Reply-To: <1364918124.5935.145.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, =?UTF-8?B?QmVubw==?= =?UTF-8?B?w650IENvdXNzb24=?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>


On 04/02/2013 10:55 AM, Christoph Fritz wrote:
> On Mon, 2013-04-01 at 22:05 +0200, Javier Martinez Canillas wrote:
> 
>>> As a quick-fix (hack) I wrote directly to the registers in gpio_probe()
>>> to enable GPIO banks. I now geht this:
>>>
>>>>> [    0.214630] omap_gpio_probe, 1133, CM_CLKSEL_PER 0x48005040: 0x000000ff
>>>>> [    0.214660] omap_gpio_probe, 1136, CM_ICLKEN_PER 0x48005010: 0x0007ffff
>>>>> [    0.214660] omap_gpio_probe, 1139, CM_FCLKEN_PER 0x48005000: 0x0007ffff
> 
> to be more specific on this point, this is the patch to enable the
> gpio-clocks:
> 
> --
> Subject: [PATCH] HACK: enable gpio-clocks in gpio-omap probe()
> 
> Without this patch setting trigger value from #interrupt-cell two
> (smsc911x) fails.
> ---
>  drivers/gpio/gpio-omap.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 159f5c5..720b2e6 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1098,6 +1098,7 @@ static int omap_gpio_probe(struct platform_device
> *pdev)
>  	struct resource *res;
>  	struct gpio_bank *bank;
>  	int ret = 0;
> +	void __iomem *tmp;
> 
>  	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
> 
> @@ -1117,6 +1118,17 @@ static int omap_gpio_probe(struct platform_device
> *pdev)
>  		return -ENODEV;
>  	}
> 
> +	// TRM: Table 3-242. PER_CM Register Summary
> +	tmp = ioremap(0x48005040, 4); //CM_CLKSEL_PER, GPT2 = sys clk
> +	writel(0xFF, tmp);
> +	iounmap(tmp);
> +	tmp = ioremap(0x48005010, 4); //CM_ICLKEN_PER, ICKen GPT2
> +	writel(0x7FFFF, tmp);
> +	iounmap(tmp);
> +	tmp = ioremap(0x48005000, 4); //CM_FCLKEN_PER, GPIOX functional clock
> is enabled
> +	writel(0x7FFFF, tmp);
> +	iounmap(tmp);
> +
>  	bank->irq = res->start;
>  	bank->dev = dev;
>  	bank->dbck_flag = pdata->dbck_flag;
> 
> Is there a better way to do this?

A better way to hack this and leave the gpio bank on always would be ...

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f1fbedb2..0fc75a2 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1181,8 +1181,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
        if (bank->loses_context)
                bank->get_context_loss_count = pdata->get_context_loss_count;
 
-       pm_runtime_put(bank->dev);
-
        list_add_tail(&bank->node, &omap_gpio_list);
 
        return ret;

>>> And it works for me. _But_ when I do enable regulator twl4030
>>> (CONFIG_REGULATOR_TWL4030=y) in my config these registers get reset:
>>>
>>> [    2.935455] smsc911x_open, 1537, CM_CLKSEL_PER 0x48005040: 0x000000ff
>>> [    2.942291] smsc911x_open, 1540, CM_ICLKEN_PER 0x48005010: 0x00040fff
>>> [    2.949066] smsc911x_open, 1543, CM_FCLKEN_PER 0x48005000: 0x00000000
>>>
>>> And the IRQ source for the network chip (smsc911x) is disabled :-(
> 
> CONFIG_REGULATOR_TWL4030=y  disables the gpio-clocks. Why is that?

Well your hack is completely by-passing pm-runtime and so pm-runtime does not
know that someone has enabled the bank. Therefore, the next time pm_runtime_get()
is called followed by a pm_runtime_put() for the gpio bank it will disable the
bank. By removing the pm_runtime_put() at the end of probe should always keep the
bank enabled.

>>> Do you have any idea how to ("quick") fix this?
>>>
>>
>> A quick hack is to call gpio_request() explicitly before calling to
>> irq_set_type() is made.
>> I've this patch just to make it work until we find a clean solution:
>>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index 90c15ee..d594e1d 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -14,6 +14,7 @@
>>   */
>>  #undef DEBUG
>>
>> +#include <linux/gpio.h>
>>  #include <linux/irq.h>
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>> @@ -1528,6 +1529,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>>                 return ret;
>>         }
>>
>> +       ret = gpio_request_one(176, GPIOF_IN, "smsc911x irq");
>> +       if (ret) {
>> +               pr_err("Failed to request IRQ GPIO%d\n", 176);
>> +               return ret;
>> +       }
>> +
>>         for_each_node_by_name(child, "nand") {
>>                 ret = gpmc_probe_nand_child(pdev, child);
>>                 if (ret < 0) {
>>
>> This solves the issue of the non-initialized GPIO bank before that
>> makes the kernel to hang.
> 
> Here it does not. A printk shows that I'm not using gpmc at all.
> So I added a gpmc node:
> 
> +       gpmc: gpmc@0x6E000000 {
> +               compatible = "ti,omap3430-gpmc";
> +               ti,hwmods = "ti,gpmc";

This should just be ...

+               ti,hwmods = "gpmc";

> +               reg = <0x6E000000 0x2000>;
> +               gpmc,num-cs = <8>;
> +               gpmc,num-waitpins = <2>;
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               ranges = <0 0 0x0 0x3FFFFFFF>;
> +
> +       };
> 
> But still, gpmc_probe_dt() isn't called. I maybe have to define some
> child nodes but currently I do configure the gpmc in u-boot and try to
> avoid kernel-gpmc-config.

Not sure what patches you have, but the plan for DT is that the kernel
configures the gpmc and is not dependent on the bootloader.

Cheers
Jon
