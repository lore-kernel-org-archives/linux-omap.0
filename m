From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [4.4-rc][PATCH] ARM: dts: am4372: fix clock source for arm twd
 and global timers
Date: Mon, 30 Nov 2015 13:53:50 +0200
Message-ID: <565C38CE.1070907@ti.com>
References: <1448653468-24908-1-git-send-email-grygorii.strashko@ti.com>
 <565C0814.3000001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <565C0814.3000001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/30/2015 10:25 AM, Tero Kristo wrote:
> On 11/27/2015 09:44 PM, Grygorii Strashko wrote:
>> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
>> But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
>> Timekeeping core misbehaves. For example, execution of command
>> "sleep 5" will take 10 sec instead of 5.
>>
>> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
>> it for clocking ARM TWD and Global timer (same way as on OMAP4).
>>
>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
>> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and
>> SCU nodes")
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi        | 4 ++--
>>   arch/arm/boot/dts/am43xx-clocks.dtsi | 8 ++++++++
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi
>> b/arch/arm/boot/dts/am4372.dtsi
>> index d83ff9c..de8791a 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -74,7 +74,7 @@
>>           reg = <0x48240200 0x100>;
>>           interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>           interrupt-parent = <&gic>;
>> -        clocks = <&dpll_mpu_m2_ck>;
>> +        clocks = <&mpu_periphclk>;
>>       };
>>
>>       local_timer: timer@48240600 {
>> @@ -82,7 +82,7 @@
>>           reg = <0x48240600 0x100>;
>>           interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>           interrupt-parent = <&gic>;
>> -        clocks = <&dpll_mpu_m2_ck>;
>> +        clocks = <&mpu_periphclk>;
>>       };
>>
>>       l2-cache-controller@48242000 {
>> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> index cc88728..2ff58b1 100644
>> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>> @@ -259,6 +259,14 @@
>>           ti,invert-autoidle-bit;
>>       };
>>
>> +    mpu_periphclk: mpu_periphclk {
>> +        #clock-cells = <0>;
>> +        compatible = "fixed-factor-clock";
>> +        clocks = <&dpll_mpu_ck>;
>
> I don't think this is correct, ARM core is fed dpll_mpu_m2_ck, where the
> divisor value can potentially differ from 1. If you feed this clock
> directly from dpll_mpu_ck, you bypass this divisor.

Sry. My mistake. I'll update it to use dpll_mpu_m2_ck.

>
> Did you check what is the impact of cpufreq on the ARM TWD/timers?

TWD is cpufreq friendly, ARM GT is not.


>> +        clock-mult = <1>;
>> +        clock-div = <2>;
>> +    };
>> +
>>       dpll_ddr_ck: dpll_ddr_ck {
>>           #clock-cells = <0>;
>>           compatible = "ti,am3-dpll-clock";
>>
>


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
