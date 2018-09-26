From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH 1/9] leds: add TI LMU backlight driver
Date: Wed, 26 Sep 2018 10:30:56 -0500
Message-ID: <ee0185f0-1fc9-9176-2236-836ca0ac6f41@ti.com>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-2-dmurphy@ti.com> <20180926150145.GS5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926150145.GS5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Tony

On 09/26/2018 10:01 AM, Tony Lindgren wrote:
> * Dan Murphy <dmurphy@ti.com> [180926 13:14]:
>> --- /dev/null
>> +++ b/drivers/leds/ti-lmu-led-common.c
>> +static int ti_lmu_common_enable(struct ti_lmu_bank *lmu_bank, bool enable)
>> +{
>> +	struct regmap *regmap = lmu_bank->regmap;
>> +	unsigned long enable_time = lmu_bank->enable_usec;
>> +	u8 reg = lmu_bank->enable_reg;
>> +	u8 mask = BIT(lmu_bank->bank_id);
>> +	u8 val = (enable == true) ? mask : 0;
>> +	int ret;
>> +
>> +	return 0;
> 
> Hmm this early return probably needs to be left out on real hardawre?
> 

Yes it does.  I have not debugged or completed this function yet.

>> +	if (!reg)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_update_bits(regmap, reg, mask, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (enable_time > 0)
>> +		usleep_range(enable_time, enable_time + 100);
>> +
>> +	return 0;
>> +}
> 
> Regards,
> 
> Tony
> 


-- 
------------------
Dan Murphy
