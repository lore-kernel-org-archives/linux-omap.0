From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
Date: Fri, 20 Jul 2018 16:03:20 +0530
Message-ID: <28f0d002-f05e-b4dc-f0dd-d0bc0fc5616d@ti.com>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
 <20180719123617.GV10204@localhost>
 <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, t-kristo@ti.com, linux-rtc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Thursday 19 July 2018 06:16 PM, Keerthy wrote:
> 
> 
> On Thursday 19 July 2018 06:06 PM, Johan Hovold wrote:
>> On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
>>> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
>>>> On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
>>>>> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
>>
>>>>>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>>>>>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>>>>>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>>>>>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
>>
>>>>>> +	/* Our calculations started right before the rollover, try again */
>>
>>>>>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>>>>>> +		goto again;
>>>>>
>>>>> Here the alarm may have gone off as part of the roll over, in which case
>>>>> you shouldn't retry.
>>>>
>>>> Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
>>>>
>>>> In the event of Roll over before setting the
>>>> OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
>>>> not miss the ALARM2 event? Then poweroff would fail right?
>>
>> Right, that would fail.
>>
>>>> Hence the attempt to retry the next second. This sequence would begin
>>>> right at the beginning of a new second and we expect the full sequence
>>>> to get over without having to retry again.
>>>>
>>>> Hope i am clear.
>>
>> Yes, sure, but my point is that could end up retrying also after the
>> alarm has fired correctly (e.g. due to latencies in turning of the
>> power)>
>> It may be enough to check OMAP_RTC_STATUS_REG before retrying.

On a second thought. Status gets set only after the next second.

if ALARM2 status bit is set that surely means interrupt has fired but if
it is not set then there are 2 possibilities

1) ALARM2 is missed as the roll over happened
2) ALARM2 yet to fire as we are yet to get to the next second.

On the other hand Seconds gives me clear indication if we missed the
interrupt or we are about to get one.

> 
> Ah okay. Yes this makes sense. I will use the status to retry.
> 
>>
>>> I tried to program the interrupt for the same second on the hardware and
>>> it does not fire. So to take care of roll over corner case one attempt
>>> to retry is needed.
>>
>> Yes, that's expected.
>>
>> Thanks,
>> Johan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
