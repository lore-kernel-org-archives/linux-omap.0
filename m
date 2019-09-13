From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] ARM: dts: omap36xx: Enable thermal throttling
Date: Fri, 13 Sep 2019 19:18:54 +0200
Message-ID: <81d6cd33-4930-6753-d5ed-678cb1d2038d@linaro.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D3AF2868-F9A4-4176-A851-5DCF029B65A9@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Adam Ford <aford173@gmail.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Andr=c3=a9_Roth?= <neolynx@gmail.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>, Adam Ford <adam.ford@logicpd.com>, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

On 13/09/2019 18:51, H. Nikolaus Schaller wrote:

[ ... ]

>> Good news (I think)
>>
>> With cooling-device = <&cpu 1 2> setup, I was able to ask the max
>> frequency and it returned 600MHz.
>>
>> # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>> 58500
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
>> 300000 600000 800000
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_m
>> scaling_max_freq  scaling_min_freq
>> # cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
>> 600000
> 
> looks good!
> But we have to understand what the <&cpu 1 2> exactly means...
> 
> Hopefully someone reading your RFCv2 can answer...

I may have missed the question :)

These are the states allowed for the cooling device (the one you can see
in the /sys/class/thermal/cooling_device0/max_state. As the logic is
inverted for cpufreq, that can be confusing.

If it was a fan with, let's say 5 speeds, you would use <&fan 0 5>, so
when the mitigation begins the cooling device state is 0 and then the
thermal governor increase the state until it sees a cooling effect.

If <&fan 0 2> is set, the governor won't set a state above 2 even if the
temperature increases.

When the cooling driver is able to return the number of states it
supports, it is safe to set the states to THERMAL_NO_LIMIT and let the
governor to find the balance point.

Now if the cooling device is cpufreq, the state order is inverted,
because the cooling effects happens when decreasing the OPP.

If the boards support 7 OPPs, the state 0 is 7 - 0, so no mitigation, if
the state is 1, the cpufreq is throttle to the 6th OPP, 2 to the 5th OPP
etc.

Now the different combinations:

<&cpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT> the governor will use the state
0 to 7.

<&cpu THERMAL_NO_LIMIT 2> the governor will use the state 0 to 2

<&cpu 1 2> the governor will use the state 1 and 2. That means there is
always the cooling effect as the governor won't set it to zero thus
stopping the mitigation.


Does it clarify the DT spec?




> What happens with trip point 60000?
> (unfortunately one has to reboot in between or can you kexec between two kernel/dtb versions?)
> 
> BR,
> Nikolaus
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
