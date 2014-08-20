From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/1] clk: ti: add support for external clock provider
Date: Wed, 20 Aug 2014 10:39:14 +0300
Message-ID: <53F450A2.2030609@ti.com>
References: <1406898948-26113-1-git-send-email-t-kristo@ti.com> <1406898948-26113-2-git-send-email-t-kristo@ti.com> <20140819132232.GM3302@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58169 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbaHTHj7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Aug 2014 03:39:59 -0400
In-Reply-To: <20140819132232.GM3302@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "mturquette@linaro.org" <mturquette@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sassmann@kpanic.de" <sassmann@kpanic.de>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "jsarha@ti.com" <jsarha@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/19/2014 04:22 PM, Mark Rutland wrote:
> Hi Tero,
>
> On Fri, Aug 01, 2014 at 02:15:48PM +0100, Tero Kristo wrote:
>> External clock provider can now be used to register external clocks under
>> it. This is needed as the TI clock driver only registers clocks
>> hierarchically under clock providers, and external clocks do not belong
>> under any of the current ones.
>
> I must admit that I don't understand the justification for this binding.
>
> Why can't these clocks be descrbied elsewhere and wired up as usual? Why
> must they be under the TI clock provide node?
>
>  From the limited description above it sounds like the only reason this
> exists is to work around a deficiency in the TI clock driver. That does
> not sound like a very good reason for having this.

I wouldn't call it a deficiency, but its by design due to need for 
registering clocks and clock providers hierarchically.

I guess it might be possible to re-work the TI clock init to check for 
the parent node, and if it is a clock provider, see if it has been 
initialized or not. The clock provider maps the IO range so it must be 
initialized before any clocks under it are initialized. I'll experiment 
with this a bit and see how it works out.

-Tero

>
> Thanks,
> Mark.
>
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   .../devicetree/bindings/arm/omap/ext-clocks.txt    |   32 ++++++++++++++++++++
>>   arch/arm/mach-omap2/io.c                           |   12 ++++++--
>>   drivers/clk/ti/clk.c                               |   23 ++++++++++++++
>>   include/linux/clk/ti.h                             |    2 ++
>>   4 files changed, 67 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/arm/omap/ext-clocks.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt b/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt
>> new file mode 100644
>> index 0000000..8e784bb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/omap/ext-clocks.txt
>> @@ -0,0 +1,32 @@
>> +TI external clock provider properties
>> +
>> +External clock provider is used to group SoC external board specific
>> +clock nodes. A separate provider node is required as the TI clock
>> +driver registers clocks hierarchically.
>> +
>> +Required properties:
>> +- compatible:		Shall be: "ti,external-clocks"
>> +- clocks:		Contains the external clocks for the board
>> +- clockdomains:		Contains the external clockdomains for the board
>> +
>> +Example:
>> +
>> +ext_clocks {
>> +	compatible = "ti,external-clocks";
>> +
>> +	ext_clocks: clocks {
>> +	};
>> +
>> +	ext_clockdomains: clockdomains {
>> +	};
>> +};
>> +
>> +...
>> +
>> +&ext_clocks {
>> +	gpio_test_clock {
>> +		compatible = "gpio-clock";
>> +		#clock-cells = <0>;
>> +		enable-gpios = <&gpio5 25 GPIO_ACTIVE_HIGH>;
>> +	};
>> +};
>> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>> index 8f55945..77be18b 100644
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -21,6 +21,8 @@
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk/ti.h>
>>
>>   #include <asm/tlb.h>
>>   #include <asm/mach/map.h>
>> @@ -729,8 +731,14 @@ int __init omap_clk_init(void)
>>   		return 0;
>>
>>   	ret = of_prcm_init();
>> -	if (!ret)
>> -		ret = omap_clk_soc_init();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ti_dt_clk_ext_init();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = omap_clk_soc_init();
>>
>>   	return ret;
>>   }
>> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
>> index b1a6f71..c84ce4d 100644
>> --- a/drivers/clk/ti/clk.c
>> +++ b/drivers/clk/ti/clk.c
>> @@ -165,3 +165,26 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
>>   		kfree(retry);
>>   	}
>>   }
>> +
>> +static struct of_device_id ti_ext_clk_match_table[] = {
>> +	{ .compatible = "ti,external-clocks" },
>> +	{ }
>> +};
>> +
>> +/**
>> + * ti_dt_clk_ext_init - initialize external clocks from DT
>> + *
>> + * Some clocks are provided from external chips outside the main SoC.
>> + * The details for these are given under a special DT node, which will
>> + * be parsed by this function.
>> + */
>> +int ti_dt_clk_ext_init(void)
>> +{
>> +	struct device_node *np;
>> +
>> +	for_each_matching_node(np, ti_ext_clk_match_table) {
>> +		ti_dt_clk_init_provider(np, -1);
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
>> index e8d8a35..188270c 100644
>> --- a/include/linux/clk/ti.h
>> +++ b/include/linux/clk/ti.h
>> @@ -310,6 +310,8 @@ int am43xx_dt_clk_init(void);
>>   int omap2420_dt_clk_init(void);
>>   int omap2430_dt_clk_init(void);
>>
>> +int ti_dt_clk_ext_init(void);
>> +
>>   #ifdef CONFIG_OF
>>   void of_ti_clk_allow_autoidle_all(void);
>>   void of_ti_clk_deny_autoidle_all(void);
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

