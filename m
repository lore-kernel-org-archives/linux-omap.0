From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] power: bq24190_charger: Use PM runtime autosuspend
Date: Thu, 12 Jan 2017 07:46:26 -0800
Message-ID: <20170112154626.GC2630@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-7-tony@atomide.com>
 <CAKvHMgTv8uXxRKXp6dnu9QGquB0o7hHXCzVHiKBdCf3ag=mmnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgTv8uXxRKXp6dnu9QGquB0o7hHXCzVHiKBdCf3ag=mmnQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170111 18:03]:
> On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> > @@ -1119,7 +1148,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
> >                 ret = -EINVAL;
> >         }
> 
> pm_runtime_get_sync() in this function needs its return value checked.

OK will check.

> > -       pm_runtime_put_sync(bdi->dev);
> > +       pm_runtime_mark_last_busy(bdi->dev);
> > +       pm_runtime_put_autosuspend(bdi->dev);
> > +
> >         return ret;
> >  }
> 
> Please submit this and #5 as a separate patchset after I resubmit 1-4.

Sure that works for me.

Tony
