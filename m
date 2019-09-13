From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 22:11:13 +0200
Message-ID: <7ebe4c56-1b89-d90d-eeb4-25adaa58dd17@linaro.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLcCO-QrYTm0jzS64P6o5t8cfudJfYELDSz-_OPV5JO5w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=c3=a9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 13/09/2019 20:46, Adam Ford wrote:
> On Fri, Sep 13, 2019 at 12:18 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/09/2019 18:51, H. Nikolaus Schaller wrote:
>>
>> [ ... ]
>>
>>>> Good news (I think)
>>>>
>>>> With cooling-device = <&cpu 1 2> setup, I was able to ask the max
>>>> frequency and it returned 600MHz.
>>>>
>>>> # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>>>> 58500
>>>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
>>>> 300000 600000 800000
>>>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_m
>>>> scaling_max_freq  scaling_min_freq
>>>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
>>>> 600000
>>>
>>> looks good!
>>> But we have to understand what the <&cpu 1 2> exactly means...
>>>
>>> Hopefully someone reading your RFCv2 can answer...
>>
> Daniel,
> 
> Thank you for replying.
> 
>> I may have missed the question :)
>>
>> These are the states allowed for the cooling device (the one you can see
>> in the /sys/class/thermal/cooling_device0/max_state. As the logic is
>> inverted for cpufreq, that can be confusing.
> 
> I think that's what has be confused.
> 
>>
>> If it was a fan with, let's say 5 speeds, you would use <&fan 0 5>, so
>> when the mitigation begins the cooling device state is 0 and then the
>> thermal governor increase the state until it sees a cooling effect.
>>
>> If <&fan 0 2> is set, the governor won't set a state above 2 even if the
>> temperature increases.
> 
> I am not sure I know what you mean by 'state' in this context.

A thermal zone is managed by the thermal framework as the following:
 - a sensor
 - a governor
 - a cooling device

The governor gets the temperature via the sensor and depending on the
temperature it will increase or decrease the cooling effect of the
cooling device. With a fan, that means it will increase or decrease its
speed. With cpufreq, it will decrease or increase the OPP.

These are discrete values the governor will use to set the cooling
effect. The state is one of these value (the current speed or the
current OPP index).

Depending on the cooling device, the number of states are different.

In the context above, the fan cooling device can be stopped (state=0),
running (state=1), running faster (state=2).

As the node tells to use no more than 2, then the governor will never go
to running much faster (state=3). (That's an example).

>> When the cooling driver is able to return the number of states it
>> supports, it is safe to set the states to THERMAL_NO_LIMIT and let the
>> governor to find the balance point.
> 
> If the cooling driver is using cpufreq, is the number of supported
> states equal to the number of operating points given to cpufreq?

Yes, absolutely if THERMAL_NO_LIMIT is set [1] (which is what is done
most of the cases). Otherwise it will use the boundaries set in <&cpu
limit_low limit_high>

When changing the limits, a state=1 has a different meaning.

For example: 7 OPPs available

<&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT> : state=[0..7]

<&cpu 0 2> : state=[0..2] (1, 2)

<&cpu 5 7> : state=[0..3] (5, 6, 7)

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/cpu_cooling.c#n334

>> Now if the cooling device is cpufreq, the state order is inverted,
>> because the cooling effects happens when decreasing the OPP.
>>
>> If the boards support 7 OPPs, the state 0 is 7 - 0, so no mitigation, if
>> the state is 1, the cpufreq is throttle to the 6th OPP, 2 to the 5th OPP
>> etc.
> 
> I am not sure how the state would be set to 2.

That is a governor decision. Let me give an example with a hikey960
board which has very fast temperature transitions, so it is simpler to
illustrate the behavior. The trip point is 75°C.

Imagine the CPU gets loaded 100%, the cpufreq sets the OPP to the max
(2.36GHz), as the temperature is still under 75°C, there is no
mitigation yet, so the cooling device state is 0.

In a very few seconds the temperature reaches 75°C, that trigger the
monitoring of the thermal zone and the mitigation begins, then the
temperature continues to increase very quickly to 78°C, the governor see
we are above the trip point and increment the cooling device state
(state=>1). That leads to an OPP change from 2.36GHz to 2.11GHz.

The governor continues to read the temperature and see the temperature
is still increasing (even if it is that happens more slowly), so it
increases the state again (state=>2). That leads to an OPP change from
2.11GHz to 1.8GHz.

The governor continues to read the temperature and see the temperature
decrease, it does nothing.

The governor continues to read the temperature, see the temperature
decreases and is below 75°C, it decrease the state (state=>1), the OPP
change to 2.36GHz.

The temperature then increases, etc ...

Actually the governors do more than that but it is for the example.

So it is a bad idea to set boundaries for the cooling device state as
that may prevent the governor to take the right decision for the cooling
effect. Imagine in the example above, we set the max state to 1 for the
cooling device, that would mean the governor won't be able to stop the
temperature increasing, thus ending up to a hard reboot.

>> Now the different combinations:
>>
>> <&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT> the governor will use the state
>> 0 to 7.
>>
>> <&cpu THERMAL_NO_LIMIT 2> the governor will use the state 0 to 2
> 
> What would be the difference between  <&cpu THERMAL_NO_LIMIT 2>  and
> <&cpu 0 2> ?
> (if there is any)

There is no difference.


>> <&cpu 1 2> the governor will use the state 1 and 2. That means there is
>> always the cooling effect as the governor won't set it to zero thus
>> stopping the mitigation.
> 
> For the purposes of the board in question, we have 4 operating points,
> 300MHz, 600MHz, 800MHz and 1GHz.  Once the board reaches 90C, we need
> them to cease operation at 800MHz and 1GHz and only permit operation
> at 300MHz and 600MHz.  I am going under the assumption that the cpu
> index[0] would be for 300MHz, index[1] = 600MHz, etc.
> 
> If I am interpreting your comment correctly, I should set <&cpu
> THERMAL_NO_LIMIT 2> which would allow it to either not cool and run up
> to 600MHz and not exceed, is that correct?

Nope, it will mean the cooling device can only reduce to 800MHz and to
600MHz to mitigate.

Actually the thermal framework neither the kernel are designed to handle
this case. They assume the OPPs are stable whatever the thermal situation.

That is the reason why I think it is a very interesting use case because
it introduces a temperature constraint in addition to a duration for a
certain OPP. IMO, that could be an extension of the turbo-mode.

With what we have now, I doubt it is feasible.

The best we can do is preventing to reach the 90°C, so we remove the OPP
temperature constraint. I suppose 85°C is a safe temperature to stick on.

And in order to let the governor have free hand.

<&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>

I don't think that will have a significant impact on performances
compared to be able to run at a higher temperature with less OPPs.


>> Does it clarify the DT spec?
>>
> 
> I think your reply to my inquiry might.  If possible, it would be nice
> to get this documented into the bindings doc for others in the future.
> I can do it, but someone with a better understanding of the concept
> maybe more qualified.  I can totally understand why some may want to
> integrate this into their SoC device trees to slow the processor when
> hot.
> 
> Thank you for taking the time to review this.  I appreciate it.
> 
> adam
> 
>>
>>
>>
>>> What happens with trip point 60000?
>>> (unfortunately one has to reboot in between or can you kexec between two kernel/dtb versions?)
>>>
>>> BR,
>>> Nikolaus
>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
