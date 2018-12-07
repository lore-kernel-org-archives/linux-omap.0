From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up
 error path in probe
Date: Fri, 7 Dec 2018 05:52:42 +0530
Message-ID: <0b3949c5-1af0-6830-15db-01271a006615@ti.com>
References: <1544117864-28276-1-git-send-email-j-keerthy@ti.com>
 <20181206205155.eucqfsq2xnk7kks5@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206205155.eucqfsq2xnk7kks5@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: tony@atomide.com, lee.jones@linaro.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/7/2018 2:21 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Dec 06, 2018 at 11:07:44PM +0530, Keerthy wrote:
>> Use devm_regmap_add_irq_chip and clean up error path in probe.
>>
>> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Boot tested on am437x-gp-evm.
> 
> This is missing cleanup of remove path?

Yes! Thanks for catching it. I will send v2 in a bit.

> 
> -- Sebastian
> 
>>   drivers/mfd/tps65218.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index 910f569..2383621 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
>>   
>>   	mutex_init(&tps->tps_lock);
>>   
>> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
>> -			IRQF_ONESHOT, 0, &tps65218_irq_chip,
>> -			&tps->irq_data);
>> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
>> +				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
>> +				       &tps->irq_data);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -253,14 +253,6 @@ static int tps65218_probe(struct i2c_client *client,
>>   			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>>   			      regmap_irq_get_domain(tps->irq_data));
>>   
>> -	if (ret < 0)
>> -		goto err_irq;
>> -
>> -	return 0;
>> -
>> -err_irq:
>> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
>> -
>>   	return ret;
>>   }
>>   
>> -- 
>> 1.9.1
>>
