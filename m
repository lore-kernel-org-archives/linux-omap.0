From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v3] ARM: dts: add minimal DT support for Nokia N950 &
 N9 phones
Date: Fri, 18 Oct 2013 17:57:17 +0200
Message-ID: <52615A5D.7030002@baylibre.com>
References: <1381869369-14626-1-git-send-email-aaro.koskinen@iki.fi>
 <20131016003536.GA15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131016003536.GA15154@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 16/10/2013 02:35, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [131015 13:36]:
>> Add minimal DT support for Nokia N950 & N9 phones. The same functionality
>> that is provided by the current board file should work: serial console,
>> USB, OneNAND and MMC.
>>
>> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Oh this is not yet merged, I'll pick this one into the
> omap-for-v3.13/board-removal as the board removal patch is
> already there.

Just to be sure. Does that mean that you'll take care of that one, and =

thus I do not have to queue it?

Thanks,
Benoit

> Regards,
>
> Tony
>
>> ---
>>
>> 	v3: Added Tony's ACK & properties for generic USB PHY framework.
>>
>> 	Previous version: http://marc.info/?t=3D138005105700010&r=3D1&w=3D2
>>
>>   arch/arm/boot/dts/Makefile           |   2 +
>>   arch/arm/boot/dts/omap3-n9.dts       |  18 ++++
>>   arch/arm/boot/dts/omap3-n950-n9.dtsi | 174 +++++++++++++++++++++++++++=
++++++++
>>   arch/arm/boot/dts/omap3-n950.dts     |  18 ++++
>>   4 files changed, 212 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/omap3-n9.dts
>>   create mode 100644 arch/arm/boot/dts/omap3-n950-n9.dtsi
>>   create mode 100644 arch/arm/boot/dts/omap3-n950.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 9df7d2c..62d0f4d 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -177,6 +177,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.dtb \
>>   	omap3-gta04.dtb \
>>   	omap3-igep0020.dtb \
>>   	omap3-igep0030.dtb \
>> +	omap3-n9.dtb \
>> +	omap3-n950.dtb \
>>   	omap4-panda.dtb \
>>   	omap4-panda-a4.dtb \
>>   	omap4-panda-es.dtb \
>> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9=
.dts
>> new file mode 100644
>> index 0000000..39828ce
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-n9.dts
>> @@ -0,0 +1,18 @@
>> +/*
>> + * omap3-n9.dts - Device Tree file for Nokia N9
>> + *
>> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "omap3-n950-n9.dtsi"
>> +
>> +/ {
>> +	model =3D "Nokia N9";
>> +	compatible =3D "nokia,omap3-n9", "ti,omap3";
>> +};
>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/om=
ap3-n950-n9.dtsi
>> new file mode 100644
>> index 0000000..94eb77d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> @@ -0,0 +1,174 @@
>> +/*
>> + * omap3-n950-n9.dtsi - Device Tree file for Nokia N950 & N9 (common st=
uff)
>> + *
>> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include "omap36xx.dtsi"
>> +
>> +/ {
>> +	cpus {
>> +		cpu@0 {
>> +			cpu0-supply =3D <&vcc>;
>> +		};
>> +	};
>> +
>> +	memory {
>> +		device_type =3D "memory";
>> +		reg =3D <0x80000000 0x40000000>; /* 1 GB */
>> +	};
>> +
>> +	vemmc: fixedregulator@0 {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "VEMMC";
>> +		regulator-min-microvolt =3D <2900000>;
>> +		regulator-max-microvolt =3D <2900000>;
>> +		gpio =3D <&gpio5 29 0>; /* gpio line 157 */
>> +		startup-delay-us =3D <150>;
>> +		enable-active-high;
>> +	};
>> +};
>> +
>> +&omap3_pmx_core {
>> +	mmc2_pins: pinmux_mmc2_pins {
>> +		pinctrl-single,pins =3D <
>> +			0x128 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_clk */
>> +			0x12a (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_cmd */
>> +			0x12c (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat0 */
>> +			0x12e (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat1 */
>> +			0x130 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat2 */
>> +			0x132 (PIN_INPUT_PULLUP | MUX_MODE0) /* sdmmc2_dat3 */
>> +		>;
>> +	};
>> +};
>> +
>> +&i2c1 {
>> +	clock-frequency =3D <2900000>;
>> +
>> +	twl: twl@48 {
>> +		reg =3D <0x48>;
>> +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
>> +		interrupt-parent =3D <&intc>;
>> +	};
>> +};
>> +
>> +/include/ "twl4030.dtsi"
>> +
>> +&twl {
>> +	compatible =3D "ti,twl5031";
>> +};
>> +
>> +&twl_gpio {
>> +	ti,pullups	=3D <0x000001>; /* BIT(0) */
>> +	ti,pulldowns	=3D <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
>> +};
>> +
>> +&i2c2 {
>> +	clock-frequency =3D <400000>;
>> +};
>> +
>> +&i2c3 {
>> +	clock-frequency =3D <400000>;
>> +};
>> +
>> +&mmc1 {
>> +	status =3D "disabled";
>> +};
>> +
>> +&mmc2 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&mmc2_pins>;
>> +	vmmc-supply =3D <&vemmc>;
>> +	bus-width =3D <4>;
>> +	ti,non-removable;
>> +};
>> +
>> +&mmc3 {
>> +	status =3D "disabled";
>> +};
>> +
>> +&usb_otg_hs {
>> +	interface-type =3D <0>;
>> +	usb-phy =3D <&usb2_phy>;
>> +	phys =3D <&usb2_phy>;
>> +	phy-names =3D "usb2-phy";
>> +	mode =3D <3>;
>> +	power =3D <50>;
>> +};
>> +
>> +&gpmc {
>> +	ranges =3D <0 0 0x04000000 0x20000000>;
>> +
>> +	onenand@0,0 {
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <1>;
>> +		reg =3D <0 0 0x20000000>;
>> +
>> +		gpmc,sync-read;
>> +		gpmc,sync-write;
>> +		gpmc,burst-length =3D <16>;
>> +		gpmc,burst-read;
>> +		gpmc,burst-wrap;
>> +		gpmc,burst-write;
>> +		gpmc,device-width =3D <2>;
>> +		gpmc,mux-add-data =3D <2>;
>> +		gpmc,cs-on-ns =3D <0>;
>> +		gpmc,cs-rd-off-ns =3D <87>;
>> +		gpmc,cs-wr-off-ns =3D <87>;
>> +		gpmc,adv-on-ns =3D <0>;
>> +		gpmc,adv-rd-off-ns =3D <10>;
>> +		gpmc,adv-wr-off-ns =3D <10>;
>> +		gpmc,oe-on-ns =3D <15>;
>> +		gpmc,oe-off-ns =3D <87>;
>> +		gpmc,we-on-ns =3D <0>;
>> +		gpmc,we-off-ns =3D <87>;
>> +		gpmc,rd-cycle-ns =3D <112>;
>> +		gpmc,wr-cycle-ns =3D <112>;
>> +		gpmc,access-ns =3D <81>;
>> +		gpmc,page-burst-access-ns =3D <15>;
>> +		gpmc,bus-turnaround-ns =3D <0>;
>> +		gpmc,cycle2cycle-delay-ns =3D <0>;
>> +		gpmc,wait-monitoring-ns =3D <0>;
>> +		gpmc,clk-activation-ns =3D <5>;
>> +		gpmc,wr-data-mux-bus-ns =3D <30>;
>> +		gpmc,wr-access-ns =3D <81>;
>> +		gpmc,sync-clk-ps =3D <15000>;
>> +
>> +		/*
>> +		 * MTD partition table corresponding to Nokia's MeeGo 1.2
>> +		 * Harmattan release.
>> +		 */
>> +		partition@0 {
>> +			label =3D "bootloader";
>> +			reg =3D <0x00000000 0x00100000>;
>> +		};
>> +		partition@1 {
>> +			label =3D "config";
>> +			reg =3D <0x00100000 0x002c0000>;
>> +		};
>> +		partition@2 {
>> +			label =3D "kernel";
>> +			reg =3D <0x003c0000 0x01000000>;
>> +		};
>> +		partition@3 {
>> +			label =3D "log";
>> +			reg =3D <0x013c0000 0x00200000>;
>> +		};
>> +		partition@4 {
>> +			label =3D "var";
>> +			reg =3D <0x015c0000 0x1ca40000>;
>> +		};
>> +		partition@5 {
>> +			label =3D "moslo";
>> +			reg =3D <0x1e000000 0x02000000>;
>> +		};
>> +		partition@6 {
>> +			label =3D "omap2-onenand";
>> +			reg =3D <0x00000000 0x20000000>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-=
n950.dts
>> new file mode 100644
>> index 0000000..b076a52
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-n950.dts
>> @@ -0,0 +1,18 @@
>> +/*
>> + * omap3-n950.dts - Device Tree file for Nokia N950
>> + *
>> + * Written by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "omap3-n950-n9.dtsi"
>> +
>> +/ {
>> +	model =3D "Nokia N950";
>> +	compatible =3D "nokia,omap3-n950", "ti,omap3";
>> +};
>> --
>> 1.8.4.rc3
>>


-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
