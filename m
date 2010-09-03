From: "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Fri, 3 Sep 2010 23:08:50 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114DA108@dbde02.ent.ti.com>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
	<87wrr83pro.fsf@deeprootsystems.com>
	<20100831111611.GF20849@rakim.wolfsonmicro.main>
	<201009010112.11834.rjw@sisk.pl> <20100901104052.5967ca25@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100901104052.5967ca25-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]
> Sent: Wednesday, September 01, 2010 2:11 PM
> To: Rafael J. Wysocki
> Cc: Mark Brown; Kevin Hilman; Sripathy, Vishwanath; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Basak, Partha; Ben Dooks
> Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
> 
> On Wed, 1 Sep 2010 01:12:11 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, August 31, 2010, Mark Brown wrote:
> > > On Mon, Aug 30, 2010 at 11:43:23AM -0700, Kevin Hilman wrote:
> > > > Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org> writes:
> > > >
> > > > > In current i2c core driver, pm_runtime_set_active call from
> i2c_device_pm_resume
> > > > > is not balanced by pm_runtime_set_suspended call from
> i2c_device_pm_suspend.
> > > > > pm_runtime_set_active called from resume path will increase the
> child_count of
> > > > > the device's parent. However, matching pm_runtime_set_suspended is not
> called
> > > > > in suspend routine because of which child_count of the device's parent
> > > > > is not balanced, preventing the parent device to idle.
> > > > > Issue has been fixed by adding pm_runtime_set_suspended call inside
> suspend
> > > > > reoutine which will make sure that child_counts are balanced.
> > > > > This fix has been tested on OMAP4430.
> > > > >
> > > > > Signed-off-by: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
> > > > > Signed-off-by: Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>
> > > > >
> > > > > Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > > > > Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > > > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > >
> > > > Also Cc'ing Mark Brown as original author of runtime PM for i2-core.
> > >
> > > Also Jean Delvare who maintains the I2C core.  To be honest Rafael did
> > > all the actual work here (and has since rewritten the code anyway).
> >
> > Sorry for the delay.
> >
> > The fix looks reasonable to me.
> 
> I take this as an Acked-by. Patch applied, thanks.
Hi,
We are seeing one more issue even after making this fix. In summary, after first suspend/resume, CPU Idle no longer works since i2c module is active. 
Basically when the system resumed from the suspend, dpm layer (dpm_resume_end) calls device_resume which intern calls i2c_device_pm_resume (among many other calls). 
i2c_device_pm_resume calls pm_runtime_set_active which brings device to Active state and increases child_count of it's parent. Since the device is active and also it's parent child_count is non 0, these modules will prevent corresponding clock domains to go idle. This will break CPU Idle. This issue happens even if the module was in idle state before performing suspend/resume. In summary, the flow is 
1. i2c module is idle (let's assume system is idle)
2. system suspend is initiated by user
3. i2c_device_pm_suspend gets called which tries to idle i2c, but it's already idled.
4. system is suspended
5. system resumed (because of user event/timers)
6. dpm layer will call i2c_device_pm_resume
7. i2c_device_pm_resume will enable i2c device by calling pm_runtime_set_active
So at the end of suspend/resume, a device that was idled before is getting enabled unnecessarily at the end.

SO I am just wondering is there any real need to call pm_runtime_set_active in resume and pm_runtime_set_suspened in suspend functions?
I just tried suspend/resume and CPU Idle after removing these calls in i2c and it seems to function perfectly fine on OMAP4.

Regards
Vishwa






I 

> 
> >
> > > > > ---
> > > > >  drivers/i2c/i2c-core.c |   12 ++++++++++--
> > > > >  1 files changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > > > index 6649176..3146bff
> > > > > --- a/drivers/i2c/i2c-core.c
> > > > > +++ b/drivers/i2c/i2c-core.c
> > > > > @@ -196,14 +196,22 @@ static int i2c_legacy_resume(struct device *dev)
> > > > >  static int i2c_device_pm_suspend(struct device *dev)
> > > > >  {
> > > > >  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm :
> NULL;
> > > > > +	int ret;
> > > > >
> > > > >  	if (pm_runtime_suspended(dev))
> > > > >  		return 0;
> > > > >
> > > > >  	if (pm)
> > > > > -		return pm->suspend ? pm->suspend(dev) : 0;
> > > > > +		ret = pm->suspend ? pm->suspend(dev) : 0;
> > > > > +	else
> > > > > +		ret = i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > > > >
> > > > > -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > > > > +	if (!ret) {
> > > > > +		pm_runtime_disable(dev);
> > > > > +		pm_runtime_set_suspended(dev);
> > > > > +		pm_runtime_enable(dev);
> > > > > +	}
> > > > > +	return ret;
> > > > >  }
> > > > >
> > > > >  static int i2c_device_pm_resume(struct device *dev)
> > >
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> Jean Delvare
