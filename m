From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: core: Add a back up thermal shutdown
 mechanism
Date: Fri, 14 Apr 2017 08:42:20 -0700
Message-ID: <20170414154219.GA25476@localhost.localdomain>
References: <1492159933-4213-1-git-send-email-j-keerthy@ti.com>
 <1492159933-4213-2-git-send-email-j-keerthy@ti.com>
 <20170414153838.GB24429@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170414153838.GB24429@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Fri, Apr 14, 2017 at 08:38:40AM -0700, Eduardo Valentin wrote:
> Hey,
>=20
> On Fri, Apr 14, 2017 at 02:22:13PM +0530, Keerthy wrote:
> > orderly_poweroff is triggered when a graceful shutdown
> > of system is desired. This may be used in many critical states of the
> > kernel such as when subsystems detects conditions such as critical
> > temperature conditions. However, in certain conditions in system
> > boot up sequences like those in the middle of driver probes being
> > initiated, userspace will be unable to power off the system in a clean
> > manner and leaves the system in a critical state. In cases like these,
> > the /sbin/poweroff will return success (having forked off to attempt
> > powering off the system. However, the system overall will fail to
> > completely poweroff (since other modules will be probed) and the system
> > is still functional with no userspace (since that would have shut itself
> > off).
> >=20
> > However, there is no clean way of detecting such failure of userspace
> > powering off the system. In such scenarios, it is necessary for a backup
> > workqueue to be able to force a shutdown of the system when orderly
> > shutdown is not successful after a configurable time period.
> >=20
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >=20
> > Changes in v4:
> >=20
> >   * Updated documentation
> >   * changed emergency_poweroff_func to thermal_emergency_poweroff_func
> >=20
> > Changes in v3:
> >=20
> >   * Removed unnecessary mutex init.
> >   * Added WARN messages instead of a simple warning message.
> >   * Added Documentation.
> >=20
> >  Documentation/thermal/sysfs-api.txt | 19 +++++++++++++++
> >  drivers/thermal/Kconfig             | 13 +++++++++++
> >  drivers/thermal/thermal_core.c      | 46 +++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 78 insertions(+)
> >=20
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therma=
l/sysfs-api.txt
> > index ef473dc..e73cc12 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -582,3 +582,22 @@ platform data is provided, this uses the step_wise=
 throttling policy.
> >  This function serves as an arbitrator to set the state of a cooling
> >  device. It sets the cooling device to the deepest cooling state if
> >  possible.
> > +
> > +6. thermal_emergency_poweroff:
> > +
> > +On an event of critical trip temperature crossing. Thermal framework
> > +allows the system to shutdown gracefully by calling orderly_poweroff().
> > +In the event of a failure of orderly_poweroff() to shut down the system
> > +we are in danger of keeping the system alive at undesirably high
> > +temperatures. To mitigate this high risk scenario we program a work
> > +queue to fire after a pre-determined number of seconds to start
> > +an emergency shutdown of the device using the kernel_power_off()
> > +function. In case kernel_power_off() fails then finally
> > +emergency_restart() is called in the worst case.
> > +
> > +The delay should be carefully profiled so as to give adequate time for
> > +orderly_poweroff(). In case of failure of an orderly_poweroff() the
> > +emergency poweroff kicks in after the delay has elapsed and shuts down
> > +the system.
> > +
> > +If set to 0 emergency poweroff will happen immediately.
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 9347401..0dd5b85 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -15,6 +15,19 @@ menuconfig THERMAL
> > =20
> >  if THERMAL
> > =20
> > +config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
> > +	int "Emergency poweroff delay in milli-seconds"
> > +	depends on THERMAL
> > +	default 0
>=20
> Only now I realized that merging this may break the working
> orderly_poweroff() out there, because you are defaulting this to 0, no
> delay, therefore giving no time for orderly_poweroff() to finish. This
> is not good.
>=20
> I think using 0 delay as immediate power off is not good as we give no
> time for graceful shutdown, and by default. My suggestion here
> is to use 0 delay as no forced shutdown. Meaning, by default, this
> feature is disabled, and all other systems out there, despite DRA7 with
> arago over NFS, work as before.
>=20
> > +	help
> > +	  The number of milliseconds to delay before emergency
> > +	  poweroff kicks in. The delay should be carefully profiled
> > +	  so as to give adequate time for orderly_poweroff(). In case
> > +	  of failure of an orderly_poweroff() the emergency poweroff
> > +	  kicks in after the delay has elapsed and shuts down the system.
> > +
> > +	  If set to 0 poweroff will happen immediately.
> > +
> >  config THERMAL_HWMON
> >  	bool
> >  	prompt "Expose thermal sensors as hwmon device"
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 8337c27..aed614d 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -324,6 +324,47 @@ static void handle_non_critical_trips(struct therm=
al_zone_device *tz,
> >  		       def_governor->throttle(tz, trip);
> >  }
> > =20
> > +/**
> > + * thermal_emergency_poweroff_func - emergency poweroff work after a k=
nown delay
> > + * @work: work_struct associated with the emergency poweroff function
> > + *
> > + * This function is called in very critical situations to force
> > + * a kernel poweroff after a configurable timeout value.
> > + */
> > +static void thermal_emergency_poweroff_func(struct work_struct *work)
> > +{
> > +	/*
> > +	 * We have reached here after the emergency thermal shutdown
> > +	 * Waiting period has expired. This means orderly_poweroff has
> > +	 * not been able to shut off the system for some reason.
> > +	 * Try to shut down the system immediately using kernel_power_off
> > +	 * if populated
> > +	 */
> > +	WARN(1, "Attempting kernel_power_off: Temperature too high\n");
> > +	kernel_power_off();
> > +
> > +	/*
> > +	 * Worst of the worst case trigger emergency restart
> > +	 */
> > +	WARN(1, "Attempting emergency_restart: Temperature too high\n");
> > +	emergency_restart();
> > +}
> > +
> > +static DECLARE_DELAYED_WORK(thermal_emergency_poweroff_work,
> > +			    thermal_emergency_poweroff_func);
> > +
> > +/**
> > + * thermal_emergency_poweroff - Trigger an emergency system poweroff
> > + *
> > + * This may be called from any critical situation to trigger a system =
shutdown
> > + * after a known period of time. By default the delay is 0 millisecond
> > + */
> > +void thermal_emergency_poweroff(void)
> > +{
> > +	schedule_delayed_work(&thermal_emergency_poweroff_work,
> > +			      msecs_to_jiffies(CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS));
>=20
> So, please, only schedule if delay is greater than 0.=20

Please update documentation accordingly..


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY8O3UAAoJEA6VkvSQfF5T4ioP/1cg4jk72Y11jXkGXlPukJp3
jUSGyhJ4/SZGHF4/gUfvXqrxOJLsWf6P74QY+qHj1N6iN14XVp8/2yCLrz7uKuge
3FzkeItd0Z1kcyYa59L677wt3iPlXHNYNILWZkfG2TsYy2mhAIsE9Ov1pEDm9dGq
JA7azbmlv2ijsGIisgmhOSY2M5Q4VLwe2nz4bdrXQd8mfS5+XRAy0ab/8DN7p2TH
NVfku72Tju1jiHI/bnwDDYFDgebr4J2kjAnv5zGOqZtB2cb4Hp70AZsS/FbPzlBV
/9o2tScUJgT1+HaK8tKDxMjevXq5Lxri/m2uZ2E3+QIiKiSi6xGdli9v0UYTOPLl
k9US05MH0nssTpP7xmcSC5kKyBEmhwZIcQUYdTglEfJMFLRzDARIxeF2ARwmiY6P
EsV4FKVKMAJMdqLkWc6m7GFHPx8RTQ8i2uBEjlSI8nzqlSpvhhcTRyfo1tIM0bbE
tsjwPunl4fMCT+vrrua0qXmjJSnCzKTm9EuvsTy/AlTuayOc9dS+pYlb/W4ENdeu
vUG60bNjmoCqLwt1WtdvTduxsBJVkaLxZCJ2aPb/GJfglY+J2FKD3W7glfvTWloq
9qnUUwf0ikQVcNNxDKujVAtzuZJCuq1lMy4fKnUowwTKNPSGU2EppyJ/lDh2UBtT
j7baOoG8gUjt10ZPmOxZ
=fvWC
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
