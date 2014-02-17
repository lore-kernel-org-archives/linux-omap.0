From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 2/2] ARM: DTS: OMAP4: Add gpmc_fck clock node
Date: Mon, 17 Feb 2014 17:13:50 +0100
Message-ID: <5302353E.7090506@epfl.ch>
References: <1392636465-31459-1-git-send-email-florian.vaussard@epfl.ch> <1392636465-31459-3-git-send-email-florian.vaussard@epfl.ch> <530200B9.8090407@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:42901 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaBQQNz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Feb 2014 11:13:55 -0500
In-Reply-To: <530200B9.8090407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 02/17/2014 01:29 PM, Tero Kristo wrote:
> On 02/17/2014 01:27 PM, Florian Vaussard wrote:
>> Add the gpmc_fck clock, derived from l3_ick, and reference it from
>> the GPMC node to get it correctly working.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi           | 2 ++
>>   arch/arm/boot/dts/omap44xx-clocks.dtsi | 6 ++++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index d3f8a6e..8a0cc71 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -275,6 +275,8 @@
>>               gpmc,num-waitpins = <4>;
>>               ti,hwmods = "gpmc";
>>               ti,no-idle-on-init;
>> +            clocks = <&gpmc_fck>;
>> +            clock-names = "fck";
>>           };
>>
>>           uart1: serial@4806a000 {
>> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> index c821ff5..ae2c441 100644
>> --- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> @@ -1036,6 +1036,12 @@
>>           ti,index-power-of-two;
>>       };
>>
>> +    gpmc_fck: gpmc_fck {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,clkdm-gate-clock";
>> +        clocks = <&l3_div_ck>;
>> +    };
>> +
> 
> Why not implement a proper gate clock for CM_L3_2_GPMC_CLKCTRL? The
> approach you have taken looks good to me otherwise.
> 

So something like:

        gpmc_fck: gpmc_fck {
                #clock-cells = <0>;
                compatible = "ti,gate-clock";
                clocks = <&l3_div_ck>;
                reg = <(CM_L3_2_GPMC_CLKCTRL)>;
                ti,bit-shift = <0>;
        };

? I was not sure for gate-clock, as setting the bit will enable the
clock only if the corresponding clock domain (CD_L3_2) is enabled as well.

Regards,
Florian
