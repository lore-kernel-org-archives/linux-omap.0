From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 2/2] thermal: core: Add a back up thermal shutdown
 mechanism
Date: Mon, 17 Apr 2017 10:16:18 -0700
Message-ID: <20170417171616.GA9889@localhost.localdomain>
References: <1492225709-30932-1-git-send-email-j-keerthy@ti.com>
 <1492225709-30932-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492225709-30932-2-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 15, 2017 at 08:38:29AM +0530, Keerthy wrote:
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
> Changes in v5:
>=20
>   * Mandated delay for thermal emergency poweroff to be a non-zero value.
>=20
> Changes in v4:
>=20
>   * Updated documentation
>   * changed emergency_poweroff_func to thermal_emergency_poweroff_func
>=20
> Changes in v3:
>=20
>   * Removed unnecessary mutex init.
>   * Added WARN messages instead of a simple warning message.
>   * Added Documentation.
>=20
>  Documentation/thermal/sysfs-api.txt | 21 +++++++++++++++
>  drivers/thermal/Kconfig             | 15 +++++++++++
>  drivers/thermal/thermal_core.c      | 53 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 89 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index ef473dc..98dc04f 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -582,3 +582,24 @@ platform data is provided, this uses the step_wise t=
hrottling policy.
>  This function serves as an arbitrator to set the state of a cooling
>  device. It sets the cooling device to the deepest cooling state if
>  possible.
> +
> +6. thermal_emergency_poweroff:
> +
> +On an event of critical trip temperature crossing. Thermal framework
> +allows the system to shutdown gracefully by calling orderly_poweroff().
> +In the event of a failure of orderly_poweroff() to shut down the system
> +we are in danger of keeping the system alive at undesirably high
> +temperatures. To mitigate this high risk scenario we program a work
> +queue to fire after a pre-determined number of seconds to start
> +an emergency shutdown of the device using the kernel_power_off()
> +function. In case kernel_power_off() fails then finally
> +emergency_restart() is called in the worst case.
> +
> +The delay should be carefully profiled so as to give adequate time for
> +orderly_poweroff(). In case of failure of an orderly_poweroff() the
> +emergency poweroff kicks in after the delay has elapsed and shuts down
> +the system.
> +
> +If set to 0 emergency poweroff will not be supported. So a carefully
> +profiled non-zero positive value is a must for emergerncy poweroff to be
> +triggered.
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9347401..2a748a6 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -15,6 +15,21 @@ menuconfig THERMAL
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
> +	  so as to give adequate time for orderly_poweroff(). In case
> +	  of failure of an orderly_poweroff() the emergency poweroff
> +	  kicks in after the delay has elapsed and shuts down the system.
> +
> +	  If set to 0 emergency poweroff will not be supported. So a carefully
> +	  profiled non-zero positive value is a must for emergerncy poweroff to=
 be
> +	  triggered.

Here is a suggestion for rephrase the above:

 +	help
 +	  Thermal subsystem will issue a graceful shutdown when
 +	  critical temperatures are reached using orderly_poweroff(). In
 +	  case of failure of an orderly_poweroff(), the thermal emergency powero=
ff
 +	  kicks in after a delay has elapsed and shuts down the system.
 +	  This config is number of milliseconds to delay before emergency
 +	  poweroff kicks in. Similarly to the critical trip point,
 +	  the delay should be carefully profiled so as to give adequate
 +	  time for orderly_poweroff() to finish on regular execution.
 +	  If set to 0 emergency poweroff will not be supported.
 +
 +	  In doubt, leave as 0.

> +
>  config THERMAL_HWMON
>  	bool
>  	prompt "Expose thermal sensors as hwmon device"
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 8337c27..de1f7be 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -324,6 +324,54 @@ static void handle_non_critical_trips(struct thermal=
_zone_device *tz,
>  		       def_governor->throttle(tz, trip);
>  }
> =20
> +/**
> + * thermal_emergency_poweroff_func - emergency poweroff work after a kno=
wn delay
> + * @work: work_struct associated with the emergency poweroff function
> + *
> + * This function is called in very critical situations to force
> + * a kernel poweroff after a configurable timeout value.
> + */
> +static void thermal_emergency_poweroff_func(struct work_struct *work)
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
> +static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
> +			    thermal_emergency_poweroff_func);
> +
> +/**
> + * thermal_emergency_poweroff - Trigger an emergency system poweroff
> + *
> + * This may be called from any critical situation to trigger a system sh=
utdown
> + * after a known period of time. By default the delay is 0 millisecond
> + */
> +void thermal_emergency_poweroff(void)
> +{
> +	int poweroff_delay_ms =3D CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
> +	/*
> +	 * poweroff_delay_ms must be a carefully profiled non-zero value.
> +	 * Its a must for thermal_emergency_poweroff_work to be scheduled
> +	 */
> +	if (!poweroff_delay_ms)

This cannot be negative. I think it better suits here:
 +	if (poweroff_delay_ms <=3D 0)

Let's avoid hidden unsigned round up issues here.

Despite the above, you can add my
Acked-by: Eduardo Valentin <edubezval@gmail.com>

BR,

Eduardo Valentin

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9PhZAAoJEA6VkvSQfF5T+BEQAKDwBZVe9MoSKAUQoy4dQhmz
bG4jryq2qqfOFuup4rmmzOX90696nU25VdQStKnqDMm8Kmj5Lc0AyWoX9e10JiUy
LlUYF4lMNSjxDr14Zre8vGzIiVpqGx/eGAcWKjBwXrd/g7unTw39rtFhvvGR26Ri
Ha98EqTB6jMfYaUqFsvcgVPo/p4OWo3nn6Mezuq3vCLdNdmJC6prvEjmZpPbQ/EP
6E4WCJAIXyZZD8yFGofEN3iuJdVKsc0r5ilEIDD7Jh/5Eq95Z+70gu59GvcioAKr
OdzP6byfO+ZWb3hpX+1sPFgyi33QcF6N3ptPLn4NUesTVEfv0IV+BwcFIYQ54Pse
cOZipReTyy5BtI4D4f3WStoyQpt8cZIcp0mGkxCnJjAhLlH068IkkAn3nLngYwlJ
aTpF7aAIHdwOrvTOEn5Lx9MT59HeMEeD2H+/axu6plOsq5IKW4IaanZ/99aMTmIs
rmj73pFhN81sEthyciyFr+mMEPfODTuvgM5t/LOxpP63kw0K+5cjn7B2/Ql9iaxQ
cDkBvmGYR+SHLK7yhk6nUUm7w55m2mI8cZ9CdIUyiLNxuDRKdG/jYCietSD6KfJz
NVq3iI24GmwCueEdsxpyl4IK6YPpNAGoscUJP9wF4GkjYz2Yb1BzS8LQsKdCC5Qz
FwB3YbX8WnKMofcm6Y0d
=b9B6
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
