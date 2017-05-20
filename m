From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] iio: adc: cpcap: Remove hung interrupt quirk
Date: Sat, 20 May 2017 14:29:11 +0200
Message-ID: <20170520122910.hqhphtrdr3wucnga@earth>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xk6kwxhd66whfppm"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170519034035.16795-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--xk6kwxhd66whfppm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 18, 2017 at 08:40:35PM -0700, Tony Lindgren wrote:
> This is no longer needed as the real problem was interrupt flags
> not getting passed properly from device tree to the cpcap-core.c
> mfd driver. This got fixed with commit ac89473213c6 ("mfd: cpcap:
> Fix interrupt to use level interrupt") So let's remove ADC
> interrupt specific the quirk.
>=20
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

> ---
>  drivers/iio/adc/cpcap-adc.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>=20
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -89,7 +89,7 @@
>  #define ST_ADC_CAL_BATTI_LOW_THRESHOLD	494
>  #define ST_ADC_CALIBRATE_DIFF_THRESHOLD	3
> =20
> -#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration and quirk */
> +#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
> =20
>  /**
>   * struct cpcap_adc_ato - timing settings for cpcap adc
> @@ -635,27 +635,6 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *d=
data,
>  	}
>  }
> =20
> -/*
> - * Occasionally the ADC does not seem to start and there will be no
> - * interrupt. Let's re-init interrupt to prevent the ADC from hanging
> - * for the next request. It is unclear why this happens, but the next
> - * request will usually work after doing this.
> - */
> -static void cpcap_adc_quirk_reset_lost_irq(struct cpcap_adc *ddata)
> -{
> -	int error;
> -
> -	dev_info(ddata->dev, "lost ADC irq, attempting to reinit\n");
> -	disable_irq(ddata->irq);
> -	error =3D regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> -				   CPCAP_BIT_ADTRIG_DIS,
> -				   CPCAP_BIT_ADTRIG_DIS);
> -	if (error)
> -		dev_warn(ddata->dev, "%s reset failed: %i\n",
> -			 __func__, error);
> -	enable_irq(ddata->irq);
> -}
> -
>  static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
>  				struct cpcap_adc_request *req)
>  {
> @@ -673,7 +652,6 @@ static int cpcap_adc_start_bank(struct cpcap_adc *dda=
ta,
>  			return 0;
> =20
>  		if (error =3D=3D 0) {
> -			cpcap_adc_quirk_reset_lost_irq(ddata);
>  			error =3D -ETIMEDOUT;
>  			continue;
>  		}
> --=20
> 2.13.0

--xk6kwxhd66whfppm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkgNpQACgkQ2O7X88g7
+prKIA/7BDwF9wETmLxKnZJ7oXFX3H0xh99IzK5dY5AGcpIiZWxxPPL0HKEWgjO2
L0NMtx8PFN2pKOxjz0aKBjRAnGG1THkiugArOH+XkufTF9g8KwDPEK24cL2X+9X4
TpYJljbJmaCMHUz6CocBQUvoE+NIU+i2+6BMWXM52Jt4t6THi+dUpa5NWh4o/CSu
e6Lfa526hi72IYmH+n7gPlmeQWOcHR5FctpoBrjbQTQP3AM5xD0WsVj1s2YysWyq
JXSRbal0n46hIj6GoT7x36KSwSEkgLqfFB+FV9ILlQbZXD4R/ouXT96wrL6Ld0bz
IWUwRi/yaxiiSxiTVzlEd3WTV8n7GPjz5xO3ZTCYL17mDi2eXpY6mJh4+gFZQ1mu
3NDWR32hnrrLgImxBvi8jVp2Eb4CsvAxpWoUE4lkLpQOduz3QY5tQwNEEcl4GlcC
1Vm5ftu8dOzszvugYLOAsmo4P3hNFPF1liNQjSIYdpI01TpVy8sj3lCRaSEndWza
LpvGjnSZH1mlIAEcQJNhMX2EKVH4hdTYw2wbuawL3VG5lN4oPe4AE/um9yLlnSHt
3++zHW/PQJjE161JbZe3/nR15WiBjh8jfkLnY6o2KPI5DL2JYQGlAEcH06eTUriS
xGUXLfLZRddicYFpTUYgpSgIp6OdaQ8eCdvlNVfczX+VIBuy4UE=
=38Ql
-----END PGP SIGNATURE-----

--xk6kwxhd66whfppm--
