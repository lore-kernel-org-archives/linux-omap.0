From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 13:51:09 -0800
Message-ID: <20160203215109.GO19432@atomide.com>
References: <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
 <20160202163536.GU19432@atomide.com>
 <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
 <20160202234145.GC19432@atomide.com>
 <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
 <20160203162705.GG19432@atomide.com>
 <CAPDyKFrsbW+vOoKBDvkNbJa=aUZE1EcikCqrAuO4cv+TkW-FnA@mail.gmail.com>
 <20160203182828.GM19432@atomide.com>
 <CAPDyKFonA4AAzx9JaQ2NZViMLvCjoa5vy2WRuhEF_5Hg8gPKeg@mail.gmail.com>
 <20160203184504.GN19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160203184504.GN19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160203 10:46]:
> * Ulf Hansson <ulf.hansson@linaro.org> [160203 10:38]:
> > On 3 February 2016 at 19:28, Tony Lindgren <tony@atomide.com> wrote:
> > > * Ulf Hansson <ulf.hansson@linaro.org> [160203 10:03]:
> > >>
> > >> One more thing though. I just realized that you have yet another issue
> > >> to consider going for the approach fixing *only* drivers.
> > >>
> > >> Let me summarize it here:
> > >>
> > >> If userspace has prevented runtime PM (pm_runtime_forbid()) when a
> > >> driver becomes unbound, the driver will not be able to suspend the
> > >> device by using any of the pm_runtime_suspend() APIs, as the usage
> > >> count is isn't zero.
> > >>
> > >> As pm_runtime_reinit() is invoked as part of the driver unbind
> > >> sequence, the runtime PM status goes out of sync. A following driver
> > >> rebind will then trigger the warning when the PM domain's
> > >> ->runtime_resume() callback gets invoked. Again, forever preventing
> > >> the device from being runtime suspended.
> > >
> > > Hmm yeah that's a good point.
> > >
> > >> How do you intend to solve this case?
> > >> I guess there are two options, pick up the patch I posted for omap
> > >> hwmod or make use of pm_runtime_force_suspend() in the driver.
> > >
> > > My gut feeling right now is we should just have
> > > BUS_NOTIFY_UNBIND_DRIVER shut down the device on the interconnect
> > > automatically as it's unused after the driver has unloaded :)
> > 
> > BUS_NOTIFY_UNBIND_DRIVER is sent prior the ->remove() callbacks is
> > invoked from driver core.
> > So if the driver requires to do a pm_runtime_get_sync() during
> > ->remove() callback, this won't work.
> > 
> > BUS_NOTIFY_UNBOUND_DRIVER may work though.
> 
> Right sorry that's what I meant. Naturally we can't do it before
> remove :)
> 
> I'll take a look.

This patch below seems to fix this issue. I'll do some more
testing here and send the driver fixes and this with proper
commit messages. Thanks for letting me know about that one!

Regards,

Tony

8< -------------------
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -191,12 +191,22 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od;
+	int err;
 
 	switch (event) {
 	case BUS_NOTIFY_DEL_DEVICE:
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		od = to_omap_device(pdev);
+		if (od && (od->_state == OMAP_DEVICE_STATE_ENABLED)) {
+			dev_info(&pdev->dev, "enabled after unload, idling\n");
+			err = omap_device_idle(pdev);
+			if (err)
+				dev_err(&pdev->dev, "failed to idle\n");
+		}
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
