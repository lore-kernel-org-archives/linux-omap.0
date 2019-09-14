From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Sat, 14 Sep 2019 11:53:47 +0200
Message-ID: <c9bb9c0b-0327-4fc6-afd9-56f016b9a3b3@linaro.org>
References: <20190912183037.18449-1-aford173@gmail.com>
 <D4F7E03C-1880-45AC-8F7C-6C8A336E2A01@goldelico.com>
 <CAHCN7xK100mR=fNns3qdDKpOyWsTWXgDnnngQfQ_j8cB_SFfuA@mail.gmail.com>
 <98751DAF-B3F7-4638-97BE-1D067B24EF18@goldelico.com>
 <CAHCN7xL-CmwmXP3PLdwAHiC-9tMjrpY4k7ZhxQ9WoXY6yUz8BA@mail.gmail.com>
 <ABCE2ACA-D19A-42D2-9606-C60F1A5CBCCB@goldelico.com>
 <CAHCN7xKfeh-cqJVfbW_km27cgee2MEBdPM3edACRi0fCaohxvw@mail.gmail.com>
 <7C9393BD-B23B-41A6-BF96-E53CD707AAC7@goldelico.com>
 <CAHCN7x+_f_jrttUGyKHBOUyYjkOx0mJxba1Yb3tPm9ee7+21og@mail.gmail.com>
 <CAHCN7xLODa114M77-rX9WHT+uJtsH3yOmbFG2KdEjZpTSECs2w@mail.gmail.com>
 <D3AF2868-F9A4-4176-A851-5DCF029B65A9@goldelico.com>
 <81d6cd33-4930-6753-d5ed-678cb1d2038d@linaro.org>
 <CAHCN7xLcCO-QrYTm0jzS64P6o5t8cfudJfYELDSz-_OPV5JO5w@mail.gmail.com>
 <7ebe4c56-1b89-d90d-eeb4-25adaa58dd17@linaro.org>
 <42A53316-100E-4899-9D77-CD9F5129179E@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <42A53316-100E-4899-9D77-CD9F5129179E@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Adam Ford <aford173@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=c3=a9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org



Hi Nikolauss,

On 13/
09/2019 22:34, H. Nikolaus Schaller wrote:

[ ... ]

>> The governor continues to read the temperature and see the temperature
>> decrease, it does nothing.
> 
> Ah, I think our misunderstanding is that the govenor "enables" and
> "disables" a set of OPPs. Rather it goes down or up in the list if
> above or below a trip point.

Right.

>> The governor continues to read the temperature, see the temperature
>> decreases and is below 75°C, it decrease the state (state=>1), the OPP
>> change to 2.36GHz.
>>
>> The temperature then increases, etc ...
>>
>> Actually the governors do more than that but it is for the example.
>>
>> So it is a bad idea to set boundaries for the cooling device state as
>> that may prevent the governor to take the right decision for the cooling
>> effect. Imagine in the example above, we set the max state to 1 for the
>> cooling device, that would mean the governor won't be able to stop the
>> temperature increasing, thus ending up to a hard reboot.
> 
> Well, the data sheet only requires that the high speed OPPs are only
> used below 90°C. If I understand correctly if we set the trip point to
> 90°C it will simply go down through the full list of OPPs. This will
> clearly avoid the high speed OPPs (and potentially some low-speed
> ones, but that does not harm).

Yes, right.

> So our approach "how to make it disable these two OPPs" seems to be
> wrong. Rather, we have to think "make sure the temperature
> stays below 90°C".

Your approach is not wrong, it proves there is a limitation in the
thermal/cpufreq framework.

There is the 'turbo mode' [1] which describes exactly what you want but
I'm not sure it is fully implemented.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/opp/opp.txt#n138

> And is it true that we do not have to define mapping for the "critical"
> trip points?

Right, you don't have to, it is optional. But the critical trip point
will make your system to shutdown in case something is going wrong, for
example an external heating source, like the sun or whatever. It is good
to set a high temperature to force the shutdown .
Usually it is below the hardware reset temperature.


>>>> Now the different combinations:
>>>>
>>>> <&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT> the governor will use the state
>>>> 0 to 7.
>>>>
>>>> <&cpu THERMAL_NO_LIMIT 2> the governor will use the state 0 to 2
>>>
>>> What would be the difference between  <&cpu THERMAL_NO_LIMIT 2>  and
>>> <&cpu 0 2> ?
>>> (if there is any)
>>
>> There is no difference.
>>
>>
>>>> <&cpu 1 2> the governor will use the state 1 and 2. That means there is
>>>> always the cooling effect as the governor won't set it to zero thus
>>>> stopping the mitigation.
>>>
>>> For the purposes of the board in question, we have 4 operating points,
>>> 300MHz, 600MHz, 800MHz and 1GHz.  Once the board reaches 90C, we need
>>> them to cease operation at 800MHz and 1GHz and only permit operation
>>> at 300MHz and 600MHz.  I am going under the assumption that the cpu
>>> index[0] would be for 300MHz, index[1] = 600MHz, etc.
>>>
>>> If I am interpreting your comment correctly, I should set <&cpu
>>> THERMAL_NO_LIMIT 2> which would allow it to either not cool and run up
>>> to 600MHz and not exceed, is that correct?
>>
>> Nope, it will mean the cooling device can only reduce to 800MHz and to
>> 600MHz to mitigate.
>>
>> Actually the thermal framework neither the kernel are designed to handle
>> this case. They assume the OPPs are stable whatever the thermal situation.
>>
>> That is the reason why I think it is a very interesting use case because
>> it introduces a temperature constraint in addition to a duration for a
>> certain OPP. IMO, that could be an extension of the turbo-mode.
>>
>> With what we have now, I doubt it is feasible.
>>
>> The best we can do is preventing to reach the 90°C, so we remove the OPP
>> temperature constraint. I suppose 85°C is a safe temperature to stick on.
>>
>> And in order to let the governor have free hand.
>>
>> <&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>
>>
>> I don't think that will have a significant impact on performances
>> compared to be able to run at a higher temperature with less OPPs.
>>
>>
>>>> Does it clarify the DT spec?
>>>>
>>>
>>> I think your reply to my inquiry might.  If possible, it would be nice
>>> to get this documented into the bindings doc for others in the future.
>>> I can do it, but someone with a better understanding of the concept
>>> maybe more qualified.  I can totally understand why some may want to
>>> integrate this into their SoC device trees to slow the processor when
>>> hot.
>>>
>>> Thank you for taking the time to review this.  I appreciate it.
>>>
>>> adam
> 
> BR,
> Nikolaus
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
