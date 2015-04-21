From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Tue, 21 Apr 2015 18:58:43 -0500
Message-ID: <5536E433.90103@ti.com>
References: <1429577494-15087-1-git-send-email-nm@ti.com> <20150421234139.GF8539@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421234139.GF8539@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On 04/21/2015 06:41 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 20/04/2015 at 19:51:34 -0500, Nishanth Menon wrote :
>> Alarm interrupt enable register is at offset 0x7, while the time
>> registers for the alarm follow that. When we program Alarm interrupt
>> enable prior to programming the time, it is possible that previous
>> time value could be close or match at the time of alarm enable
>> resulting in interrupt trigger which is unexpected (and does not match
>> the time we expect it to trigger).
>>
>> To prevent this scenario from occuring, program the ALM0_EN bit only
>> after the alarm time is appropriately programmed.
>>
>> Ofcourse, I2C programming is non-atomic, so there are loopholes where
>> the interrupt wont trigger if the time requested is in the past at
>> the time of programming the ALM0_EN bit. However, we will not have
>> unexpected interrupts while the time is programmed after the interrupt
>> are enabled.
>>
> 
> Do you have more details about the issue you are trying to solve?
Testcase: rtctest /dev/rtc0
waveform capture: http://goo.gl/S8Z54x
Corresponding decode: http://pastebin.ubuntu.com/10863880/

> 
> Consider the following use case: a platform is setting the RTC alarm
> before going to suspend to ram. Before your patch, it may be woken up
^^ precisely what I am trying to solve.

> quite quickly, before expected. After your patch, it may never wake at
> all.

Why is that so? when set alarm is requested for time X, you want
interrupt at time X, not an interrupt for previous configured RTC
alarm time!

If the time X is > the point when ALM0 is programmed, then you will
get an interrupt.

If you get an interrupt (like my screenshot shows) because the new
value has not yet been programmed (just because we enabled interrupt
before programming time), it is unexpected event and wrong!

Another scenario: Take the following time points A < B < C < D
we program at time (A), an interrupt for time (C).
but at time B, we intiate a new time request for time (D).
if we happen to send the first ALM0EN at time C (before programming
D), you will generate an interrupt, but before the irq handler can
handle (since we are doing burst i2c), we program D which clears the
irq status (as can be seen in waveform).

This does not make sense for a predictable behavior! Yeah, it will
wakeup quickly, but when we go and read irqstatus (ALM0IF), it will be
0 and nothing will get reported to rtc subsystem. So:
a) we woke up at a time not requested - this is wrong
b) our irq handler has nothing to handle! - this is wrong as well.

in short, the behavior you are asking for is quiet the wrong behavior!

> 
> 
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Changes in v2:
>> 	- minor typo fix in comments
>> 	- merged up code that I missed committing in
>>
>> V1: https://patchwork.kernel.org/patch/6245041/
>>
>>  drivers/rtc/rtc-ds1307.c |   12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>> index 4ffabb322a9a..3cd4783375a5 100644
>> --- a/drivers/rtc/rtc-ds1307.c
>> +++ b/drivers/rtc/rtc-ds1307.c
>> @@ -742,17 +742,17 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>>  	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
>>  	/* Set alarm match: second, minute, hour, day, date, month. */
>>  	regs[6] |= MCP794XX_MSK_ALMX_MATCH;
>> -
>> -	if (t->enabled)
>> -		regs[0] |= MCP794XX_BIT_ALM0_EN;
>> -	else
>> -		regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>> +	/* Disable interrupt. We will not enable until completely programmed */
>> +	regs[0] &= ~MCP794XX_BIT_ALM0_EN;
>>  
>>  	ret = ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10, regs);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	return 0;
>> +	if (!t->enabled)
>> +		return 0;
>> +	regs[0] |= MCP794XX_BIT_ALM0_EN;
>> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, regs[0]);
>>  }
>>  
>>  static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned int enabled)
>> -- 
>> 1.7.9.5
>>
> 


-- 
Regards,
Nishanth Menon
