From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
Date: Wed, 11 Apr 2012 12:13:00 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C3318295AE@DBDE01.ent.ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
 <20120411113537.GG12064@arwen.pp.htv.fi>
 <1BAFE6F6C881BF42822005164F1491C331829571@DBDE01.ent.ti.com>
 <20120411121056.GJ12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411121056.GJ12064-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2012 at 17:40:58, Balbi, Felipe wrote:
> On Wed, Apr 11, 2012 at 12:09:22PM +0000, Hebbar, Gururaja wrote:
> > Bablpi,
> > 
> > On Wed, Apr 11, 2012 at 17:05:38, Balbi, Felipe wrote:
> > > On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
> > > > Use SET_RUNTIME_PM_OPS macro to set runtime functions.
> > > > 
> > > > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > > > ---
> > > >  drivers/i2c/busses/i2c-omap.c |   11 ++++-------
> > > >  1 files changed, 4 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > > > index dd65416..28de1d2 100644
> > > > --- a/drivers/i2c/busses/i2c-omap.c
> > > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > > @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct device *dev)
> > > >  
> > > >  	return 0;
> > > >  }
> > > > +#endif
> > > >  
> > > >  static struct dev_pm_ops omap_i2c_pm_ops = {
> > > > -	.runtime_suspend = omap_i2c_runtime_suspend,
> > > > -	.runtime_resume = omap_i2c_runtime_resume,
> > > > +	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> > > > +			   omap_i2c_runtime_resume, NULL)
> > > >  };
> > > > -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> > > > -#else
> > > > -#define OMAP_I2C_PM_OPS NULL
> > > > -#endif
> > > 
> > > I think you should keep this define, otherwise the pm pointer will
> > > always be valid.
> > 
> > No. using SET_RUNTIME_PM_OPS will make it NULL when !CONFIG_PM_RUNTIME
> > Kindly correct me if I am wrong.
> 
> you will have a defined structure with NULL members, but the structure
> itself is still valid.

Oops. You are correct. I stand corrected.

> 
> -- 
> balbi
> 


Regards, 
Gururaja
