From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: omap3-igep0020: add mux conf for GPIO LEDs
Date: Fri, 12 Jul 2013 02:14:06 +0200
Message-ID: <CAAwP0s0Dvozi9BZ=zYdtkrdorg3gmGUqH-FDG3dTtMKyE6SgLg@mail.gmail.com>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371739352-19670-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57568 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab3GLAO0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jul 2013 20:14:26 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so18363856iec.8
        for <linux-omap@vger.kernel.org>; Thu, 11 Jul 2013 17:14:26 -0700 (PDT)
In-Reply-To: <1371739352-19670-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Thu, Jun 20, 2013 at 4:42 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The IGEPv2 has a number of GPIO LED connected to OMAP
> pins. Configure these pins as output GPIO.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep0020.dts |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
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
> --

Hi Benoit,

These patches are actually a fix since without setting the mux pin for
the GPIO makes the gpio led driver probe fails and the user leds are
not available. So, it would be possible to add these as part of the
3.11 -rc cycle fixes?

Thanks a lot and best regards,
Javier
