From: Jason Kridner <jkridner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: Add am335x-boneblack-wireless
Date: Wed, 28 Dec 2016 15:26:32 -0600
Message-ID: <CB5C8999-6CAE-41F6-85A6-D2A856BD8011@gmail.com>
References: <20161227175837.28970-1-robertcnelson@gmail.com> <20161227175837.28970-2-robertcnelson@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161227175837.28970-2-robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> On Dec 27, 2016, at 11:58 AM, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>=20
> BeagleBone Black Wireless is clone of the BeagleBone Black (BBB) with the E=
thernet
> replaced by a TI wl1835 wireless module.
>=20
> This board can be indentified by the BWAx value after A335BNLT (BBB) in th=
e at24 eeprom:
> BWAx [aa 55 33 ee 41 33 33 35  42 4e 4c 54 42 57 41 35  |.U3.A335BNLTBWA5|=
]

I believe the correct statement is BWxx, but BWBx reserves the option to be s=
oftware incompatible in some way. My preference is to have it boot anyway, b=
ut I believe that is only dependent in the bootloader.=20

>=20
> http://beagleboard.org/black-wireless
> https://github.com/beagleboard/beaglebone-black-wireless
>=20
> firmware: https://github.com/beagleboard/beaglebone-black-wireless/tree/ma=
ster/firmware
> wl18xx mac address: /proc/device-tree/ocp/ethernet@4a100000/slave@4a100200=
/mac-address
>=20
> Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
> ---
> arch/arm/boot/dts/Makefile                      |   1 +
> arch/arm/boot/dts/am335x-boneblack-wireless.dts | 109 ++++++++++++++++++++=
++++
> 2 files changed, 110 insertions(+)
> create mode 100644 arch/arm/boot/dts/am335x-boneblack-wireless.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index cccdbcb557b6..9415a49bd11b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -563,6 +563,7 @@ dtb-$(CONFIG_SOC_AM33XX) +=3D \
>    am335x-base0033.dtb \
>    am335x-bone.dtb \
>    am335x-boneblack.dtb \
> +    am335x-boneblack-wireless.dtb \
>    am335x-bonegreen.dtb \
>    am335x-chiliboard.dtb \
>    am335x-cm-t335.dtb \
> diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/bo=
ot/dts/am335x-boneblack-wireless.dts
> new file mode 100644
> index 000000000000..105bd10655f7
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/=

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "am33xx.dtsi"
> +#include "am335x-bone-common.dtsi"
> +#include "am335x-boneblack-common.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +    model =3D "TI AM335x BeagleBone Black Wireless";
> +    compatible =3D "ti,am335x-bone-black-wireless", "ti,am335x-bone-black=
", "ti,am335x-bone", "ti,am33xx";
> +
> +    wlan_en_reg: fixedregulator@2 {
> +        compatible =3D "regulator-fixed";
> +        regulator-name =3D "wlan-en-regulator";
> +        regulator-min-microvolt =3D <1800000>;
> +        regulator-max-microvolt =3D <1800000>;
> +        startup-delay-us=3D <70000>;
> +
> +        /* WL_EN */
> +        gpio =3D <&gpio3 9 0>;
> +        enable-active-high;
> +    };
> +};
> +
> +&am33xx_pinmux {
> +    bt_pins: pinmux_bt_pins {
> +        pinctrl-single,pins =3D <
> +            AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLUP | MUX_MODE7)    /* gmii=
1_txd0.gpio0_28 - BT_EN */
> +        >;
> +    };
> +
> +    mmc3_pins: pinmux_mmc3_pins {
> +        pinctrl-single,pins =3D <
> +            AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (L15) g=
mii1_rxd1.mmc2_clk */
> +            AM33XX_IOPAD(0x914, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (J16) g=
mii1_txen.mmc2_cmd */
> +            AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J17) g=
mii1_rxdv.mmc2_dat0 */
> +            AM33XX_IOPAD(0x91c, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J18) g=
mii1_txd3.mmc2_dat1 */
> +            AM33XX_IOPAD(0x920, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (K15) g=
mii1_txd2.mmc2_dat2 */
> +            AM33XX_IOPAD(0x908, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (H16) g=
mii1_col.mmc2_dat3 */
> +        >;
> +    };
> +
> +    uart3_pins: pinmux_uart3_pins {
> +        pinctrl-single,pins =3D <
> +            AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)    /* gmii1=
_rxd3.uart3_rxd */
> +            AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)    /* gm=
ii1_rxd2.uart3_txd */
> +            AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)        /* mdio_dat=
a.uart3_ctsn */
> +            AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)    /* md=
io_clk.uart3_rtsn */
> +        >;
> +    };
> +
> +    wl18xx_pins: pinmux_wl18xx_pins {
> +        pinctrl-single,pins =3D <
> +            AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)    /* gm=
ii1_txclk.gpio3_9 WL_EN */
> +            AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)    /* rmi=
i1_refclk.gpio0_29 WL_IRQ */
> +            AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)    /* gmii=
1_rxclk.gpio3_10 LS_BUF_EN */
> +        >;
> +    };
> +};
> +
> +&mac {
> +    status =3D "disabled";
> +};
> +
> +&mmc3 {
> +    dmas =3D <&edma_xbar 12 0 1
> +        &edma_xbar 13 0 2>;
> +    dma-names =3D "tx", "rx";
> +    status =3D "okay";
> +    vmmc-supply =3D <&wlan_en_reg>;
> +    bus-width =3D <4>;
> +    non-removable;
> +    cap-power-off-card;
> +    ti,needs-special-hs-handling;
> +    keep-power-in-suspend;
> +    pinctrl-names =3D "default";
> +    pinctrl-0 =3D <&mmc3_pins &wl18xx_pins>;
> +
> +    #address-cells =3D <1>;
> +    #size-cells =3D <0>;
> +    wlcore: wlcore@2 {
> +        compatible =3D "ti,wl1835";
> +        reg =3D <2>;
> +        interrupt-parent =3D <&gpio0>;
> +        interrupts =3D <29 IRQ_TYPE_EDGE_RISING>;
> +    };
> +};
> +
> +&uart3 {
> +    pinctrl-names =3D "default";
> +    pinctrl-0 =3D <&uart3_pins &bt_pins>;
> +    status =3D "okay";
> +};
> +
> +&gpio3 {
> +    ls_buf_en {
> +        gpio-hog;
> +        gpios =3D <10 GPIO_ACTIVE_HIGH>;
> +        output-high;
> +        line-name =3D "LS_BUF_EN";
> +    };
> +};
> --=20
> 2.11.0
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
