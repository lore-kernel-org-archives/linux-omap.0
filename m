From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/3] gpio-twl4030: get platform data from device tree
Date: Wed, 05 Sep 2012 09:10:00 +0200
Message-ID: <5046FAC8.5080609@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch> <1346680491-4211-2-git-send-email-florian.vaussard@epfl.ch> <5045AD54.5030503@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:33385 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754232Ab2IEHKJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 03:10:09 -0400
In-Reply-To: <5045AD54.5030503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org



>
> On 9/3/2012 7:24 PM, Florian Vaussard wrote:
>> Adds a number of missing properties to the device tree of
>> twl4030/gpio:
>> - "ti,use-leds"  -> .use_leds
>> - "ti,debounce"  -> .debounce
>> - "ti,mmc-cd"    -> .mmc_cd
>> - "ti,pullups"   -> .pullups
>> - "ti,pulldowns" -> .pulldowns
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   drivers/gpio/gpio-twl4030.c |   86 +++++++++++++++++++++++++++++-------------
>>   1 files changed, 59 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
>> index 94256fe..dabe76b 100644
>> --- a/drivers/gpio/gpio-twl4030.c
>> +++ b/drivers/gpio/gpio-twl4030.c
>> @@ -395,6 +395,33 @@ static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
>>   
>>   static int gpio_twl4030_remove(struct platform_device *pdev);
>>   
>> +static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
>> +{
>> +	struct twl4030_gpio_platform_data *omap_twl_info;
>> +	const char *of_use_leds;
>> +
>> +	omap_twl_info = devm_kzalloc(dev, sizeof(*omap_twl_info), GFP_KERNEL);
>> +	if (!omap_twl_info)
>> +		return NULL;
>> +
>> +	omap_twl_info->gpio_base = -1;
>> +
>> +	of_property_read_string(dev->of_node, "ti,use-leds", &of_use_leds);
>> +	if (!strcmp(of_use_leds, "true"))
>> +		omap_twl_info->use_leds = true;
>> +
> You can replace this with
>
> omap_twl_info->use_leds = of_property_read_bool(dev->of_node,
> "ti,use-leds");
>
> Otherwise looks OK to me, also I have tested it on OMAP3EVM.
>
> Tested-&-Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thank you Vaibhav for your review. I will send a v2 today.

Regards,
Florian
