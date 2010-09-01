From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Wed, 1 Sep 2010 10:40:52 +0200
Message-ID: <20100901104052.5967ca25@hyperion.delvare>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
	<87wrr83pro.fsf@deeprootsystems.com>
	<20100831111611.GF20849@rakim.wolfsonmicro.main>
	<201009010112.11834.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201009010112.11834.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 1 Sep 2010 01:12:11 +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 31, 2010, Mark Brown wrote:
> > On Mon, Aug 30, 2010 at 11:43:23AM -0700, Kevin Hilman wrote:
> > > Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org> writes:
> > > 
> > > > In current i2c core driver, pm_runtime_set_active call from i2c_device_pm_resume
> > > > is not balanced by pm_runtime_set_suspended call from i2c_device_pm_suspend.
> > > > pm_runtime_set_active called from resume path will increase the child_count of
> > > > the device's parent. However, matching pm_runtime_set_suspended is not called
> > > > in suspend routine because of which child_count of the device's parent
> > > > is not balanced, preventing the parent device to idle.
> > > > Issue has been fixed by adding pm_runtime_set_suspended call inside suspend
> > > > reoutine which will make sure that child_counts are balanced.
> > > > This fix has been tested on OMAP4430.
> > > >
> > > > Signed-off-by: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
> > > > Signed-off-by: Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org>
> > > >
> > > > Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > > > Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> > > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > 
> > > Also Cc'ing Mark Brown as original author of runtime PM for i2-core.
> > 
> > Also Jean Delvare who maintains the I2C core.  To be honest Rafael did
> > all the actual work here (and has since rewritten the code anyway).
> 
> Sorry for the delay.
> 
> The fix looks reasonable to me.

I take this as an Acked-by. Patch applied, thanks.

> 
> > > > ---
> > > >  drivers/i2c/i2c-core.c |   12 ++++++++++--
> > > >  1 files changed, 10 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > > index 6649176..3146bff
> > > > --- a/drivers/i2c/i2c-core.c
> > > > +++ b/drivers/i2c/i2c-core.c
> > > > @@ -196,14 +196,22 @@ static int i2c_legacy_resume(struct device *dev)
> > > >  static int i2c_device_pm_suspend(struct device *dev)
> > > >  {
> > > >  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > > > +	int ret;
> > > >  
> > > >  	if (pm_runtime_suspended(dev))
> > > >  		return 0;
> > > >  
> > > >  	if (pm)
> > > > -		return pm->suspend ? pm->suspend(dev) : 0;
> > > > +		ret = pm->suspend ? pm->suspend(dev) : 0;
> > > > +	else
> > > > +		ret = i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > > >  
> > > > -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > > > +	if (!ret) {
> > > > +		pm_runtime_disable(dev);
> > > > +		pm_runtime_set_suspended(dev);
> > > > +		pm_runtime_enable(dev);
> > > > +	}
> > > > +	return ret;
> > > >  }
> > > >  
> > > >  static int i2c_device_pm_resume(struct device *dev)
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Jean Delvare
