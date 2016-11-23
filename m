From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] bq24190_charger: Fix PM runtime use for
 bq24190_battery_set_property
Date: Wed, 23 Nov 2016 23:35:33 +0100
Message-ID: <20161123223533.gmt7joee3kzhjk5p@earth>
References: <20161115033831.7620-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4p7jirqhaqww3yg"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115033831.7620-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--u4p7jirqhaqww3yg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 14, 2016 at 07:38:31PM -0800, Tony Lindgren wrote:
> There's a typo, it should do pm_runtime_get_sync, not put.
>=20
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/bq24190_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1141,7 +1141,7 @@ static int bq24190_battery_set_property(struct powe=
r_supply *psy,
> =20
>  	dev_dbg(bdi->dev, "prop: %d\n", psp);
> =20
> -	pm_runtime_put_sync(bdi->dev);
> +	pm_runtime_get_sync(bdi->dev);
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:

Thanks, queued to power-supply's for-next branch. I added

Fixes: d7bf353fd0aa3

-- Sebastian

--u4p7jirqhaqww3yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg2GbAACgkQ2O7X88g7
+por6w/8CTAw1hFoS25Wtaq9AdwDX37NREcZyGTWyAxPeTPO/ja1sRdbUhlb7Nn1
W2J5IF0WCBXcSa0aJTdzYyMJsaSMnU9baUK8VhndxAkdXpfmw4zzZhyuTA+DQ9xT
TG0ji0bZ3E7g4sxTcItXnKJyZFWvdHLGVch8pCskfglgtSS9+e5NavZI2U5m86ZM
zZt9S2fgtz48Ui5q8LFzNloQeyQ1MsyLtvv1JPIutcGcnjk0hjGFFodVCrqXLdfH
DwGM9RR/LFyy7zLxIqkQhZkPsdBhB2mkAYPwGAdbKf7euYUKOV1rEaa+F3RNJ4Tx
5W1r8w6/wKQTumSZwlNByxj1q/6vITmxQYbesZrfZ2IWTRG4tas7w31J/RXdwNB3
aQPo5zPUFkZCmrnVrApHdEOprf/0+V0WzS346Ow9hEeNWwlNwpvMvRVwICKRSdnC
7TdbLfc2RCbacYdRlBecM1Funrx5Bkow/74/HJIn/aHkGF9WnErRBFNGMXQLTwXg
NYxbkjNLPiZYyBDsC8RYmON3H+S+YOhDLmdxAVqvLi/+Rq7lgDuVzK/SNIlJgeg6
bMDB7vDTQxnlfuOTtDSlAM5SqlppTSruu79igsqLA/pz2x909yiEzHK/ef1Zw+Cj
lq7zue0vWnBQPQPE/Qtthflrxecj5zpKwauZGKqy1Iot6J/RJ1g=
=zk0G
-----END PGP SIGNATURE-----

--u4p7jirqhaqww3yg--
