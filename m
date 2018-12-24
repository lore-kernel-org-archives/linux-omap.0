From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Date: Mon, 24 Dec 2018 15:08:57 +0530
Message-ID: <16dc864e-1952-5d9c-2939-2804872c7814@ti.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181221110128.GO13248@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221110128.GO13248@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/21/2018 4:31 PM, Lee Jones wrote:
> On Tue, 18 Dec 2018, Christian Hohnstaedt wrote:
> 
>> These options apply to all regulators in this chip.
>>
>> strict-supply-voltage:
>>    Set STRICT flag in CONFIG1
>> under-voltage-limit:
>>    Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
>> under-voltage-hysteresis:
>>    Select 200mV or 400mV UVLOHYS in CONFIG2
>>
>> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
>> ---
>>   drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
> 
> This needs a close review by Tony and any of the other OMAP guys.
> 
> At the very least, please put '\n's between the if() statements.  You
> also need to return after an error print, else I suggest it's not an
> error.
> 
> It would also look tidier if you changed the if()s to one liners to
> assign to different variables, then dealt with them separately later
> on.  The way it's done here looks messy to say the least.
> 
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index 8bcdecf..f5e559b 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -211,6 +211,50 @@ static const struct of_device_id of_tps65218_match_table[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
>>   
>> +static void tps65218_options(struct tps65218 *tps)
>> +{
>> +	struct device *dev = tps->dev;
>> +	struct device_node *np = dev->of_node;
>> +	u32 pval;
> 
> What does pval mean?  I suggest just val is more common.
> 
>> +	if (!of_property_read_u32(np, "strict-supply-voltage", &pval)) {
>> +		tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
>> +			TPS65218_CONFIG1_STRICT,
>> +			pval ? TPS65218_CONFIG1_STRICT : 0,
>> +			TPS65218_PROTECT_L1);
>> +		dev_dbg(dev, "tps65218 strict-supply-voltage: %d\n", pval);
>> +	}
>> +	if (!of_property_read_u32(np, "under-voltage-hysteresis", &pval)) {
>> +		if (pval != 400000 && pval != 200000) {
>> +			dev_err(dev,
>> +				 "under-voltage-hysteresis must be %d or %d\n",
>> +				 200000, 400000);
>> +		} else {
>> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
>> +				TPS65218_CONFIG2_UVLOHYS,
>> +				pval == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
>> +				TPS65218_PROTECT_L1);
>> +		}
>> +		dev_dbg(dev, "tps65218 under-voltage-hysteresis: %d\n", pval);
>> +	}
>> +	if (!of_property_read_u32(np, "under-voltage-limit", &pval)) {
>> +		int i, vals[] = { 275, 295, 325, 335 };
>> +
>> +		for (i = 0; i < ARRAY_SIZE(vals); i++) {
>> +			if (pval == vals[i] * 10000)
> 
> Just use the full value in 'vals'.
> 
>> +				break;
>> +		}
> 
> It took me a few seconds to realise what you're doing here.
> 
> I think a switch() statement would be cleaner.
> 
> You should also #define the values.
> 
> TPS65218_UNDER_VOLT_LIM_2750000 0
> 
> Etc.
> 
>> +		if (i < ARRAY_SIZE(vals)) {
>> +			tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
>> +				TPS65218_CONFIG1_UVLO_MASK, i,
>> +				TPS65218_PROTECT_L1);
>> +		} else {
>> +			dev_err(dev, "Invalid under-voltage-limit: %d\n", pval);
> 
> This could go in the default: section.
> 
>> +		}
>> +		dev_dbg(dev, "tps65218 under-voltage-limit: %d=%d\n", pval, i);
> 
> I suggest considering removing these.
> 
>> +	}
>> +}
>> +
>>   static int tps65218_probe(struct i2c_client *client,
>>   				const struct i2c_device_id *ids)
>>   {
>> @@ -249,6 +293,8 @@ static int tps65218_probe(struct i2c_client *client,
>>   
>>   	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
>>   
>> +	tps65218_options(tps);
> 
> Options is not good nomenclature as it doesn't really tell us
> anything.  Looks like all the values are voltage related to me?

Can we simply call them tps65218_voltage_set_strict, 
tps65218_voltage_set_uvlo, tps65218_voltage_set_uv_hyst?

or if you want them under one function then i would suggest 
tps65218_set_voltage_quirks or something like that.

- Keerthy
> 
>>   	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
>>   			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>>   			      regmap_irq_get_domain(tps->irq_data));
> 
