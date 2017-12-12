From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v5 1/8] clocksource: dmtimer: Remove all the exports
Date: Tue, 12 Dec 2017 13:38:04 +0530
Message-ID: <9de9b3dc-09f4-d58b-ba5a-60fcb563c665@ti.com>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <1513059137-21593-2-git-send-email-j-keerthy@ti.com>
 <20171212071624.GA3453@lenoch> <c6a407a8-41c5-f0fd-931c-a58e7e627c82@ti.com>
 <20171212080134.GA9589@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <20171212080134.GA9589@lenoch>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, tony@atomide.com
Cc: daniel.lezcano@linaro.org, aaro.koskinen@iki.fi, thierry.reding@gmail.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux@armlinux.org.uk
List-Id: linux-omap@vger.kernel.org



On Tuesday 12 December 2017 01:31 PM, Ladislav Michl wrote:
> On Tue, Dec 12, 2017 at 01:01:51PM +0530, Keerthy wrote:
>>
>>
>> On Tuesday 12 December 2017 12:46 PM, Ladislav Michl wrote:
>>> Keerthy,
>>>
>>> On Tue, Dec 12, 2017 at 11:42:10AM +0530, Keerthy wrote:
>>>> Remove all the unwanted exports from the driver
>>>
>>> I'm adding event capture capability to the pwm-omap driver and so far used
>>> v4.15-rc3 as codebase.
>>>
>>> Intended use is an IR receiver; for that I need to measure pulses width and
>>> spaces between pulses. So DM timer was setup to generate interupt after
>>> both TCAR1 and TCAR2 are filled, values are passed to IR decoder and
>>> TCAR_IT_FLAG is cleared.
>>>
>>> Of course, this is just proof of concept and needs to be polished and
>>> generalized, but to make it at least work I need functions you just
>>> unexported (plus some new).
>>>
>>> Question is whenever we need this level of indirection (omap_dm_timer_ops)
>>> or plain exports are enough.
>>
>> The general guidance is not to do plain exports and go via
>> omap_dm_timer_ops.
> 
> ...in contrary what other clocksource drivers are doing.
> 
> Now I'm assuming it is okay to extend omap_dm_timer_ops. That would mean
> check for ops members to be assigned should be also extended or we should
> delete it altogether and assume all members are populated?

It should be fine to extend omap_dm_timer_ops. What are the ops missing
for your new implementation?

Tony,

Your thoughts on the above?

Regards,
Keerthy
> 
> Thanks,
> 	ladis
> 
