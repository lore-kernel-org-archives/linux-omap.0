From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 08/33] ARM: dts: omap4 clock data
Date: Wed, 31 Jul 2013 17:49:28 +0300
Message-ID: <51F923F8.6080700@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-9-git-send-email-t-kristo@ti.com> <51F813B3.7020000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F813B3.7020000@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 10:27 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
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
>>   arch/arm/boot/dts/omap44xx-clocks.dtsi | 1654
>> ++++++++++++++++++++++++++++++++
> arch/arm/boot/dts/omap44xx-common-clocks.dtsi ?
>>   5 files changed, 1714 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/omap443x-clocks.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap446x-clocks.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap44xx-clocks.dtsi
>>
>> diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi
>> b/arch/arm/boot/dts/omap443x-clocks.dtsi
>> new file mode 100644
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
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
> Doing
> /include/ "omap44xx-clocks.dtsi" might avoid including that header in
> corresponding SoC dtsi,
> OR:
>> +bandgap_fclk: bandgap_fclk@4a307888 {
>> +    #clock-cells = <0>;
>> +    compatible = "gate-clock";
>> +    clocks = <&sys_32k_ck>;
>> +    bit-shift = <8>;
>> +    reg = <0x4a307888 0x4>;
>> +};
>
> Since we already have omap443x.dtsi and omap446x.dtsi, do we need
> clock.dtsi containing just a few entries?
> instead we could define the delta clocks in the clocks section, and save
> on two additional files, no?

Yea, thats also possible. I didn't want to put clock nodes there though, 
just for clarity. I think this is for whoever is maintaining the DTS 
files to answer.

>
> [...]
>
>> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> b/arch/arm/boot/dts/omap44xx-clocks.dtsi
>> new file mode 100644
>> index 0000000..ed6bc9b
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> [...]
>
>> +dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@4a0041f0 {
>> +    #clock-cells = <0>;
>> +    compatible = "divider-clock";
>> +    clocks = <&dpll_abe_x2_ck>;
>> +    ti,autoidle-shift = <8>;
>> +    reg = <0x4a0041f0 0x4>;
>> +    bit-mask = <0x1f>;
>> +    index-starts-at-one;
>> +    ti,autoidle-low;
>> +};
>> +
>> +abe_24m_fclk: abe_24m_fclk {
>> +    #clock-cells = <0>;
>> +    compatible = "fixed-factor-clock";
>> +    clocks = <&dpll_abe_m2x2_ck>;
>> +    clock-mult = <1>;
>> +    clock-div = <8>;
>> +};
>> +
>> +abe_clk: abe_clk@4a004108 {
>> +    #clock-cells = <0>;
>> +    compatible = "divider-clock";
>> +    clocks = <&dpll_abe_m2x2_ck>;
>> +    reg = <0x4a004108 0x4>;
>> +    bit-mask = <0x3>;
>> +    index-power-of-two;
>> +};
>> +
>> +aess_fclk: aess_fclk@4a004528 {
> is there a naming convention used here? abe_clk, fclk etc?

The clock names are directly converted from existing data, so whatever 
currently is there, will be in the DT also.

>
>> +    #clock-cells = <0>;
>> +    compatible = "divider-clock";
>> +    clocks = <&abe_clk>;
>> +    bit-shift = <24>;
>> +    reg = <0x4a004528 0x4>;
>> +    bit-mask = <0x1>;
>> +};
>
> [...]
>
>> +
>> +ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@4a0093e0 {
> _ck?
>
> [...]
>
>
