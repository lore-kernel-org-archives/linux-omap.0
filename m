From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Tue, 10 Sep 2013 17:38:08 +0200
Message-ID: <CAFqH_503dztqH0XEohTyV8VCZiNHsrwk1ahKFXgz6DzKDc-fAQ@mail.gmail.com>
References: <1378827323-15433-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:49027 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab3IJPiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Sep 2013 11:38:10 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so5820145wes.13
        for <linux-omap@vger.kernel.org>; Tue, 10 Sep 2013 08:38:09 -0700 (PDT)
In-Reply-To: <1378827323-15433-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

2013/9/10 Enric Balletbo i Serra <eballetbo@gmail.com>:
> Add pinmux configuration for MCBSP2 connected to the TDM interface. With
> this configuration the Headset modules works as expected.
>
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
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

Hi Benoit,

I sent this patch some time ago to be merged as a fix for 3.11, but
seems was not merged. Would be possible include this patch in these
series ?

Best regards,
    Enric
