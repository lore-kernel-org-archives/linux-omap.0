From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: omap3-pandora: add DM3730 1 GHz version
Date: Fri, 13 Feb 2015 01:10:12 +0200
Message-ID: <CANOLnONUZr9iCt-ND0OvQP91dARM=P6C7WXq5OigAeZOdsX2Ug@mail.gmail.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
	<1423746226-700-4-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423746226-700-4-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, "H. Nikolaus Schaller" <hns@goldelico.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, robh+dt@kernel.org, galak@codeaurora.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 12, 2015 at 3:03 PM, Marek Belisko <marek@goldelico.com> wr=
ote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-1ghz.dts | 65 ++++++++++++++++++++++=
++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-pandora-1ghz.dts
>
> diff --git a/arch/arm/boot/dts/omap3-pandora-1ghz.dts b/arch/arm/boot=
/dts/omap3-pandora-1ghz.dts
> new file mode 100644
> index 0000000..6286f41
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-pandora-1ghz.dts
=2E..
> +
> +       control_pins: pinmux_control_pins {
> +               pinctrl-single,pins =3D <
> +                       OMAP3630_CORE2_IOPAD(0x25dc, PIN_INPUT_PULLDO=
WN | MUX_MODE4)    /* etk_d0.gpio_14 =3D  HP_SHUTDOWN */
> +                       OMAP3630_CORE2_IOPAD(0x25de, PIN_OUTPUT | MUX=
_MODE4)            /* etk_d1.gpio_15 =3D  BT_SHUTDOWN */
> +                       OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT | MUX=
_MODE4)            /* etk_d2.gpio_16 =3D  RESET_USB_HOST */
> +                       OMAP3630_CORE2_IOPAD(0x25ea, PIN_INPUT_PULLUP=
 | MUX_MODE4)      /* etk_d7.gpio_21 =3D  WIFI IRQ */

The WG7210 document claims that no pulldown/pullup is needed, and we
always had it disabled. The mainline wl1251 driver also reconfigures
that signal to be active high on wl1251 side, and uses rising edge
interrupts (I don't know why it does that).

> +                       OMAP3630_CORE2_IOPAD(0x25ec, PIN_OUTPUT | MUX=
_MODE4)            /* etk_d8.gpio_22 =3D  MSECURE */
> +                       OMAP3630_CORE2_IOPAD(0x25ee, PIN_OUTPUT | MUX=
_MODE4)            /* etk_d9.gpio_23 =3D  WIFI_POWER */

I think we also need these here:
  OMAP3_WKUP_IOPAD(0x2a54, PIN_INPUT | MUX_MODE4)   /*
reserved.gpio_127 =3D MMC2_WP */
  OMAP3_WKUP_IOPAD(0x2a56, PIN_INPUT | MUX_MODE4)   /*
reserved.gpio_126 =3D MMC1_WP */
  OMAP3_WKUP_IOPAD(0x2a58, PIN_OUTPUT | MUX_MODE4)   /*
reserved.gpio_128 =3D LED_MMC1 */
  OMAP3_WKUP_IOPAD(0x2a5a, PIN_OUTPUT | MUX_MODE4)   /*
reserved.gpio_129 =3D LED_MMC2 */


Gra=C5=BEvydas
