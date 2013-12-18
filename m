From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: Add basic devices for AM3517-craneboard
Date: Wed, 18 Dec 2013 17:57:00 +0100
Message-ID: <52B1D3DC.1010304@baylibre.com>
References: <1386626150-23504-1-git-send-email-nm@ti.com> <52B0A9C8.7070201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:51588 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab3LRQ5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 11:57:05 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so8435460pdj.37
        for <linux-omap@vger.kernel.org>; Wed, 18 Dec 2013 08:57:04 -0800 (PST)
In-Reply-To: <52B0A9C8.7070201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Nishanth,

On 17/12/2013 20:45, Nishanth Menon wrote:
> On 12/09/2013 03:55 PM, Nishanth Menon wrote:
>> Craneboard is a hardware development platform based on the Sitara
>> AM3517 ARM Cortex - A8 microprocessor device - see [1] for more
>> details. Add basic devices for craneboard as replacement for the boa=
rd
>> file scheduled for removal as part of device tree conversion
>>
>> [1] http://craneboard.org
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>
> gentle ping.. had'nt seen a response on this patch. Could we queue
> this up for v3.14-rc1?

Yep, it looks good to me.
But if you don't mind I'll start pushing my branch after Xmas :-).

Thanks,
Benoit


>> Based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>> branch: omap-for-v3.14/omap3-board-removal 736e812 ARM: OMAP2+: Remo=
ve unused platform init code and headers
>>
>> Bootlog: http://pastebin.mozilla.org/3744412
>>
>>   arch/arm/boot/dts/Makefile              |    1 +
>>   arch/arm/boot/dts/am3517-craneboard.dts |  174 +++++++++++++++++++=
++++++++++++
>>   2 files changed, 175 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/am3517-craneboard.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index fc37bca..ad155fc 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -205,6 +205,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.dt=
b \
>>   	am335x-boneblack.dtb \
>>   	am335x-nano.dtb \
>>   	am335x-base0033.dtb \
>> +	am3517-craneboard.dtb \
>>   	am3517-evm.dtb \
>>   	am3517_mt_ventoux.dtb \
>>   	am43x-epos-evm.dtb \
>> diff --git a/arch/arm/boot/dts/am3517-craneboard.dts b/arch/arm/boot=
/dts/am3517-craneboard.dts
>> new file mode 100644
>> index 0000000..2d40b3f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/am3517-craneboard.dts
>> @@ -0,0 +1,174 @@
>> +/*
>> + * See craneboard.org for more details
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.t=
i.com/
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +#include "am3517.dtsi"
>> +
>> +/ {
>> +	model =3D "TI AM3517 CraneBoard (TMDSEVM3517)";
>> +	compatible =3D "ti,am3517-craneboard", "ti,am3517", "ti,omap3";
>> +
>> +	memory {
>> +		device_type =3D "memory";
>> +		reg =3D <0x80000000 0x10000000>;	/* 256 MB */
>> +	};
>> +
>> +	vbat: fixedregulator@0 {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vbat";
>> +		regulator-min-microvolt =3D <5000000>;
>> +		regulator-max-microvolt =3D <5000000>;
>> +		regulator-boot-on;
>> +	};
>> +};
>> +
>> +&davinci_emac {
>> +	status =3D "okay";
>> +};
>> +
>> +&davinci_mdio {
>> +	status =3D "okay";
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency =3D <2600000>;
>> +
>> +	tps: tps@2d {
>> +		reg =3D <0x2d>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency =3D <400000>;
>> +	/* goes to expansion connector */
>> +	status =3D "disabled";
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency =3D <400000>;
>> +	/* goes to expansion connector */
>> +	status =3D "disabled";
>> +};
>> +
>> +&mmc1 {
>> +	vmmc-supply =3D <&vdd2_reg>;
>> +	bus-width =3D <8>;
>> +};
>> +
>> +&mmc2 {
>> +	/* goes to expansion connector */
>> +	status =3D "disabled";
>> +};
>> +
>> +&mmc3 {
>> +	/* goes to expansion connector */
>> +	status =3D "disabled";
>> +};
>> +
>> +#include "tps65910.dtsi"
>> +
>> +&omap3_pmx_core {
>> +	tps_pins: pinmux_tps_pins {
>> +		pinctrl-single,pins =3D <
>> +			0x1b0 (PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq.sys_nirq */
>> +		>;
>> +	};
>> +};
>> +
>> +&tps {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&tps_pins>;
>> +
>> +	interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
>> +	interrupt-parent =3D <&intc>;
>> +
>> +	ti,en-ck32k-xtal;
>> +
>> +	vcc1-supply =3D <&vbat>;
>> +	vcc2-supply =3D <&vbat>;
>> +	vcc3-supply =3D <&vbat>;
>> +	vcc4-supply =3D <&vbat>;
>> +	vcc5-supply =3D <&vbat>;
>> +	vcc6-supply =3D <&vbat>;
>> +	vcc7-supply =3D <&vbat>;
>> +	vccio-supply =3D <&vbat>;
>> +
>> +	regulators {
>> +		vrtc_reg: regulator@0 {
>> +			regulator-always-on;
>> +		};
>> +
>> +		vio_reg: regulator@1 {
>> +			regulator-always-on;
>> +		};
>> +
>> +		/*
>> +		 * Unused:
>> +		 * VDIG1=3D2.7V,300mA max
>> +		 * VDIG2=3D1.8V,300mA max
>> +		 */
>> +
>> +		vpll_reg: regulator@7 {
>> +			/* VDDS_DPLL_1V8 */
>> +			regulator-min-microvolt =3D <1800000>;
>> +			regulator-max-microvolt =3D <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vaux1_reg: regulator@9 {
>> +			/* VDDS_SRAM_1V8 */
>> +			regulator-min-microvolt =3D <1800000>;
>> +			regulator-max-microvolt =3D <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vaux2_reg: regulator@10 {
>> +			/* VDDA1P8V_USBPHY */
>> +			regulator-min-microvolt =3D <1800000>;
>> +			regulator-max-microvolt =3D <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		/* VAUX33 unused */
>> +
>> +		vdac_reg: regulator@8 {
>> +			/* VDDA_DAC_1V8 */
>> +			regulator-min-microvolt =3D <1800000>;
>> +			regulator-max-microvolt =3D <1800000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vmmc_reg: regulator@12 {
>> +			/* VDDA3P3V_USBPHY */
>> +			regulator-min-microvolt =3D <3300000>;
>> +			regulator-max-microvolt =3D <3300000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vdd1_reg: regulator@2 {
>> +			/* VDD_CORE */
>> +			regulator-name =3D "vdd_core";
>> +			regulator-min-microvolt =3D <1200000>;
>> +			regulator-max-microvolt =3D <1200000>;
>> +			regulator-boot-on;
>> +			regulator-always-on;
>> +		};
>> +
>> +		vdd2_reg: regulator@3 {
>> +			/* VDDSHV_3V3 */
>> +			regulator-name =3D "vdd_shv";
>> +			regulator-min-microvolt =3D <3300000>;
>> +			regulator-max-microvolt =3D <3300000>;
>> +			regulator-always-on;
>> +		};
>> +
>> +		/* VDD3 unused */
>> +	};
>> +};
>>
>
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
