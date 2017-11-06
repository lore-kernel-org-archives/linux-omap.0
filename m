From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] mfd: palmas: Assign the right powerhold mask for tps65917
Date: Mon, 6 Nov 2017 17:58:01 +0530
Message-ID: <a24fd003-a468-2f08-fccd-435f1f78bd1c@ti.com>
References: <1508833296-20702-1-git-send-email-j-keerthy@ti.com>
 <20171031104800.sedywmkgf4kp6ych@dell>
 <b7915318-5edb-a821-4a33-9176b037d51a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b7915318-5edb-a821-4a33-9176b037d51a@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Monday 06 November 2017 03:22 PM, Keerthy wrote:
> 
> 
> On Tuesday 31 October 2017 04:18 PM, Lee Jones wrote:
>> On Tue, 24 Oct 2017, Keerthy wrote:
>>
>>> The powerhold mask for TPS65917 is different when comapred to
>>> the other palmas versions. Hence assign the right mask that enables
>>> power off of tps65917 pmic correctly.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>  drivers/mfd/palmas.c       | 10 +++++++++-
>>>  include/linux/mfd/palmas.h |  3 +++
>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>>> index 3922a93..663a239 100644
>>> --- a/drivers/mfd/palmas.c
>>> +++ b/drivers/mfd/palmas.c
>>> @@ -430,6 +430,7 @@ static void palmas_power_off(void)
>>>  {
>>>  	unsigned int addr;
>>>  	int ret, slave;
>>> +	u8 powerhold_mask;
>>>  	struct device_node *np = palmas_dev->dev->of_node;
>>>  
>>>  	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
>>> @@ -437,8 +438,15 @@ static void palmas_power_off(void)
>>>  					  PALMAS_PRIMARY_SECONDARY_PAD2);
>>>  		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>>>  
>>> +		if (of_device_is_compatible(np, "ti,tps65917"))
>>
>> Is it possible to interrogate the device itself, rather than DT?
> 
> You mean using driver data tagged with compatibles?

I guess you meant interrogating by i2c register red like revision
register, i am afraid no such register to distinguish hence went by the
compatible.

Regards,
Keerthy
> 
>>
>>> +			powerhold_mask =
>>> +				TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK;
>>> +		else
>>> +			powerhold_mask =
>>> +				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK;
>>> +
>>>  		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
>>> -				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
>>> +					 powerhold_mask, 0);
>>>  		if (ret)
>>>  			dev_err(palmas_dev->dev,
>>>  				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
>>> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
>>> index 6dec438..cffb23b 100644
>>> --- a/include/linux/mfd/palmas.h
>>> +++ b/include/linux/mfd/palmas.h
>>> @@ -3733,6 +3733,9 @@ enum usb_irq_events {
>>>  #define TPS65917_REGEN3_CTRL_MODE_ACTIVE			0x01
>>>  #define TPS65917_REGEN3_CTRL_MODE_ACTIVE_SHIFT			0x00
>>>  
>>> +/* POWERHOLD Mask field for PRIMARY_SECONDARY_PAD2 register */
>>> +#define TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK		0xC
>>> +
>>>  /* Registers for function RESOURCE */
>>>  #define TPS65917_REGEN1_CTRL					0x2
>>>  #define TPS65917_PLLEN_CTRL					0x3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
