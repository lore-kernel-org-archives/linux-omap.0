From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 2/4] power: supply: bq27xxx: enable writing capacity
 values for bq27500
Date: Thu, 31 Aug 2017 10:38:10 +0200
Message-ID: <20170831083810.pk7d2qqetwc356rs@earth>
References: <cover.1504162792.git.hns@goldelico.com>
 <af9c1a4e95640e744a104780bfed269d0a6c63cb.1504162792.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plyamg76nvk3t7m6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <af9c1a4e95640e744a104780bfed269d0a6c63cb.1504162792.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: afd@ti.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--plyamg76nvk3t7m6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 31, 2017 at 08:59:51AM +0200, H. Nikolaus Schaller wrote:
> Tested on OpenPandora with bq27500.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index e80571cf7be1..5562f998330f 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -653,15 +653,11 @@ enum bq27xxx_dm_reg_id {
>  #define bq2751x_dm_regs 0
>  #define bq2752x_dm_regs 0
> =20
> -#if 0 /* not yet tested */
>  static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
>  	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 10, 2,    0, 65535 },
>  	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { }, /* missing on chip */
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 48, 2, 1000, 32767 },
>  };
> -#else
> -#define bq27500_dm_regs 0
> -#endif
> =20
>  /* todo create data memory definitions from datasheets and test on chips=
 */
>  #define bq27510g1_dm_regs 0
> --=20
> 2.12.2
>=20

--plyamg76nvk3t7m6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmnyvIACgkQ2O7X88g7
+ppLlQ//XoR0Hs7BnqgbBgNIkqfaC4abz+cCQ9TYCFrqyKJa/W75mL4bhjcXu8ZN
f4WBubWJ0tR7HjxP7cHvzgYkDpZykdC4JznB5McKrndCLGyDrxd+Jpw72WdWWAMN
RlOQ4O5FNyXHVHbiztqeRUdJ/25JI304SD5RIEE/vZ6RzJ1Kc5FQNR/PhH4lxfI3
uG+Iek7N7l0guV/yHxBKzZtAiXf4uBpYZRNpSk7EJKiPnEPxW1qYjidKQbFPGjQg
3IG7RVArlm3nDjZFpmM81IWVtrlTevq7IQi9ievREYAzf3NRaJvqFzsqJzN+hw9F
n/yf/8kyTx7EaUYr+QAGEknlU/V8w8E0mSyuTNliB8ZkfXsOL6TRZh2U+cOC8SlP
iK5xHVFOTvxyVRzWyVWu5hUM292hIQ12kFt6CPSfu2EGNL+YtQnmBK2KA0lN2X14
4Sxxozm/KaWfa5Zelts9/a8r8Az//mGjiPfy+4XwokWnMc9ZU/4dO6dCK7wnjf0i
C7QDveRdDMDqhiD6ZEgDXJG2lqUCQGxE1PryzqXoVTXHxpoqkh1Sd8eZXb3crNir
UKij0FHbjC758Szg8OFpJhKJKzDet5Z3ePRxsdHefrL+BZk68UGXXvazKhXZneyR
JiTRZpTsQYUnQXOEuJsZkpOefZ5rWWlQ8s+nLSzkr7zpefXcR4U=
=VpbH
-----END PGP SIGNATURE-----

--plyamg76nvk3t7m6--
