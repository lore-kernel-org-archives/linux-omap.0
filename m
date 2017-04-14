From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/2] thermal: core: Allow orderly_poweroff to be
 called only once
Date: Thu, 13 Apr 2017 23:00:11 -0700
Message-ID: <20170414060008.GA19715@localhost.localdomain>
References: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2017 at 10:48:24AM +0530, Keerthy wrote:
> thermal_zone_device_check --> thermal_zone_device_update -->
> handle_thermal_trip --> handle_critical_trips --> orderly_poweroff
>=20
> The above sequence happens every 250/500 mS based on the configuration.
> The orderly_poweroff function is getting called every 250/500 mS.
> With a full fledged file system it takes at least 5-10 Seconds to
> power off gracefully.
>=20
> In that period due to the thermal_zone_device_check triggering
> periodically the thermal work queues bombard with
> orderly_poweroff calls multiple times eventually leading to
> failures in gracefully powering off the system.
>=20
> Make sure that orderly_poweroff is called only once.
>=20
> Reported-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Changes in v3:
>=20
>   * Changed the place where mutex was locked and unlocked.
>=20
> Changes in v2:
>=20
>   * Added a global mutex to serialize poweroff code sequence.
>=20
>  drivers/thermal/thermal_core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 11f0675..9cad1ba 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -45,6 +45,7 @@
> =20
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
> +static DEFINE_MUTEX(poweroff_lock);
> =20
>  static atomic_t in_suspend;
> =20
> @@ -326,6 +327,7 @@ static void handle_critical_trips(struct thermal_zone=
_device *tz,
>  				  int trip, enum thermal_trip_type trip_type)
>  {
>  	int trip_temp;
> +	static bool power_off_triggered;

I would prefer this to be closer to its lock. Can you please move this
to the global section?

> =20
>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> =20
> @@ -342,7 +344,12 @@ static void handle_critical_trips(struct thermal_zon=
e_device *tz,
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached(%d C),shutting down\n",
>  			  tz->temperature / 1000);
> -		orderly_poweroff(true);
> +		mutex_lock(&poweroff_lock);
> +		if (!power_off_triggered) {
> +			orderly_poweroff(true);
> +			power_off_triggered =3D true;
> +		}
> +		mutex_unlock(&poweroff_lock);
>  	}
>  }
> =20
> @@ -1463,6 +1470,7 @@ static int __init thermal_init(void)
>  {
>  	int result;
> =20
> +	mutex_init(&poweroff_lock);
>  	result =3D thermal_register_governors();
>  	if (result)
>  		goto error;
> @@ -1497,6 +1505,7 @@ static int __init thermal_init(void)
>  	ida_destroy(&thermal_cdev_ida);
>  	mutex_destroy(&thermal_list_lock);
>  	mutex_destroy(&thermal_governor_lock);
> +	mutex_destroy(&poweroff_lock);
>  	return result;
>  }
> =20
> --=20
> 1.9.1
>=20

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY8GVgAAoJEA6VkvSQfF5T034QAKndwVJrYnGPb99lttPjLuEF
NkQbdpoJDRxKCaapgvwt9n/9ktOhJf4Zvny4bRxOyhd7PVkrkwrl41YBdGstIH5h
feUwV/I7g8gTH53AU1JcJNlZsGAAu3/1aZcDxElTMaTuCuqvIAVFfd7uQkgB+rjd
2LV1Ql7feqx1L+XiasqOGRN9UErVIXffVi2QQiOj5n5T5LSV6w0KUW6uhMzOXdDH
h1ThRL6NkKCJJvHvnyCk2eRheApQlpVJJhZsvrvD7Hd2frJWmlqu0Uza5iMJOXEh
PbloogDdPtfgXYpqk6eVqiFvA1tJ0lmTY345m7xSV7qqxVfWsS89Dtwlz6jqAQ4b
Ys7l6gobsM9firpToDhRnyhdMeAMfX7lfVDcM2MwWNkduxWae6nnzlXJBYLs3dHD
PP9d3tDayDs43gT/PFyJXlVzbes7Exn8RQsO5OmvIPe8XILut3nmPhTTERYB9i/9
DzPLzBtk6gfoWvfeIhmvTvgnN4E8aUyvvnDdYOupZPZEaXyCfp4DgTevnxbVvCzI
E3rN5TqUwpYXp8McZNcS14g2qQVruKJMGpbC90gqYyGTZ/1jS+DMcvyPs8zWaxLc
Sh6gGtJ56uIEd7Re/yc45GxpqlJnrqX8ckYKiYhefMnT6jB+B0xrVKaT6x7MQNxg
Ed4fzUjMtAJgqB3mUAum
=b4PI
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
