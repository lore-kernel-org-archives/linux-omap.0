From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep: Move eth IRQ pinmux to IGEPv2
 common dtsi
Date: Mon, 7 Sep 2015 21:39:38 +0200
Message-ID: <CAFqH_50Hbzu1WDV7O3_jnUKVZ2Hhg_0PvV9jR_R1PkhfJ1MAxQ@mail.gmail.com>
References: <1441643058-8641-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441643058-8641-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2015-09-07 18:24 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Only the IGEPv2 boards have a LAN9221i chip connected to the GPMC
> so the pinmux configuration for the GPIO connected to the IRQ line
> of the LAN chip should not be defined in the IGEP common dtsi but
> in the one common to the IGEPv2 boards.
>
> While there, use the OMAP3_CORE1_IOPAD() macro for the padconf reg.
>
> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  arch/arm/boot/dts/omap3-igep.dtsi            | 6 ------
>  arch/arm/boot/dts/omap3-igep0020-common.dtsi | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index d5e5cd449b16..2230e1c03320 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -78,12 +78,6 @@
>                 >;
>         };
>
> -       smsc9221_pins: pinmux_smsc9221_pins {
> -               pinctrl-single,pins = <
> -                       0x1a2 (PIN_INPUT | MUX_MODE4)           /* mcspi1_cs2.gpio_176 */
> -               >;
> -       };
> -
>         i2c1_pins: pinmux_i2c1_pins {
>                 pinctrl-single,pins = <
>                         0x18a (PIN_INPUT | MUX_MODE0)   /* i2c1_scl.i2c1_scl */
> diff --git a/arch/arm/boot/dts/omap3-igep0020-common.dtsi b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> index e458c2185e3c..5ad688c57a00 100644
> --- a/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep0020-common.dtsi
> @@ -156,6 +156,12 @@
>                         OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)        /* uart2_rx.uart2_rx */
>                 >;
>         };
> +
> +       smsc9221_pins: pinmux_smsc9221_pins {
> +               pinctrl-single,pins = <
> +                       OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT | MUX_MODE4)        /* mcspi1_cs2.gpio_176 */
> +               >;
> +       };
>  };
>
>  &omap3_pmx_core2 {
> --
> 2.4.3
>

Looks good to me.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
