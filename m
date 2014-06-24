From: Jason Kridner <jkridner@gmail.com>
Subject: Re: [PATCH v1 3/3] ARM: dts: am335x-bone: add support for beaglebone
 LCD4 cape
Date: Tue, 24 Jun 2014 11:24:05 -0400
Message-ID: <CA+T6QP=eETQtLKs6HcCAJsZg7+tSdJyeaXdaZTv5qt9y+7+mmg@mail.gmail.com>
References: <1403612666-31197-1-git-send-email-pekon@ti.com>
	<1403612666-31197-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39968 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaFXPYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2014 11:24:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so506286oag.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2014 08:24:05 -0700 (PDT)
In-Reply-To: <1403612666-31197-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>, Robert Nelson <robertcnelson@gmail.com>

On Tue, Jun 24, 2014 at 8:24 AM, Pekon Gupta <pekon@ti.com> wrote:
> This patch adds support for LCD4 cape as advertised on
>   http://elinux.org/CircuitCo:BeagleBone_LCD4
>
> This cape has:
> * 480x272 TFT-LCD panel
>  - LCD panel datasheet and timing information are sourced from [1]
>  - LCD backlight is connected to 'EHRPWM1A' on cape board, but its used for
>    enabling backlight power-supply. So 'gpio-backlight' driver is used instead
>    of 'pwm-backlight' driver (Kconfig: BACKLIGHT_GPIO=y).
>
> * 4-wire resistive Touchscreen
>
> *Known constrains*
> As LCD panel pins (lcd_data, hsync, vsync, pclk) are shared with on-board
> NXP HDMI framer, so either HDMI or LCD-cape can be used at time. Thus while
> using this cape 'hdmi' DT node needs to be disabled in am335x-boneblack.dts
>
> [1] www.newhavendisplay.com/specs/NHD-4.3-480272MF-ATXI-T-1.pdf
>     www.newhavendisplay.com/app_notes/OTA5180A.pdf
>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone-display-cape.dts | 104 +++++++++++++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts              |   1 +
>  arch/arm/boot/dts/am335x-boneblack.dts         |   1 +
>  3 files changed, 106 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am335x-bone-display-cape.dts
>
> diff --git a/arch/arm/boot/dts/am335x-bone-display-cape.dts b/arch/arm/boot/dts/am335x-bone-display-cape.dts

If this is mean to be included, why not use the .dtsi extension rather
than .dts. .dts implies it is a top-level file.

> new file mode 100644
> index 0000000..f3b7cef
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-bone-display-cape.dts
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This DTS adds supports for display capes using LCD interface for display
> + * and GPIO or PWM interface for backlight controls.
> + */
> +
> +
> +&am33xx_pinmux {
> +       bbcape_backlight_pins: bbcape_backlight_pins {
> +               pinctrl-single,pins = <
> +                       0x48  (PIN_OUTPUT | MUX_MODE7)          /* gpmc_a[2].GPIO1[18] (backlight control) */
> +               >;
> +       };
> +
> +       bbcape_lcd_pins: bbcape_lcd_pins {
> +               pinctrl-single,pins = <
> +                       0xa0 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data0.lcd_data0 */
> +                       0xa4 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data1.lcd_data1 */
> +                       0xa8 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data2.lcd_data2 */
> +                       0xac (PIN_OUTPUT | MUX_MODE0)           /* lcd_data3.lcd_data3 */
> +                       0xb0 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data4.lcd_data4 */
> +                       0xb4 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data5.lcd_data5 */
> +                       0xb8 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data6.lcd_data6 */
> +                       0xbc (PIN_OUTPUT | MUX_MODE0)           /* lcd_data7.lcd_data7 */
> +                       0xc0 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data8.lcd_data8 */
> +                       0xc4 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data9.lcd_data9 */
> +                       0xc8 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data10.lcd_data10 */
> +                       0xcc (PIN_OUTPUT | MUX_MODE0)           /* lcd_data11.lcd_data11 */
> +                       0xd0 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data12.lcd_data12 */
> +                       0xd4 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data13.lcd_data13 */
> +                       0xd8 (PIN_OUTPUT | MUX_MODE0)           /* lcd_data14.lcd_data14 */
> +                       0xdc (PIN_OUTPUT | MUX_MODE0)           /* lcd_data15.lcd_data15 */
> +                       0xe0 (PIN_OUTPUT | MUX_MODE0)           /* lcd_vsync.lcd_vsync */
> +                       0xe4 (PIN_OUTPUT | MUX_MODE0)           /* lcd_hsync.lcd_hsync */
> +                       0xe8 (PIN_OUTPUT | MUX_MODE0)           /* lcd_pclk.lcd_pclk */
> +                       0xec (PIN_OUTPUT | MUX_MODE0)           /* lcd_ac_bias_en.lcd_ac_bias_en (lcd_en) */
> +                       0x1a4 (PIN_OUTPUT_PULLUP | MUX_MODE7)   /* mcasp0_fsr.gpio3[19] (lcd_disen) */
> +               >;
> +       };
> +
> +       bbcape_touchscreen_pins: bbcape_touchscreen_pins {
> +               pinctrl-single,pins = <
> +                       0x184 (PIN_INPUT_PULLDOWN | MUX_MODE7)          /* uart1_txd.gpio0[15] (enter) */
> +                       0x40  (PIN_INPUT_PULLDOWN | MUX_MODE7)          /* gpmc_a0.gpio1[16] (left) */
> +                       0x44  (PIN_INPUT_PULLDOWN | MUX_MODE7)          /* gpmc_a1.gpio1[17] (right) */
> +                       0x4c  (PIN_INPUT_PULLDOWN | MUX_MODE7)          /* gpmc_a3.gpio1[19] (up) */
> +                       0x198 (PIN_INPUT_PULLDOWN | MUX_MODE7)          /* mcasp0_axr0.gpio3[16] (down) */
> +               >;
> +       };
> +};
> +
> +
> +/ {
> +       backlight {
> +               status = "disabled";
> +               compatible = "gpio-backlight";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&bbcape_backlight_pins>;
> +               gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +               default-on;
> +       };
> +
> +       panel {
> +               status = "disabled";

Where are you expecting to enable this? I'm guessing through your
u-boot hacking? Certainly I can see editing the boot script to make
this work, but I don't see how this results in the average user simply
plugging in the cape and having it work without having to edit files.
Perhaps you can put some real logic into the bootloader that looks at
the cape EEPROMs?

Have you considered using tools like pinmux-helper as is done with the
cape-universal overlay?
https://github.com/beagleboard/devicetree-source/blob/master/arch/arm/boot/dts/cape-universal-00A0.dts

I've been hacking with adding all of these pinmux helpers to the main
.dts. I think you are encouraging me to add it to include files to
make it a bit more granular.

http://paste.debian.net/106319/

> +               compatible = "ti,tilcdc,panel";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&bbcape_lcd_pins>;
> +               panel-info {
> +                       ac-bias           = <255>;
> +                       ac-bias-intrpt    = <0>;
> +                       dma-burst-sz      = <16>;
> +                       bpp               = <16>;
> +                       fdd               = <0x80>;
> +                       sync-edge         = <0>;
> +                       sync-ctrl         = <0>;
> +                       raster-order      = <0>;
> +                       fifo-th           = <0>;
> +               };
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       /* www.newhavendisplay.com/app_notes/OTA5180A.pdf */
> +                       timing0: 480x272 {
> +                               clock-frequency = <30000000>;
> +                               hactive = <480>;
> +                               vactive = <272>;
> +                               hfront-porch = <8>;
> +                               hback-porch = <47>;
> +                               hsync-len = <41>;
> +                               vback-porch = <2>;
> +                               vfront-porch = <3>;
> +                               vsync-len = <10>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <0>;
> +                       };
> +               };
> +       };
> +};

I appreciate the enthusiasm to get this support into the mainline. If
it goes, I'll try to follow with a bunch of other outstanding changes
we have sitting in the vendor tree right now.

Have you looked at the features in the devicetree for this cape that
is currently pushed in the vendor tree?

https://github.com/beagleboard/devicetree-source/blob/master/arch/arm/boot/dts/BB-BONE-LCD4-01-00A1.dts

> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index f16bfcf..41439dc 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -10,6 +10,7 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  #include "am335x-bone-memory-cape.dts"
> +#include "am335x-bone-display-cape.dts"
>
>  &ldo3_reg {
>         regulator-min-microvolt = <1800000>;
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index e6d7e54..03232c7 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -10,6 +10,7 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
>  #include "am335x-bone-memory-cape.dts"
> +#include "am335x-bone-display-cape.dts"
>
>  &ldo3_reg {
>         regulator-min-microvolt = <1800000>;
> --
> 1.8.5.1.163.gd7aced9
>
