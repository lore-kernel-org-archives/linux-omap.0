From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arch: arm: mach-omap2: usb-tusb6010.c:  Cleaning up
 variable is set more than once
Date: Fri, 27 Jun 2014 10:57:13 -0500
Message-ID: <20140627155713.GM8069@saruman.home>
References: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403699310-22960-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2014 at 02:28:30PM +0200, Rickard Strandqvist wrote:
> A struct member variable is set to the same value more than once
>=20
> This was found using a static code analysis program called cppcheck.
>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>

I think there was a bigger series from Roger rewriting most of this, but
if I'm mistaken:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-tusb6010.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb=
-tusb6010.c
> index e832bc7..8333400 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -95,7 +95,6 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
>  	dev_t.t_avdp_w =3D t_scsnh_advnh;
>  	dev_t.cyc_aavdh_we =3D 3;
>  	dev_t.cyc_wpl =3D 6;
> -	dev_t.t_ce_rdyz =3D 7000;
> =20
>  	gpmc_calc_timings(&t, &tusb_sync, &dev_t);
> =20
> --=20
> 1.7.10.4
>=20

--=20
balbi

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrZRZAAoJEIaOsuA1yqREtuwQAJOHyvyVnUtDT20I+RGkVhI9
K15ifWzoQ7eh0ZfeksLgvy3ilmNyt/q2IxiIhZ2UJXHkemD69EYDEWf/kLRlFlmO
sEzMrGPNI1uOVtmMgd/RdGTU+fvrv8a7gb63JkVGSLTjZnA2CDalKon7eQNpIFhc
cy/jQzG1B/nOnuvDCxfLxMcKQWkTIB46w2yWylU+0zr6ch0/9pviRpzuHB3jXM0m
GF6VM6DnqQwSp/YBrOBhvA26AUdVqGXdN5F2e3vRdOhHJaAOJ30lG+ZiOgeifKvH
tUTX3rKJzVvbVaYOvwSFjD5Dh3cZxJrLG13PzDeWLcJLol1CGySQoXwkaOAR2c5X
LwHyuSE33oUJgajM7ik20RPYj7sbaM9yuS0AT2+BqoFirPq/G8fxD4KWSeCEenP+
92/nDxEApRGLZKtNvwC77FXxyp3C5Z0TOAviZTD4pqiFiEN6qlwiAVunuKmWTBS7
IrPHmc+Db0FPHWq58Q7HfQ1FCNsmO2+PFbfgCHnyJXiHfoAz4T9URA30REk5MgAi
3oNcRAbdLMdTz+nfKvvNsb9/wssTG78tdzfdSdrDlY4mkaKvnURfnUYSSEtI/w2x
Gagu+O7D+/sZZZFvA2pOOtTHBv5MLUnQork5D6icsm9kKnjp+/l+UAJYjPsOc/mD
vktCFVAYxAtUq2vysTN4
=U2sB
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
