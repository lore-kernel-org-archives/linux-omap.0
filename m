From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI platforms
Date: Wed, 31 Aug 2016 21:46:05 -0500
Message-ID: <57C7966D.2000800@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com> <20160519044744.GE32001@vireshk-i7> <20160610110414.GX22406@atomide.com> <575AD3A0.1050203@ti.com> <20160611024400.GE27439@vireshk-i7> <5768206A.5050501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <5768206A.5050501@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-omap@vger.kernel.org

Hi,
On 06/20/2016 11:57 AM, Dave Gerlach wrote:
> On 06/10/2016 09:44 PM, Viresh Kumar wrote:
>> On 10-06-16, 09:50, Nishanth Menon wrote:
>>> On 06/10/2016 06:04 AM, Tony Lindgren wrote:
>>>> * Viresh Kumar <viresh.kumar@linaro.org> [160518 21:49]:
>>>>> On 18-05-16, 18:36, Dave Gerlach wrote:
>>>>>> Hi,
>>>>>> This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
>>>>>> and am57xx based platforms along with some support patches so that we
>>>>>> can enable more OPPs for the CPU on these platforms.
>>>>>>
>>>>>> These patches rely on the ti-cpufreq series sent here [1] and provide
>>>>>> opp-supported-hw data for each OPP so that only the appropriate OPPs
>>>>>> for a specific piece of silicon get enabled.
>>>>>
>>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>
>>>> Applying all the dts changes into omap-for-v4.8/dt thanks.
>>>>
>>>> Tony
>>>>
>>> Viresh, are we ready with the cpufreq series?
>>>
>>> https://patchwork.kernel.org/patch/9122961/
>>> https://patchwork.kernel.org/patch/9122921/
>>>
>>> Also current series: https://patchwork.kernel.org/patch/9123071/
>>> Seems to have comments pending.
>>>
>>> Dave is on vacation for another week or so, doubt he can respond in
>>> time -> Should we wait on this series till we get the cpufreq support in?
>>
>> Rafael handles all the merges, etc. It would be better if you can
>> reply to that thread instead.
>>
> 
> Sorry for the delay responding here, the only issue with this series would be
> that we haven't received an ACK on the DT binding doc from cpufreq series [1]
> from a DT maintainer, so if comments are received there these patches could
> potentially change. I had pinged but still no response either way.
> 
> Regards,
> Dave
> 
> [1] https://patchwork.kernel.org/patch/9122921/

Seems this got merged and is already part of master, even though the binding it
uses is not yet finalized or accepted. I am about to send v2 of the ti-cpufreq
series that makes use of these bindings, and I will be sending a series to fix
these nodes that has already been merged, however it should *NOT* be merged.
until the binding and driver have been merged, as it could still potentially change.

Also, this series replaced the OPP v1 tables for am33xx and dra7, so cpufreq is
no longer enabled at the moment for these platforms. To fix this we could revert
patches:

f80bc97fd0a9 ("ARM: dts: dra7: Move to operating-points-v2 table")
c36e6ec90487 ("ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu")
4317be116210 ("ARM: dts: am33xx: Move to operating-points-v2 table and
ti-cpufreq driver")

until the ti-cpufreq driver series is merged, at which point we can add them
back in to re-enable cpufreq with the new driver.

Regards,
Dave
