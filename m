From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap3-igep: add pinmux node for GPIO LED configuration
Date: Sat, 3 Aug 2013 21:11:08 +0200
Message-ID: <CAAwP0s0BqsWqhi4vRxLHjDWdaVhPy2TL6syydV-=+vAYioi6ig@mail.gmail.com>
References: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61051 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3HCTL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Aug 2013 15:11:28 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so3140989obc.24
        for <linux-omap@vger.kernel.org>; Sat, 03 Aug 2013 12:11:28 -0700 (PDT)
In-Reply-To: <1371739352-19670-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: benoit.cousson@linaro.org, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Thu, Jun 20, 2013 at 4:42 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> IGEP boards have a number of LED connected to OMAP or TWL GPIO
> lines. The actual wiring is different on each board so each board
> DT has need to configure the mux correctly.
>
> Even though it works with the current DT, the kernel complains with:
>
> [2.305023] leds-gpio leds.18: pins are not configured from the driver
>
> Add an empty pinmux_leds_pins pinctrl child node so boards can
> override with the correct mux configuration and not depend on
> default values for the GPIO LEDs to work.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index bc48b11..55f9f61 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -68,6 +68,8 @@
>                         0x1a2 (PIN_INPUT | MUX_MODE4)           /* mcspi1_cs2.gpio_176 */
>                 >;
>         };
> +
> +       leds_pins: pinmux_leds_pins { };
>  };
>
>  &i2c1 {
> --
> 1.7.7.6
>
> --

Hi Benoit,

Any feedback about this patch-set?

Thanks a lot and best regards,
Javier
