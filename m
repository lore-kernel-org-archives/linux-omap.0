From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
Date: Thu, 27 Jun 2013 10:09:21 +0200
Message-ID: <CAFqH_53ceOcGsU8Aq+D1-CXnFX5aanOpOd0_Bh+j+qX9UTj82w@mail.gmail.com>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
	<1371739352-19670-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:62731 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3F0IJW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 04:09:22 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so306791wgg.20
        for <linux-omap@vger.kernel.org>; Thu, 27 Jun 2013 01:09:21 -0700 (PDT)
In-Reply-To: <1371739352-19670-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

2013/6/20 Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> The IGEPv2 has a number of GPIO LED connected to OMAP
> pins. Configure these pins as output GPIO.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep0020.dts |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts
> b/arch/arm/boot/dts/omap3-igep0020.dts
> index e8c4828..51c084e 100644
> --- a/arch/arm/boot/dts/omap3-igep0020.dts
> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
> @@ -16,7 +16,10 @@
>         compatible = "isee,omap3-igep0020", "ti,omap3";
>
>         leds {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&leds_pins>;
>                 compatible = "gpio-leds";
> +
>                 boot {
>                          label = "omap3:green:boot";
>                          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> @@ -54,6 +57,14 @@
>         };
>  };
>
> +&leds_pins {
> +       pinctrl-single,pins = <
> +               0x5c4 (PIN_OUTPUT | MUX_MODE4) /* etk_d12.gpio_26 */
> +               0x5c6 (PIN_OUTPUT | MUX_MODE4) /* etk_d13.gpio_27 */
> +               0x5c8 (PIN_OUTPUT | MUX_MODE4) /* etk_d14.gpio_28 */
> +       >;
> +};
> +
>  &i2c3 {
>         clock-frequency = <100000>;
>
> --
> 1.7.7.6
>
Tested-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
