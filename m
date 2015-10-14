From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH 4/5] ARM: dts: am437x/am33xx/omap3/dm816x: Add gpmc dma
 channel
Date: Wed, 14 Oct 2015 08:57:04 -0500
Message-ID: <561E5F30.80302@ti.com>
References: <1444700338-27582-1-git-send-email-fcooper@ti.com>
 <1444700338-27582-5-git-send-email-fcooper@ti.com> <561E4019.7090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <561E4019.7090904@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org



On 10/14/2015 06:44 AM, Roger Quadros wrote:
> On 13/10/15 04:38, Franklin S Cooper Jr wrote:
>> Add dma channel information to the gpmc. Although not enabled by
>> default this will allow prefetch-dma to be used.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>>  arch/arm/boot/dts/am33xx.dtsi | 2 ++
>>  arch/arm/boot/dts/am4372.dtsi | 2 ++
>>  arch/arm/boot/dts/dm816x.dtsi | 2 ++
>>  arch/arm/boot/dts/omap3.dtsi  | 2 ++
> How about fixing up omap4/5 and dra7 as well?

Shouldn't be a problem for omap4 and omap5.

Dra7 with sdma can't support this feature. With edma it works fine. So I'll
wait until edma support for dra7 makes it into mainline and then I can send
a new patch adding support.
>
> cheers,
> -roger
>
>>  4 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>> index e065f21..f2d8eed 100644
>> --- a/arch/arm/boot/dts/am33xx.dtsi
>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>> @@ -819,6 +819,8 @@
>>  			ti,no-idle-on-init;
>>  			reg = <0x50000000 0x2000>;
>>  			interrupts = <100>;
>> +			dmas = <&edma 52>;
>> +			dma-names = "rxtx";
>>  			gpmc,num-cs = <7>;
>>  			gpmc,num-waitpins = <2>;
>>  			#address-cells = <2>;
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ec8b7a3..c02061b 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -841,6 +841,8 @@
>>  		gpmc: gpmc@50000000 {
>>  			compatible = "ti,am3352-gpmc";
>>  			ti,hwmods = "gpmc";
>> +			dmas = <&edma 52>;
>> +			dma-names = "rxtx";
>>  			clocks = <&l3s_gclk>;
>>  			clock-names = "fck";
>>  			reg = <0x50000000 0x2000>;
>> diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
>> index 68fb444..d2e5d31 100644
>> --- a/arch/arm/boot/dts/dm816x.dtsi
>> +++ b/arch/arm/boot/dts/dm816x.dtsi
>> @@ -180,6 +180,8 @@
>>  			#address-cells = <2>;
>>  			#size-cells = <1>;
>>  			interrupts = <100>;
>> +			dmas = <&edma 52>;
>> +			dma-names = "rxtx";
>>  			gpmc,num-cs = <6>;
>>  			gpmc,num-waitpins = <2>;
>>  			gpio-controller;
>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>> index 7f212b6..9dbbcf6 100644
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -717,6 +717,8 @@
>>  			ti,hwmods = "gpmc";
>>  			reg = <0x6e000000 0x02d0>;
>>  			interrupts = <20>;
>> +			dmas = <&sdma 4>;
>> +			dma-names = "rxtx";
>>  			gpmc,num-cs = <8>;
>>  			gpmc,num-waitpins = <4>;
>>  			#address-cells = <2>;
>>
