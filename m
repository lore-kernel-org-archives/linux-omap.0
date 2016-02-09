From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain
 data
Date: Tue, 9 Feb 2016 09:07:27 +0530
Message-ID: <56B95EF7.9080107@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
 <20160208195704.GW19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160208195704.GW19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: edubezval@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org



On Tuesday 09 February 2016 01:27 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [160208 01:19]:
>> OMAP5 has 3 thermal zones cpu, core and multimedia.
>> On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
>> and iva. Currently cpu, core and multimedia are being added via dt
>> and the other 2 are getting added via kernel. Add the missing thermal
>> domains in dt so as give the correct trip numbers, type and temperatures.
>>
>> Tested on DRA7-EVM.
>
> Are these critical fixes to have for v4.5-rc cycle or can they
> wait for v4.6 merge window?

Driver configures some default thresholds that are a bit higher but 
there are some thresholds already for dspeve and iva too. So guess these 
can wait if its already too late.

Regards,
Keerthy

>
> Regards,
>
> Tony
>
>> Keerthy (3):
>>    arm: dts: DRA7: Add DSPEVE thermal data
>>    arm: dts: DRA7: Add IVA thermal data
>>    arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data
>>
>>   arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
>>   arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 +++++++++++++++++++++++++++
>>   arch/arm/boot/dts/dra7.dtsi                |  2 ++
>>   3 files changed, 56 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>>   create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
>>
>> --
>> 1.9.1
>>
