From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] bq24190_charger: Fix PM runtime use for
 bq24190_battery_set_property
Date: Fri, 25 Nov 2016 05:34:22 -0800
Message-ID: <20161125133421.GO4082@atomide.com>
References: <20161115033831.7620-1-tony@atomide.com>
 <20161123223533.gmt7joee3kzhjk5p@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123223533.gmt7joee3kzhjk5p@earth>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [161123 14:35]:
> Hi,
> 
> On Mon, Nov 14, 2016 at 07:38:31PM -0800, Tony Lindgren wrote:
> > There's a typo, it should do pm_runtime_get_sync, not put.
> > 
> > Cc: Mark A. Greer <mgreer@animalcreek.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/power/supply/bq24190_charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -1141,7 +1141,7 @@ static int bq24190_battery_set_property(struct power_supply *psy,
> >  
> >  	dev_dbg(bdi->dev, "prop: %d\n", psp);
> >  
> > -	pm_runtime_put_sync(bdi->dev);
> > +	pm_runtime_get_sync(bdi->dev);
> >  
> >  	switch (psp) {
> >  	case POWER_SUPPLY_PROP_ONLINE:
> 
> Thanks, queued to power-supply's for-next branch. I added
> 
> Fixes: d7bf353fd0aa3

Thanks!

Tony

