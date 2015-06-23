From: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: pci: make better use of gpiod API
Date: Tue, 23 Jun 2015 13:01:16 +0300
Message-ID: <20150623100116.GB1296@kuha.fi.intel.com>
References: <1434093019-14009-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434093019-14009-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 12, 2015 at 09:10:19AM +0200, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for outp=
ut.
>=20
> Furthermore there is devm_gpiod_get_optional which is designed to get
> optional gpios. Also use devm_gpiod_get* because otherwise the gpio
> might be grabbed by a different driver.

These gpios are later given to the phy driver. We handle them in this
quirk separately because otherwise the phy can not be probed as it
may still be in reset.

So we are just turning the phy "on" here, and then releasing the gpios
so the phy driver can take over.

> diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.=
c
> index 27e4fc896e9d..7e308730f955 100644
> --- a/drivers/usb/dwc3/dwc3-pci.c
> +++ b/drivers/usb/dwc3/dwc3-pci.c
> @@ -84,18 +84,19 @@ static int dwc3_pci_quirks(struct pci_dev *pdev)
>  					  acpi_dwc3_byt_gpios);
> =20
>  		/* These GPIOs will turn on the USB2 PHY */
> -		gpio =3D gpiod_get(&pdev->dev, "cs");
> -		if (!IS_ERR(gpio)) {
> -			gpiod_direction_output(gpio, 0);
> -			gpiod_set_value_cansleep(gpio, 1);
> -			gpiod_put(gpio);
> -		}
> +		gpio =3D devm_gpiod_get_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
> +		if (IS_ERR(gpio))
> +			return PTR_ERR(gpio);
> +
> +		gpiod_set_value_cansleep(gpio, 1);
> +
> +		gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset",
> +					       GPIOD_OUT_LOW);
> +		if (IS_ERR(gpio))
> +			return PTR_ERR(gpio);
> =20
> -		gpio =3D gpiod_get(&pdev->dev, "reset");
> -		if (!IS_ERR(gpio)) {
> -			gpiod_direction_output(gpio, 0);
> +		if (gpio) {
>  			gpiod_set_value_cansleep(gpio, 1);
> -			gpiod_put(gpio);

So we still need to release the gpio here, or we break the platforms
where we have these gpios.


Thanks,

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
