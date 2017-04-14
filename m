From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: core: Add a back up thermal shutdown
 mechanism
Date: Thu, 13 Apr 2017 23:03:55 -0700
Message-ID: <20170414060353.GB19715@localhost.localdomain>
References: <1492147105-26692-1-git-send-email-j-keerthy@ti.com>
 <1492147105-26692-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492147105-26692-2-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Apr 14, 2017 at 10:48:25AM +0530, Keerthy wrote:
> orderly_poweroff is triggered when a graceful shutdown
> of system is desired. This may be used in many critical states of the
> kernel such as when subsystems detects conditions such as critical
> temperature conditions. However, in certain conditions in system
> boot up sequences like those in the middle of driver probes being
> initiated, userspace will be unable to power off the system in a clean
> manner and leaves the system in a critical state. In cases like these,
> the /sbin/poweroff will return success (having forked off to attempt
> powering off the system. However, the system overall will fail to
> completely poweroff (since other modules will be probed) and the system
> is still functional with no userspace (since that would have shut itself
> off).
>=20
> However, there is no clean way of detecting such failure of userspace
> powering off the system. In such scenarios, it is necessary for a backup
> workqueue to be able to force a shutdown of the system when orderly
> shutdown is not successful after a configurable time period.
>=20
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>=20
> Changes in v3:
>=20
>   * Removed unnecessary mutex init.
>   * Added WARN messages instead of a simple warning message.
>   * Added Documentation.
>=20
>  Documentation/thermal/sysfs-api.txt | 18 +++++++++++++++
>  drivers/thermal/Kconfig             | 13 +++++++++++
>  drivers/thermal/thermal_core.c      | 45 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 76 insertions(+)

Cool!

Just minor comments..

>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index ef473dc..94b707c 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -582,3 +582,21 @@ platform data is provided, this uses the step_wise t=
hrottling policy.
>  This function serves as an arbitrator to set the state of a cooling
>  device. It sets the cooling device to the deepest cooling state if
>  possible.
> +
> +6. thermal_emergency_poweroff:
> +
> +On an event of critical trip temperature crossing. Thermal framework
> +allows the system to shutdown gracefully by calling orderly_poweroff.
> +In the event of a failure of orderly_poweroff to shut down the system
> +we are in danger of keeping the system alive at undesirably high
> +temperatures. To mitigate this high risk scenario we program a work
> +queue to fire after a pre-determined number of seconds to start
> +an emergency shutdown of the device using the kernel_power_off
> +function.
> +
> +The delay should be carefully profiled so as to give adequate time for
> +orderly_poweroff. In case of failure of an orderly_poweroff the
> +emergency poweroff kicks in after the delay has elapsed and shuts down
> +the system.

Can you mark functions with () in the above, e.g., orderly_poweroff().

Also, you did not mention about the call to emergency_reset();

> +
> +If set to 0 emergency poweroff will happen immediately.
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9347401..971fd54 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -15,6 +15,19 @@ menuconfig THERMAL
> =20
>  if THERMAL
> =20
> +config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
> +	int "Emergency poweroff delay in milli-seconds"
> +	depends on THERMAL
> +	default 0
> +	help
> +	  The number of milliseconds to delay before emergency
> +	  poweroff kicks in. The delay should be carefully profiled
> +	  so as to give adequate time for orderly_poweroff. In case
> +	  of failure of an orderly_poweroff the emergency poweroff
> +	  kicks in after the delay has elapsed and shuts down the system.
> +
> +	  If set to 0 poweroff will happen immediately.
> +
>  config THERMAL_HWMON
>  	bool
>  	prompt "Expose thermal sensors as hwmon device"
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 9cad1ba..30098cd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -323,6 +323,46 @@ static void handle_non_critical_trips(struct thermal=
_zone_device *tz,
>  		       def_governor->throttle(tz, trip);
>  }
> =20
> +/**
> + * emergency_poweroff_func - emergency poweroff work after a known delay

s/emergency_poweroff_func/thermal_emergency_poweroff_func/g

> + * @work: work_struct associated with the emergency poweroff function
> + *
> + * This function is called in very critical situations to force
> + * a kernel poweroff after a configurable timeout value.
> + */
> +static void emergency_poweroff_func(struct work_struct *work)
> +{
> +	/*
> +	 * We have reached here after the emergency thermal shutdown
> +	 * Waiting period has expired. This means orderly_poweroff has
> +	 * not been able to shut off the system for some reason.
> +	 * Try to shut down the system immediately using kernel_power_off
> +	 * if populated
> +	 */
> +	WARN(1, "Attempting kernel_power_off: Temperature too high\n");
> +	kernel_power_off();
> +
> +	/*
> +	 * Worst of the worst case trigger emergency restart
> +	 */
> +	WARN(1, "Attempting emergency_restart: Temperature too high\n");
> +	emergency_restart();
> +}
> +
> +static DECLARE_DELAYED_WORK(emergency_poweroff_work, emergency_poweroff_=
func);
> +
> +/**
> + * emergency_poweroff - Trigger an emergency system poweroff

s/emergency_poweroff/thermal_emergency_poweroff/g

> + *
> + * This may be called from any critical situation to trigger a system sh=
utdown
> + * after a known period of time. By default the delay is 0 millisecond
> + */
> +void thermal_emergency_poweroff(void)
> +{
> +	schedule_delayed_work(&emergency_poweroff_work,
> +			      msecs_to_jiffies(CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS));
> +}
> +
>  static void handle_critical_trips(struct thermal_zone_device *tz,
>  				  int trip, enum thermal_trip_type trip_type)
>  {
> @@ -346,6 +386,11 @@ static void handle_critical_trips(struct thermal_zon=
e_device *tz,
>  			  tz->temperature / 1000);
>  		mutex_lock(&poweroff_lock);
>  		if (!power_off_triggered) {
> +			/*
> +			 * Queue a backup emergency shutdown in the event of
> +			 * orderly_poweroff failure
> +			 */
> +			thermal_emergency_poweroff();
>  			orderly_poweroff(true);
>  			power_off_triggered =3D true;
>  		}
> --=20
> 1.9.1
>=20

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY8GZBAAoJEA6VkvSQfF5T5EwP/je1oL6wq9cq4IO9Sz+V+D7y
pN9/Hni+vwGJFWEdOGH3MBkjhhbAdgzkKZrDZgtbwz13ILfOQIjim+dRtVltDRKl
a+3DHzA1fL6lYKINst7hnMTPFm0lgMVxNFadPdqXWXCyfye/tr7lIHhygrmyvnNq
EtLgyAmMFF06Fr4oE+RneWvpWZrdB9sM4d5ebATp1GsRCbuw47jVKIFntRGIT71e
X9EdmYjyaW0peahhYJDk8gLnmi0XbAssvg6wy/vvqyKcxiPGFtXgeD/85fYIKqCG
iSyBbpFa8zloI1N0C5v3DwoMUVzb0Sh4VdfY+juEyN6meDpIuY/LdWlopuYjv7P6
bdb/0jRlIztHcc26eCVp0fU0nbv/Pd6t9vASixssrX48F32bgUQ63aB9LoK5Japc
oD74vNUv1euo9k4XK6Kuk8Yqu1cdCnA/HXQwfvFSXSZukGkKFAG/9rIFA849ZRGv
mJgWw/wY9RMYIx3ZYEwuhlBZD8oij+UO/rtuhePFTf/I0rjlcBJmEG2b0KStt298
VjQ3Vq3+Jmmd/xgU5bKnWetYb35RsFbtWy6zaXbOePoe74jooFGEsVxdpOgRxYHY
ajeZDYWvhe8O4NLOLoSxraUAicTkCub1IFHwTUz94kcYmP2o1V23RzTHYgS1xElW
0GGW45vr8e+2avjJyarn
=hGQS
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
