From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 1/2] thermal: core: Allow orderly_poweroff to be
 called only once
Date: Fri, 14 Apr 2017 08:40:10 -0700
Message-ID: <20170414154008.GC24429@localhost.localdomain>
References: <1492159933-4213-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492159933-4213-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2017 at 02:22:12PM +0530, Keerthy wrote:
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

Not sure I have seen the above tagging before.

Anyways, Rui, please pick this one, or let me know if you prefer me to
queue it for you.

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>=20
> Changes in v4:
>=20
>   * power_off_triggered declaration together with mutex definition.
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
> index 11f0675..8337c27 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -45,8 +45,10 @@
> =20
>  static DEFINE_MUTEX(thermal_list_lock);
>  static DEFINE_MUTEX(thermal_governor_lock);
> +static DEFINE_MUTEX(poweroff_lock);
> =20
>  static atomic_t in_suspend;
> +static bool power_off_triggered;
> =20
>  static struct thermal_governor *def_governor;
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

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY8O1RAAoJEA6VkvSQfF5TJ1wP/0hUE5WXt6QJfq3KIHucZm0s
At6rA3FhtdU17/yPujosTIa90f4PIt6CvoKOKaBt2DvpF19urVhliMkKflyT1BDC
fp5+RJA6lu+2M4+nCxmEvkTDjhOQNbpjjm1tNQAkagG7pY2J/qCsgBCAOkH8U8i+
7WHz8aglqxdOUPjTUUKO4+KDIVG+NZloywCePg+B1W+FwQfNkmaFlbhYD6PpBmcK
qigc9Bh48vOdhguOzqnSxFuxh1GbGZQvGSKZNH+hb8DmOBOE0+CUTgrTd2y8Gz6t
vtzwRpp+FjjRp5P1QjYBYWPwwf4p7Jr168IOAJiW8bLfRS0khpuEEMRXJ70pxE0w
anrykjR9PyPJyOTB9DbAL1hkpX3gFJOJFYQzr5yu9P9037/b7BD69ifJWcpUltHB
UCrg8H7TBrcx0oM+lzZ6d7V/bgfhh8r9Ohutt/FVLBzG0xKKVFJBATq4PijBLeiD
quAO2z1LJ5pzo2cS9iKYk2ql4/QY2dbsDVgECUkCSfPUW1ytCGgQERjb2GsQxU2A
2hnRYlhRKLfJb4Ni1N5y6l3BZJavSCL/+XcMrhg5WnxRejCqlG06Vy0NEr5PhOho
we3WSwjxOuFoUD99yfV7qtZtFmDfv9rwZIanV9OhmQBEZRASTk++MK5g2pfQJ7Je
ox7pMxicps3DHgyQ/cea
=r9yy
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
