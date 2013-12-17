From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 21/41] ARM: dts: omap4 clock data
Date: Tue, 17 Dec 2013 11:57:36 +0200
Message-ID: <52B02010.2060307@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-22-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312170934180.14039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35697 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab3LQJ6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 04:58:07 -0500
In-Reply-To: <alpine.DEB.2.02.1312170934180.14039@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/17/2013 11:44 AM, Paul Walmsley wrote:
> On Tue, 26 Nov 2013, Tero Kristo wrote:
>
>> This patch creates a unique node for each clock in the OMAP4 power,
>> reset and clock manager (PRCM). OMAP443x and OMAP446x have slightly
>> different clock tree which is taken into account in the data.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> ...
>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index a1e0585..c2e3993 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -107,6 +107,34 @@
>>   		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>>   			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>
>> +		cm1: cm1@4a004000 {
>> +			compatible = "ti,clock-master";
>
> These devices are low-level IP blocks, and should have accurate compatible
> strings like any other low-level IP block.  At some point in the future,
> these IP blocks will have device driver code that matches up with these DT
> nodes, and is probed via these compatible strings.  These should be
> corrected now, so unnecessary DT data synchronization problems don't
> appear with later kernels.
>
> So this should be something like:
>
> compatible = "ti,omap4-cm1";
>
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x4a004000 0x2000>;
>> +		};
>> +
>> +		prm: prm@4a306000 {
>> +			compatible = "ti,clock-master";
>
> Similarly this should be
>
> compatible = "ti,omap4-prm";

How about just adding dual compatible strings? Keep the current one and 
add the other as extra.

	compatible = "ti,clock-master", "ti,omap4-prm";

Easier to handle it this way.

>
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x4a306000 0x3000>;
>> +		};
>> +
>> +		cm2: cm2@4a008000 {
>> +			compatible = "ti,clock-master";
>
> compatible = "ti,omap4-cm2";
>
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0x4a008000 0x3000>;
>> +		};
>> +
>> +		scrm: scrm@4a30a000 {
>> +			compatible = "ti,clock-master";
>
> compatible = "ti,omap4-scrm";
>
>
> ...
>
>> diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi b/arch/arm/boot/dts/omap443x-clocks.dtsi
>> new file mode 100644
>> index 0000000..643755b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap443x-clocks.dtsi
>> @@ -0,0 +1,18 @@
>> +/*
>> + * Device Tree Source for OMAP4 clock data
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +&prm {
>> +	bandgap_fclk: bandgap_fclk {
>> +		#clock-cells = <0>;
>> +		compatible = "ti,gate-clock";
>> +		clocks = <&sys_32k_ck>;
>> +		ti,bit-shift = <8>;
>> +		reg = <0x1888>;
>> +	};
>
> So we've already discussed that clocks should be moved underneath
> separate "clocks {" node in the IP block data.  And similarly...

Yeah, I have actually wip v11 which has this done. I ended up creating 
this though:

...
    prm {
       prm_clocks: clocks {

       };
    };

... and references like:

&prm_clocks {

};

It seems the references to existing clocks {} nodes is impossible 
otherwise as I need to add some extra clocks to these.

>
>> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> new file mode 100644
>> index 0000000..2b59d54
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>
> ...
>
>> +	emu_sys_clkdm: emu_sys_clkdm {
>> +		compatible = "ti,clockdomain";
>> +		clocks = <&trace_clk_div_ck>;
>> +	};
>
> ... all of the clockdomains should be moved underneath "clockdomains {"
> nodes in the IP block DT data.

Ok that can be done.

>
>
> - Paul
>

