From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 4/9] mfd: palmas: Add tps65917 support
Date: Wed, 18 Jun 2014 10:36:46 +0530
Message-ID: <53A11E66.9040201@ti.com>
References: <1401272423-25761-1-git-send-email-j-keerthy@ti.com> <1401272423-25761-5-git-send-email-j-keerthy@ti.com> <20140617161940.GO29841@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140617161940.GO29841@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 17 June 2014 09:49 PM, Lee Jones wrote:
>> Add tps65917 PMIC support. tps65917 is a subset of palmas PMIC.
>> Some of the register definitions and the interrupt mappings
>> are different.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/palmas.c |  176 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 171 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>> index d280d78..485d755 100644
>> --- a/drivers/mfd/palmas.c
>> +++ b/drivers/mfd/palmas.c
> [...]
>
>> +struct palmas_driver_data {
>> +	unsigned int *features;
>> +	struct regmap_irq_chip *irq_chip;
>> +};
>> +
>> +static struct palmas_driver_data palmas_data = {
>> +	.features = &palmas_features,
>> +	.irq_chip = &palmas_irq_chip,
>> +};
>> +
>> +static struct palmas_driver_data tps659038_data = {
>> +	.features = &tps659038_features,
>> +	.irq_chip = &palmas_irq_chip,
>> +};
>> +
>> +static struct palmas_driver_data tps65917_data = {
>> +	.features = &tps659038_features,
>> +	.irq_chip = &tps65917_irq_chip,
>> +};
>> +
> [...]
>
>> @@ -375,6 +539,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>>   {
>>   	struct palmas *palmas;
>>   	struct palmas_platform_data *pdata;
>> +	struct palmas_driver_data *driver_data;
>>   	struct device_node *node = i2c->dev.of_node;
>>   	int ret = 0, i;
>>   	unsigned int reg, addr, *features;
>> @@ -408,7 +573,8 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>>   	if (!match)
>>   		return -ENODATA;
>>   
>> -	features = (unsigned int *)match->data;
>> +	driver_data = (struct palmas_driver_data *)match->data;
>> +	features = (unsigned int *)driver_data->features;
>>   	palmas->features = *features;
> Couple of things a) I don't think the cast is required here and b) you
> may as well do away with the local features variable here.
>
> Just do:
>    palmas->features = *driver_data->features;
>
> Once fixed, re-submit with my:
>    Acked-by: Lee Jones <lee.jones@linaro.org>

Sure. I will redo and send this set.
Thanks.

>
