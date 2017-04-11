From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: core: Add a back up thermal shutdown mechanism
Date: Tue, 11 Apr 2017 10:29:20 -0700
Message-ID: <20170411172918.GA5193@localhost.localdomain>
References: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490941820-13511-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Mar 31, 2017 at 12:00:20PM +0530, Keerthy wrote:
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

OK... This seams to me, still a corner case supposed to be fixed at
orderly_power_off, not at thermal. But..

>=20
> However, there is no clean way of detecting such failure of userspace
> powering off the system. In such scenarios, it is necessary for a backup
> workqueue to be able to force a shutdown of the system when orderly
> shutdown is not successful after a configurable time period.
>=20

Given that system running hot is a thermal issue, I guess we care more
on this matter then..

> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/Kconfig        | 13 +++++++++++++
>  drivers/thermal/thermal_core.c | 42 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 0a16cf4..4cc55f9 100644
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
> index 11f0675..dc7fdd4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -322,6 +322,47 @@ static void handle_non_critical_trips(struct thermal=
_zone_device *tz,
>  		       def_governor->throttle(tz, trip);
>  }
> =20
> +/**
> + * emergency_poweroff_func - emergency poweroff work after a known delay
> + * @work: work_struct associated with the emergency poweroff function
> + *
> + * This function is called in very critical situations to force
> + * a kernel poweroff after a configurable timeout value.
> + */
> +static void emergency_poweroff_func(struct work_struct *work)
> +{
> +	/**
> +	 * We have reached here after the emergency thermal shutdown
> +	 * Waiting period has expired. This means orderly_poweroff has
> +	 * not been able to shut off the system for some reason.
> +	 * Try to shut down the system immediately using pm_power_off
> +	 * if populated
> +	 */

The above is not a kernel doc entry...

> +	pr_warn("Attempting kernel_power_off\n");
> +	if (pm_power_off)
> +		pm_power_off();

Why not calling kernel_power_off() directly instead? That is what is called=
 by orderly
power off in case it fails, which seams to be  the missing part when
user land returns success, and therefore we don't call
kernel_power_off(). That path goes through the machine_power_off(),
which seams to be the default for pm_power_off() anyway.

kernel_power_off() handles the power off system call too.

> +
> +	/**

not a kernel doc entry...

> +	 * Worst of the worst case trigger emergency restart
> +	 */
> +	pr_warn("kernel_power_off has failed! Attempting emergency_restart\n");
> +	emergency_restart();
> +}
> +
> +static DECLARE_DELAYED_WORK(emergency_poweroff_work, emergency_poweroff_=
func);
> +
> +/**
> + * emergency_poweroff - Trigger an emergency system poweroff
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
> @@ -343,6 +384,7 @@ static void handle_critical_trips(struct thermal_zone=
_device *tz,
>  			  "critical temperature reached(%d C),shutting down\n",
>  			  tz->temperature / 1000);
>  		orderly_poweroff(true);
> +		thermal_emergency_poweroff();

Shouldn't we start count the timeout before calling orderly_poweroff?

>  	}
>  }
> =20
> --=20
> 1.9.1
>=20

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7RJmAAoJEA6VkvSQfF5TYb8QAKm2Vut62Jn6z7VmKqyG95Zc
/DCGOsNymwFJyo6co5B3RWgGW+LbPFBWgSHimDjcVWQkP8r9fmwJDsWyvhudlRaI
tInWf7a7U+yugnpnQQhtZ3RW+wYEbmAOnHWkfwBZlQ0rAXKFJPCCYHz6poKUiOGJ
hoPK3Wp8SnWhUra0LgiQZMMsqvrq7ZE/TqOjZDIkGk/dMsPJlE3yWdk2A7mDL5so
3wcHW5scOKrxD3TueERaKknnMEuGeOvsYVxsDZ4WOhtH+TFWEY79zHBkDljS0tiZ
6/2xA0ocqCQR8xY0xiARbgpCB5rC3wPr2pjEzjEbcQylMKS0K5hdwkd/2oArUTuw
gJhAsTQR9D21MHYiITERBLwsrYYsZaTj09spqYWJ/jREoUim4uN0I9JquBrqC2Zm
3ij4Lgw6wynXswfLOtP4O3x6V6qbvvmd8z/v3VvQ/4myLH8oVcdsR6q98MFD2y3l
k3Gao1FjiROfCAvSAyhdPJprZNtf+00O+v1/YWe6QnAiTy4PTioi3tTgvvIfFi4J
/iAXvXAzGr22QCZ8k7uOHgkMo2104N7TkIJURUw2YyYZJefGAElrDd1okfaHDRTn
ri/7Kk+b+qUAxwvHgNbFeQMUwN3s+T9P3FoHSb40zkPafrycx+2YkCCBd0+7c9C9
4NJ1K2tDLMjYXZaIciyh
=ZmWv
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
