From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] bq24190: Simplify code in property_is_writeable
Date: Tue, 9 Jan 2018 17:21:54 +0100
Message-ID: <20180109162154.ewgp5bbuxlaesgwz@earth.universe>
References: <20171227092041.GA14507@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uownwn2qz3fjurl6"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171227092041.GA14507@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--uownwn2qz3fjurl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 27, 2017 at 10:20:42AM +0100, Pavel Machek wrote:
> Simplify function that should be trivial.
>=20
> Signed-off-by: Pavel machek <pavel@ucw.cz>

Thanks, queued.

-- Sebastian

> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 35ff406..4ea8f0a 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1193,8 +1193,6 @@ static int bq24190_charger_set_property(struct powe=
r_supply *psy,
>  static int bq24190_charger_property_is_writeable(struct power_supply *ps=
y,
>  		enum power_supply_property psp)
>  {
> -	int ret;
> -
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
>  	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> @@ -1202,13 +1200,10 @@ static int bq24190_charger_property_is_writeable(=
struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> -		ret =3D 1;
> -		break;
> +		return 1;
>  	default:
> -		ret =3D 0;
> +		return 0;
>  	}
> -
> -	return ret;
>  }
> =20
>  static void bq24190_input_current_limit_work(struct work_struct *work)
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--uownwn2qz3fjurl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpU7BEACgkQ2O7X88g7
+ppXeA/9Eo3GtrcOyAp1zQAN81D+SZ7XmPqIcu9jcdIYCNeH8U5SqKrnmWAuyjLo
EORrZCBoNkNA+ojchl43e8ggHr0JqLvZnL7RFLLfLnpHNxizbFqxzfnlT0+KpHDR
u+4ckUlCfJXWML5HCGq4xVTHu7DeM73MrQX7dAGlkLfTX6YL0AufrnrcbhVzpL3T
G/GpqlPlYpNRFsImcFh8Fk2auY0CbeXljcPtPqvroiBmJr2qs0FYIzCF81aq9QAN
lJsfDrf9FH2S6iIbdrkzYRf5JKyqemgkzbRUXob+3EqWnPqSq3BM0FBlqdQW4XTx
ug1H9Nj3cjnp7y5RPfVL24eW3pEE5GAzxq81tgafK9Qj/3uAmPa+5gJMo6J+JuoK
3dpG8AXexCULF0RFlFShD6tC6fzcs6Vig1Fif4Qmx2fnOmeOGPlE1DBA9qlj3Lui
poXfVZRlewdVFWRC1T0oB+CKkT6GXXysF4NA+dp+fYHZtjUMGMFlaoElh8vuzLdO
pHQzpmdBw3cbEMVIjxZ8k80utBaAAtIuT7W7CycwSzIq0EkUDUXTFsAK829/9n2Q
SvmAF3NTmqWi/mhSsb4WLrxD+TkXuYUrczyQfiK8SB+6HnQSCmpIWXQbhwYTpu/l
dAOOf/uV9N2NybzfRk9UuxcE4nUjYQXw04We4DzE+52AmTlBWzU=
=ntsD
-----END PGP SIGNATURE-----

--uownwn2qz3fjurl6--
