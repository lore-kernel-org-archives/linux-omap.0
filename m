From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
Date: Thu, 24 Dec 2015 13:33:22 -0300
Message-ID: <CABxcv=kjwE2JJ_NDWEF7goHaYpsbP5gMV4P_bHdwyj5iDk-SqA@mail.gmail.com>
References: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
	<1450971335-15961-4-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450971335-15961-4-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Uri,

On Thu, Dec 24, 2015 at 12:35 PM, Uri Mashiach
<uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
> Device tree modifications:
> - Pinmux for SPI0 and WiFi GPIOs.
> - SPI0 node with wlcore as a child node.
>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Acked-by: Igor Grinberg <grinberg-lB3UumIvzKrRNpEZXGUFxA@public.gmane.org>
> ---
> v1 -> v2: replace interrupts and interrupt-parent with interrupts-extended.
>
>  arch/arm/boot/dts/am335x-cm-t335.dts | 57 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
> index 42e9b66..31f8371 100644
> --- a/arch/arm/boot/dts/am335x-cm-t335.dts
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
> @@ -11,6 +11,7 @@
>  /dts-v1/;
>
>  #include "am33xx.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         model = "CompuLab CM-T335";
> @@ -40,6 +41,15 @@
>                 regulator-max-microvolt = <3300000>;
>         };
>
> +       /* Regulator for WiFi */
> +       vwlan_fixed: fixedregulator@2 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vwlan_fixed";
> +               gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>; /* gpio0_20 */
> +               enable-active-high;
> +               regulator-boot-off;
> +       };
> +
>         backlight {
>                 compatible = "pwm-backlight";
>                 pwms = <&ecap0 0 50000 0>;
> @@ -50,7 +60,10 @@
>
>  &am33xx_pinmux {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&bluetooth_pins>;
> +       pinctrl-0 = <
> +                 &bluetooth_pins
> +                 &wifi_pins
> +       >;

The pinctrl lines should be in the device node that needs the pin
muxing (unless there isn't a device node) so I think is better if you
mofe the pinctrl-0 = <&wifi_pins> to the wlcore dev node.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
