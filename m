From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Mon, 1 Feb 2016 15:28:33 -0800
Message-ID: <20160201232833.GR19432@atomide.com>
References: <CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
 <20160126235222.GF19432@atomide.com>
 <CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
 <20160128165810.GA19432@atomide.com>
 <CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
 <20160201181135.GL19432@atomide.com>
 <20160201220657.GO19432@atomide.com>
 <CAJZ5v0gOtJE24Hu8R9jx7kBktmd__qFUNF_KnsCDLwgidskUvw@mail.gmail.com>
 <20160201222926.GQ19432@atomide.com>
 <CAJZ5v0jN3uK8q46N1Sp6xR2U=MpJZj=PX8uh9Kp+n75J4UZCZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jN3uK8q46N1Sp6xR2U=MpJZj=PX8uh9Kp+n75J4UZCZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [160201 15:11]:
> On Mon, Feb 1, 2016 at 11:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Rafael J. Wysocki <rafael@kernel.org> [160201 14:18]:
> >> On Mon, Feb 1, 2016 at 11:06 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> > --- a/drivers/base/power/runtime.c
> >> > +++ b/drivers/base/power/runtime.c
> >> > @@ -1419,17 +1419,25 @@ void pm_runtime_init(struct device *dev)
> >> >   */
> >> >  void pm_runtime_reinit(struct device *dev)
> >> >  {
> >> > -       if (!pm_runtime_enabled(dev)) {
> >> > -               if (dev->power.runtime_status == RPM_ACTIVE)
> >> > +       if (pm_runtime_enabled(dev))
> >> > +               return;
> >> > +
> >> > +       if (dev->power.runtime_status == RPM_ACTIVE) {
> >> > +               if (dev->power.use_autosuspend) {
> >> > +                       __pm_runtime_use_autosuspend(dev, false);
> >> > +                       pm_runtime_suspend(dev);
> >>
> >> This won't work, because runtime PM is disabled at this point.
> >
> > Hmm right OK. It does work from idling the hardware point
> > of view though..
> 
> pm_runtime_suspend() with runtime PM disabled is a NOP.  It will do
> nothing and return -EACCES.

Hmm it  makes a difference here for sure :)

> >> What about doing this instead:
> >>
> >>                if (dev->power.use_autosuspend)
> >>                        __pm_runtime_use_autosuspend(dev, false);
> >>
> >>                pm_runtime_set_suspended(dev);
> >
> > ..while this does not work. The hardware is never idled
> > in this case.
> 
> I'm not sure what you mean.  pm_runtime_set_suspended() sets the
> status to RPM_SUSPENDED for devices with runtime PM disabled.  It has
> nothing to do with "idling" in principle.

Well looking at the update_autosuspend(), it seems we're now missing
rpm_idle() call that now never happens.

Does the patch below make more sense to you where we call rpm_idle?
That seems to make things behave here also.

> > What else does __pm_runtime_use_autosuspend() set initially
> > that changes things here?
> 
> The usage counter, if the delay is negative.

Yeah I don't see any difference with those.

> I'll look at this in detail, but not right now, sorry.  I'm working on
> something else ATM and I was hoping that Ulf would be able to figure
> out what's going on here.

Yeah we need to understand what's going on here. Having the PM runtime
framework out of sync with the hardare is not good.. If we can't
figure this out we should probably revert the patch until we understand
it.

Regards,

Tony

8< ------------
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1419,17 +1419,28 @@ void pm_runtime_init(struct device *dev)
  */
 void pm_runtime_reinit(struct device *dev)
 {
-	if (!pm_runtime_enabled(dev)) {
-		if (dev->power.runtime_status == RPM_ACTIVE)
+	int (*callback)(struct device *);
+	int err;
+
+	if (pm_runtime_enabled(dev))
+		return;
+
+	if (dev->power.runtime_status == RPM_ACTIVE) {
+		if (dev->power.use_autosuspend) {
+			__pm_runtime_use_autosuspend(dev, false);
+			rpm_idle(dev, RPM_AUTO);
+		} else {
 			pm_runtime_set_suspended(dev);
-		if (dev->power.irq_safe) {
-			spin_lock_irq(&dev->power.lock);
-			dev->power.irq_safe = 0;
-			spin_unlock_irq(&dev->power.lock);
-			if (dev->parent)
-				pm_runtime_put(dev->parent);
 		}
 	}
+
+	if (dev->power.irq_safe) {
+		spin_lock_irq(&dev->power.lock);
+		dev->power.irq_safe = 0;
+		spin_unlock_irq(&dev->power.lock);
+		if (dev->parent)
+			pm_runtime_put(dev->parent);
+	}
 }
 
 /**
