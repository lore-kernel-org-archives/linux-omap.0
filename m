From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Sat, 6 Jul 2013 11:42:28 +0200
Message-ID: <CABxcv=mfOhZFG4yE7LG9FdGyz0bhN0qPB4ZTD4hTknAygWGs8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:53135 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3GFJm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jul 2013 05:42:29 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so2533322wgg.8
        for <linux-omap@vger.kernel.org>; Sat, 06 Jul 2013 02:42:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Fri, Jul 5, 2013 at 11:38 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> IGEP Processor Boards based on OMAP3 have the MCBSP2 connected to the TDM
> interface. The kernel should configure the pinmux for these pins in order
> to get TWL4030 codec working. Without this, for example, playing a wav file
> doesn't work.
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index bc48b11..2326d11 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -48,6 +48,15 @@
>                 >;
>         };
>
> +       mcbsp2_pins: pinmux_mcbsp2_pins {
> +               pinctrl-single,pins = <
> +                       0x10c (PIN_INPUT | MUX_MODE0)           /* mcbsp2_fsx.mcbsp2_fsx */
> +                       0x10e (PIN_INPUT | MUX_MODE0)           /* mcbsp2_clkx.mcbsp2_clkx */
> +                       0x110 (PIN_INPUT | MUX_MODE0)           /* mcbsp2_dr.mcbsp2.dr */
> +                       0x112 (PIN_OUTPUT | MUX_MODE0)          /* mcbsp2_dx.mcbsp2_dx */
> +               >;
> +       };
> +
>         mmc1_pins: pinmux_mmc1_pins {
>                 pinctrl-single,pins = <
>                         0x114 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_clk.sdmmc1_clk */
> @@ -93,6 +102,11 @@
>         clock-frequency = <400000>;
>  };
>
> +&mcbsp2 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mcbsp2_pins>;
> +};
> +
>  &mmc1 {
>        pinctrl-names = "default";
>        pinctrl-0 = <&mmc1_pins>;
> --
> 1.8.1.2
>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
