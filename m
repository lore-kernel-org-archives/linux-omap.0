From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: omap3-igep0030: add mux conf for GPIO LED
Date: Thu, 27 Jun 2013 10:09:47 +0200
Message-ID: <CAFqH_51E==SivBkQS3vc5OFPgw_V2Eo51d=s5iZdF03c9Gk0cg@mail.gmail.com>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
	<1371739352-19670-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:55095 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab3F0IJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 04:09:48 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so308792wes.13
        for <linux-omap@vger.kernel.org>; Thu, 27 Jun 2013 01:09:47 -0700 (PDT)
In-Reply-To: <1371739352-19670-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

2013/6/20 Javier Martinez Canillas <javier.martinez@collabora.co.uk>:
> The IGEP COM MOdule has a GPIO LED connected to OMAP
> pins. Configure this pin as output GPIO.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep0030.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 644d053..eee3c63 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -16,7 +16,10 @@
>         compatible = "isee,omap3-igep0030", "ti,omap3";
>
>         leds {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&leds_pins>;
>                 compatible = "gpio-leds";
> +
>                 boot {
>                          label = "omap3:green:boot";
>                          gpios = <&twl_gpio 13 GPIO_ACTIVE_LOW>;
> @@ -43,6 +46,12 @@
>         };
>  };
>
> +&leds_pins {
> +       pinctrl-single,pins = <
> +               0x5b0 (PIN_OUTPUT | MUX_MODE4) /* etk_d2.gpio_16 */
> +       >;
> +};
> +
>  &gpmc {
>         ranges = <0 0 0x00000000 0x20000000>;
>
> --
> 1.7.7.6
>
Tested-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
