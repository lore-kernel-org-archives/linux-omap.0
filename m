From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
Date: Mon, 07 Nov 2011 11:57:44 +0530
Message-ID: <4EB77A60.5050704@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
 <1319702185-16108-3-git-send-email-rnayak@ti.com>
 <20111104203422.GB3918@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20111104203422.GB3918-O5ziIzlqnXUVNXGz7ipsyg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>
>> +- regulator-fixed-gpio: gpio to use for enable control
>> +- regulator-fixed-startup-delay: startup time in microseconds
>
> startup-delay-ms ?

ok.

>
>> +- regulator-fixed-enable-high: Polarity of enable GPIO,
>> +  1 = Active High, 0 = Active low
>
> Some gpio specifiers allow you to specify active high or low flags, but either
> way something like "enable-active-low" as a property (with active high as
> default if property is missing) is a more devicetreey convention.
>
>> +- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no
>
> Same here, you can drop the prefix. Also, the regular regulators use
> "regulator-name" for the supply name, it would make sense to reuse the same
> naming here, right?

yes, will do these changes.

>
>> +
>> +Example:
>> +
>> +	abc: fixedregulator@0 {
>> +		compatible = "regulator-fixed";
>> +		regulator-fixed-supply = "fixed-supply";
>> +		regulator-fixed-microvolts =<1800000>;
>> +		regulator-fixed-gpio =<43>;
>
> This is not a valid gpio specifier.

right. will fix.
>
>> +		regulator-fixed-startup-delay =<70000>;
>> +		regulator-fixed-enable-high;
>> +		regulator-fixed-enabled-at-boot;
>> +	};
>> diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
>> index 2fe9d99..9851b42 100644
>> --- a/drivers/regulator/fixed.c
>> +++ b/drivers/regulator/fixed.c
>> @@ -26,6 +26,9 @@
>>   #include<linux/gpio.h>
>>   #include<linux/delay.h>
>>   #include<linux/slab.h>
>> +#include<linux/of.h>
>> +#include<linux/regulator/of_regulator.h>
>> +#include<linux/regulator/machine.h>
>>
>>   struct fixed_voltage_data {
>>   	struct regulator_desc desc;
>> @@ -37,6 +40,46 @@ struct fixed_voltage_data {
>>   	bool is_enabled;
>>   };
>>
>> +
>> +/**
>> + * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
>> + * @dev: device requesting for fixed_voltage_config
>> + *
>> + * Populates fixed_voltage_config structure by extracting data from device
>> + * tree node, returns a pointer to the populated structure of NULL if memory
>> + * alloc fails.
>> + */
>> +struct fixed_voltage_config *of_get_fixed_voltage_config(struct device *dev)
>> +{
>> +	struct fixed_voltage_config *config;
>> +	struct device_node *np = dev->of_node;
>> +	const __be32 *microvolts, *gpio, *delay;
>> +
>> +	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config), GFP_KERNEL);
>> +	if (!config)
>> +		return NULL;
>> +
>> +	config->supply_name = of_get_property(np, "regulator-fixed-supply", NULL);
>> +	microvolts = of_get_property(np, "regulator-fixed-microvolts", NULL);
>> +	if (microvolts)
>> +		config->microvolts = be32_to_cpu(*microvolts);
>> +	gpio = of_get_property(np, "regulator-fixed-gpio", NULL);
>> +	if (gpio)
>> +		config->gpio = be32_to_cpu(*gpio);
>
> This needs to be fixed to parse a gpio properly instead.

yes, will use of_get_gpio() here.

>
>
>
> -Olof
