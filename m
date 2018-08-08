From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
Date: Wed, 8 Aug 2018 14:38:00 +0530
Message-ID: <bc07ac40-accc-64aa-a277-063833645545@ti.com>
References: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
 <20180808090607.GR99251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808090607.GR99251@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 08 August 2018 02:36 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180725 05:59]:
>> RTC alarm2 is connected to pmic_en line and hence can be used to control
>> the pmic enabling/disabling. Hence add the system-power-controller for rtc
>> node.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>  arch/arm/boot/dts/am4372.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index f0cbd86..d4b7c59 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -469,6 +469,7 @@
>>  			ti,hwmods = "rtc";
>>  			clocks = <&clk_32768_ck>;
>>  			clock-names = "int-clk";
>> +			system-power-controller;
>>  			status = "disabled";
>>  		};
>>  
> 
> Should this be queued as a fix for v4.19-rc series?

Yes this makes pmic to shutdown during power off.

> 
> Regards,
> 
> Tony
> 
