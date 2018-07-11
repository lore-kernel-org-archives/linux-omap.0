From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH v3 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Wed, 11 Jul 2018 21:46:41 +0530
Message-ID: <cf50def4-9ff8-a921-521a-c568b4987b89@ti.com>
References: <1531205452-6086-1-git-send-email-j-keerthy@ti.com>
 <1531205452-6086-2-git-send-email-j-keerthy@ti.com>
 <20180711135444.GC12517@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711135444.GC12517@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 7/11/2018 7:24 PM, Johan Hovold wrote:
> On Tue, Jul 10, 2018 at 12:20:49PM +0530, Keerthy wrote:
>> Cut down the shutdown time from 2 seconds to 1 sec. In case of roll
>> over try again.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/rtc/rtc-omap.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
>> index 323ff55..14f2241 100644
>> --- a/drivers/rtc/rtc-omap.c
>> +++ b/drivers/rtc/rtc-omap.c
>> @@ -441,11 +441,12 @@ static void omap_rtc_power_off(void)
>>   	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>>   	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
>>   
>> -	/* set alarm two seconds from now */
>> +again:
>> +	/* set alarm one second from now */
>>   	omap_rtc_read_time_raw(rtc, &tm);
>>   	bcd2tm(&tm);
>>   	rtc_tm_to_time(&tm, &now);
>> -	rtc_time_to_tm(now + 2, &tm);
>> +	rtc_time_to_tm(now + 1, &tm);
>>   
>>   	if (tm2bcd(&tm) < 0) {
>>   		dev_err(&rtc->rtc->dev, "power off failed\n");
>> @@ -455,6 +456,10 @@ static void omap_rtc_power_off(void)
>>   
>>   	rtc_wait_not_busy(rtc);
>>   
>> +	/* Our calculations started right before the rollover, try again */
>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>> +		goto again;
> 
> First, this doesn't even compile.

My bad. seconds got introduced in patch 2 and i did not compile test 
this one individually. Apologies for that.

> 
> Second, nothing is preventing the rollover from happening here after the
> check.

Okay. That window cannot be ignored. So 'now + 2' will surely solve 
that. I will stick to that.

> 
>> +
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_SECONDS_REG, tm.tm_sec);
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_MINUTES_REG, tm.tm_min);
>>   	rtc_write(rtc, OMAP_RTC_ALARM2_HOURS_REG, tm.tm_hour);
> 
> Johan
> 
