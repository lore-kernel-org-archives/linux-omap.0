From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] I2C: Fix for suspend/resume issue in i2c-core
Date: Tue, 31 Aug 2010 12:16:11 +0100
Message-ID: <20100831111611.GF20849@rakim.wolfsonmicro.main>
References: <1283219414-8798-1-git-send-email-vishwanath.bs@ti.com>
 <87wrr83pro.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59750 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757176Ab0HaLQN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Aug 2010 07:16:13 -0400
Content-Disposition: inline
In-Reply-To: <87wrr83pro.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>

On Mon, Aug 30, 2010 at 11:43:23AM -0700, Kevin Hilman wrote:
> Vishwanath BS <vishwanath.bs@ti.com> writes:
> 
> > In current i2c core driver, pm_runtime_set_active call from i2c_device_pm_resume
> > is not balanced by pm_runtime_set_suspended call from i2c_device_pm_suspend.
> > pm_runtime_set_active called from resume path will increase the child_count of
> > the device's parent. However, matching pm_runtime_set_suspended is not called
> > in suspend routine because of which child_count of the device's parent
> > is not balanced, preventing the parent device to idle.
> > Issue has been fixed by adding pm_runtime_set_suspended call inside suspend
> > reoutine which will make sure that child_counts are balanced.
> > This fix has been tested on OMAP4430.
> >
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> >
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> 
> Also Cc'ing Mark Brown as original author of runtime PM for i2-core.

Also Jean Delvare who maintains the I2C core.  To be honest Rafael did
all the actual work here (and has since rewritten the code anyway).

> > ---
> >  drivers/i2c/i2c-core.c |   12 ++++++++++--
> >  1 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 6649176..3146bff
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -196,14 +196,22 @@ static int i2c_legacy_resume(struct device *dev)
> >  static int i2c_device_pm_suspend(struct device *dev)
> >  {
> >  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > +	int ret;
> >  
> >  	if (pm_runtime_suspended(dev))
> >  		return 0;
> >  
> >  	if (pm)
> > -		return pm->suspend ? pm->suspend(dev) : 0;
> > +		ret = pm->suspend ? pm->suspend(dev) : 0;
> > +	else
> > +		ret = i2c_legacy_suspend(dev, PMSG_SUSPEND);
> >  
> > -	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> > +	if (!ret) {
> > +		pm_runtime_disable(dev);
> > +		pm_runtime_set_suspended(dev);
> > +		pm_runtime_enable(dev);
> > +	}
> > +	return ret;
> >  }
> >  
> >  static int i2c_device_pm_resume(struct device *dev)
