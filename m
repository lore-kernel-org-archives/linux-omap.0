From: Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>
Subject: Re: [PATCH v1 3/3] ARM: dts: am335x-bone: add support for beaglebone
 LCD4 cape
Date: Thu, 26 Jun 2014 12:40:52 -0300
Message-ID: <20140626154052.GB15648@fox>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
 <1403612666-31197-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:58481 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbaFZPii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 11:38:38 -0400
Received: by mail-yh0-f42.google.com with SMTP id i57so2242746yha.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2014 08:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403612666-31197-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Jason Kridner <jkridner@gmail.com>, Robert Nelson <robertcnelson@gmail.com>

Hi Pekon,

I had some issues with this patch. Booting linux-next on a BeagleBone
Black with this exact LCD left me with an unusable white screen. Please
see below for some details.

On Tue, Jun 24, 2014 at 05:54:26PM +0530, Pekon Gupta wrote:
> This patch adds support for LCD4 cape as advertised on
>   http://elinux.org/CircuitCo:BeagleBone_LCD4
>=20
> This cape has:
> * 480x272 TFT-LCD panel
>  - LCD panel datasheet and timing information are sourced from [1]
>  - LCD backlight is connected to 'EHRPWM1A' on cape board, but its us=
ed for
>    enabling backlight power-supply. So 'gpio-backlight' driver is use=
d instead
>    of 'pwm-backlight' driver (Kconfig: BACKLIGHT_GPIO=3Dy).
>=20
> * 4-wire resistive Touchscreen
>=20
> *Known constrains*
> As LCD panel pins (lcd_data, hsync, vsync, pclk) are shared with on-b=
oard
> NXP HDMI framer, so either HDMI or LCD-cape can be used at time. Thus=
 while
> using this cape 'hdmi' DT node needs to be disabled in am335x-bonebla=
ck.dts
>=20
> [1] www.newhavendisplay.com/specs/NHD-4.3-480272MF-ATXI-T-1.pdf
>     www.newhavendisplay.com/app_notes/OTA5180A.pdf
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone-display-cape.dts | 104 +++++++++++++++=
++++++++++
>  arch/arm/boot/dts/am335x-bone.dts              |   1 +
>  arch/arm/boot/dts/am335x-boneblack.dts         |   1 +
>  3 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-bone-display-cape.dts
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone-display-cape.dts b/arch/ar=
m/boot/dts/am335x-bone-display-cape.dts
> new file mode 100644
> index 0000000..f3b7cef
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-bone-display-cape.dts
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This DTS adds supports for display capes using LCD interface for =
display
> + * and GPIO or PWM interface for backlight controls.
> + */
> +
> +
> +&am33xx_pinmux {
> +	bbcape_backlight_pins: bbcape_backlight_pins {
> +		pinctrl-single,pins =3D <
> +			0x48  (PIN_OUTPUT | MUX_MODE7)		/* gpmc_a[2].GPIO1[18] (backlight=
 control) */
> +		>;
> +	};
> +
> +	bbcape_lcd_pins: bbcape_lcd_pins {
> +		pinctrl-single,pins =3D <
> +			0xa0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
> +			0xa4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
> +			0xa8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
> +			0xac (PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
> +			0xb0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
> +			0xb4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
> +			0xb8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
> +			0xbc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
> +			0xc0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
> +			0xc4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
> +			0xc8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
> +			0xcc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
> +			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
> +			0xd4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
> +			0xd8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
> +			0xdc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
> +			0xe0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
> +			0xe4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
> +			0xe8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
> +			0xec (PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en (=
lcd_en) */
> +			0x1a4 (PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mcasp0_fsr.gpio3[19] (lc=
d_disen) */
> +		>;
> +	};
> +
> +	bbcape_touchscreen_pins: bbcape_touchscreen_pins {
> +		pinctrl-single,pins =3D <
> +			0x184 (PIN_INPUT_PULLDOWN | MUX_MODE7)		/* uart1_txd.gpio0[15] (e=
nter) */
> +			0x40  (PIN_INPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a0.gpio1[16] (lef=
t) */
> +			0x44  (PIN_INPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a1.gpio1[17] (rig=
ht) */
> +			0x4c  (PIN_INPUT_PULLDOWN | MUX_MODE7)		/* gpmc_a3.gpio1[19] (up)=
 */
> +			0x198 (PIN_INPUT_PULLDOWN | MUX_MODE7)		/* mcasp0_axr0.gpio3[16] =
(down) */
> +		>;
> +	};
> +};
> +
> +
> +/ {
> +	backlight {
> +		status =3D "disabled";
> +		compatible =3D "gpio-backlight";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bbcape_backlight_pins>;
> +		gpios =3D <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +	};
> +
> +	panel {
> +		status =3D "disabled";
> +		compatible =3D "ti,tilcdc,panel";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bbcape_lcd_pins>;
> +		panel-info {
> +			ac-bias           =3D <255>;
> +			ac-bias-intrpt    =3D <0>;
> +			dma-burst-sz      =3D <16>;
> +			bpp               =3D <16>;
> +			fdd               =3D <0x80>;
> +			sync-edge         =3D <0>;
> +			sync-ctrl         =3D <0>;
I had to set this to <1>. Does that make sense?=20

> +			raster-order      =3D <0>;
> +			fifo-th           =3D <0>;
> +		};
> +		display-timings {
> +			native-mode =3D <&timing0>;
> +			/* www.newhavendisplay.com/app_notes/OTA5180A.pdf */
> +			timing0: 480x272 {
> +				clock-frequency =3D <30000000>;
> +				hactive =3D <480>;
> +				vactive =3D <272>;
> +				hfront-porch =3D <8>;
> +				hback-porch =3D <47>;
> +				hsync-len =3D <41>;
> +				vback-porch =3D <2>;
> +				vfront-porch =3D <3>;
> +				vsync-len =3D <10>;
> +				hsync-active =3D <0>;
> +				vsync-active =3D <0>;
> +				de-active =3D <1>;
> +				pixelclk-active =3D <0>;
Are you sure these timings are ok? When enabling the sync control I get
an usable display, but it looks a bit funny. For example an all black
display looks very clear and has a dotted pattern.

I tried to take a picture of it but it doesn't show.

Also I'm just guessing about the timings, maybe it's something else?

> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am=
335x-bone.dts
> index f16bfcf..41439dc 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -10,6 +10,7 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  #include "am335x-bone-memory-cape.dts"
> +#include "am335x-bone-display-cape.dts"
> =20
>  &ldo3_reg {
>  	regulator-min-microvolt =3D <1800000>;
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/d=
ts/am335x-boneblack.dts
> index e6d7e54..03232c7 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -10,6 +10,7 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  #include "am335x-bone-memory-cape.dts"
> +#include "am335x-bone-display-cape.dts"
> =20
>  &ldo3_reg {
>  	regulator-min-microvolt =3D <1800000>;
> --=20
> 1.8.5.1.163.gd7aced9
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Guido Mart=EDnez, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
