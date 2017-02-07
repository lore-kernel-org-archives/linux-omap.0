From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] power: bq24190_charger: Use PM runtime autosuspend
Date: Tue, 7 Feb 2017 08:01:57 -0800
Message-ID: <20170207160157.GA21809@atomide.com>
References: <20170131000210.5442-1-tony@atomide.com>
 <20170131000210.5442-3-tony@atomide.com>
 <CAKvHMgSXVertQyZyj-C-_w72Uh7xf4DbC2rsNs_T9DMPJP2tXA@mail.gmail.com>
 <20170131003632.GB7403@atomide.com>
 <CAKvHMgTOKoeOxp0oxOBOO7zqothPWeC9aBrV-Km1Rq+YAafw5w@mail.gmail.com>
 <20170203185408.GB3721@atomide.com>
 <CAKvHMgQs3YYtyMApYvdRAyzuzii_xA=ZKRfqG-zpFzrMef_qdg@mail.gmail.com>
 <20170203211707.GC3721@atomide.com>
 <CAKvHMgRV=mm2XBtrNjQCvGXuAQY6n6xEKerP4eVw2izkS9C7ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgRV=mm2XBtrNjQCvGXuAQY6n6xEKerP4eVw2izkS9C7ww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Liam Breck <liam@networkimprov.net> [170203 16:25]:
> On Fri, Feb 3, 2017 at 1:17 PM, Tony Lindgren <tony@atomide.com> wrote:
> >  static int bq24190_remove(struct i2c_client *client)
> >  {
> >         struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
> > +       int error;
> >
> > -       pm_runtime_get_sync(bdi->dev);
> > -       bq24190_register_reset(bdi);
> > -       pm_runtime_put_sync(bdi->dev);
> > +       error = pm_runtime_get_sync(bdi->dev);
> > +       if (error < 0) {
> > +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> > +               pm_runtime_put_noidle(bdi->dev);
> > +       }
> >
> > +       bq24190_register_reset(bdi);
> >         bq24190_sysfs_remove_group(bdi);
> >         power_supply_unregister(bdi->battery);
> >         power_supply_unregister(bdi->charger);
> > +       pm_runtime_put_sync(bdi->dev);
> > +       pm_runtime_dont_use_autosuspend(bdi->dev);
> >         pm_runtime_disable(bdi->dev);
> 
> I think you addressed this, but should the above be
> 
> if (!error)
>   pm_runtime_put_sync(bdi->dev);

Hmm yeah.. But we need to check for if (error >= 0), also in the other
places see below.

Regards,

Tony

8< --------------------
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1487,7 +1487,8 @@ static int bq24190_remove(struct i2c_client *client)
 	bq24190_sysfs_remove_group(bdi);
 	power_supply_unregister(bdi->battery);
 	power_supply_unregister(bdi->charger);
-	pm_runtime_put_sync(bdi->dev);
+	if (error >= 0)
+		pm_runtime_put_sync(bdi->dev);
 	pm_runtime_dont_use_autosuspend(bdi->dev);
 	pm_runtime_disable(bdi->dev);
 
@@ -1541,7 +1542,7 @@ static int bq24190_pm_suspend(struct device *dev)
 
 	bq24190_register_reset(bdi);
 
-	if (!error) {
+	if (error >= 0) {
 		pm_runtime_mark_last_busy(bdi->dev);
 		pm_runtime_put_autosuspend(bdi->dev);
 	}
@@ -1568,7 +1569,7 @@ static int bq24190_pm_resume(struct device *dev)
 	bq24190_set_mode_host(bdi);
 	bq24190_read(bdi, BQ24190_REG_SS, &bdi->ss_reg);
 
-	if (!error) {
+	if (error >= 0) {
 		pm_runtime_mark_last_busy(bdi->dev);
 		pm_runtime_put_autosuspend(bdi->dev);
 	}
-- 
2.11.0
