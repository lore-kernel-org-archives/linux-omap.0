From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] arm, am335x: add support for Moxa UC-8100-ME-T open platform
Date: Wed, 2 Aug 2017 00:07:59 -0500
Message-ID: <CAOCHtYgq-vJve2eeD9pfM3F4bBCV00cC8+9K2Z5LbgjD-JD7qw@mail.gmail.com>
References: <20170801112650.7566-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801112650.7566-1-sz.lin@moxa.com>
Sender: linux-kernel-owner@vger.kernel.org
To: SZ Lin <sz.lin@moxa.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "tony@atomide.com" <tony@atomide.com>, devicetree <devicetree@vger.kernel.org>, linux kernel <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 1, 2017 at 6:26 AM, SZ Lin <sz.lin@moxa.com> wrote:
> Add support for Moxa UC-8100-ME-T open platform
>
> The UC-8100-ME-T computing platform is designed
> for embedded data acquisition industrial applications
>
> The features of UC-8100-ME-T series are:
> * eMMC
> * SPI flash
> * SD slot
> * 2x LAN
> * 2 RS-232/422/485 ports, software-selectable
> * Mini PCIe form factor with USB signal
> * USB host
> * EEPROM
> * TPM
> * Watchdog
> * RTC
> * User gpio-keys
> * User LEDs
> * User button
>
> Signed-off-by: SZ Lin <sz.lin@moxa.com>
> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     | 525 +++++++++++++++=
++++++
>  3 files changed, 529 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Docume=
ntation/devicetree/bindings/arm/omap/omap.txt
> index 8219b2c6bb29..72ad8700156a 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -154,6 +154,9 @@ Boards:
>  - AM335X phyCORE-AM335x: Development kit
>    compatible =3D "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "=
ti,am33xx"
>
> +- AM335X UC-8100-ME-T: Communication-centric industrial computing platfo=
rm
> +  compatible =3D "moxa,uc-8100-me-t", "ti,am33xx";
> +
>  - OMAP5 EVM : Evaluation Module
>    compatible =3D "ti,omap5-evm", "ti,omap5"
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35dc9a7..2e60f4947c96 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -618,6 +618,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
>         am335x-icev2.dtb \
>         am335x-lxm.dtb \
>         am335x-nano.dtb \
> +       am335x-moxa-uc-8100-me-t.dtb \
>         am335x-pepper.dtb \
>         am335x-phycore-rdk.dtb \
>         am335x-shc.dtb \
> diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/bo=
ot/dts/am335x-moxa-uc-8100-me-t.dts
> new file mode 100644
> index 000000000000..9a7a421b0d6b
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
> @@ -0,0 +1,525 @@
> +/*
> + * Copyright (C) 2017 MOXA Inc. - https://www.moxa.com/
> + *
> + * Author: SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) <sz.lin@moxa.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +
> +/ {
> +       model =3D "Moxa UC-8100-ME-T";
> +       compatible =3D "moxa,uc-8100-me-t", "ti,am33xx";
> +
> +       cpus {
> +               cpu@0 {
> +                       cpu0-supply =3D <&vdd1_reg>;
> +               };
> +       };
> +
> +       memory {
> +               device_type =3D "memory";
> +               reg =3D <0x80000000 0x20000000>; /* 512 MB */
> +       };
> +
> +       vbat: fixedregulator@0 {
> +               compatible =3D "regulator-fixed";
> +       };
> +
> +       /* Power supply provides a fixed 3.3V @3A */
> +       vmmcsd_fixed: fixedregulator@1 {
> +             compatible =3D "regulator-fixed";
> +             regulator-name =3D "vmmcsd_fixed";
> +             regulator-min-microvolt =3D <3300000>;
> +             regulator-max-microvolt =3D <3300000>;
> +             regulator-boot-on;
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +               led@1 {


Please remove the un-needed @ in led@x's

see for example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/arm/boot/dts/am335x-bone-common.dtsi?h=3Dv4.13-rc3&id=3Dc731abd99121cae=
0b9a1735c062c96c56e2b72fc

> +                       label =3D "uc8100me:CEL1";
> +                       gpios =3D <&gpio_xten 8 0>;
> +                       default-state =3D "off";
> +               };
> +
> +               led@2 {
> +                       label =3D "uc8100me:CEL2";
> +                       gpios =3D <&gpio_xten 9 0>;
> +                       default-state =3D "off";
> +               };
> +
> +               led@3 {
> +                       label =3D "uc8100me:CEL3";
> +                       gpios =3D <&gpio_xten 10 0>;
> +                       default-state =3D "off";
> +               };
> +
> +               led@4 {
> +                       label =3D "uc8100me:DIA1";
> +                       gpios =3D <&gpio_xten 11 0>;
> +                       default-state =3D "off";
> +               };
> +               led@5 {
> +                       label =3D "uc8100me:DIA2";
> +                       gpios =3D <&gpio_xten 12 0>;
> +                       default-state =3D "off";
> +               };
> +               led@6 {
> +                       label =3D "uc8100me:DIA3";
> +                       gpios =3D <&gpio_xten 13 0>;
> +                       default-state =3D "off";
> +               };
> +               led@7 {
> +                       label =3D "uc8100me:SD";
> +                       gpios =3D <&gpio_xten 14 0>;
> +                       default-state =3D "off";
> +               };
> +               led@8 {
> +                       label =3D "uc8100me:USB";
> +                       gpios =3D <&gpio_xten 15 0>;
> +                       default-state =3D "off";
> +               };
> +               led@9 {
> +                       label =3D "uc8100me:USER";
> +                       gpios =3D <&gpio0 20 GPIO_ACTIVE_HIGH>;
> +                       default-state =3D "off";
> +               };
> +       };
> +
> +       buttons: push_button {
> +               compatible =3D "gpio-keys";
> +       };
> +
> +};
> +
> +&am33xx_pinmux {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&minipcie_pins>;
> +
> +       minipcie_pins: pinmux_minipcie {
> +               pinctrl-single,pins =3D <
> +                       0xe8 (PIN_INPUT_PULLDOWN | MUX_MODE7)   /* lcd_pc=
lk.gpio2_24 */
> +                       0xec (PIN_INPUT_PULLDOWN | MUX_MODE7)   /* lcd_ac=
_bias_en.gpio2_25 */
> +                       0xe0 (PIN_INPUT_PULLDOWN | MUX_MODE7)   /* lcd_vs=
ync.gpio2_22  Power off PIN*/

please use the AM33XX_IOPAD macros:

example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/a=
rch/arm/boot/dts/am335x-bone-common.dtsi?h=3Dv4.13-rc3&id=3De03b2a26d6bf93d=
1631aa36985892877986ee7b9

> +               >;
> +       };
> +
> +       push_button_pins: pinmux_push_button {
> +               pinctrl-single,pins =3D <
> +                       0x1ac (PIN_INPUT_PULLDOWN | MUX_MODE7)  /* mcasp0=
_ahcklx.gpio3_21 */
> +               >;
> +       };
> +
> +       i2c0_pins: pinmux_i2c0_pins {
> +               pinctrl-single,pins =3D <
> +                       0x188 (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_s=
da.i2c0_sda */
> +                       0x18c (PIN_INPUT_PULLUP | MUX_MODE0)    /* i2c0_s=
cl.i2c0_scl */
> +               >;
> +       };
> +
> +
> +       i2c1_pins: pinmux_i2c1_pins {
> +               pinctrl-single,pins =3D <
> +                       0x168 (PIN_INPUT_PULLUP | MUX_MODE3)    /* uart0_=
ctsn.i2c1_sda */
> +                       0x16c (PIN_INPUT_PULLUP | MUX_MODE3)    /* uart0_=
rtsn.i2c1_scl */
> +               >;
> +       };
> +
> +       uart0_pins: pinmux_uart0_pins {
> +               pinctrl-single,pins =3D <
> +                       0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_=
rxd.uart0_rxd */
> +                       0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_=
txd.uart0_txd */
> +               >;
> +       };
> +
> +       uart1_pins: pinmux_uart1_pins {
> +               pinctrl-single,pins =3D <
> +                       0x178 (PIN_INPUT | MUX_MODE0)           /* uart1_=
ctsn.uart1_ctsn */
> +                       0x17C (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_=
rtsn.uart1_rtsn */
> +                       0x180 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_=
rxd.uart1_rxd */
> +                       0x184 (PIN_OUTPUT | MUX_MODE0)          /* uart1_=
txd.uart1_txd */
> +               >;
> +       };
> +
> +       uart2_pins: pinmux_uart2_pins {
> +               pinctrl-single,pins =3D <
> +                       0xd8 (PIN_INPUT | MUX_MODE6)            /* lcd_da=
ta14.uart5_ctsn */
> +                       0xdc (PIN_OUTPUT_PULLDOWN | MUX_MODE6)  /* lcd_da=
ta15.uart5_rtsn */
> +                       0xc4 (PIN_INPUT_PULLUP | MUX_MODE4)     /* lcd_da=
ta9.uart5_rxd */
> +                       0xc0 (PIN_OUTPUT | MUX_MODE4)           /* lcd_da=
ta8.uart5_txd */
> +               >;
> +       };
> +
> +       cpsw_default: cpsw_default {
> +               pinctrl-single,pins =3D <
> +                       /* Slave 1 */
> +                       0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_c=
rs.rmii1_crs_dv */
> +                       0x110 (PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_r=
xerr.rmii1_rxerr */
> +                       0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_t=
xen.rmii1_txen */
> +                       0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_t=
xd1.rmii1_txd1 */
> +                       0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_t=
xd0.rmii1_txd0 */
> +                       0x13c (PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_r=
xd1.rmii1_rxd1 */
> +                       0x140 (PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_r=
xd0.rmii1_rxd0 */
> +                       0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mii1_r=
efclk.rmii1_refclk */
> +
> +                       /* Slave 2 */
> +                       0x70 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_=
crs_dv */
> +                       0x74 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_=
rxer */
> +                       0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_=
txen */
> +                       0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_=
td1 */
> +                       0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_=
td0 */
> +                       0x68 (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_=
rd1 */
> +                       0x6c (PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_=
rd0 */
> +                       0x108 (PIN_INPUT_PULLDOWN | MUX_MODE1)  /* rmii2_=
refclk */
> +
> +               >;
> +       };
> +
> +       davinci_mdio_default: davinci_mdio_default {
> +               pinctrl-single,pins =3D <
> +                       /* MDIO */
> +                       0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MOD=
E0)    /* mdio_data.mdio_data */
> +                       0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)            =
       /* mdio_clk.mdio_clk */
> +               >;
> +       };
> +
> +       mmc0_pins_default: pinmux_mmc0_pins {
> +               pinctrl-single,pins =3D <
> +                       0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)     /* mmc0_d=
at3 */
> +                       0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)     /* mmc0_d=
at2 */
> +                       0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)     /* mmc0_d=
at1 */
> +                       0xfc (PIN_INPUT_PULLUP | MUX_MODE0)     /* mmc0_d=
at0 */
> +                       0x100 (PIN_INPUT_PULLUP | MUX_MODE0)    /* mmc0_c=
lk */
> +                       0x104 (PIN_INPUT_PULLUP | MUX_MODE0)    /* mmc0_c=
md */
> +                       0x190 (PIN_INPUT_PULLUP | MUX_MODE7)    /* mcasp0=
_aclkx.gpio3_14 */
> +                       0x1a0 (PIN_INPUT_PULLUP | MUX_MODE7)    /* mcasp0=
_aclkx.gpio3_18 */
> +               >;
> +       };
> +
> +       mmc2_pins_default: pinmux_mmc2_pins {
> +               pinctrl-single,pins =3D <
> +                       /* eMMC */
> +                       0x30 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d12.mmc2_dat0 */
> +                       0x34 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d13.mmc2_dat1 */
> +                       0x38 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d14.mmc2_dat2 */
> +                       0x3c (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d15.mmc2_dat3 */
> +                       0x20 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d8.mmc2_dat4 */
> +                       0x24 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d9.mmc2_dat5 */
> +                       0x28 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d10.mmc2_dat6 */
> +                       0x2c (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_a=
d11.mmc2_dat7 */
> +                       0x88 (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_c=
sn3.mmc2_cmd */
> +                       0x8c (PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_c=
lk.mmc2_clk */
> +               >;
> +       };
> +
> +       spi0_pins: pinmux_spi0 {
> +               pinctrl-single,pins =3D <
> +                       0x150 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk=
.spi0_sclk */
> +                       0x15C (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.=
spi0_cs0 */
> +                       0x154 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.s=
pi0_d0 */
> +                       0x158 (PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.s=
pi0_d1 */
> +               >;
> +       };
> +
> +};
> +
> +&uart0 {
> +       /* Console */
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart0_pins>;
> +};
> +
> +&uart1 {
> +       /* UART 1 setting */
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart1_pins>;
> +};
> +
> +&uart5 {
> +       /* UART 2 setting */
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&uart2_pins>;
> +};
> +
> +&i2c0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c0_pins>;
> +
> +       status =3D "okay";
> +       clock-frequency =3D <400000>;
> +
> +       tpm: tpm@20 {
> +               compatible =3D "infineon,slb9645tt";
> +               reg =3D <0x20>;
> +       };
> +
> +       tps: tps@2d {
> +               compatible =3D "ti,tps65910";
> +               reg =3D <0x2d>;
> +       };
> +
> +       eeprom: eeprom@50 {
> +               compatible =3D "atmel,24c16";
> +               pagesize =3D <16>;
> +               reg =3D <0x50>;
> +       };
> +
> +       rtc_wdt: rtc_wdt@68 {
> +               compatible =3D "dallas,ds1374";
> +               reg =3D <0x68>;
> +       };
> +};
> +
> +&i2c1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&i2c1_pins>;
> +
> +       status =3D "okay";
> +       clock-frequency =3D <400000>;
> +       gpio_xten: gpio_xten@27 {
> +               compatible =3D "nxp,pca9535";
> +               gpio-controller;
> +               #gpio-cells =3D <2>;
> +               reg =3D <0x27>;
> +       };
> +};
> +
> +&usb {
> +       status =3D "okay";
> +};
> +
> +&usb_ctrl_mod {
> +       status =3D "okay";
> +};
> +
> +&usb0_phy {
> +       status =3D "okay";
> +};
> +
> +&usb1_phy {
> +       status =3D "okay";
> +};
> +
> +&usb0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
> +
> +&usb1 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
> +
> +&cppi41dma  {
> +       status =3D "okay";
> +};
> +
> +#include "tps65910.dtsi"
> +
> +&tps {
> +       vcc1-supply =3D <&vbat>;
> +       vcc2-supply =3D <&vbat>;
> +       vcc3-supply =3D <&vbat>;
> +       vcc4-supply =3D <&vbat>;
> +       vcc5-supply =3D <&vbat>;
> +       vcc6-supply =3D <&vbat>;
> +       vcc7-supply =3D <&vbat>;
> +       vccio-supply =3D <&vbat>;
> +
> +       regulators {
> +               vrtc_reg: regulator@0 {
> +                       regulator-always-on;
> +               };
> +
> +               vio_reg: regulator@1 {
> +                       regulator-always-on;
> +               };
> +
> +               vdd1_reg: regulator@2 {
> +                       /* VDD_MPU voltage limits 0.95V - 1.26V with +/-4=
% tolerance */
> +                       regulator-name =3D "vdd_mpu";
> +                       regulator-min-microvolt =3D <912500>;
> +                       regulator-max-microvolt =3D <1378000>;
> +                       regulator-boot-on;
> +                       regulator-always-on;
> +               };
> +
> +               vdd2_reg: regulator@3 {
> +                       /* VDD_CORE voltage limits 0.95V - 1.1V with +/-4=
% tolerance */
> +                       regulator-name =3D "vdd_core";
> +                       regulator-min-microvolt =3D <912500>;
> +                       regulator-max-microvolt =3D <1150000>;
> +                       regulator-boot-on;
> +                       regulator-always-on;
> +               };
> +
> +               vdd3_reg: regulator@4 {
> +                       regulator-always-on;
> +               };
> +
> +               vdig1_reg: regulator@5 {
> +                       regulator-always-on;
> +               };
> +
> +               vdig2_reg: regulator@6 {
> +                       regulator-always-on;
> +               };
> +
> +               vpll_reg: regulator@7 {
> +                       regulator-always-on;
> +               };
> +
> +               vdac_reg: regulator@8 {
> +                       regulator-always-on;
> +               };
> +
> +               vaux1_reg: regulator@9 {
> +                       regulator-always-on;
> +               };
> +
> +               vaux2_reg: regulator@10 {
> +                       regulator-always-on;
> +               };
> +
> +               vaux33_reg: regulator@11 {
> +                       regulator-always-on;
> +               };
> +
> +               vmmc_reg: regulator@12 {
> +                       compatible =3D "regulator-fixed";
> +                       regulator-name =3D "vmmc_reg";
> +                       regulator-min-microvolt =3D <3300000>;
> +                       regulator-max-microvolt =3D <3300000>;
> +                       regulator-always-on;
> +               };
> +       };
> +};
> +
> +/* Power */
> +&vbat {
> +       regulator-name =3D "vbat";
> +       regulator-min-microvolt =3D <5000000>;
> +       regulator-max-microvolt =3D <5000000>;
> +};
> +
> +&mac {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&cpsw_default>;
> +       dual_emac =3D <1>;
> +       status =3D "okay";
> +};
> +
> +&davinci_mdio {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&davinci_mdio_default>;
> +       status =3D "okay";
> +};
> +
> +&cpsw_emac0 {
> +       status =3D "okay";
> +       phy_id =3D <&davinci_mdio>, <4>;
> +       phy-mode =3D "rmii";
> +       dual_emac_res_vlan =3D <1>;
> +};
> +
> +&cpsw_emac1 {
> +       status =3D "okay";
> +       phy_id =3D <&davinci_mdio>, <5>;
> +       phy-mode =3D "rmii";
> +       dual_emac_res_vlan =3D <2>;
> +};
> +
> +&phy_sel {
> +       reg=3D <0x44e10650 0xf5>;
> +       rmii-clock-ext;
> +};
> +
> +&sham {
> +       status =3D "okay";
> +};
> +
> +&aes {
> +       status =3D "okay";
> +};
> +
> +&gpio0 {
> +       ti,no-reset-on-init;
> +};
> +
> +&mmc1 {
> +       pinctrl-names =3D "default";
> +       vmmc-supply =3D <&vmmcsd_fixed>;
> +       bus-width =3D <4>;
> +       pinctrl-0 =3D <&mmc0_pins_default>;
> +       cd-gpios =3D <&gpio3 14 GPIO_ACTIVE_HIGH>;
> +       wp-gpios =3D <&gpio3 18 GPIO_ACTIVE_HIGH>;
> +       status =3D "okay";
> +};
> +
> +&mmc3 {
> +       dmas =3D <&edma_xbar 12 0 1
> +                       &edma_xbar 13 0 2>;
> +       dma-names =3D "tx", "rx";
> +       pinctrl-names =3D "default";
> +       vmmc-supply =3D <&vmmcsd_fixed>;
> +       bus-width =3D <8>;
> +       pinctrl-0 =3D <&mmc2_pins_default>;
> +       ti,non-removable;
> +       status =3D "okay";
> +};
> +
> +&buttons {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&push_button_pins>;
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       button@0 {
> +               label =3D "push_button";
> +               linux,code =3D <0x100>;
> +               gpios =3D <&gpio3 21 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +/* SPI Busses */
> +&spi0 {
> +       status =3D "okay";
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&spi0_pins>;
> +
> +       m25p80@0 {
> +               compatible =3D "mx25l6405d";
> +               spi-max-frequency =3D <40000000>;
> +
> +               reg =3D <0>;
> +               spi-cpol;
> +               spi-cpha;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +
> +               /* reg : The partition's offset and size within the mtd b=
ank. */
> +               partitions@0 {
> +                       label =3D "MLO";
> +                       reg =3D <0x0 0x80000>;
> +               };
> +
> +               partitions@1 {
> +                       label =3D "U-Boot";
> +                       reg =3D <0x80000 0x100000>;
> +               };
> +
> +               partitions@2 {
> +                       label =3D "U-Boot Env";
> +                       reg =3D <0x180000 0x20000>;
> +               };
> +       };
> +};
> --
> 2.13.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
