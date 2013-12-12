From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/7] usb: dwc3: keystone: add basic PM support
Date: Thu, 12 Dec 2013 15:43:06 -0600
Message-ID: <20131212214306.GS1939@saruman.home>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-2-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Sa0i77dkqaUxqYg"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386884325-11440-2-git-send-email-balbi@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, kgene.kim@samsung.com, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, w-kwok2@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

--1Sa0i77dkqaUxqYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 03:38:39PM -0600, Felipe Balbi wrote:
> A bare-minimum PM implementation which will
> server as building block for more complex
> PM implementation in the future.
>=20
> At the least will not leave clocks on unnecessarily
> when e.g.  a user write mem to /sys/power/state.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 94 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-key=
stone.c
> index 1fad161..361437f 100644
> --- a/drivers/usb/dwc3/dwc3-keystone.c
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/io.h>
>  #include <linux/of_platform.h>
> =20
> @@ -118,13 +119,23 @@ static int kdwc3_probe(struct platform_device *pdev)
> =20
>  	kdwc->clk =3D devm_clk_get(kdwc->dev, "usb");
> =20
> -	error =3D clk_prepare_enable(kdwc->clk);
> +	error =3D clk_prepare(kdwc->clk);
>  	if (error < 0) {
>  		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
>  			error);
>  		return error;
>  	}
> =20
> +	pm_runtime_enable(dev);
> +
> +	error =3D pm_runtime_get_sync(dev);
> +	if (error < 0) {
> +		dev_dbg(dev, "unable to pm_runtime_get_sync(), err %d\n",
> +				error);
> +		pm_runtime_put_sync(dev);

I can move this pm_runtime_sync() to error path, will refresh this
patch.

--=20
balbi

--1Sa0i77dkqaUxqYg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqi3qAAoJEIaOsuA1yqREvFUQAIfI6fo+i6pmno8dCLQ1Qts0
SBoklTJG+shpvdnFOeOmqbLoRvmqUfRFC1MKw/sAbFYV/4V+jVrXhacHWUzMtO0W
1bqZ/QxBIYJDkIkZdW/tqxqUkYMiI+I6+VLP0GAJ3Ghwdu/iSt7+xrjZh96kIjZQ
xbfZv6bxXxR5XA9S35askOFfvSoIRl9cjyqU2pFFQkmsQDbpx3x5JM6AIG7HbYhs
ml8qSjUC7CyJyHze7E3oIOsBU0RIePdqWK6TaaxZc2i8Sv2kvTZSMyavUiTUTgjR
oLT+w01XPOkbHR1YJmF8GV+FWMnyUb5cJeu4kTwBlAA2GrzLslH8eFdOcaSkjGch
9af4CYI2JKVC/YgoHNezlgTEcc23UsFm6e5ueRG62qyZ+hTbVpQ0GD54YuJnobYc
5isO+Abdw6fATTUelD38/cNTOpS2hRGIh1stVuVKbbl3bfVD0B9UNQeAu7UiM6zb
DXiCaipcRxFBRKDnGXG9YNRY6MiEMfY/Z75zE3YPYCGZ/8u5BwbrTh+Vb5voX1KY
CBslxIi+RarAOK6QFJ+zBOaYTVEJ5lZ/yXitkoKiuhnUbCmtmMSrkr80Agnh3DaQ
m6LxyLJ9ucAvZOv0t0GW6eq3mA7J5ntsfN2vaM9LTE7cl8P/YItXk1UY3KqoR6LZ
eJaP8eUEM1AZ8GKcbmMs
=FJKb
-----END PGP SIGNATURE-----

--1Sa0i77dkqaUxqYg--
