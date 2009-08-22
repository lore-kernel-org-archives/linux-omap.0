From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 1/3] RTC periodic interrupts enabling and msecure init
Date: Sat, 22 Aug 2009 19:29:06 +0300
Message-ID: <877hwvvmlp.fsf@deeprootsystems.com>
References: <1250091924-5399-1-git-send-email-charu@ti.com>
	<4A855801.8070102@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:27735 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbZHVQ3I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 12:29:08 -0400
Received: by ey-out-2122.google.com with SMTP id 22so361988eye.37
        for <linux-omap@vger.kernel.org>; Sat, 22 Aug 2009 09:29:09 -0700 (PDT)
In-Reply-To: <4A855801.8070102@nokia.com> (Roger Quadros's message of "Fri\, 14 Aug 2009 15\:26\:41 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: "ext charu@ti.com" <charu@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com

Roger Quadros <ext-roger.quadros@nokia.com> writes:

> ext charu@ti.com wrote:
>> Triton2 RTC code changes for fixing periodic interrupt feature in RTC.
>> rtc-twlcore.c does initialisation of the msecure gpio pin. Board
>> files indicate msecure gpio line through twl4030 platform
>> data. twl4030-core.c passes this information to RTC driver.
>> Board files does msecure gpio mux configuration.
>>
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>
> Periodic interrupts and msecure are 2 different entities. I think they
> should be implemented in different patches.

Agreed.  The "fix" part of this should be a separated out with a
detailed description of both the problem and the fix.

Kevin

>> ---
>>  drivers/rtc/rtc-twl4030.c |   63 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 62 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
>> index 9c8c70c..614adf0 100644
>> --- a/drivers/rtc/rtc-twl4030.c
>> +++ b/drivers/rtc/rtc-twl4030.c
>> @@ -29,7 +29,12 @@
>>  #include <linux/interrupt.h>
>>   #include <linux/i2c/twl4030.h>
>> +#include <linux/gpio.h>
>>  +/*
>> + * To find if the value is a power of two
>> + */
>> +#define is_power_of_two(x)    (!((x) & ((x)-1)))
>>   /*
>>   * RTC block register offsets (use TWL_MODULE_RTC)
>> @@ -86,6 +91,37 @@
>>  /*----------------------------------------------------------------------*/
>>   /*
>> + * msecure line initialisation for TWL4030 RTC registers write access
>> + */
>> +static int msecure_init(struct twl4030_rtc_platform_data *pdata)
>> +{
>> +	int ret = 0;
>> +	if (pdata == NULL)
>> +		goto out;
>> +
>> +	ret = gpio_request(pdata->msecure_gpio, "msecure");
>> +	if (ret < 0) {
>
> if (ret) should suffice
>
>> +		pr_err("twl4030_rtc: can't reserve msecure GPIO:%d !\n"
>> +			"RTC functionality will not be available\n",
>> +			pdata->msecure_gpio);
>> +		goto out;
>> +	}
>> +	/*
>> +	 * TWL4030 will be in secure mode if msecure line from OMAP is low.
>> +	 * Make msecure line high in order to change the TWL4030 RTC time
>> +	 * and calender registers.
>> +	 */
>> +	ret = gpio_direction_output(pdata->msecure_gpio, 1);
>> +	if (ret < 0)
>
> ditto
>
>> +		pr_err("twl4030_rtc: can't set msecure GPIO direction:%d !\n"
>> +			"RTC functionality will not be available\n",
>> +			pdata->msecure_gpio);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>> +/*
>>   * Supports 1 byte read from TWL4030 RTC register.
>>   */
>>  static int twl4030_rtc_read_u8(u8 *data, u8 reg)
>> @@ -128,7 +164,6 @@ static int set_rtc_irq_bit(unsigned char bit)
>>  	int ret;
>>   	val = rtc_irq_bits | bit;
>> -	val &= ~BIT_RTC_INTERRUPTS_REG_EVERY_M;
>>  	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
>>  	if (ret == 0)
>>  		rtc_irq_bits = val;
>> @@ -318,6 +353,25 @@ out:
>>  	return ret;
>>  }
>>  +static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
>> +{
>> +	int ret, val = 1;
>> +	int regbit = 0;
>> +
>> +	if ((!is_power_of_2(freq)) || (freq > 8) || (freq <= 0))
>> +		return -EINVAL;
>
> 0 is valid freq. it means disable periodic interrupts.
>
>> +
>> +	while ((freq & val) == 0) {
>> +		val = val << 1;
>> +		regbit++;
>> +	}
>
> as per your implementation, if user sets interrupt rate of 4 Hz then
> you will set regbit to 2 which means interrupt every hour?
> i.e. 0.00027 Hz. no?
>
>> +	ret = set_rtc_irq_bit(regbit);
>> +	if (ret)
>> +		dev_err(dev, "rtc_irq_set_freq error %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>>  static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
>>  {
>>  	unsigned long events = 0;
>> @@ -383,6 +437,7 @@ static struct rtc_class_ops twl4030_rtc_ops = {
>>  	.set_alarm	= twl4030_rtc_set_alarm,
>>  	.alarm_irq_enable = twl4030_rtc_alarm_irq_enable,
>>  	.update_irq_enable = twl4030_rtc_update_irq_enable,
>> +	.irq_set_freq   = twl4030_rtc_irq_set_freq,
>
> IMHO this does not make sense.
> twl4030 supports a max interrupt rate of 1 Hz (i.e. 1 sec). So you can
> only support freq values of 0 and 1 i.e. 0 for disabled and 1 for 1
> sec interrupt.
> This functionality is already achieved by update_irq_enable.
>
> -roger
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
