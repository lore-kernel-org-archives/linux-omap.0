From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 08/33] ARM: dts: omap4 clock data
Date: Tue, 30 Jul 2013 14:27:47 -0500
Message-ID: <51F813B3.7020000@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-9-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38723 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab3G3T2P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 15:28:15 -0400
In-Reply-To: <1374564028-11352-9-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> This patch creates a unique node for each clock in the OMAP4 power,
> reset and clock manager (PRCM). OMAP443x and OMAP446x have slightly
> different clock tree which is taken into account in the data.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/boot/dts/omap443x-clocks.dtsi |   17 +
>   arch/arm/boot/dts/omap443x.dtsi        |    8 +
>   arch/arm/boot/dts/omap4460.dtsi        |    8 +
>   arch/arm/boot/dts/omap446x-clocks.dtsi |   27 +
>   arch/arm/boot/dts/omap44xx-clocks.dtsi | 1654 ++++++++++++++++++++++++++++++++
arch/arm/boot/dts/omap44xx-common-clocks.dtsi ?
>   5 files changed, 1714 insertions(+)
>   create mode 100644 arch/arm/boot/dts/omap443x-clocks.dtsi
>   create mode 100644 arch/arm/boot/dts/omap446x-clocks.dtsi
>   create mode 100644 arch/arm/boot/dts/omap44xx-clocks.dtsi
>
> diff --git a/arch/arm/boot/dts/omap443x-clocks.dtsi b/arch/arm/boot/dts/omap443x-clocks.dtsi
> new file mode 100644
> index 0000000..2bd82b2
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap443x-clocks.dtsi
> @@ -0,0 +1,17 @@
> +/*
> + * Device Tree Source for OMAP443x clock data
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
Doing
/include/ "omap44xx-clocks.dtsi" might avoid including that header in 
corresponding SoC dtsi,
OR:
> +bandgap_fclk: bandgap_fclk@4a307888 {
> +	#clock-cells = <0>;
> +	compatible = "gate-clock";
> +	clocks = <&sys_32k_ck>;
> +	bit-shift = <8>;
> +	reg = <0x4a307888 0x4>;
> +};

Since we already have omap443x.dtsi and omap446x.dtsi, do we need 
clock.dtsi containing just a few entries?
instead we could define the delta clocks in the clocks section, and save 
on two additional files, no?

[...]

> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> new file mode 100644
> index 0000000..ed6bc9b
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
[...]

> +dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@4a0041f0 {
> +	#clock-cells = <0>;
> +	compatible = "divider-clock";
> +	clocks = <&dpll_abe_x2_ck>;
> +	ti,autoidle-shift = <8>;
> +	reg = <0x4a0041f0 0x4>;
> +	bit-mask = <0x1f>;
> +	index-starts-at-one;
> +	ti,autoidle-low;
> +};
> +
> +abe_24m_fclk: abe_24m_fclk {
> +	#clock-cells = <0>;
> +	compatible = "fixed-factor-clock";
> +	clocks = <&dpll_abe_m2x2_ck>;
> +	clock-mult = <1>;
> +	clock-div = <8>;
> +};
> +
> +abe_clk: abe_clk@4a004108 {
> +	#clock-cells = <0>;
> +	compatible = "divider-clock";
> +	clocks = <&dpll_abe_m2x2_ck>;
> +	reg = <0x4a004108 0x4>;
> +	bit-mask = <0x3>;
> +	index-power-of-two;
> +};
> +
> +aess_fclk: aess_fclk@4a004528 {
is there a naming convention used here? abe_clk, fclk etc?

> +	#clock-cells = <0>;
> +	compatible = "divider-clock";
> +	clocks = <&abe_clk>;
> +	bit-shift = <24>;
> +	reg = <0x4a004528 0x4>;
> +	bit-mask = <0x1>;
> +};

[...]

> +
> +ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@4a0093e0 {
_ck?

[...]


-- 
Regards,
Nishanth Menon
