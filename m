From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 5/6] pwm: enable TI PWMSS if the IIO tiecap driver is
 selected
Date: Wed, 26 Feb 2014 15:15:10 +0100
Message-ID: <20140226141508.GF29779@ulmo.nvidia.com>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
 <1391626901-31684-6-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391626901-31684-6-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux IIO List <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2014 at 02:01:40PM -0500, Matt Porter wrote:
> The IIO TI ECAP driver depends on the TI PWMSS management
> driver in this subsystem. Enable PWMSS when the IIO TI ECAP
> driver is selected.
>=20
> Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 22f2f28..bd3cc65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -219,7 +219,7 @@ config  PWM_TIEHRPWM
> =20
>  config  PWM_TIPWMSS
>  	bool
> -	default y if SOC_AM33XX && (PWM_TIECAP || PWM_TIEHRPWM)
> +	default y if SOC_AM33XX && (IIO_TIECAP || PWM_TIECAP || PWM_TIEHRPWM)
>  	help
>  	  PWM Subsystem driver support for AM33xx SOC.

Perhaps this module should move out of drivers/pwm if it's no longer a
PWM specific module.

Thierry

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDfbsAAoJEN0jrNd/PrOhECAP/j2I0zpD7fFA5CK5JNLz4ZdF
Fxp0JEtEAPHhw/36hcUiillkwbnl3bmPGEsFLjIOmyL22LvMkmiOGsAgkQjcPvcJ
6cNwu/cn56t4L4k+jQAa0oSCqMIyQTASCUC13b+L/1tGUwBvoXnStarLcBQuWrTX
fcNs8PCHXqe59+/xL81eIgFMxJuWJ8XvuDWW8jrL9ffg9RH6s5VqZcu5u0WhISlf
jw+VJurPAZskB553Ve6QFMLAsf5xvfmu4R4Tm7U2vlDxzdYLbEQWCRf87HVipKQr
3MC3Rm9W2vAFKFFJFwx5oz1WnsCkH7BYt0MyfSn3Tt8WP6TXgS7dZRa85zt42E4P
4XdUaVTFJ3/ikuFQdVUlD3Hlp4fWZX1TxTBPHF7fiwUxSdkO+PtwYgdmAJvIjEIt
gFzhX+6de9xBAbj6ei/1VWx9CUPUaKC00GpB9UwuwjYiWAuzuSmc9yIke515Vg8f
fvtv+b9fgpeU3j5UZ2pXyZKsk2ONZfGQjavEZw99/rM/v+BKXs3PpiGKkOJex+s6
Cgn0KbhGtvQwKWj55lKLW52G6QHpJlmSE/UCQrcI0sVenrQZt/5nld4JuTKMmKrY
kSKE9dzozmTLVVHmufj2vojfIWLMXdwl7wGr+mOfxs/wb41Z7gDV1+uZZgpXZ/sT
Wivk3DjAFknD5cmFYupo
=gNT3
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
