From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 3/5] mfd: palmas: Reset the POWERHOLD mux during power
 off
Date: Fri, 24 Mar 2017 17:06:03 +0530
Message-ID: <78ad0c4c-2746-9f3d-e070-1042c1d9f297@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-4-git-send-email-j-keerthy@ti.com>
 <20161122130308.GE316@dell.lan> <ee4f7c28-7847-ab4f-4d8f-1dce288f809a@ti.com>
 <20170324113014.fpkfoc5n7qpo2l5d@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170324113014.fpkfoc5n7qpo2l5d@dell>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: tony@atomide.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Friday 24 March 2017 05:00 PM, Lee Jones wrote:
> On Fri, 24 Mar 2017, Keerthy wrote:
> 
>>
>>
>> On Tuesday 22 November 2016 06:33 PM, Lee Jones wrote:
>>> On Thu, 10 Nov 2016, Keerthy wrote:
>>>
>>>> POWERHOLD signal has higher priority  over the DEV_ON bit.
>>>> So power off will not happen if the POWERHOLD is held high.
>>>> Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
>>>> and the DEV_ON bit to take effect to power off the PMIC.
>>>>
>>>> PMIC Power off happens in dire situations like thermal shutdown
>>>> so irrespective of the POWERHOLD setting go ahead and turn off
>>>> the powerhold.  Currently poweroff is broken on boards that have
>>>> powerhold enabled. This fixes poweroff on those boards.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>>
>>>>   * Changed pr_err to dev_err
>>>>   * removed redundant boolean variable override-powerhold
>>>>
>>>>  drivers/mfd/palmas.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>
>>> Applied, thanks.
>>
>> Lee Jones,
>>
>> For some strange reason this patch is missing!
>> The other patch in the series is applied through mfd tree but somehow
>> this particular patch is missed out.
>>
>> https://patchwork.kernel.org/patch/9420631/ is applied.
>>
>> https://patchwork.kernel.org/patch/9420655/ is not.
>>
>> I tried applying this very patch and it applies cleanly on the next
>> branch. Let me know if you want me to send this again on top of latest
>> next branch.
> 
> Sorry about this.
> 
> Reapplied and re-pushed.

Thanks Lee Jones.

> 
>>>> diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
>>>> index ee9e9ea..da90124 100644
>>>> --- a/drivers/mfd/palmas.c
>>>> +++ b/drivers/mfd/palmas.c
>>>> @@ -430,6 +430,20 @@ static void palmas_power_off(void)
>>>>  {
>>>>  	unsigned int addr;
>>>>  	int ret, slave;
>>>> +	struct device_node *np = palmas_dev->dev->of_node;
>>>> +
>>>> +	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
>>>> +		addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
>>>> +					  PALMAS_PRIMARY_SECONDARY_PAD2);
>>>> +		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>>>> +
>>>> +		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
>>>> +				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
>>>> +		if (ret)
>>>> +			dev_err(palmas_dev->dev,
>>>> +				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
>>>> +				ret);
>>>> +	}
>>>>  
>>>>  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PMU_CONTROL_BASE);
>>>>  	addr = PALMAS_BASE_TO_REG(PALMAS_PMU_CONTROL_BASE, PALMAS_DEV_CTRL);
>>>
> 
