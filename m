From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: core: Allow orderly_poweroff to be
 called only once
Date: Thu, 13 Apr 2017 08:16:01 -0700
Message-ID: <20170413151558.GA8412@localhost.localdomain>
References: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492070556-24660-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Apr 13, 2017 at 01:32:35PM +0530, Keerthy wrote:
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
> Reported-by: Nishanth Menon <nm@ti.com>

Was this reported by nm or found by you?

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Changes in v2:
>=20
>   * Added a global mutex to serialize poweroff code sequence.
>=20
>  drivers/thermal/thermal_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 11f0675..7462ae5 100644
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
> =20
>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> =20
> @@ -338,11 +340,14 @@ static void handle_critical_trips(struct thermal_zo=
ne_device *tz,
>  	if (tz->ops->notify)
>  		tz->ops->notify(tz, trip, trip_type);
> =20
> -	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL) {
> +	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL && !power_off_triggered) {
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached(%d C),shutting down\n",
>  			  tz->temperature / 1000);
> +		mutex_lock(&poweroff_lock);
>  		orderly_poweroff(true);
> +		power_off_triggered =3D true;
> +		mutex_unlock(&poweroff_lock);

The above code does not fully prevent orderly_poweroff() to be called
only once, does it?

- thermal zone 0 goes all the way in the critical path, but gets
  preempted between orderly_poweroff(true)l and power_off_triggered =3D
  true;, i.e., preempted right before setting to true, therefore,
  power_off_triggered still 0.
- thermal zone 1 also enters critical path, but will sleep at the
  power_off_lock, right?
- then thermal zone 0 gets the CPU again, finishes the critical path,
  unlocks poweroff_lock.
- thermal zone 1 is unblocked, and call again orderly_poweroff(true);



BR,
>  	}
>  }
> =20
> @@ -1463,6 +1468,7 @@ static int __init thermal_init(void)
>  {
>  	int result;
> =20
> +	mutex_init(&poweroff_lock);
>  	result =3D thermal_register_governors();
>  	if (result)
>  		goto error;
> @@ -1497,6 +1503,7 @@ static int __init thermal_init(void)
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

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY75YlAAoJEA6VkvSQfF5TWlYP/07Qb2rrZb7PxkAmCOFAmQTP
cuw6n2c741lWgNwQA2uXUOpS9qCWtmMdP9Vw4YGULJ1iDIhv2pbz5e0syp10ReWU
M9ODOosDBEvCVmDfd6AWMy8dpTlmxECETaDvDelkeLBJ6mhugrZZXDddFyiIW7AE
oVpEOPgxPfwmbkUzDQc/FdoMr1zF7F2stM4f8/j5H29BirCoQemylBJMGkmFfdq3
tKMUC9Y+K0fZwpbglMEGj0Wy3n7o/rlTewN0ACbGgJ+JZcT98Qn020egy8+7V845
8iTC8u2CaFYoHP6l/rWcWW7q82AIj0fRaV77jrM1SQ4RReWdtlTlXOPWjyseUmQO
f90zSRoiMutp+AbFRkvgrVQ6mwac99xymj49eoRpxp8cY1PNdmko6HsHz5Bz1WHe
+vN8dvCnHI05nQlRbhlo66AsNk9ji2/Krf5YBN+lW1PT4D4q0JhJrjY44UcOD2W4
8sX+QsCXjCvRT0moDxVZ3moi1shxIYvscMJG09W8zb+gMQpqj+Uq725VpI7/kXaN
Zf7e0pG0tBMnbVxkAhZVLpT3kkS6QUA7gZd6E+A6FEvc72Jy5y6M4Ld7sLrHeJ8q
eBiHaRw6cYWeogW5tKFSny0aWLsOK1pb90g8F4RZ2P/8uttY7TNjdKmWhCE0NZjx
A5fyHG2jzM/+KcfmWMid
=Rg1B
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
