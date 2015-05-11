From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Sun, 10 May 2015 19:23:34 -0500
Message-ID: <554FF686.5050704@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com> <554D17F3.7090008@ti.com> <554D18AB.6060901@ti.com> <20150508202439.GA25459@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56847 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbbEKAYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 May 2015 20:24:17 -0400
In-Reply-To: <20150508202439.GA25459@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 05/08/2015 03:24 PM, Felipe Balbi wrote:
> On Fri, May 08, 2015 at 03:12:27PM -0500, Nishanth Menon wrote:
>> On 05/08/2015 03:09 PM, Nishanth Menon wrote:
>>> On 05/08/2015 02:57 PM, Felipe Balbi wrote:
>>>> By adding operating points, cpufreq-dt has a
>>>> chance of running and doing something useful.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>>>> index c80a3e233792..ea1db20f64fc 100644
>>>> --- a/arch/arm/boot/dts/am4372.dtsi
>>>> +++ b/arch/arm/boot/dts/am4372.dtsi
>>>> @@ -38,6 +38,15 @@
>>>>  			clocks = <&dpll_mpu_ck>;
>>>>  			clock-names = "cpu";
>>>>  
>>>> +			operating-points = <
>>>> +				/* kHz		uV */
>>>> +				1000000		1325000 /* OPP_NITRO */
>>>> +				 800000		1260000 /* OPP_TURBO */
>>>> +				 720000		1200000 /* OPP_120 */
>>>> +				 600000		1100000 /* OPP_100 */
>>>> +				 300000		 950000 /* OPP_50 */
>>>> +			>;
>>>> +
>>>>  			clock-latency = <300000>; /* From omap-cpufreq driver */
>>>>  		};
>>>>  	};
>>>>
>>> which of these OPPs need AVS? which of these are dependent on Efuse bit
>>> dependent?
>>>
>>
>>
>> You can use
>> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-3.14.y/arch/arm/mach-omap2/opp43xx_data.c
>> for reference.
> 
> heh, why isn't that upstream yet ? Seems to be ready already. The point

we have tried in the past[1] - unfortunately that was just bandaid since
the existing OPP device tree bindings have very limiting behavior across
multiple SoCs.This was one of the reasons why we stopped adding more
OPPs, since we are hoping to see the new bindings[2] which is under
discussion settle down and help enable support for cases like that we
have on TI SoCs, iMX SoCs etc.

> is that as of now, u-boot will set maximum OPP it can find and, for
> AM437x, that will be 800MHz or 1GHz depending on your board. 1GHz might
> not be supported in all SoCs and letting that be used all the time is
> likely going to reduce silicon lifetime.

> At least allowing ondemand governor run, we will be mostly running at
> 300MHz and only jump to "invalid" OPPs under load which, granted, is
> still not perfect, but better than running at 1GHz all the time, don't
> you agree ?
The fix for this should ideally be in u-boot - we are trying not to
introduce dts changes in the hopes that the new proposed bindings that
Viresh has on discussion comes to conclusion and help introduce new dtb
support with proper SoC description. allowing an SoC to enter an invalid
OPP is broken by design. we must attempt to curb it. unfortunately, we
already do have a broken implementation for AM335x, DRA7 in place which
went with the assumption that we will be able to do modifiers on top of
existing dt description and the hopes that [1] will eventually get
upstream. But, as is clear now, [1] has no future path in upstream
kernel. following the same broken path for newer SoC definitions will
probably very short sighted by us.

in my opinion, doing a temporary hack in upstream kernel is not an
elegant approach. I suggest helping review and approving Viresh's new
bindings so that we have a longer term solution is more the way to do this.

Just my 2 cents. Thanks once again for identifying the urgent need for
helping Viresh's series along - will be great if folks could help review
and approve his series to get them upstream and help all of us ARM SoC
variations along.


[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/309466
[2] http://marc.info/?l=devicetree&m=143039569104090&w=2

-- 
Regards,
Nishanth Menon
