From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] ARM: OMAP3: There is no FS USB controller on omap3
Date: Tue, 22 May 2012 10:06:45 +0300
Message-ID: <20120522070644.GA30559@arwen.pp.htv.fi>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190102.927.86158.stgit@muffinssi.local>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120521190102.927.86158.stgit-t/zwCYRDW5/25TI67NSWRg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 12:01:02PM -0700, Tony Lindgren wrote:
> We should not select ARCH_OMAP_OTG as the hardware does not
> have the legacy FS (Full Speed) USB interface.
>=20
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 4cf5142..0e4dd67 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -76,7 +76,6 @@ config SOC_OMAP3430
>  	bool "OMAP3430 support"
>  	depends on ARCH_OMAP3
>  	default y
> -	select ARCH_OMAP_OTG
> =20
>  config SOC_TI81XX
>  	bool "TI81XX support"
>=20

--=20
balbi

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPuzsEAAoJEIaOsuA1yqRElPUP/jVhn9VszhWzownbnXd0xf29
tCL8TtXJIRYR2DWJ3LhOUAyXL43O2IeuHu5QpuAz9hNfNiFuoYStrOJFhPZUsQn2
NHrgAZRvpUv/G2MVToyTnVzvUgW6F/aY4YG3bh+713jsPg5g3eQu5XR56Ugu1YpI
bHgQ3zdNB50kwBwddZcVfs6OBmSJ6aIJyynW0eaen+BS3Gl9WnykVtD8wBKhCgUV
rAzMT08W9V7EEh953q45dS9vCLgbuAynY/96FsVDWpVxvu6vQnWpLQvTPtXWsPBy
+4exyi4QwGgS3y0QjuOheeS/3tmcwrfQd3N65UAbJs0oVWGya6pOw3nVna/Y+3ka
DPenExBREvVPB/loIzUedZnAw7xHDyZfoJredggCnpeNAIcLl2iiUcZKSXdkU4xA
scjo7xVzmuJaRlJjwVn1zXueUfyzvmk2r4oFXJv2+v0ToTN8hCqkTdLr3Qi95MfV
oDCNYZjQtYKkvXnC4THWtJztha76mmw1F3npn8odOVvYQ1FP2U9CADH5cgmdD/wo
bLrRNy38ls21XHulh9NeHrGXIl5joPencf3cQWd6MduIWUrsPKaMG4EWGWHydLpn
fH7rwMS6EKdV3rJer+yVWUhSoNDvEp09RsMz/+X7EXqfEs20NezRhGZGY3TebTyJ
PBH1htWw4sbHbcC7GZ8x
=Zv7f
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
