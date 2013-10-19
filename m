From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi
 connected to SDIO.
Date: Sun, 20 Oct 2013 01:18:56 +0200
Message-ID: <CAAwP0s0VXnMZYtJrBjrwjXnqSaQ1rd_hNm7wxVeSTLVnvd9tRQ@mail.gmail.com>
References: <1382212448-31094-1-git-send-email-eballetbo@gmail.com> <1382212448-31094-3-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63251 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab3JSXTQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 19:19:16 -0400
Received: by mail-ie0-f172.google.com with SMTP id tp5so9244056ieb.3
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 16:19:16 -0700 (PDT)
In-Reply-To: <1382212448-31094-3-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Enric,

On Sat, Oct 19, 2013 at 9:54 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> The LBEE1USJYC is a WiFi/BT combo module used on OMAP3-based IGEP boards. In
> both cases, IGEPv2 Rev. C and IGEP COM MODULE, the module is connected using
> the same MMC interface and uses the same GPIOs.
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi | 45 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index d4fecce..882e318 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -24,6 +24,25 @@
>                 ti,mcbsp = <&mcbsp2>;
>                 ti,codec = <&twl_audio>;
>         };
> +
> +       vdd33: regulator-vdd33 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vdd33";
> +               regulator-always-on;
> +       };
> +
> +       lbee1usjyc_vmmc: lbee1usjyc_vmmc {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&lbee1usjyc_pins>;
> +               compatible = "regulator-fixed";
> +               regulator-name = "regulator-lbee1usjyc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               gpio = <&gpio5 10 0>;   /* gpio_138 WIFI_PDN */

Is better if you use GPIO_ACTIVE_HIGH instead of 0 here.

> +               startup-delay-us = <10000>;
> +               enable-active-high;
> +               vin-supply = <&vdd33>;
> +       };
>  };
>
>  &omap3_pmx_core {
> @@ -48,6 +67,15 @@
>                 >;
>         };
>
> +       /* WiFi/BT combo */
> +       lbee1usjyc_pins: pinmux_lbee1usjyc_pins {
> +               pinctrl-single,pins = <
> +                       0x136 (PIN_OUTPUT | MUX_MODE4)  /* sdmmc2_dat5.gpio_137 */
> +                       0x138 (PIN_OUTPUT | MUX_MODE4)  /* sdmmc2_dat6.gpio_138 */
> +                       0x13a (PIN_OUTPUT | MUX_MODE4)  /* sdmmc2_dat7.gpio_139 */
> +               >;
> +       };
> +

Is this enough to correctly reset the chip or do you also have a patch
to do the init sequence on pdata-quirks.c?

>         mcbsp2_pins: pinmux_mcbsp2_pins {
>                 pinctrl-single,pins = <
>                         0x10c (PIN_INPUT | MUX_MODE0)           /* mcbsp2_fsx.mcbsp2_fsx */
> @@ -68,6 +96,17 @@
>                 >;
>         };
>
> +       mmc2_pins: pinmux_mmc2_pins {
> +               pinctrl-single,pins = <
> +                       0x128 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_clk.sdmmc2_clk */
> +                       0x12a (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_cmd.sdmmc2_cmd */
> +                       0x12c (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat0.sdmmc2_dat0 */
> +                       0x12e (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat1.sdmmc2_dat1 */
> +                       0x130 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat2.sdmmc2_dat2 */
> +                       0x132 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc2_dat3.sdmmc2_dat3 */
> +               >;
> +       };
> +
>         smsc911x_pins: pinmux_smsc911x_pins {
>                 pinctrl-single,pins = <
>                         0x1a2 (PIN_INPUT | MUX_MODE4)           /* mcspi1_cs2.gpio_176 */
> @@ -114,7 +153,11 @@
>  };
>
>  &mmc2 {
> -       status = "disabled";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc2_pins>;
> +       vmmc-supply = <&lbee1usjyc_vmmc>;
> +       bus-width = <4>;
> +       non-removable;
>  };
>
>  &mmc3 {
> --
> 1.8.1.2
>

Best regards,
Javier
