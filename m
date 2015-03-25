From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 29/35] ARM: dts: am4372: add minimal l4 bus layout with
 control module support
Date: Wed, 25 Mar 2015 11:10:04 +0200
Message-ID: <55127B6C.5020900@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com> <1426877086-17131-30-git-send-email-t-kristo@ti.com> <5511C4CF.1020601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbbCYJKg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2015 05:10:36 -0400
In-Reply-To: <5511C4CF.1020601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 03/24/2015 10:10 PM, Suman Anna wrote:
> Hi Tero,
>
> On 03/20/2015 01:44 PM, Kristo, Tero wrote:
>> This patch creates an l4_wkup interconnect for AM43xx, and moves some of
>> the generic peripherals under it. System control module nodes are moved
>> under this new interconnect also, and the SCM clock layout is changed
>> to use the renamed SCM nodea as the clock provider.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   Documentation/devicetree/bindings/arm/omap/l4.txt  |    1 +
>>   .../devicetree/bindings/arm/omap/prcm.txt          |    2 +-
>>   arch/arm/boot/dts/am4372.dtsi                      |   85 +++++++++++---------
>>   arch/arm/boot/dts/am43xx-clocks.dtsi               |    2 +-
>>   arch/arm/mach-omap2/control.c                      |    2 +-
>>   5 files changed, 53 insertions(+), 39 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
>> index d333f0a..941b914 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/l4.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
>> @@ -7,6 +7,7 @@ Required properties:
>>   	       Should be "ti,omap2-l4-wkup" for OMAP2 family l4 wkup bus
>>   	       Should be "ti,omap3-l4-core" for OMAP3 family l4 core bus
>>   	       Should be "ti,am3-l4-wkup" for AM33xx family l4 wkup bus
>> +	       Should be "ti,am4-l4-wkup" for AM43xx family l4 wkup bus
>>   - ranges : contains the IO map range for the bus
>>
>>   Examples:
>> diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
>> index c8e2027..8af4f32 100644
>> --- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
>> +++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
>> @@ -12,7 +12,7 @@ Required properties:
>>   		"ti,am3-prcm"
>>   		"ti,am3-scm"
>>   		"ti,am4-prcm"
>> -		"ti,am4-scrm"
>> +		"ti,am4-scm"
>>   		"ti,omap2-prcm"
>>   		"ti,omap2-scm"
>>   		"ti,omap3-prm"
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index 1943fc3..9ed58115 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -57,22 +57,6 @@
>>   		cache-level = <2>;
>>   	};
>>
>> -	am43xx_control_module: control_module@4a002000 {
>> -		compatible = "syscon";
>> -		reg = <0x44e10000 0x7f4>;
>> -	};
>> -
>> -	am43xx_pinmux: pinmux@44e10800 {
>> -		compatible = "ti,am437-padconf", "pinctrl-single";
>> -		reg = <0x44e10800 0x31c>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		#interrupt-cells = <1>;
>> -		interrupt-controller;
>> -		pinctrl-single,register-width = <32>;
>> -		pinctrl-single,function-mask = <0xffffffff>;
>> -	};
>> -
>>   	ocp {
>>   		compatible = "ti,am4372-l3-noc", "simple-bus";
>>   		#address-cells = <1>;
>> @@ -84,29 +68,58 @@
>>   		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>>   			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>
>> -		prcm: prcm@44df0000 {
>> -			compatible = "ti,am4-prcm";
>> -			reg = <0x44df0000 0x11000>;
>> -
>> -			prcm_clocks: clocks {
>> -				#address-cells = <1>;
>> -				#size-cells = <0>;
>> -			};
>> +		l4_wkup: l4_wkup@44c00000 {
>> +			compatible = "ti,am4-l4-wkup", "simple-bus";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0x44c00000 0x287000>;
>>
>> -			prcm_clockdomains: clockdomains {
>> -			};
>> -		};
>> +			prcm: prcm@1f0000 {
>> +				compatible = "ti,am4-prcm";
>> +				reg = <0x1f0000 0x11000>;
>>
>> -		scrm: scrm@44e10000 {
>> -			compatible = "ti,am4-scrm";
>> -			reg = <0x44e10000 0x2000>;
>> +				prcm_clocks: clocks {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +				};
>>
>> -			scrm_clocks: clocks {
>> -				#address-cells = <1>;
>> -				#size-cells = <0>;
>> +				prcm_clockdomains: clockdomains {
>> +				};
>>   			};
>>
>> -			scrm_clockdomains: clockdomains {
>> +			scm: scm@210000 {
>> +				compatible = "ti,am4-scm", "simple-bus";
>> +				reg = <0x210000 0x1000>;
>
> Any reason for choosing a different size here compared to AM335x. Also,
> the scrm node above has 0x2000 as size. I found that I needed to
> increase the size to 0x2000 here to accomodate the wkup_m3_ipc node on
> top of your series. The node uses IPC registers which are part of the
> Control module, so on AM335x, I added it as a child node of scm, but
> here to do the same I have to correct the size. Also, there are some
> DISPPLL related registers at 0x3000 offset within the Control module,
> not sure where they would fit.

It looks like I shrank the size of the scm address-space based on 
current children on it. I'll increase this to 0x4000 to accommodate 
everything under the SCM. A separate syscon mapping needs to be created 
for the DISPPLL stuff if required.

-Tero

>
> regards
> Suman
>
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x210000 0x1000>;
>> +
>> +				am43xx_pinmux: pinmux@800 {
>> +					compatible = "ti,am437-padconf",
>> +						     "pinctrl-single";
>> +					reg = <0x800 0x31c>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					#interrupt-cells = <1>;
>> +					interrupt-controller;
>> +					pinctrl-single,register-width = <32>;
>> +					pinctrl-single,function-mask = <0xffffffff>;
>> +				};
>> +
>> +				scm_conf: scm_conf@0 {
>> +					compatible = "syscon";
>> +					reg = <0x0 0x7fc>;
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +
>> +					scm_clocks: clocks {
>> +						#address-cells = <1>;
>> +						#size-cells = <0>;
>> +					};
>> +				};
>> +
>> +				scm_clockdomains: clockdomains {
>> +				};
>>   			};
>>   		};
>>
>
> [snip]
>

