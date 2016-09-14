From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: Add operating-points-v2 tables for TI
 platforms
Date: Wed, 14 Sep 2016 11:45:14 -0500
Message-ID: <57D97E9A.90400@ti.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
 <20160913220244.txdiak6ikujvwzjk@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160913220244.txdiak6ikujvwzjk@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,
On 09/13/2016 05:02 PM, Tony Lindgren wrote:
> Hi,
>
> * Dave Gerlach <d-gerlach@ti.com> [160831 19:49]:
>> Hi,
>> This is v2 of the series to add operating-points-v2 tables for am335x,
>> am437x, dra7, and am57x platforms, but really just updates the already
>> merged v1 found here [1].
>>
>> It seems v1 was merged without the binding being finalized so this series
>> just updates the nodes that are already present in order to work with the
>> new bindings coming in v2 of the ti-cpufreq driver series which will follow
>> shortly.
>
> Assuming this will have to wait based on what you mentioned about
> am335x cpufreq regression. I guess you'll instead send few patches
> to revert?
>

Correct, these should not be merged, I will be sending a fixup series 
until this series is ready.

I needed to resend the ti-cpufreq driver at [2] to get a response about 
the dt binding and other updates Viresh asked for and sent this to 
update the merged nodes so they would work with the driver. But the 
driver has not been merged yet, so in order to re-enable the previously 
existing cpufreq support on those platforms I must revert three patches 
from v1 [1] of this series that got merged, which I will send.

I also found that 7694ca6e1d6f ("cpufreq: omap: Use generic platdev 
driver") which went in v4.6-rc1 had already broken the existing cpufreq 
support on am335x and dra7xx, so it's been missing for some time. I can 
send a patch fixing that as well but I will need to remove it once the 
ti-cpufreq driver in [2] below gets merged as that driver must create 
the cpufreq-dt platform device instead of cpufreq-dt-platdev. So I will 
send a series that can fix cpufreq until ti-cpufreq is ready which will 
give us better support for more OPPs on am335x, am437x (which has no 
implementation today), and dra7xx.

Regards,
Dave

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430205.html
[2] http://www.spinics.net/lists/devicetree/msg141152.html

> Regards,
>
> Tony
>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430205.html
>>
>> Dave Gerlach (3):
>>    ARM: dts: am33xx: Change operating-points-v2 table to am3352 version
>>    ARM: dts: am4372: Change operating-points-v2 table to am4372 version
>>    ARM: dts: dra7: Change operating-points-v2 table to dra7 version
>>
>>   arch/arm/boot/dts/am33xx.dtsi | 2 +-
>>   arch/arm/boot/dts/am4372.dtsi | 2 +-
>>   arch/arm/boot/dts/dra7.dtsi   | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> --
>> 2.9.0
>>

