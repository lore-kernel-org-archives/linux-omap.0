From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: Re: [PATCH] i2c-omap: Trigger bus recovery in lockup case
Date: Wed, 20 Sep 2017 11:24:44 +0200
Message-ID: <7c68d7e7-6c10-dc51-4dd9-b11a0d2c1b62@ergon.ch>
References: <1505403549-12992-1-git-send-email-claudio.foellmi@ergon.ch>
 <9d3e3029-f775-a9aa-8025-badccb699ed8@ti.com>
 <48ddc9bc-2b83-97c9-fbd7-90d4da9f2687@ti.com>
 <0a506277-6c9b-1407-dea3-f9895fdc3e63@ergon.ch>
 <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <cbb3aaa2-44d1-8a7d-1d8e-1433b0a7b9d3@ti.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, "Strashko, Grygorii" <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 19.09.2017 12:50, Vignesh R wrote:
> 
> 
> On Monday 18 September 2017 05:31 PM, Claudio Foellmi wrote:
>> On 18.09.2017 07:24, Vignesh R wrote:
>>>
>>>
>>> On Saturday 16 September 2017 05:01 AM, Strashko, Grygorii wrote:
>>>>
>>>>
>>>> On 09/14/2017 10:39 AM, Claudio Foellmi wrote:
>>>>> A very conservative check for bus activity (to prevent interference
>>>>> in multimaster setups) prevented the bus recovery methods from being
>>>>> triggered in the case that SDA or SCL was stuck low.
>>>>> This defeats the purpose of the recovery mechanism, which was introduced
>>>>> for exactly this situation (a slave device keeping SDA pulled down).
>>>>>
>>>>> Note that bus lockups can persist across reboots. The only other options
>>>>> are to reset or power cycle the offending slave device, and many i2c
>>>>> slaves do not even have a reset pin.
>>>>>
>>>>> If we see that one of the lines is low for the entire timeout duration,
>>>>> we can actually be sure that there is no other master driving the bus.
>>>>> It is therefore save for us to attempt a bus recovery.
>>>>>
>>>>
>>>> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>
>>>>> Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
>>>>> ---
>>>>> Caveat: It turns out I don't have the hardware to fully test the
>>>>> recovery mechanism. My faulty i2c slave device actually pulls down SCL,
>>>>> not SDA (so the recovery will not succeed in my case).
>>>
>>> Maybe, you could detect SCL stuck low case by reading status of SCL line
>>> from OMAP_I2C_SYSTEST_REG and then call IP reset (there is nothing much
>>> that can be done) instead of bus recovery.
>>>
>>
>> I plan on posting a related patch soon, that will print better messages
>> if the generic recovery fails. If SCL is stuck low, I think the best we
>> can do is make the problem visible in the kernel log.
>>
>>>>> But by directly connecting SDA to ground, I could at least make sure
>>>>> the recovery function gets called after applying this patch.
>>>>>
>>>
>>> I had seen flood of XRDY & RRDY interrupts as soon as TMODE is set to
>>> 0x3 as part of omap_i2c_prepare_recovery() leading to unusable system.
>>> Did you observe this behavior on your system? Could you mention the
>>> platform on which this experiment done?
>>>
>>
>> So attempting bus recovery is dangerous on some platforms?
>> I did not notice any obvious problems (assuming an 'unusable system'
>> would be hard to miss), but then again I only have one target to test on.
>> I'm working with a TI AM3352, the slave is a NXP NT3H2211 on i2c-1.
>>
>
> I hit a situation where when communicating with a faulty i2c device, the
> last transaction on the bus does not end with proper STOP condition on
> the i2c bus. Since, STOP condition was not detected by IP, Bus Busy will
> remain set even though both SCL and SDA are high. Thus,
> omap_i2c_wait_for_bb() function would end up calling bus recovery. And
> as soon as TMODE is set to 0x3 and ST_EN to 0x1, there is a flood of
> XRDY & RRDY interrupts.
>

If I understand the code correctly, the problem is that omap_i2c_wait_for_bb_valid
does not quite do what the name would suggest:
If SDA, SCL and BB are all 1 for a while, it correctly detects that
the bus is actually free, but then just sets bb_valid=1 and returns.
So now bb_valid is set, even though the value of BB is wrong.
Later, omap_i2c_wait_for_bb runs into a timeout because it trusts that BB flag,
and triggers the recovery.

It would be nice if we could manually set BB to 0 in that case.
But from what I've read in the manual, the only way to reset BB is to
reset the device.

> This spurious irqs can be reproduced easily by setting TMODE to 0x3 and
> ST_EN to 0x1 in OMAP_I2C_SYSTEST_REG when both SCL and SDA are high (bus
> is idle) even on AM335x.
>
> So, if you are not seeing irq flood when SCL/SDA is stuck low, then
> maybe its safe to enter TMODE 0x3 in such cases. Could you modify the
> patch to test whether or not SDA is stuck low before initiating bus
> recovery?
>

What happens if we try to transmit while BB is still 1?
If the transmission succeeds, adding such a check in omap_i2c_wait_for_bb
should be enough to deal with your case (as the message we then send
will contain the stop condition to correct BB).

Btw, it also looks like omap_i2c_wait_for_bb currently assumes that if
recovery succeeds, the bus will then also be free. I'm not sure if that
is actually correct.

>>>>>   drivers/i2c/busses/i2c-omap.c | 7 ++++++-
>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>>>>> index 1ebb5e9..4b25fd1 100644
>>>>> --- a/drivers/i2c/busses/i2c-omap.c
>>>>> +++ b/drivers/i2c/busses/i2c-omap.c
>>>>> @@ -563,8 +563,13 @@ static int omap_i2c_wait_for_bb_valid(struct omap_i2c_dev *omap)
>>>>>   		}
>>>>>   
>>>>>   		if (time_after(jiffies, timeout)) {
>>>>> +			/*
>>>>> +			 * SDA or SCL were low for the entire timeout without
>>>>> +			 * any activity detected. Most likely, a slave is
>>>>> +			 * locking up the bus with no master driving the clock.
>>>>> +			 */
>>>>>   			dev_warn(omap->dev, "timeout waiting for bus ready\n");
>>>>> -			return -ETIMEDOUT;
>>>>> +			return i2c_recover_bus(&omap->adapter);
>>>>>   		}
>>>>>   
>>>>>   		msleep(1);
>>>>>
>>>>
>>>
>>
>
