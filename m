From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Allow orderly_poweroff to be called only
 once
Date: Wed, 12 Apr 2017 22:06:40 -0700
Message-ID: <20170413050637.GA7816@localhost.localdomain>
References: <1491988332-13398-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491988332-13398-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Apr 12, 2017 at 02:42:12PM +0530, Keerthy wrote:
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
> Fixes: 0c01ebbfd3caf1d ("Thermal: Remove throttling logic out of thermal_=
sys.c")

Why? how the above commit introduced this issue?

> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/thermal_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 11f0675..4e68ce0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -326,6 +326,7 @@ static void handle_critical_trips(struct thermal_zone=
_device *tz,
>  				  int trip, enum thermal_trip_type trip_type)
>  {
>  	int trip_temp;
> +	static bool power_off_triggered;
> =20

I am not convinced this change does what you say it does..

>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> =20
> @@ -338,11 +339,12 @@ static void handle_critical_trips(struct thermal_zo=
ne_device *tz,
>  	if (tz->ops->notify)
>  		tz->ops->notify(tz, trip, trip_type);
> =20
> -	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL) {
> +	if (trip_type =3D=3D THERMAL_TRIP_CRITICAL && !power_off_triggered) {
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached(%d C),shutting down\n",
>  			  tz->temperature / 1000);
>  		orderly_poweroff(true);

Imagine you have two zones about to enter critical path. thermal zone 0
first gets into critical, and at this line (btween orderly_poweroff()
and you set your flag), it gets preempted. Then thermal zone 1 also
enters the critical path, then happens to be scheduled, you essentially
end up still calling orderly_poweroff() twice, which is what this patch
is supposed to avoid.

You better simply use a lock to serialize code execution.

BR,

> +		power_off_triggered =3D true;
>  	}
>  }
> =20
> --=20
> 1.9.1
>=20

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7wdLAAoJEA6VkvSQfF5TWPAQAM9enVJhzHcvFjlaw3wKdQAb
9ALfxd0A6cF2478v0Kh/ha2upAHyHcb1Rj1guA99XlG7TJT6HG9eActsEQJ+XrVE
Fx8+A3cYs60GCx7jVSd5pUfitg25HQ1ynA9Nc2zKy/Yiw3wLYHx6HeF6GCkA8gNO
pdsfZFriUvgkMTA70xbqxvYLk8gMJOW3rLDfixt850NETTxteXfu901vnxI0rEI+
yjaL5ZRinFNPsgwn/PoFV884hMJ6TZbQ/Uy3EM1DeWesUXT/+xELHserc5tQcW1d
0RtOoSEINe+RTyf6UotzEQSkJKRGfJAswm0sKzPd2mireKkTEmsEK/el9R+oUWCj
/SsEd1y9Rx4nWta1pnvDjg1XDmzzc5xWl1a8+ju9T/BtAW9eMDEcjhpdysd500e7
KJ0rULwRgtJn7q2GxtIWXf+0o9dv4IOZg7BeJeNqMdoFkIe+VAuBxum/wjAVAGUQ
9IjGzgDoo8FjBLQgOHXy5kedqx1oeKRy+WTCC9aP8DJO5V2E0dyo25s8AL5Y7olg
e2XVBVFJ0ZyVVRfsgsm9R6uP25MaVvVVGk46MzReJg19HhPkIORW52Aj4uLDsheQ
ndSAhsg1fj/5C4+s7v/PDyLq2CdzT5tP5OqmREEOgdSnPK+ge4rEKzQ9GdaTY2XQ
qCeyLrNbQPvfRrrvab1Q
=MaBF
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
