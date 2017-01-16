From: Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH 6/6] power: bq24190_charger: Use PM runtime autosuspend
Date: Mon, 16 Jan 2017 12:22:01 -0700
Message-ID: <20170116192201.GJ27262@animalcreek.com>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-7-tony@atomide.com>
 <CAKvHMgTv8uXxRKXp6dnu9QGquB0o7hHXCzVHiKBdCf3ag=mmnQ@mail.gmail.com>
 <20170112154626.GC2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170112154626.GC2630@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 12, 2017 at 07:46:26AM -0800, Tony Lindgren wrote:
> * Liam Breck <liam@networkimprov.net> [170111 18:03]:
> > On Wed, Jan 11, 2017 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > @@ -1119,7 +1148,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
> > >                 ret = -EINVAL;
> > >         }
> > 
> > pm_runtime_get_sync() in this function needs its return value checked.
> 
> OK will check.

Tony, if you add the check, feel free to add my Acked-by:

Acked-by: Mark Greer <mgreer@animalcreek.com>
