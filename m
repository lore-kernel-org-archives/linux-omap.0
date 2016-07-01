From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv4 1/1] thermal: core: call thermal_zone_device_update()
 after mode update
Date: Fri, 1 Jul 2016 13:57:59 -0700
Message-ID: <20160701205758.GC7814@localhost.localdomain>
References: <1466563538.2471.10.camel@intel.com>
 <1466607798-30025-1-git-send-email-edubezval@gmail.com>
 <1467181402.2194.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467181402.2194.9.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 29, 2016 at 02:23:22PM +0800, Zhang Rui wrote:
> Hi, Eduardo,
>=20
> as the locking patch set has not been in upstream yet, you should
> either fold this fix into patch 02/15, or rebase your locking patch
> series on top of this fix.

I am folding into 02/15 and resending only the new version of that
patch. Are you OK to pick it up like that?

>=20
> thanks,
> rui
>=20
> On =E4=B8=89, 2016-06-22 at 08:03 -0700, Eduardo Valentin wrote:
> > Because several drivers do the following pattern:
> > .set_mode()
> > =C2=A0=C2=A0=C2=A0...
> > =C2=A0=C2=A0=C2=A0local_data->mode =3D new_mode;
> > =C2=A0=C2=A0=C2=A0thermal_zone_device_update(tz);
> >=20
> > makes sense to simply do the thermal_zone_device_update()
> > in thermal core, after setting the new mode.
> >=20
> > Also, this patch also remove deadlocks on drivers that
> > call thermal_zone_device_update() on .set_mode(),
> > as .set_mode()=C2=A0=C2=A0is now called always with tz->lock held.
> >=20
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: "Lee, Chun-Yi" <jlee@suse.com>
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-omap@vger.kernel.org
> > Cc: platform-driver-x86@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> > Hello,
> >=20
> > V3->V4:
> > - ti-soc: Removed extra locking from TI SoC in set_mode
> > - ACPI: Kept the update on check as it is called on other places
> >=20
> > BR,
> >=20
> > Eduardo
> >=20
> > =C2=A0drivers/acpi/thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1 -
> > =C2=A0drivers/platform/x86/acerhdf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 1 -
> > =C2=A0drivers/thermal/imx_thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1 -
> > =C2=A0drivers/thermal/of-thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 5 -----
> > =C2=A0drivers/thermal/thermal_sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| 1 +
> > =C2=A0drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 5 -----
> > =C2=A06 files changed, 1 insertion(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> > index 82707f9..03c3460 100644
> > --- a/drivers/acpi/thermal.c
> > +++ b/drivers/acpi/thermal.c
> > @@ -581,7 +581,6 @@ static int thermal_set_mode(struct
> > thermal_zone_device *thermal,
> > =C2=A0		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > =C2=A0			"%s kernel ACPI thermal control\n",
> > =C2=A0			tz->tz_enabled ? "Enable" : "Disable"));
> > -		acpi_thermal_check(tz);
> > =C2=A0	}
> > =C2=A0	return 0;
> > =C2=A0}
> > diff --git a/drivers/platform/x86/acerhdf.c
> > b/drivers/platform/x86/acerhdf.c
> > index 460fa67..aee33ba 100644
> > --- a/drivers/platform/x86/acerhdf.c
> > +++ b/drivers/platform/x86/acerhdf.c
> > @@ -405,7 +405,6 @@ static inline void
> > acerhdf_enable_kernelmode(void)
> > =C2=A0	kernelmode =3D 1;
> > =C2=A0
> > =C2=A0	thz_dev->polling_delay =3D interval*1000;
> > -	thermal_zone_device_update(thz_dev);
> > =C2=A0	pr_notice("kernel mode fan control ON\n");
> > =C2=A0}
> > =C2=A0
> > diff --git a/drivers/thermal/imx_thermal.c
> > b/drivers/thermal/imx_thermal.c
> > index c5547bd..a413eb6 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -246,7 +246,6 @@ static int imx_set_mode(struct
> > thermal_zone_device *tz,
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	data->mode =3D mode;
> > -	thermal_zone_device_update(tz);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> > thermal.c
> > index b8e509c..95c47da 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -282,17 +282,12 @@ static int of_thermal_set_mode(struct
> > thermal_zone_device *tz,
> > =C2=A0{
> > =C2=A0	struct __thermal_zone *data =3D tz->devdata;
> > =C2=A0
> > -	mutex_lock(&tz->lock);
> > -
> > =C2=A0	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
> > =C2=A0		tz->polling_delay =3D data->polling_delay;
> > =C2=A0	else
> > =C2=A0		tz->polling_delay =3D 0;
> > =C2=A0
> > -	mutex_unlock(&tz->lock);
> > -
> > =C2=A0	data->mode =3D mode;
> > -	thermal_zone_device_update(tz);
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index 743df50..3d0dc30 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -100,6 +100,7 @@ mode_store(struct device *dev, struct
> > device_attribute *attr,
> > =C2=A0	mutex_lock(&tz->lock);
> > =C2=A0	result =3D tz->ops->set_mode(tz, mode);
> > =C2=A0	mutex_unlock(&tz->lock);
> > +	thermal_zone_device_update(tz);
> > =C2=A0
> > =C2=A0	if (result)
> > =C2=A0		return result;
> > diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > index 15c0a9a..5dce053 100644
> > --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> > @@ -193,19 +193,14 @@ static int ti_thermal_set_mode(struct
> > thermal_zone_device *thermal,
> > =C2=A0		return 0;
> > =C2=A0	}
> > =C2=A0
> > -	mutex_lock(&data->ti_thermal->lock);
> > -
> > =C2=A0	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
> > =C2=A0		data->ti_thermal->polling_delay =3D
> > FAST_TEMP_MONITORING_RATE;
> > =C2=A0	else
> > =C2=A0		data->ti_thermal->polling_delay =3D 0;
> > =C2=A0
> > -	mutex_unlock(&data->ti_thermal->lock);
> > -
> > =C2=A0	data->mode =3D mode;
> > =C2=A0	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> > =C2=A0					data->ti_thermal-
> > >polling_delay);
> > -	thermal_zone_device_update(data->ti_thermal);
> > =C2=A0	dev_dbg(&thermal->device, "thermal polling set for
> > duration=3D%d msec\n",
> > =C2=A0		data->ti_thermal->polling_delay);
> > =C2=A0
