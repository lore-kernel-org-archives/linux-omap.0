From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] arm: boot: dts: add DTS for Baltos IR5221
Date: Wed, 13 May 2015 17:37:30 +0200
Message-ID: <CAGm1_kvGASvTJ6RwKNVnG6=WQkB4_KwewOZ77K3EiR2DEM4WtQ@mail.gmail.com>
References: <1431468917-27697-1-git-send-email-balbi@ti.com>
 <20150513074002.0b7b8dda@ipc1.ka-ro> <20150513152904.GC4201@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36848 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965462AbbEMPhw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 11:37:52 -0400
Received: by pabsx10 with SMTP id sx10so54175699pab.3
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2015 08:37:51 -0700 (PDT)
In-Reply-To: <20150513152904.GC4201@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Wed, May 13, 2015 at 5:29 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, May 13, 2015 at 07:40:02AM +0200, Lothar Wa=C3=9Fmann wrote:
>> Hi,
>>
>> > From: Yegor Yefremov <yegorslists@googlemail.com>
>> >
>> > This device is an industrial PC based on
>> > AM335x SoC.
>> >
>> > [ balbi@ti.com : updated to fit current mainline ]
>> >
>> > Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > ---
>> >
>> > Note that this is just a respin of DTS available from [1]
>> >
>> > [1] https://github.com/visionsystemsgmbh/onrisc_br_bsp/blob/master=
/board/vscom/dts/3.15/onrisc-baltos-ir-5221.dts
>> >
>> >  arch/arm/boot/dts/Makefile          |   1 +
>> >  arch/arm/boot/dts/am335x-baltos.dts | 528 +++++++++++++++++++++++=
+++++++++++++
>> >  2 files changed, 529 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/am335x-baltos.dts
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefi=
le
>> > index 86217db2937a..941217b405e9 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -406,6 +406,7 @@ dtb-$(CONFIG_ARCH_OMAP3) +=3D \
>> >  dtb-$(CONFIG_SOC_TI81XX) +=3D \
>> >     dm8168-evm.dtb
>> >  dtb-$(CONFIG_SOC_AM33XX) +=3D \
>> > +   am335x-baltos.dtb \
>> >     am335x-base0033.dtb \
>> >     am335x-bone.dtb \
>> >     am335x-boneblack.dtb \
>> > diff --git a/arch/arm/boot/dts/am335x-baltos.dts b/arch/arm/boot/d=
ts/am335x-baltos.dts
>> > new file mode 100644
>> > index 000000000000..296965ab8bb5
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/am335x-baltos.dts
>> > @@ -0,0 +1,528 @@
>> > +/*
>> > + * Copyright (C) 2012 Texas Instruments Incorporated - http://www=
=2Eti.com/
>> > + *
>> > + * This program is free software; you can redistribute it and/or =
modify
>> > + * it under the terms of the GNU General Public License version 2=
 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +
>> > +/*
>> > + * VScom OnRISC
>> > + * http://www.vscom.de
>> > + */
>> > +
>> > +/dts-v1/;
>> > +
>> > +#include "am33xx.dtsi"
>> > +#include <dt-bindings/pwm/pwm.h>
>> > +
>> > +/ {
>> > +   model =3D "OnRISC Baltos iR 5221";
>> > +   compatible =3D "vscom,onrisc", "ti,am33xx";
>> > +
>> > +   cpus {
>> > +           cpu@0 {
>> > +                   cpu0-supply =3D <&vdd1_reg>;
>> > +           };
>> > +   };
>> > +
>> > +   memory {
>> > +           device_type =3D "memory";
>> > +           reg =3D <0x80000000 0x10000000>; /* 256 MB */
>> > +   };
>> > +
>> > +   vbat: fixedregulator@0 {
>> > +           compatible =3D "regulator-fixed";
>> > +           regulator-name =3D "vbat";
>> > +           regulator-min-microvolt =3D <5000000>;
>> > +           regulator-max-microvolt =3D <5000000>;
>> > +           regulator-boot-on;
>> > +   };
>> > +
>> > +   lis3_reg: fixedregulator@1 {
>> > +           compatible =3D "regulator-fixed";
>> > +           regulator-name =3D "lis3_reg";
>> > +           regulator-boot-on;
>> > +   };
>> > +
>> > +   wl12xx_vmmc: fixedregulator@2 {
>> > +           pinctrl-names =3D "default";
>> > +           pinctrl-0 =3D <&wl12xx_gpio>;
>> > +           compatible =3D "regulator-fixed";
>> > +           regulator-name =3D "vwl1271";
>> > +           regulator-min-microvolt =3D <3300000>;
>> > +           regulator-max-microvolt =3D <3300000>;
>> > +           gpio =3D <&gpio3 8 0>;
>> > +           startup-delay-us =3D <70000>;
>> > +           enable-active-high;
>> > +   };
>> > +};
>> > +
>> > +&am33xx_pinmux {
>> > +   mmc2_pins: pinmux_mmc2_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x020 (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_ad8.mmc1_dat0_mux0 */
>> > +                   0x024 (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_ad9.mmc1_dat1_mux0 */
>> > +                   0x028 (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_ad10.mmc1_dat2_mux0 */
>> > +                   0x02c (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_ad11.mmc1_dat3_mux0 */
>> > +                   0x080 (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_csn1.mmc1_clk_mux0 */
>> > +                   0x084 (PIN_INPUT_PULLUP | MUX_MODE2)      /* g=
pmc_csn2.mmc1_cmd_mux0 */
>> > +                   0x1e4 (PIN_INPUT_PULLUP | MUX_MODE7)      /* e=
mu0.gpio3[7] */
>> > +           >;
>> > +   };
>> > +
>> > +   wl12xx_gpio: pinmux_wl12xx_gpio {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x1e8 (PIN_OUTPUT_PULLUP | MUX_MODE7)      /* =
emu1.gpio3[8] */
>> > +           >;
>> > +   };
>> > +
>> > +   tps65910_pins: pinmux_tps65910_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x078 (PIN_INPUT_PULLUP | MUX_MODE7)      /* g=
pmc_ben1.gpio1[28] */
>> > +           >;
>> > +   };
>> > +
>> > +   tca6416_pins: pinmux_tca6416_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x1b4 (PIN_INPUT_PULLUP | MUX_MODE7)      /* x=
dma_event_intr1.gpio0[20] tca6416 stuff */
>> > +           >;
>> > +   };
>> > +
>> > +   i2c1_pins: pinmux_i2c1_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x158 0x2a      /* spi0_d1.i2c1_sda_mux3, INPU=
T | MODE2 */
>> > +                   0x15c 0x2a      /* spi0_cs0.i2c1_scl_mux3, INP=
UT | MODE2 */
>> > +           >;
>> > +   };
>> > +
>> > +   dcan1_pins: pinmux_dcan1_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x168 0x0a      /* uart0_ctsn.dcan1_tx_mux0, O=
UTPUT | MODE2 */
>> > +                   0x16c 0x2a      /* uart0_rtsn.dcan1_rx_mux0, I=
NPUT | MODE2 */
>> > +           >;
>> > +   };
>> > +
>> > +   uart0_pins: pinmux_uart0_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x170 (PIN_INPUT_PULLUP | MUX_MODE0)    /* uar=
t0_rxd.uart0_rxd */
>> > +                   0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)       =
  /* uart0_txd.uart0_txd */
>> > +           >;
>> > +   };
>> > +
>> > +   uart1_pins: pinmux_uart1_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x180 0x28      /* uart1_rxd, INPUT | MODE0 */
>> > +                   0x184 0x28      /* uart1_txd, INPUT | MODE0 */
>> > +                   /*0x178 0x28*/      /* uart1_ctsn, INPUT | MOD=
E0 */
>> > +                   /*0x17c 0x08*/      /* uart1_rtsn, OUTPUT | MO=
DE0 */
>> > +                   0x178 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 uart1_ctsn, INPUT | MODE0 */
>> > +                   0x17c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /=
* uart1_rtsn, OUTPUT | MODE0 */
>> > +                   0x0e0 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /=
* lcd_vsync.gpio2[22] DTR */
>> > +                   0x0e4 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 lcd_hsync.gpio2[23] DSR */
>> > +                   0x0e8 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 lcd_pclk.gpio2[24] DCD */
>> > +                   0x0ec (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 lcd_ac_bias_en.gpio2[25] RI */
>> > +           >;
>> > +   };
>> > +
>> > +   uart2_pins: pinmux_uart2_pins {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x150 0x29      /* spi0_sclk.uart2_rxd_mux3, I=
NPUT | MODE1 */
>> > +                   0x154 0x09      /* spi0_d0.uart2_txd_mux3, OUT=
PUT | MODE1 */
>> > +                   /*0x188 0x2a*/      /* i2c0_sda.uart2_ctsn_mux=
0, INPUT | MODE2 */
>> > +                   /*0x18c 0x2a*/      /* i2c0_scl.uart2_rtsn_mux=
0, INPUT | MODE2 */
>> > +                   0x188 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 i2c0_sda.uart2_ctsn_mux0 */
>> > +                   0x18c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /=
* i2c0_scl.uart2_rtsn_mux0 */
>> > +                   0x030 (PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /=
* gpmc_ad12.gpio1[12] DTR */
>> > +                   0x034 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 gpmc_ad13.gpio1[13] DSR */
>> > +                   0x038 (PIN_INPUT_PULLDOWN | MUX_MODE7)      /*=
 gpmc_ad14.gpio1[14] DCD */
>> > +                   0x03c (PIN_INPUT_PULLDOWN | MUX_MODE7)     /* =
gpmc_ad15.gpio1[15] RI */
>> > +
>> > +                   0x1a0 (PIN_INPUT_PULLUP | MUX_MODE7)      /* m=
casp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
>> > +           >;
>> > +   };
>> > +
>> > +   cpsw_default: cpsw_default {
>> > +           pinctrl-single,pins =3D <
>> > +                   /* Slave 1 */
>> > +                   0x10c (PIN_INPUT_PULLDOWN | MUX_MODE1)       /=
* mii1_crs.rmii1_crs_dv */
>> > +                   0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /=
* mii1_tx_en.rmii1_txen */
>> > +                   0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /=
* mii1_txd1.rmii1_txd1 */
>> > +                   0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /=
* mii1_txd0.rmii1_txd0 */
>> > +                   0x13c (PIN_INPUT_PULLDOWN | MUX_MODE1)      /*=
 mii1_rxd1.rmii1_rxd1 */
>> > +                   0x140 (PIN_INPUT_PULLDOWN | MUX_MODE1)      /*=
 mii1_rxd0.rmii1_rxd0 */
>> > +                   0x144 (PIN_INPUT_PULLDOWN | MUX_MODE0)      /*=
 rmii1_ref_clk.rmii1_refclk */
>> > +
>> > +
>> > +                   /* Slave 2 */
>> > +                   0x40 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a0.rgmii2_tctl */
>> > +                   0x44 (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a1.rgmii2_rctl */
>> > +                   0x48 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a2.rgmii2_td3 */
>> > +                   0x4c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a3.rgmii2_td2 */
>> > +                   0x50 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a4.rgmii2_td1 */
>> > +                   0x54 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a5.rgmii2_td0 */
>> > +                   0x58 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)  /* gpm=
c_a6.rgmii2_tclk */
>> > +                   0x5c (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a7.rgmii2_rclk */
>> > +                   0x60 (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a8.rgmii2_rd3 */
>> > +                   0x64 (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a9.rgmii2_rd2 */
>> > +                   0x68 (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a10.rgmii2_rd1 */
>> > +                   0x6c (PIN_INPUT_PULLDOWN | MUX_MODE2)   /* gpm=
c_a11.rgmii2_rd0 */
>> > +           >;
>> > +   };
>> > +
>> > +   cpsw_sleep: cpsw_sleep {
>> > +           pinctrl-single,pins =3D <
>> > +                   /* Slave 1 reset value */
>> > +                   0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +
>> > +                   /* Slave 2 reset value*/
>> > +                   0x40 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x44 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x48 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x4c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x50 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x54 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x58 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x5c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x60 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x64 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x68 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x6c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +           >;
>> > +   };
>> > +
>> > +   davinci_mdio_default: davinci_mdio_default {
>> > +           pinctrl-single,pins =3D <
>> > +                   /* MDIO */
>> > +                   0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_=
MODE0)    /* mdio_data.mdio_data */
>> > +                   0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)         =
          /* mdio_clk.mdio_clk */
>> > +           >;
>> > +   };
>> > +
>> > +   davinci_mdio_sleep: davinci_mdio_sleep {
>> > +           pinctrl-single,pins =3D <
>> > +                   /* MDIO reset value */
>> > +                   0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +                   0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>> > +           >;
>> > +   };
>> > +
>> > +   nandflash_pins_s0: nandflash_pins_s0 {
>> > +           pinctrl-single,pins =3D <
>> > +                   0x0 (PIN_INPUT_PULLUP | MUX_MODE0)      /* gpm=
c_ad0.gpmc_ad0 */
>> > +                   0x4 (PIN_INPUT_PULLUP | MUX_MODE0)      /* gpm=
c_ad1.gpmc_ad1 */
>> > +                   0x8 (PIN_INPUT_PULLUP | MUX_MODE0)      /* gpm=
c_ad2.gpmc_ad2 */
>> > +                   0xc (PIN_INPUT_PULLUP | MUX_MODE0)      /* gpm=
c_ad3.gpmc_ad3 */
>> > +                   0x10 (PIN_INPUT_PULLUP | MUX_MODE0)     /* gpm=
c_ad4.gpmc_ad4 */
>> > +                   0x14 (PIN_INPUT_PULLUP | MUX_MODE0)     /* gpm=
c_ad5.gpmc_ad5 */
>> > +                   0x18 (PIN_INPUT_PULLUP | MUX_MODE0)     /* gpm=
c_ad6.gpmc_ad6 */
>> > +                   0x1c (PIN_INPUT_PULLUP | MUX_MODE0)     /* gpm=
c_ad7.gpmc_ad7 */
>> > +                   0x70 (PIN_INPUT_PULLUP | MUX_MODE0)     /* gpm=
c_wait0.gpmc_wait0 */
>> > +                   0x74 (PIN_INPUT_PULLUP | MUX_MODE7)     /* gpm=
c_wpn.gpio0_30 */
>> > +                   0x7c (PIN_OUTPUT | MUX_MODE0)           /* gpm=
c_csn0.gpmc_csn0  */
>> > +                   0x90 (PIN_OUTPUT | MUX_MODE0)           /* gpm=
c_advn_ale.gpmc_advn_ale */
>> > +                   0x94 (PIN_OUTPUT | MUX_MODE0)           /* gpm=
c_oen_ren.gpmc_oen_ren */
>> > +                   0x98 (PIN_OUTPUT | MUX_MODE0)           /* gpm=
c_wen.gpmc_wen */
>> > +                   0x9c (PIN_OUTPUT | MUX_MODE0)           /* gpm=
c_be0n_cle.gpmc_be0n_cle */
>> > +           >;
>> > +   };
>> > +};
>> > +
>> > +&elm {
>> > +   status =3D "okay";
>> > +};
>> > +
>> > +&gpmc {
>> > +   pinctrl-names =3D "default";
>> > +   pinctrl-0 =3D <&nandflash_pins_s0>;
>> > +   ranges =3D <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
>> > +   status =3D "okay";
>> > +
>> > +   nand@0,0 {
>> > +           reg =3D <0 0 0>; /* CS0, offset 0 */
>> > +           nand-bus-width =3D <8>;
>> > +           ti,nand-ecc-opt =3D "bch8";
>> > +           ti,nand-xfer-type =3D "polled";
>> > +
>> > +           gpmc,device-nand =3D "true";
>> > +           gpmc,device-width =3D <1>;
>> > +           gpmc,sync-clk-ps =3D <0>;
>> > +           gpmc,cs-on-ns =3D <0>;
>> > +           gpmc,cs-rd-off-ns =3D <44>;
>> > +           gpmc,cs-wr-off-ns =3D <44>;
>> > +           gpmc,adv-on-ns =3D <6>;
>> > +           gpmc,adv-rd-off-ns =3D <34>;
>> > +           gpmc,adv-wr-off-ns =3D <44>;
>> > +           gpmc,we-on-ns =3D <0>;
>> > +           gpmc,we-off-ns =3D <40>;
>> > +           gpmc,oe-on-ns =3D <0>;
>> > +           gpmc,oe-off-ns =3D <54>;
>> > +           gpmc,access-ns =3D <64>;
>> > +           gpmc,rd-cycle-ns =3D <82>;
>> > +           gpmc,wr-cycle-ns =3D <82>;
>> > +           gpmc,wait-on-read =3D "true";
>> > +           gpmc,wait-on-write =3D "true";
>> > +           gpmc,bus-turnaround-ns =3D <0>;
>> > +           gpmc,cycle2cycle-delay-ns =3D <0>;
>> > +           gpmc,clk-activation-ns =3D <0>;
>> > +           gpmc,wait-monitoring-ns =3D <0>;
>> > +           gpmc,wr-access-ns =3D <40>;
>> > +           gpmc,wr-data-mux-bus-ns =3D <0>;
>> > +
>> > +           #address-cells =3D <1>;
>> > +           #size-cells =3D <1>;
>> > +           elm_id =3D <&elm>;
>> > +   };
>> > +};
>> > +
>> > +&uart0 {
>> > +   pinctrl-names =3D "default";
>> > +   pinctrl-0 =3D <&uart0_pins>;
>> > +
>> > +   status =3D "okay";
>> > +};
>> > +
>> > +&uart1 {
>> > +   pinctrl-names =3D "default";
>> > +   pinctrl-0 =3D <&uart1_pins>;
>> > +   dtr-gpios =3D <&gpio2 22 GPIO_ACTIVE_LOW>;
>> > +   dsr-gpios =3D <&gpio2 23 GPIO_ACTIVE_LOW>;
>> > +   dcd-gpios =3D <&gpio2 24 GPIO_ACTIVE_LOW>;
>> > +   rng-gpios =3D <&gpio2 25 GPIO_ACTIVE_LOW>;
>> > +   cts-gpios =3D <&gpio0 12 GPIO_ACTIVE_LOW>;
>> > +   rts-gpios =3D <&gpio0 13 GPIO_ACTIVE_LOW>;
>> > +
>> > +   status =3D "okay";
>> > +};
>> > +
>> > +&uart2 {
>> > +   pinctrl-names =3D "default";
>> > +   pinctrl-0 =3D <&uart2_pins>;
>> > +   dtr-gpios =3D <&gpio1 12 GPIO_ACTIVE_LOW>;
>> > +   dsr-gpios =3D <&gpio1 13 GPIO_ACTIVE_LOW>;
>> > +   dcd-gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
>> > +   rng-gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
>> > +   cts-gpios =3D <&gpio3 5 GPIO_ACTIVE_LOW>;
>> > +   rts-gpios =3D <&gpio3 6 GPIO_ACTIVE_LOW>;
>> > +
>> > +   status =3D "okay";
>> > +};
>> > +
>> > +&i2c1 {
>> > +   pinctrl-names =3D "default";
>> > +   pinctrl-0 =3D <&i2c1_pins>;
>> > +
>> > +   status =3D "okay";
>> > +   clock-frequency =3D <400000>;
>> > +
>> > +   tps: tps@2d {
>> > +           reg =3D <0x2d>;
>> > +           gpio-controller;
>> > +           #gpio-cells =3D <2>;
>> > +           interrupt-parent =3D <&gpio1>;
>> > +           interrupts =3D <28 GPIO_ACTIVE_LOW>;
>> > +           pinctrl-names =3D "default";
>> > +           pinctrl-0 =3D <&tps65910_pins>;
>> > +   };
>> > +
>> > +   at24@50 {
>> > +           compatible =3D "at24,24c02";
>> > +           pagesize =3D <8>;
>> > +           reg =3D <0x50>;
>> > +   };
>> > +
>> > +   tca6416: gpio@20 {
>> > +           compatible =3D "ti,tca6416";
>> > +           reg =3D <0x20>;
>> > +           gpio-controller;
>> > +           #gpio-cells =3D <2>;
>> > +           interrupt-parent =3D <&gpio0>;
>> > +           interrupts =3D <20 GPIO_ACTIVE_LOW>;
>> > +           pinctrl-names =3D "default";
>> > +           pinctrl-0 =3D <&tca6416_pins>;
>> > +   };
>> > +};
>> > +
>> > +&usb {
>> > +   status =3D "okay";
>> > +
>> > +   control@44e10620 {
>> > +           status =3D "okay";
>> > +   };
>> > +
>> > +   usb-phy@47401300 {
>> > +           status =3D "okay";
>> > +   };
>> > +
>> > +   usb-phy@47401b00 {
>> > +           status =3D "okay";
>> > +   };
>> > +
>> > +   usb@47401000 {
>> > +           status =3D "okay";
>> > +           dr_mode =3D "host";
>> > +   };
>> > +
>> > +   usb@47401800 {
>> > +           status =3D "okay";
>> > +           dr_mode =3D "otg";
>> > +   };
>> > +
>> > +   dma-controller@47402000  {
>> > +           status =3D "okay";
>> > +   };
>> > +};
>> > +
>> > +#include "tps65910.dtsi"
>> > +
>> > +&tps {
>> [...]
>> > +&mac {
>> [...]
>> > +&davinci_mdio {
>> [...]
>> > +&cpsw_emac0 {
>> [...]
>> >
>> Should these be ordered alphabetically?
>
> why ?

=46ound some issues. Will respin v2.

Yegor
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
