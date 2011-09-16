From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 05/11] TWL: regulator: Make twl-regulator driver extract
 data from DT
Date: Fri, 16 Sep 2011 12:55:07 +0530
Message-ID: <4E72F9D3.9060304@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com> <1316085727-15023-2-git-send-email-rnayak@ti.com> <1316085727-15023-3-git-send-email-rnayak@ti.com> <1316085727-15023-4-git-send-email-rnayak@ti.com> <1316085727-15023-5-git-send-email-rnayak@ti.com> <1316085727-15023-6-git-send-email-rnayak@ti.com> <20110915221811.GN3523@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51331 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab1IPHZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 03:25:14 -0400
Received: by mail-gx0-f178.google.com with SMTP id 21so2261719gxk.23
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 00:25:13 -0700 (PDT)
In-Reply-To: <20110915221811.GN3523@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: broonie@opensource.wolfsonmicro.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com

On Friday 16 September 2011 03:48 AM, Grant Likely wrote:
> On Thu, Sep 15, 2011 at 04:52:01PM +0530, Rajendra Nayak wrote:
>> Modify the twl regulator driver to extract the regulator_init_data from
>> device tree when passed, instead of getting it through platform_data
>> structures (on non-DT builds)
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   drivers/regulator/twl-regulator.c |   28 +++++++++++++++++++++++++---
>>   1 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
>> index ee8747f..df1b95a 100644
>> --- a/drivers/regulator/twl-regulator.c
>> +++ b/drivers/regulator/twl-regulator.c
>> @@ -17,6 +17,8 @@
>>   #include<linux/regulator/driver.h>
>>   #include<linux/regulator/machine.h>
>>   #include<linux/i2c/twl.h>
>> +#include<linux/of.h>
>> +#include<linux/of_regulator.h>
>>
>>
>>   /*
>> @@ -1011,6 +1013,9 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>>   	struct regulation_constraints	*c;
>>   	struct regulator_dev		*rdev;
>>
>> +	if (pdev->dev.of_node)
>> +		of_property_read_u32(pdev->dev.of_node, "ti,reg-id",&pdev->id);
>> +
>
> Don't do this.  As much as possible, don't reply on plaform_device->id
> when using DT.  Plus it is illegal to modify pdev->id after the device
> is registered.

yeah, I did this hackery to just get around the drivers per-regulator
lookup table for which it uses the pdev->id as the index.
I will need to do this lookup based on compatible instead I guess.

>
>>   	for (i = 0, info = NULL; i<  ARRAY_SIZE(twl_regs); i++) {
>>   		if (twl_regs[i].desc.id != pdev->id)
>>   			continue;
>> @@ -1020,7 +1025,11 @@ static int __devinit twlreg_probe(struct platform_device *pdev)
>>   	if (!info)
>>   		return -ENODEV;
>>
>> -	initdata = pdev->dev.platform_data;
>> +	if (pdev->dev.of_node)
>> +		initdata = of_get_regulator_init_data(pdev->dev.of_node);
>> +	else
>> +		initdata = pdev->dev.platform_data;
>> +
>>   	if (!initdata)
>>   		return -EINVAL;
>>
>> @@ -1101,14 +1110,27 @@ static int __devexit twlreg_remove(struct platform_device *pdev)
>>
>>   MODULE_ALIAS("platform:twl_reg");
>>
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id twl_of_match[] __devinitconst = {
>> +	{ .compatible = "ti,twl-reg", },
>
> This looks rather generic.  Is this a specific chip?  It should be.

We have multiple chips in the twl family like twl6030/twl6040/twl6025
but just one driver which handles all variants.

>
> g.
>
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, twl_of_match);
>> +#else
>> +#define twl_of_match NULL
>> +#endif
>> +
>>   static struct platform_driver twlreg_driver = {
>>   	.probe		= twlreg_probe,
>>   	.remove		= __devexit_p(twlreg_remove),
>>   	/* NOTE: short name, to work around driver model truncation of
>>   	 * "twl_regulator.12" (and friends) to "twl_regulator.1".
>>   	 */
>> -	.driver.name	= "twl_reg",
>> -	.driver.owner	= THIS_MODULE,
>> +	.driver  = {
>> +		.name  = "twl_reg",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = twl_of_match,
>> +	},
>>   };
>>
>>   static int __init twlreg_init(void)
>> --
>> 1.7.1
>>

