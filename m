From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 3/8] mfd: tps65218: Use mfd_add_devices instead of
 of_platform_populate
Date: Wed, 8 Jun 2016 21:39:45 +0530
Message-ID: <57584349.7000906@ti.com>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-4-git-send-email-j-keerthy@ti.com>
 <20160608155025.GB14888@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608155025.GB14888@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikita@compulab.co.il, nm@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 June 2016 09:20 PM, Lee Jones wrote:
> On Wed, 11 May 2016, Keerthy wrote:
>
>> mfd_add_devices enables parsing device tree nodes without compatibles
>> for child nodes. Replace of_platform_populate with mfd_add_devices.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/tps65218.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index f20a531..b8b3a58 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -33,6 +33,10 @@
>>
>>   #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
>>
>> +static const struct mfd_cell tps65218_cells[] = {
>> +	{ .name = "tps65218-regulator", },
>> +};
>
> What other devices does the TPS65218 consist of?

As of now only regulators driver is in kernel. The PMIC contains
a bunch of GPIOs, Over temperature warning / shutdown unit.

>
>>   /**
>>    * tps65218_reg_write: Write a single tps65218 register.
>>    *
>> @@ -236,8 +240,10 @@ static int tps65218_probe(struct i2c_client *client,
>>   	if (ret < 0)
>>   		return ret;
>>
>> -	ret = of_platform_populate(client->dev.of_node, NULL, NULL,
>> -				   &client->dev);
>> +	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
>> +			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>> +			      regmap_irq_get_domain(tps->irq_data));
>> +
>>   	if (ret < 0)
>>   		goto err_irq;
>>
>
