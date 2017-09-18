From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Mon, 18 Sep 2017 10:54:06 +0530
Message-ID: <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: "Strashko, Grygorii" <grygorii.strashko@ti.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On Saturday 16 September 2017 05:01 AM, Strashko, Grygorii wrote:
> 
> 
> On 09/14/2017 10:39 AM, Claudio Foellmi wrote:
>> A very conservative check for bus activity (to prevent interference
>> in multimaster setups) prevented the bus recovery methods from being
>> triggered in the case that SDA or SCL was stuck low.
>> This defeats the purpose of the recovery mechanism, which was introduced
>> for exactly this situation (a slave device keeping SDA pulled down).
>>
>> Note that bus lockups can persist across reboots. The only other options
>> are to reset or power cycle the offending slave device, and many i2c
>> slaves do not even have a reset pin.
>>
>> If we see that one of the lines is low for the entire timeout duration,
>> we can actually be sure that there is no other master driving the bus.
>> It is therefore save for us to attempt a bus recovery.
>>
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
>> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
>> ---
>> Caveat: It turns out I don't have the hardware to fully test the
>> recovery mechanism. My faulty i2c slave device actually pulls down SCL,
>> not SDA (so the recovery will not succeed in my case).

Maybe, you could detect SCL stuck low case by reading status of SCL line
from OMAP_I2C_SYSTEST_REG and then call IP reset (there is nothing much
that can be done) instead of bus recovery.

>> But by directly connecting SDA to ground, I could at least make sure
>> the recovery function gets called after applying this patch.
>>

I had seen flood of XRDY & RRDY interrupts as soon as TMODE is set to
0x3 as part of omap_i2c_prepare_recovery() leading to unusable system.
Did you observe this behavior on your system? Could you mention the
platform on which this experiment done?

>>   drivers/i2c/busses/i2c-omap.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 1ebb5e9..4b25fd1 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -563,8 +563,13 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
>>   		}
>>   
>>   		if (time_after(jiffies, timeout)) {
>> +			/*
>> +			 * SDA or SCL were low for the entire timeout without
>> +			 * any activity detected. Most likely, a slave is
>> +			 * locking up the bus with no master driving the clock.
>> +			 */
>>   			dev_warn(omap->dev, "timeout waiting for bus ready\n");
>> -			return -ETIMEDOUT;
>> +			return i2c_recover_bus(&omap->adapter);
>>   		}
>>   
>>   		msleep(1);
>>
> 

-- 
Regards
Vignesh
