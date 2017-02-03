From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Fri, 3 Feb 2017 14:28:13 -0800
Message-ID: <20170203222812.GA3900@atomide.com>
References: <20170131000210.5442-1-tony@atomide.com>
 <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com>
 <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
 <20170203185408.GB3721@atomide.com>
 <CAKvHMgQs3YYtyMApYvdRAyzuzii_xA=ZKRfqG-zpFzrMef_qdg@mail.gmail.com>
 <20170203211707.GC3721@atomide.com>
 <CAKvHMgQwhm3pBupBj8KFLwyhZpdeHtMyKj3BardbKpcAy_qXfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgQwhm3pBupBj8KFLwyhZpdeHtMyKj3BardbKpcAy_qXfg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170203 13:46]:
> On Fri, Feb 3, 2017 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Cc: Liam Breck <kernel@networkimprov.net>
> > Acked-by: Mark Greer <mgreer@animalcreek.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Liam Breck <kernel@networkimprov.net>

Thanks for looking though it.

> > @@ -1492,15 +1553,25 @@ static int bq24190_pm_resume(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +       int error;
> >
> >         bdi->f_reg = 0;
> >         bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > +       error = pm_runtime_get_sync(bdi->dev);
> > +       if (error < 0) {
> > +               pm_runtime_put_noidle(bdi->dev);
> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> > +       }
> 
> Last nitpick: call put_noidle after dev_warn, as in suspend :-)

Sure, will do that and repost v3 of both patches shortly.

Regards,

Tony
