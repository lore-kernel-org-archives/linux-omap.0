From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/5] HSI: nokia-modem: drop support for disabled pm
Date: Sun, 31 Jan 2016 12:24:34 +0100
Message-ID: <201601311224.34249@pali>
References: <1454203187-688-1-git-send-email-sre@kernel.org> <1454203187-688-5-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5848325.kOtS8rGoBT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454203187-688-5-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart5848325.kOtS8rGoBT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 31 January 2016 02:19:46 Sebastian Reichel wrote:
> Disabled power management means, that the driver can only be
> used together with further out-of-tree kernel patches. There
> is no reason to support this in the mainline kernel and not
> having support for it means, that userspace can automatically
> detect if we are running kernel based power management.

Hi!

I'm against this change. It will break support for (patched) Maemo and=20
proprietary Nokia sscd modem daemon.

Also you can export GPIOs manually via sysfs and touch that state. Which=20
means that you can do power management with mainline kernel even if you=20
set nokia-modem.pm=3D0. So please drop this patch.

> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/hsi/clients/nokia-modem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hsi/clients/nokia-modem.c
> b/drivers/hsi/clients/nokia-modem.c index 1b4a250cf113..5e333eb82912
> 100644
> --- a/drivers/hsi/clients/nokia-modem.c
> +++ b/drivers/hsi/clients/nokia-modem.c
> @@ -33,7 +33,7 @@
>  static unsigned int pm =3D 1;
>  module_param(pm, int, 0400);
>  MODULE_PARM_DESC(pm,
> -	"Enable power management (0=3Ddisabled, 1=3Duserland based [default],
> 2=3Dkernel based)"); +	"Enable power management (1=3Duserland based
> [default], 2=3Dkernel based)");
>=20
>  struct nokia_modem_device {
>  	struct tasklet_struct	nokia_modem_rst_ind_tasklet;
> @@ -198,6 +198,11 @@ static int nokia_modem_gpio_probe(struct device
> *dev) struct nokia_modem_device *modem =3D dev_get_drvdata(dev);
>  	int gpio_count, gpio_name_count, i, err;
>=20
> +	if (pm !=3D 1 && pm !=3D 2) {
> +		dev_err(dev, "invalid pm configuration!");
> +		return -EINVAL;
> +	}
> +
>  	gpio_count =3D of_gpio_count(np);
>=20
>  	if (gpio_count < 0) {

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5848325.kOtS8rGoBT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlat7vIACgkQi/DJPQPkQ1L6PgCdGE6ahvJDweOzeG+s/JcOCwvP
YMAAoK+TRUQyf+Xn9lJ3jpJllt0N8P8S
=3OyU
-----END PGP SIGNATURE-----

--nextPart5848325.kOtS8rGoBT--
