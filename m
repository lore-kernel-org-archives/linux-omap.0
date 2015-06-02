From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
Date: Tue, 2 Jun 2015 16:53:12 +0530
Message-ID: <556D9220.8050205@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com> <1433159614-437-4-git-send-email-vigneshr@ti.com> <556D67CB.8090309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46891 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbbFBLYJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 07:24:09 -0400
In-Reply-To: <556D67CB.8090309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org



On Tuesday 02 June 2015 01:52 PM, Tero Kristo wrote:
> On 06/01/2015 02:53 PM, Vignesh R wrote:
>> tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
>> clock to control ehrpwm tbclk.
> 
> Care to add TRM reference here?

Ok, I will add the following reference.

tbclk is derived from SYSCLKOUT. The system clock - SYSCLKOUT is the
ePWM functional clock derived from the gateable interface and functional
clock of PWMSS.
See AM57x TRM SPRUHZ6, October 2014, Section 29.2.2.1, Table 29-19 and
the NOTE at the end of the table.

> 
> -Tero
> 
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi          |  5 +++++
>>   arch/arm/boot/dts/dra7xx-clocks.dtsi | 26 ++++++++++++++++++++++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index f03a091cd076..387c76ca41f9 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -131,6 +131,11 @@
>>                               regulator-max-microvolt = <3000000>;
>>                           };
>>                       };
>> +
>> +                    scm_conf_clocks: clocks {
>> +                        #address-cells = <1>;
>> +                        #size-cells = <0>;
>> +                    };
>>                   };
>>
>>                   dra7_pmx_core: pinmux@1400 {
>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> index 3b933f74d000..92452d61cf58 100644
>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> @@ -2136,3 +2136,29 @@
>>           clocks = <&dpll_usb_ck>;
>>       };
>>   };
>> +
>> +&scm_conf_clocks {
>> +       ehrpwm0_tbclk: ehrpwm0_tbclk {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&l4_root_clk_div>;
>> +        ti,bit-shift = <20>;
>> +        reg = <0x0558>;
>> +    };
>> +
>> +    ehrpwm1_tbclk: ehrpwm1_tbclk {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&l4_root_clk_div>;
>> +        ti,bit-shift = <21>;
>> +        reg = <0x0558>;
>> +    };
>> +
>> +    ehrpwm2_tbclk: ehrpwm2_tbclk {
>> +        #clock-cells = <0>;
>> +        compatible = "ti,gate-clock";
>> +        clocks = <&l4_root_clk_div>;
>> +        ti,bit-shift = <22>;
>> +        reg = <0x0558>;
>> +    };
>> +};
>>
> 
