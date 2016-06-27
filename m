From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v2 1/8] mfd: tps65218: Remove redundant read wrapper
Date: Mon, 27 Jun 2016 20:00:53 +0530
Message-ID: <5771389D.5000103@ti.com>
References: <1467025305-13464-1-git-send-email-j-keerthy@ti.com>
 <1467025305-13464-2-git-send-email-j-keerthy@ti.com>
 <20160627122331.GB24377@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160627122331.GB24377@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>
Cc: broonie@kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Monday 27 June 2016 05:53 PM, Lee Jones wrote:
> On Mon, 27 Jun 2016, Keerthy wrote:
>
>> Currently read directly calls the repmap read function. Hence
>> remove the redundant wrapper and use regmap read wherever
>> needed.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/mfd/tps65218.c                 | 16 +---------------
>>   drivers/regulator/tps65218-regulator.c |  3 ++-
>>   include/linux/mfd/tps65218.h           |  2 --
>>   3 files changed, 3 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index 80b9dc3..f20a531 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -34,20 +34,6 @@
>>   #define TPS65218_PASSWORD_REGS_UNLOCK   0x7D
>>
>>   /**
>> - * tps65218_reg_read: Read a single tps65218 register.
>> - *
>> - * @tps: Device to read from.
>> - * @reg: Register to read.
>> - * @val: Contians the value
>> - */
>> -int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
>> -			unsigned int *val)
>> -{
>> -	return regmap_read(tps->regmap, reg, val);
>> -}
>> -EXPORT_SYMBOL_GPL(tps65218_reg_read);
>> -
>
> What about the calls in the GPIO and Misc drivers?

Thanks Lee Jones for catching this. I will send an updated v3 of the set.

>
>> -/**
>>    * tps65218_reg_write: Write a single tps65218 register.
>>    *
>>    * @tps65218: Device to write to.
>> @@ -93,7 +79,7 @@ static int tps65218_update_bits(struct tps65218 *tps, unsigned int reg,
>>   	int ret;
>>   	unsigned int data;
>>
>> -	ret = tps65218_reg_read(tps, reg, &data);
>> +	ret = regmap_read(tps->regmap, reg, &data);
>>   	if (ret) {
>>   		dev_err(tps->dev, "Read from reg 0x%x failed\n", reg);
>>   		return ret;
>> diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
>> index a5e5634..679ab2f 100644
>> --- a/drivers/regulator/tps65218-regulator.c
>> +++ b/drivers/regulator/tps65218-regulator.c
>> @@ -22,6 +22,7 @@
>>   #include <linux/err.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/of_device.h>
>> +#include <linux/regmap.h>
>>   #include <linux/regulator/of_regulator.h>
>>   #include <linux/regulator/driver.h>
>>   #include <linux/regulator/machine.h>
>> @@ -224,7 +225,7 @@ static int tps65218_pmic_get_current_limit(struct regulator_dev *dev)
>>   	unsigned int index;
>>   	struct tps65218 *tps = rdev_get_drvdata(dev);
>>
>> -	retval = tps65218_reg_read(tps, dev->desc->csel_reg, &index);
>> +	retval = regmap_read(tps->regmap, dev->desc->csel_reg, &index);
>>   	if (retval < 0)
>>   		return retval;
>>
>> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps65218.h
>> index d58f3b5..7c9241f 100644
>> --- a/include/linux/mfd/tps65218.h
>> +++ b/include/linux/mfd/tps65218.h
>> @@ -276,8 +276,6 @@ struct tps65218 {
>>   	struct regmap *regmap;
>>   };
>>
>> -int tps65218_reg_read(struct tps65218 *tps, unsigned int reg,
>> -					unsigned int *val);
>>   int tps65218_reg_write(struct tps65218 *tps, unsigned int reg,
>>   			unsigned int val, unsigned int level);
>>   int tps65218_set_bits(struct tps65218 *tps, unsigned int reg,
>
