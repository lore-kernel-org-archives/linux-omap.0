From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 06/31] ARM: dts: omap4 clock data
Date: Mon, 19 Aug 2013 16:43:56 +0300
Message-ID: <5212211C.3050407@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-7-git-send-email-t-kristo@ti.com> <4452066.ogQpVHnZLL@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49165 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3HSNog (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 09:44:36 -0400
In-Reply-To: <4452066.ogQpVHnZLL@flatron>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 08/03/2013 05:16 PM, Tomasz Figa wrote:
> On Friday 02 of August 2013 19:25:25 Tero Kristo wrote:
>> This patch creates a unique node for each clock in the OMAP4 power,
>> reset and clock manager (PRCM). OMAP443x and OMAP446x have slightly
>> different clock tree which is taken into account in the data.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/boot/dts/omap443x-clocks.dtsi |   17 +
>>   arch/arm/boot/dts/omap443x.dtsi        |    8 +
>>   arch/arm/boot/dts/omap4460.dtsi        |    8 +
>>   arch/arm/boot/dts/omap446x-clocks.dtsi |   27 +
>>   arch/arm/boot/dts/omap44xx-clocks.dtsi | 1648
>> ++++++++++++++++++++++++++++++++ 5 files changed, 1708 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/omap443x-clocks.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap446x-clocks.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap44xx-clocks.dtsi
>>
>> diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi
>> b/arch/arm/boot/dts/omap443x-clocks.dtsi new file mode 100644
>> index 0000000..2bd82b2
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap443x-clocks.dtsi
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Device Tree Source for OMAP443x clock data
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as +
>> * published by the Free Software Foundation.
>> + */
>> +
>> +bandgap_fclk: bandgap_fclk@4a307888 {
>> +	#clock-cells = <0>;
>> +	compatible = "gate-clock";
>> +	clocks = <&sys_32k_ck>;
>> +	bit-shift = <8>;
>> +	reg = <0x4a307888 0x4>;
>> +};
>> diff --git a/arch/arm/boot/dts/omap443x.dtsi
>> b/arch/arm/boot/dts/omap443x.dtsi index bcf455e..dfd648c 100644
>> --- a/arch/arm/boot/dts/omap443x.dtsi
>> +++ b/arch/arm/boot/dts/omap443x.dtsi
>> @@ -30,4 +30,12 @@
>>   		       0x4a00232C 0x4>;
>>   		compatible = "ti,omap4430-bandgap";
>>   	};
>> +
>> +	clocks {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +		/include/ "omap44xx-clocks.dtsi"
>> +		/include/ "omap443x-clocks.dtsi"
>> +	};
>>   };
>> diff --git a/arch/arm/boot/dts/omap4460.dtsi
>> b/arch/arm/boot/dts/omap4460.dtsi index c2f0f39..d9d00b2 100644
>> --- a/arch/arm/boot/dts/omap4460.dtsi
>> +++ b/arch/arm/boot/dts/omap4460.dtsi
>> @@ -38,4 +38,12 @@
>>   		interrupts = <0 126 IRQ_TYPE_LEVEL_HIGH>; /* talert */
>>   		gpios = <&gpio3 22 0>; /* tshut */
>>   	};
>> +
>> +	clocks {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +		/include/ "omap44xx-clocks.dtsi"
>> +		/include/ "omap446x-clocks.dtsi"
>> +	};
>>   };
>> diff --git a/arch/arm/boot/dts/omap446x-clocks.dtsi
>> b/arch/arm/boot/dts/omap446x-clocks.dtsi new file mode 100644
>> index 0000000..86d0805
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap446x-clocks.dtsi
>> @@ -0,0 +1,27 @@
>> +/*
>> + * Device Tree Source for OMAP446x clock data
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as +
>> * published by the Free Software Foundation.
>> + */
>> +
>> +div_ts_ck: div_ts_ck@4a307888 {
>> +	#clock-cells = <0>;
>> +	compatible = "divider-clock";
>> +	clocks = <&l4_wkup_clk_mux_ck>;
>> +	bit-shift = <24>;
>> +	reg = <0x4a307888 0x4>;
>> +	table = < 8 0 >, < 16 1 >, < 32 2 >;
>> +	bit-mask = <0x3>;
>> +};
>> +
>> +bandgap_ts_fclk: bandgap_ts_fclk@4a307888 {
>> +	#clock-cells = <0>;
>> +	compatible = "gate-clock";
>> +	clocks = <&div_ts_ck>;
>> +	bit-shift = <8>;
>> +	reg = <0x4a307888 0x4>;
>> +};
>> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> b/arch/arm/boot/dts/omap44xx-clocks.dtsi new file mode 100644
>> index 0000000..23f623c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> @@ -0,0 +1,1648 @@
>> +/*
>> + * Device Tree Source for OMAP4 clock data
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as +
>> * published by the Free Software Foundation.
>> + */
>> +
>> +extalt_clkin_ck: extalt_clkin_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <59000000>;
>> +};
>> +
>> +pad_clks_src_ck: pad_clks_src_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <12000000>;
>> +};
>> +
>> +pad_clks_ck: pad_clks_ck@4a004108 {
>> +	#clock-cells = <0>;
>> +	compatible = "gate-clock";
>> +	clocks = <&pad_clks_src_ck>;
>> +	bit-shift = <8>;
>> +	reg = <0x4a004108 0x4>;
>> +};
>> +
>> +pad_slimbus_core_clks_ck: pad_slimbus_core_clks_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <12000000>;
>> +};
>> +
>> +secure_32k_clk_src_ck: secure_32k_clk_src_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <32768>;
>> +};
>> +
>> +slimbus_src_clk: slimbus_src_clk {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <12000000>;
>> +};
>> +
>> +slimbus_clk: slimbus_clk@4a004108 {
>> +	#clock-cells = <0>;
>> +	compatible = "gate-clock";
>> +	clocks = <&slimbus_src_clk>;
>> +	bit-shift = <10>;
>> +	reg = <0x4a004108 0x4>;
>> +};
>> +
>> +sys_32k_ck: sys_32k_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <32768>;
>> +};
>> +
>> +virt_12000000_ck: virt_12000000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <12000000>;
>> +};
>> +
>> +virt_13000000_ck: virt_13000000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <13000000>;
>> +};
>> +
>> +virt_16800000_ck: virt_16800000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <16800000>;
>> +};
>> +
>> +virt_19200000_ck: virt_19200000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <19200000>;
>> +};
>> +
>> +virt_26000000_ck: virt_26000000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <26000000>;
>> +};
>> +
>> +virt_27000000_ck: virt_27000000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <27000000>;
>> +};
>> +
>> +virt_38400000_ck: virt_38400000_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <38400000>;
>> +};
>> +
>> +sys_clkin_ck: sys_clkin_ck@4a306110 {
>> +	#clock-cells = <0>;
>> +	compatible = "mux-clock";
>> +	clocks = <&virt_12000000_ck>, <&virt_13000000_ck>,
>> <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>,
>> <&virt_27000000_ck>, <&virt_38400000_ck>; +	reg = <0x4a306110 0x4>;
>> +	bit-mask = <0x7>;
>> +	index-starts-at-one;
>> +};
>> +
>> +tie_low_clock_ck: tie_low_clock_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <0>;
>> +};
>> +
>> +utmi_phy_clkout_ck: utmi_phy_clkout_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <60000000>;
>> +};
>> +
>> +xclk60mhsp1_ck: xclk60mhsp1_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <60000000>;
>> +};
>> +
>> +xclk60mhsp2_ck: xclk60mhsp2_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <60000000>;
>> +};
>> +
>> +xclk60motg_ck: xclk60motg_ck {
>> +	#clock-cells = <0>;
>> +	compatible = "fixed-clock";
>> +	clock-frequency = <60000000>;
>> +};
>> +
>> +abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@4a306108 {
>> +	#clock-cells = <0>;
>> +	compatible = "mux-clock";
>> +	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
>> +	bit-shift = <24>;
>> +	reg = <0x4a306108 0x4>;
>> +	bit-mask = <0x1>;
>> +};
>> +
>> +abe_dpll_refclk_mux_ck: abe_dpll_refclk_mux_ck@4a30610c {
>> +	#clock-cells = <0>;
>> +	compatible = "mux-clock";
>> +	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
>> +	reg = <0x4a30610c 0x4>;
>> +	bit-mask = <0x1>;
>> +};
>> +
>> +dpll_abe_ck: dpll_abe_ck@4a0041e0 {
>> +	#clock-cells = <0>;
>> +	compatible = "ti,omap4-dpll-m4xen-clock";
>> +	clocks = <&abe_dpll_refclk_mux_ck>, <&abe_dpll_bypass_clk_mux_ck>;
>> +	reg = <0x4a0041e0 0x4>, <0x4a0041e4 0x4>, <0x4a0041e8 0x4>,
>> <0x4a0041ec 0x4>; +	ti,clk-ref = <&abe_dpll_refclk_mux_ck>;
>> +	ti,clk-bypass = <&abe_dpll_bypass_clk_mux_ck>;
>
> Hmm, why do you need to pass references to other clocks using private
> properties? Is there a reason you can't use the clocks and clock-names
> properties defined by standard clock bindings?
>
> The same for other PLLs defined in this patch.

Will be changed for next rev, clk-bypass / clk-ref will be populated 
from clocks property directly.

-Tero
