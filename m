From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP34xx
Date: Tue, 7 Feb 2012 00:19:50 +0100
Message-ID: <4F306016.9010203@ti.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120205012556.GG1426@atomide.com> <20120205125904.GB11372@n2100.arm.linux.org.uk> <20120205172925.GS20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41595 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab2BFXUB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Feb 2012 18:20:01 -0500
In-Reply-To: <20120205172925.GS20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

+ Grant and Rob

Hi Tony,

On 2/5/2012 6:29 PM, Tony Lindgren wrote:

[...]

>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -200,7 +200,7 @@ config MENELAUS
>>
>>   config TWL4030_CORE
>>   	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
>> -	depends on I2C=y&&  GENERIC_HARDIRQS&&  IRQ_DOMAIN
>> +	depends on I2C=y&&  GENERIC_HARDIRQS
>>   	help
>>   	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
>>   	  This core driver provides register access and IRQ handling
>> --- a/drivers/mfd/twl-core.c
>> +++ b/drivers/mfd/twl-core.c
>> @@ -263,7 +263,9 @@ struct twl_client {
>>
>>   static struct twl_client twl_modules[TWL_NUM_SLAVES];
>>
>> +#ifdef CONFIG_IRQ_DOMAIN
>>   static struct irq_domain domain;
>> +#endif
>>
>>   /* mapping the module id to slave id and base address */
>>   struct twl_mapping {
>> @@ -1226,13 +1228,13 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>   	pdata->irq_base = status;
>>   	pdata->irq_end = pdata->irq_base + nr_irqs;
>>
>> +#ifdef CONFIG_IRQ_DOMAIN
>>   	domain.irq_base = pdata->irq_base;
>>   	domain.nr_irq = nr_irqs;
>> -#ifdef CONFIG_OF_IRQ
>>   	domain.of_node = of_node_get(node);
>>   	domain.ops =&irq_domain_simple_ops;
>> -#endif
>>   	irq_domain_add(&domain);
>> +#endif
>>
>>   	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
>>   		dev_dbg(&client->dev, "can't talk I2C?\n");
> 
> The above should be a separate fix to the drivers/mfd/twl code.

In theory that patch should not be even needed.
The twl changes were done like that because it was assuming that USE_OF and thus IRQ_DOMAIN will be enabled by default for all OMAP2+ platforms at 3.3 time.
The whole point of doing that was to reduce the ifdefery in every drivers we have to adapt to DT.

You even pulled the patch to enable that a while back [1], but for some reason it did not reach mainline in 3.3-rc1.

Since Rob is about to enable IRQ_DOMAIN for every ARM platforms, I'd rather push the patch to enable OF for every OMAP2+ platform and avoid hacking the twl-core any further since Grant / Rob have anyway some patches to simplify and potentially removed the custom irq_domain from this driver [2].

Regards,
Benoit


[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commit;h=40c0591f0a349ec074357e05c6ab1a3bc951807c
[2] http://www.spinics.net/lists/arm-kernel/msg157375.html

