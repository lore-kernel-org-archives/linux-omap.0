From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-pandora: add common device tree
Date: Thu, 12 Feb 2015 19:47:41 +0200
Message-ID: <CANOLnOMEJXSJcujdeG+6XXkU99yv7cSw115b+-NX+CPVVO_FVw@mail.gmail.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
	<1423746226-700-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423746226-700-2-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, "H. Nikolaus Schaller" <hns@goldelico.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, galak@codeaurora.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 12, 2015 at 3:03 PM, Marek Belisko <marek@goldelico.com> wr=
ote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> This device tree allows to boot, supports the panel,
> framebuffer, touch screen, as well as some more peripherals.
> Since there is a OMAP3530 based 600 MHz variant and a DM3730 based
> 1 GHz variant we must include this common device tree code
> in one of two CPU specific device trees.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 641 ++++++++++++++++++=
++++++++++
>  1 file changed, 641 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-pandora-common.dtsi
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/b=
oot/dts/omap3-pandora-common.dtsi
> new file mode 100644
> index 0000000..0a2a878
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -0,0 +1,641 @@

=2E..

> +
> +       gpio-leds {
> +
> +               compatible =3D "gpio-leds";
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&led_pins>;
> +
> +               led@1 {
> +                       label =3D "pandora::sd1";
> +                       gpios =3D <&gpio5 0 GPIO_ACTIVE_HIGH>;    /* =
GPIO_128 */
> +                       linux,default-trigger =3D "mmc0";
> +                       default-state =3D "off";
> +               };
> +
> +               led@2 {
> +                       label =3D "pandora::sd2";
> +                       gpios =3D <&gpio5 1 GPIO_ACTIVE_HIGH>;    /* =
GPIO_129 */
> +                       linux,default-trigger =3D "mmc1";
> +                       default-state =3D "off";
> +               };
> +
> +               led@3 {
> +                       label =3D "pandora::bluetooth";
> +                       gpios =3D <&gpio5 30 GPIO_ACTIVE_HIGH>;   /* =
GPIO_158 */
> +                       linux,default-trigger =3D "heartbeat";

I'd prefer this had no trigger, but no strong feelings here.

> +                       default-state =3D "off";
> +               };
> +
> +               led@4 {
> +                       label =3D "pandora::wifi";
> +                       gpios =3D <&gpio5 31 GPIO_ACTIVE_HIGH>;   /* =
GPIO_159 */
> +                       linux,default-trigger =3D "mmc2";
> +                       default-state =3D "off";
> +               };
> +       };
> +
> +       gpio-keys {
> +               compatible =3D "gpio-keys";
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&button_pins>;
> +
> +               up-button {
> +                       label =3D "up";
> +                       linux,code =3D <KEY_UP>;
> +                       gpios =3D <&gpio4 14 GPIO_ACTIVE_HIGH>;   /* =
GPIO_110 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               down-button {
> +                       label =3D "down";
> +                       linux,code =3D <KEY_DOWN>;
> +                       gpios =3D <&gpio4 7 GPIO_ACTIVE_HIGH>;    /* =
GPIO_103 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-button {
> +                       label =3D "left";
> +                       linux,code =3D <KEY_LEFT>;
> +                       gpios =3D <&gpio4 0 GPIO_ACTIVE_HIGH>;    /* =
GPIO_96 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-button {
> +                       label =3D "right";
> +                       linux,code =3D <KEY_RIGHT>;
> +                       gpios =3D <&gpio4 2 GPIO_ACTIVE_HIGH>;    /* =
GPIO_98 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               pageup-button {
> +                       label =3D "game 1";
> +                       linux,code =3D <KEY_PAGEUP>;
> +                       gpios =3D <&gpio4 13 GPIO_ACTIVE_HIGH>;   /* =
GPIO_109 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               pagedown-button {
> +                       label =3D "game 3";
> +                       linux,code =3D <KEY_PAGEDOWN>;
> +                       gpios =3D <&gpio4 10 GPIO_ACTIVE_HIGH>;   /* =
GPIO_106 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               home-button {
> +                       label =3D "game 4";
> +                       linux,code =3D <KEY_HOME>;
> +                       gpios =3D <&gpio4 5 GPIO_ACTIVE_HIGH>;    /* =
GPIO_101 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               end-button {
> +                       label =3D "game 2";
> +                       linux,code =3D <KEY_END>;
> +                       gpios =3D <&gpio4 15 GPIO_ACTIVE_HIGH>;   /* =
GPIO_111 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-shift {
> +                       label =3D "l";
> +                       linux,code =3D <KEY_RIGHTSHIFT>;
> +                       gpios =3D <&gpio4 6 GPIO_ACTIVE_HIGH>;    /* =
GPIO_102 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               kp-plus {
> +                       label =3D "l2";
> +                       linux,code =3D <KEY_KPPLUS>;
> +                       gpios =3D <&gpio4 1 GPIO_ACTIVE_HIGH>;    /* =
GPIO_97 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               right-ctrl {
> +                       label =3D "r";
> +                       linux,code =3D <KEY_RIGHTCTRL>;
> +                       gpios =3D <&gpio4 9 GPIO_ACTIVE_HIGH>;    /* =
GPIO_105 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               kp-minus {
> +                       label =3D "r2";
> +                       linux,code =3D <KEY_KPMINUS>;
> +                       gpios =3D <&gpio4 11 GPIO_ACTIVE_HIGH>;   /* =
GPIO_107 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-ctrl {
> +                       label =3D "ctrl";
> +                       linux,code =3D <KEY_LEFTCTRL>;
> +                       gpios =3D <&gpio4 8 GPIO_ACTIVE_HIGH>;    /* =
GPIO_104 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               menu {
> +                       label =3D "menu";
> +                       linux,code =3D <KEY_MENU>;
> +                       gpios =3D <&gpio4 3 GPIO_ACTIVE_HIGH>;    /* =
GPIO_99 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               hold {
> +                       label =3D "hold";
> +                       linux,code =3D <KEY_COFFEE>;
> +                       gpios =3D <&gpio6 16 GPIO_ACTIVE_HIGH>;   /* =
GPIO_176 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               left-alt {
> +                       label =3D "alt";
> +                       linux,code =3D <KEY_LEFTALT>;
> +                       gpios =3D <&gpio4 4 GPIO_ACTIVE_HIGH>;    /* =
GPIO_100 */
> +                       gpio-key,wakeup;
> +               };
> +
> +               lid {
> +                       label =3D "lid";
> +                       linux,code =3D <0x00>;    /* SW_LID lid shut =
*/
> +                       linux,input-type =3D <0x05>;    /* EV_SW */
> +                       gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>;   /* =
GPIO_108 */
> +                       gpio-key,wakeup;
> +               };

This is not right, all button GPIOs are active low except GPIO_100,
which is active high. GPIO_108 should not have the wakeup flag set
because lid switch power is normally cut during low power modes.

=2E..

> +
> +       dss_dpi_pins: pinmux_dss_dpi_pins {
> +               pinctrl-single,pins =3D <
> +                       OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_pclk.dss_pclk */
> +                       OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_hsync.dss_hsync */
> +                       OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_vsync.dss_vsync */
> +                       OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_acbias.dss_acbias */
> +                       OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data0.dss_data0 */
> +                       OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data1.dss_data1 */
> +                       OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data2.dss_data2 */
> +                       OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data3.dss_data3 */
> +                       OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data4.dss_data4 */
> +                       OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data5.dss_data5 */
> +                       OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data6.dss_data6 */
> +                       OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data7.dss_data7 */
> +                       OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data8.dss_data8 */
> +                       OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data9.dss_data9 */
> +                       OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data10.dss_data10 */
> +                       OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data11.dss_data11 */
> +                       OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data12.dss_data12 */
> +                       OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data13.dss_data13 */
> +                       OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data14.dss_data14 */
> +                       OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data15.dss_data15 */
> +                       OMAP3_CORE1_IOPAD(0x20fc, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data16.dss_data16 */
> +                       OMAP3_CORE1_IOPAD(0x20fe, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data17.dss_data17 */
> +                       OMAP3_CORE1_IOPAD(0x2100, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data18.dss_data18 */
> +                       OMAP3_CORE1_IOPAD(0x2102, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data19.dss_data19 */
> +                       OMAP3_CORE1_IOPAD(0x2104, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data20.dss_data20 */
> +                       OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data21.dss_data21 */
> +                       OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data22.dss_data22 */
> +                       OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MO=
DE0)       /* dss_data23.dss_data23 */
> +                       OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MO=
DE4)       /* GPIO_157 =3D lcd reset */
> +               >;
> +       };
> +
> +       uart3_pins: pinmux_uart3_pins {
> +               pinctrl-single,pins =3D <
> +                       OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | PIN_OFF=
_WAKEUPENABLE | MUX_MODE0) /* uart3_rx_irrx.uart3_rx_irrx */
> +                       OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MO=
DE0) /* uart3_tx_irtx.uart3_tx_irtx */
> +               >;
> +       };
> +
> +       led_pins: pinmux_leds_pins {
> +               pinctrl-single,pins =3D <
> +                       OMAP3_CORE1_IOPAD(0x2154, PIN_OUTPUT | MUX_MO=
DE4)       /* GPIO_128 */
> +                       OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MO=
DE4)       /* GPIO_129 */
> +                       OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MO=
DE4)       /* GPIO_158 */
> +                       OMAP3_CORE1_IOPAD(0x2192, PIN_OUTPUT | MUX_MO=
DE4)       /* GPIO_159 */
> +               >;
> +       };
> +
> +       button_pins: pinmux_button_pins {
> +               pinctrl-single,pins =3D <
> +                       OMAP3_CORE1_IOPAD(0x2110, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_96 */
> +                       OMAP3_CORE1_IOPAD(0x2112, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_97 */
> +                       OMAP3_CORE1_IOPAD(0x2114, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_98 */
> +                       OMAP3_CORE1_IOPAD(0x2116, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_99 */
> +                       OMAP3_CORE1_IOPAD(0x2118, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_100 */
> +                       OMAP3_CORE1_IOPAD(0x211a, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_101 */
> +                       OMAP3_CORE1_IOPAD(0x211c, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_102 */
> +                       OMAP3_CORE1_IOPAD(0x211e, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_103 */
> +                       OMAP3_CORE1_IOPAD(0x2120, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_104 */
> +                       OMAP3_CORE1_IOPAD(0x2122, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_105 */
> +                       OMAP3_CORE1_IOPAD(0x2124, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_106 */
> +                       OMAP3_CORE1_IOPAD(0x2126, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_107 */
> +                       OMAP3_CORE1_IOPAD(0x2128, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_108 */
> +                       OMAP3_CORE1_IOPAD(0x212a, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_109 */
> +                       OMAP3_CORE1_IOPAD(0x212c, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_110 */
> +                       OMAP3_CORE1_IOPAD(0x212e, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_111 */
> +                       OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT_PULLUP | =
MUX_MODE4)        /* GPIO_176 */

We should not set pullups for all the buttons, they all have external p=
ullups.

> +               >;
> +       };
> +
> +       penirq_pins: pinmux_penirq_pins {
> +               pinctrl-single,pins =3D <
> +                       /* here we could enable to wakeup the cpu fro=
m suspend by a pen touch */
> +                       OMAP3_CORE1_IOPAD(0x210c, PIN_INPUT_PULLUP | =
MUX_MODE4) /* GPIO_94 */

Again, we already have external pullup, no need to waste power.

=2E..

> +
> +&mmc1 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&mmc1_pins>;
> +       vmmc-supply =3D <&vmmc1>;
> +       bus-width =3D <4>;
> +       cd-gpios =3D <&twl_gpio 0 GPIO_ACTIVE_LOW>;
> +       wp-gpios =3D <&gpio4 30 GPIO_ACTIVE_LOW>; /* GPIO_126 */

Large number of pandoras have defective write potect pins. Kernel used
to not support write protect at all, so we noticed it too late. If
it's possible to omit this it would be better do so, perhaps with a
comment, or I can send a patch later...

> +};
> +
> +&mmc2 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&mmc2_pins>;
> +       vmmc-supply =3D <&vmmc2>;
> +       bus-width =3D <4>;
> +       cd-gpios =3D <&twl_gpio 1 GPIO_ACTIVE_HIGH>;
> +       wp-gpios =3D <&gpio4 31 GPIO_ACTIVE_LOW>; /* GPIO_127 */

same here


Gra=C5=BEvydas
