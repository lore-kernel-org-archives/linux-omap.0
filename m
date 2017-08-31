From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v3 1/4] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Thu, 31 Aug 2017 10:37:36 +0200
Message-ID: <20170831083736.7vb576hu4ygub57k@earth>
References: <cover.1504162792.git.hns@goldelico.com>
 <8d323718d7d1dcd7633da236abcd782f88200113.1504162792.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ojeyvbusc3s4kfco"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8d323718d7d1dcd7633da236abcd782f88200113.1504162792.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: afd-l0cyMroinI0@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--ojeyvbusc3s4kfco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 31, 2017 at 08:59:50AM +0200, H. Nikolaus Schaller wrote:
> Tested on Pyra prototype with bq27421.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index ad876a3abe01..e80571cf7be1 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -688,15 +688,11 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
>  #define bq27545_dm_regs 0
>  #endif
> =20
> -#if 0 /* not yet tested */
>  static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
>  	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0,  8000 },
>  	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2500,  3700 },
>  };
> -#else
> -#define bq27421_dm_regs 0
> -#endif
> =20
>  static struct bq27xxx_dm_reg bq27425_dm_regs[] =3D {
>  	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 12, 2,    0, 32767 },
> --=20
> 2.12.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ojeyvbusc3s4kfco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmnys0ACgkQ2O7X88g7
+prr/RAAlHRjwOT/Be6Ozna8MIhcAgkmp/pBw8/9nfpEYCObFE83hBxyVYuJn8yY
b0d0Ze8blJTNAvZdWD7dcdLabnvQzEeUezxLHVyxbsmvj5TdMhZbSZObgFmsbpBF
KeB5LNqUq8YB6sgjS4kvwOeKy97zx2Sq0xiAkPZ9F8bRDAAnnETFpgXSt3IYqftB
cIGI92D6RMWdF5776+FuaHwJLoZpajSztRqU9V7aydCGkWoV+1l69k+X/jpUZrfP
jiqEWmTOcvK/8Xk0YiQboJ6gBzuy/WB7/TVceurM5xj1UiuitUUHVoLRHWMg46LC
FDouRxtwCMDlYx5/0s0c2qCjarUXMM0850PtZdLsbbWI6EyUsbIPKAugca608olB
/RyxyIAOJwNSOW/t+Ti5w0p6GgDOS5S7GIg/4sxBN7CDwZsaA1NGY4X6ca573HYB
VgZiceWrbSPPaHGEEZ3gmB09UiBA6sw1hf0c8K20t6Qr13XQSX/uDvLdWht8siZj
Sjb7v5T2wYS1O/9pNF2uQsmvKC3WBSfF4MrNNt34KI/7/sjgCnIV1Vs8DHfibIZS
92zD/2sngsBUw875YUMbpXFod5tdUsZnDo+xypByWg+lWbSKbnIlNQi5tTU6JKF1
SuGXYVY9R4PcDxXYG1+5v64PxEpBZ7lOabJqIt2S3bX/45t2gWY=
=80LP
-----END PGP SIGNATURE-----

--ojeyvbusc3s4kfco--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
