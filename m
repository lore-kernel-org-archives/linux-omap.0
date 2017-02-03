From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Thu, 2 Feb 2017 19:44:40 -0800
Message-ID: <20170203034440.GI7403@atomide.com>
References: <20170131000210.5442-1-tony@atomide.com>
 <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com>
 <CAKvHMgTP40_YTHZn=mNNYBW5aheVNV2WskuikQeyjv3Zn27fOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgTP40_YTHZn=mNNYBW5aheVNV2WskuikQeyjv3Zn27fOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170202 17:44]:
> > @@ -427,11 +428,20 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
> >         if (!info)
> >                 return -EINVAL;
> >
> > +       ret = pm_runtime_get_sync(bdi->dev);
> > +       if (ret < 0)
> > +               return ret;
> 
> Let's not stop here if get_sync fails.

Hmm care to describe why we would want to ignore errors on pm_runtime_get()?
I don't think that's a good idea.. And for sysfs_show() output?

If these calls fail it's a sign of a serious problem somewhere
and it should be fixed instead of ignoring the errors and attempting to
continue. Ignoring errors with these calls can lead into problems that
are hard to debug.

> > @@ -1364,12 +1394,16 @@ static int bq24190_probe(struct i2c_client *client,
> >         }
> >
> >         pm_runtime_enable(dev);
> > -       pm_runtime_resume(dev);
> > +       pm_runtime_use_autosuspend(dev);
> > +       pm_runtime_set_autosuspend_delay(dev, 600);
> > +       ret = pm_runtime_get_sync(dev);
> > +       if (ret < 0)
> > +               goto out1;
> 
> Nor here 8.

Eek, let's not try to continue the probe if pm_runtime_get_fails. Let's
just assume it's either implemented and must be working, or a nop operation
that will not do anything. Depending on the implementation, this could
affect something in the hardware like pin multiplexing, parent device
clocking.. On the module exit path it might make sense as we know the
device was working to get there so it might be possible to do something :)

> We need helper funcs...
> 
> static inline int bq24190_pmrt_get(struct device* dev) {
>   int err = pm_runtime_get_sync(dev);
>   if (err < 0) {
>     dev_warn(dev, "pm_runtime_get failed: %i\n", err);
>     pm_runtime_put_noidle(dev);
>   }
>   return err;
> }
> 
> static inline void bq24190_pmrt_put(struct device* dev, int err) {
>   if (!err) {
>     pm_runtime_mark_last_busy(dev);
>     pm_runtime_put_autosuspend(dev);
>   }
> }

If you want to implement something like that it should probably be
done in a Linux generic way. There's still quite a bit boilerplate
code needed for the autosuspend usage.

Regards,

Tony
