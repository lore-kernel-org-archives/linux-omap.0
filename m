From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/3] regulator: twl: Make sure we have access to powerbus
 before trying to write to it
Date: Sun, 24 Apr 2016 20:14:51 +0300
Message-ID: <571CFF0B.4010704@gmail.com>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1458980895-10240-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160424161002.GC8880@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160424161002.GC8880@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 24.04.2016 19:10, Pavel Machek wrote:
> Hi!
>
>> According to the TRM, we need to enable i2c access to powerbus before
>> writing to it. Also, a new write to powerbus should not be attempted if
>> there is a pending transfer. The current code does not implement that
>> functionality and while there are no known problems caused by that, it is
>> better to follow what TRM says.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   drivers/regulator/twl-regulator.c | 78 +++++++++++++++++++++++++++++++++++----
>>   1 file changed, 70 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
>> index 955a6fb..aad748b0 100644
>> --- a/drivers/regulator/twl-regulator.c
>> +++ b/drivers/regulator/twl-regulator.c
>> @@ -21,7 +21,7 @@
>>   #include <linux/regulator/machine.h>
>>   #include <linux/regulator/of_regulator.h>
>>   #include <linux/i2c/twl.h>
>> -
>> +#include <linux/delay.h>
>>
>>   /*
>>    * The TWL4030/TW5030/TPS659x0/TWL6030 family chips include power management, a
>> @@ -188,6 +188,74 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
>>   	return grp && (val == TWL6030_CFG_STATE_ON);
>>   }
>>
>> +#define PB_I2C_BUSY	BIT(0)
>> +#define PB_I2C_BWEN	BIT(1)
>> +
>> +/* Wait until buffer empty/ready to send a word on power bus. */
>> +static int twl4030_wait_pb_ready(void)
>> +{
>> +
>> +	int	ret;
>> +	int	timeout = 10;
>> +	u8	val;
>> +
>
> Can we do this plain
>
>      while (timeout--) {
>      }...
>

Now looking at the code, yes, while(timeout--) looks prettier, but as 
the $subject patch is in the linux-next for a couple of weeks already, 
that change will need another patch. I'll put that in my TODO, right 
after the RFC for the N900 cameras :) .

> ? Also... if the bit is not immediately available, it will wait for
> 1msec. Would it make sense to have timeout = 1000 but wait only 10usec
> each time or something?
>

Well, anyway these look like a kind of arbitrary values, I guess it will 
work both ways. But, I borrowed the code in the patch from stock Nokia 
kernel, it has been field tested on tens of thousands of devices, so, 
unless you have hard values giving a reason to do it the other way, I 
prefer to keep it as it is.

Regards,
Ivo

>> +	do {
>> +		ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
>> +				      TWL4030_PM_MASTER_PB_CFG);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (!(val & PB_I2C_BUSY))
>> +			return 0;
>> +
>> +		mdelay(1);
>> +		timeout--;
>> +	} while (timeout);
>> +
>> +	return -ETIMEDOUT;
>> +}
>
