From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/3] wlcore/wl12xx: spi: add device tree support
Date: Thu, 24 Dec 2015 13:25:42 -0300
Message-ID: <CABxcv=nS_RSXotJXqjY4QR3zDgM5iviC=YVwhjG=408znW1hiQ@mail.gmail.com>
References: <1450971335-15961-1-git-send-email-uri.mashiach@compulab.co.il>
	<1450971335-15961-3-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450971335-15961-3-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Uri,

On Thu, Dec 24, 2015 at 12:35 PM, Uri Mashiach
<uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org> wrote:
> Add DT support for the wl1271 SPI WiFi.
>
> Add documentation file for the wl1271 SPI WiFi.
>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> ---
> v1 -> v2: update interrupt documentation.
>           replace interrupts and interrupt-parent with interrupts-extended.
>           IRQ parameters retrieved from spi_device instead of DT.
>           remove redundant #ifdef CONFIG_OF
>
>  .../bindings/net/wireless/ti,wlcore,spi.txt        | 34 +++++++++++++
>  drivers/net/wireless/ti/wlcore/spi.c               | 55 ++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt
>
> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt b/Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt
> new file mode 100644
> index 0000000..502c27e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/ti,wlcore,spi.txt
> @@ -0,0 +1,34 @@
> +* Texas Instruments wl1271 wireless lan controller
> +
> +The wl1271 chip can be connected via SPI or via SDIO. This
> +document describes the binding for the SPI connected chip.
> +
> +Required properties:
> +- compatible :          Should be "ti,wl1271"
> +- reg :                 Chip select address of device
> +- spi-max-frequency :   Maximum SPI clocking speed of device in Hz
> +- ref-clock-frequency : Reference clock frequency
> +- interrupts-extended : Should contain parameters for 1 interrupt line.
> +                        Interrupt parameters: parent, line number, type.
> +- vwlan-supply :        Point the node of the regulator that powers/enable the wl1271 chip
> +
> +Optional properties:
> +- clock-xtal :          boolean, clock is generated from XTAL
> +
> +- Please consult Documentation/devicetree/bindings/spi/spi-bus.txt
> +  for optional SPI connection related properties,
> +
> +Examples:
> +
> +&spi1 {
> +       wl1271@1 {
> +               compatible = "ti,wl1271";
> +
> +               reg = <1>;
> +               spi-max-frequency = <48000000>;
> +               clock-xtal;
> +               ref-clock-frequency = <38400000>;
> +               interrupts-extended = <&gpio3 8 IRQ_TYPE_LEVEL_HIGH>;
> +               vwlan-supply = <&vwlan_fixed>;
> +       };
> +};
> diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
> index d3a4bcb..e9e8d54 100644
> --- a/drivers/net/wireless/ti/wlcore/spi.c
> +++ b/drivers/net/wireless/ti/wlcore/spi.c
> @@ -30,6 +30,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/wl12xx.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/regulator/consumer.h>
>
>  #include "wlcore.h"
> @@ -357,6 +358,46 @@ static struct wl1271_if_operations spi_ops = {
>         .set_block_size = NULL,
>  };
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id wlcore_spi_of_match_table[] = {
> +       { .compatible = "ti,wl1271" },
> +       { }
> +};

Could you please add a MODULE_DEVICE_TABLE(of, wlcore_spi_of_match_table) here?

> +
> +/**
> + * wlcore_probe_of - DT node parsing.
> + * @spi: SPI slave device parameters.
> + * @res: resource parameters.
> + * @glue: wl12xx SPI bus to slave device glue parameters.
> + * @pdev_data: wlcore device parameters
> + */
> +static int wlcore_probe_of(struct spi_device *spi, struct wl12xx_spi_glue *glue,
> +                          struct wlcore_platdev_data *pdev_data)
> +{
> +       struct device_node *dt_node = spi->dev.of_node;
> +       int ret;
> +
> +       if (of_find_property(dt_node, "clock-xtal", NULL))
> +               pdev_data->ref_clock_xtal = true;
> +
> +       ret = of_property_read_u32(dt_node, "ref-clock-frequency",
> +                                  &pdev_data->ref_clock_freq);
> +       if (IS_ERR_VALUE(ret)) {
> +               dev_err(glue->dev,
> +                       "can't get reference clock frequency (%d)\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +#else /* CONFIG_OF */
> +static int wlcore_probe_of(struct spi_device *spi, struct wl12xx_spi_glue *glue,
> +                          struct wlcore_platdev_data *pdev_data)
> +{
> +       return -ENODATA;
> +}
> +#endif /* CONFIG_OF */
> +

I don't understand what's the point of making the driver to be built
with !CONFIG_OF if the probe function is going to fail anyways. If
this driver really need then is better to remove the ifdefery and make
the Kconfig symbol to depend on OF.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
