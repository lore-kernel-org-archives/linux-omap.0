From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] genirq: provide dummy set_irq_wake()
Date: Mon, 30 Mar 2015 13:06:24 -0500
Message-ID: <20150330180624.GB9513@saruman.tx.rr.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427721345-6402-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tglx@linutronix.de, cw00.choi@samsung.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 04:15:45PM +0300, Roger Quadros wrote:
> Without this system suspend is broken on systems that have
> drivers calling enable/disable_irq_wake() for interrupts based off
> the dummy irq hook.
> (e.g. drivers/gpio/gpio-pcf857x.c)
>=20
> http://article.gmane.org/gmane.linux.kernel/1879035
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  kernel/irq/dummychip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
> index 988dc58..2405d7a 100644
> --- a/kernel/irq/dummychip.c
> +++ b/kernel/irq/dummychip.c
> @@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
>  	return 0;
>  }
> =20
> +static int noop_int_ret(struct irq_data *data, unsigned int val)
> +{
> +	return 0;
> +}
> +

isn't this the same as noop_ret ?

--=20
balbi

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVGZCgAAoJEIaOsuA1yqRE6VEP/3eZfDqdXdBhO2L93GpZ7z8u
gjxRbHa52266ls30wCQDGyjtHctupmFmWE25I7ddYk05M0pcBXscf/Q6nxpwu+UB
GWYYtnzdlm2Kaw5rVH6pdfvV3y8bibuT9Xs+Y+fh1PwhyulOoII5p3UzEvln7QJQ
sp55SoHTmQRTbIcf/s++avsxxSFZRMyrrlEgdzRQWBgsVOAjFmvHiSShngV82V0X
PxkKR2L0nHjVkhds2KGDoD+EJ4Jdlnt7Kd6FrwcMaimKJeohtEVX2HAkOdJUZeVg
WXjhWOXuQChaEJm7noOHUvWSHiyaHHDy7kNOBbyU44wg+AXEgpd4Ssr9DmZr6LKz
Kyu0sIc/IUNL4mZOtBi4967v10hz9jKGxhyfOgVi0EC1CyO62iKsxqyddU2FFGG5
nRWVbC4DGQzHg9yELsoaOPsPog+2wHXy3oebr3bz4PADSm2ZdDfRredh9oon2/ZF
vVJCttxDf8pr88T/mdiZG1Ef3unGPdtGy6YPwzRqUhliOgf2ZNSdidsFlmPrdFK8
UqkFizxM1NuGdvx1hWFnF1iqKGeDWO6UFRMcEoEiGQEQdK/5AlBszl2LQlLuVIcH
fo2gANIqIShqrodwXBslXkdj60+vBJEkkzfJm4/sRwzXwP88U/ub4mXP4IkNotTU
P0KMb7mYKn3C4qrPlz0+
=WH5n
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
