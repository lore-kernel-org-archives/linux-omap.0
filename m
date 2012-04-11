From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
Date: Wed, 11 Apr 2012 14:35:38 +0300
Message-ID: <20120411113537.GG12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HZmXSWY/1Xf1kK7R"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334142776-10583-15-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--HZmXSWY/1Xf1kK7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
> Use SET_RUNTIME_PM_OPS macro to set runtime functions.
>=20
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index dd65416..28de1d2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct device =
*dev)
> =20
>  	return 0;
>  }
> +#endif
> =20
>  static struct dev_pm_ops omap_i2c_pm_ops =3D {
> -	.runtime_suspend =3D omap_i2c_runtime_suspend,
> -	.runtime_resume =3D omap_i2c_runtime_resume,
> +	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> +			   omap_i2c_runtime_resume, NULL)
>  };
> -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> -#else
> -#define OMAP_I2C_PM_OPS NULL
> -#endif

I think you should keep this define, otherwise the pm pointer will
always be valid.

--=20
balbi

--HZmXSWY/1Xf1kK7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhWyJAAoJEIaOsuA1yqREpdsQAILOy7nuY224tsxbOu3cIiB4
fYa9QAHgpYj492glMxkfzdHAivnuTzdgKRHBKzikH8u7QvBnZ//QvE30cpinBV/1
uFM1qRsAjPgLkVKjgnRgGxCOrWGDYisTiI+1WY46Nj+kg7nIwaIuiphalds2RAww
VXHv2yPdNxrdbdm94d3RTN9tFGcRcMqgpw1K6Ql7+oRFnfwmW46Xp0pBoQB3jtGe
lsS9qLPLX0xjbjhkqsoorFzhPlE+d2HiJrbA5b9zx7oYSfSyunfq9nrxlMIcYqPG
L/kbERRS2r59cv4XPACZUeDG1Rd7YSwT7Ec6coZp3P0x33JhN77RXyWqBU5VDiJO
u3x6Frk5NJgirYY/59FC37WJrcYLwnl4BQC7OtmAPNJ9Kvm+zi9ZJWW06XZ5P/Vs
Tsa4Tx44XvqU03nJuI+sstmq9BTX1vzf9xo5oXGxkKMM1TsTzRPsXyDAzt+xbBwm
KoS7sEFKBSfaazVNwXhIAiklpsL/8IhGR9JXZbI+xfnNhgT9gnz4nUaDER77zUCU
k9Txf1e3DyPUIvCkcTg4r7eq1GlKyM1LJLX4ZCMRZeyxDrJmFTIPRpG38PZUlPVV
vcfNWmaLyVBUrzkcMQxZq6soFah5AU5JMB5FXRXKymARbzrm+fb0zcGCsz1asWHF
wQ9fMgxZUO3xl0I8656a
=YR3t
-----END PGP SIGNATURE-----

--HZmXSWY/1Xf1kK7R--
