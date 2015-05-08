From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Fri, 8 May 2015 15:12:27 -0500
Message-ID: <554D18AB.6060901@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com> <554D17F3.7090008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <554D17F3.7090008@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/08/2015 03:09 PM, Nishanth Menon wrote:
> On 05/08/2015 02:57 PM, Felipe Balbi wrote:
>> By adding operating points, cpufreq-dt has a
>> chance of running and doing something useful.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index c80a3e233792..ea1db20f64fc 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -38,6 +38,15 @@
>>  			clocks = <&dpll_mpu_ck>;
>>  			clock-names = "cpu";
>>  
>> +			operating-points = <
>> +				/* kHz		uV */
>> +				1000000		1325000 /* OPP_NITRO */
>> +				 800000		1260000 /* OPP_TURBO */
>> +				 720000		1200000 /* OPP_120 */
>> +				 600000		1100000 /* OPP_100 */
>> +				 300000		 950000 /* OPP_50 */
>> +			>;
>> +
>>  			clock-latency = <300000>; /* From omap-cpufreq driver */
>>  		};
>>  	};
>>
> which of these OPPs need AVS? which of these are dependent on Efuse bit
> dependent?
>


You can use
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-linux-3.14.y/arch/arm/mach-omap2/opp43xx_data.c
for reference.


-- 
Regards,
Nishanth Menon
