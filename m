From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [POWER DOMAIN suspend callbacks] Observation.
Date: Tue, 23 Aug 2011 20:31:52 +0530
Message-ID: <CAAL8m4wnky-FJebTS6HpOaqZBy-FVkPuCd=htkUQkZsCvdR+qA@mail.gmail.com>
References: <4E53B6FC.8030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36886 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab1HWPCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Aug 2011 11:02:17 -0400
Received: by bke11 with SMTP id 11so157966bke.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 08:02:16 -0700 (PDT)
In-Reply-To: <4E53B6FC.8030507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Govindraj R <govindraj.raja@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On Tue, Aug 23, 2011 at 7:49 PM, Santosh <santosh.shilimkar@ti.com> wrote:
> Rafael, Kevin,
>
> On latest kernel( V3.1-rc1+), the subsystem(driver) suspend
> callbacks are not getting called because power domain callbcaks
> are populated.
>
> And as per commit 4d27e9dc{PM: Make power domain callbacks take
> precedence over subsystem ones}, it's expected bahavior.
>
> Who is suppose to call the driver suspend callback?
> Some drivers/subsystem would have state machine which needs to
> be suspended.
>
> Is the power domain suspend callback, suppose to take care of
> it ? If yes, then that seems to be missing for OMAP.
>

Looks like from

_od_suspend_noirq
      -> pm_generic_suspend_noirq
             -> __pm_generic_call(dev, PM_EVENT_SUSPEND, true);
                  -->  [..]
                      case PM_EVENT_SUSPEND:
                      callback = noirq ? pm->suspend_noirq : pm->suspend;


shouldn't we call pm_generic_suspend from _od_suspend_noirq
rather than calling pm_generic_suspend_noirq?

Since _noirq seems to call .suspend_noirq hook which
most of the them have not populated.

pm_generic_suspend* calls may fail to call legacy platform .suspend hooks?

Looks like we need below change for driver .suspend hook to be called.

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index b6b4097..c2a18ae 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -584,9 +584,9 @@ static int _od_suspend_noirq(struct device *dev)
        int ret;

        if (od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND)
-               return pm_generic_suspend_noirq(dev);
+               return pm_generic_suspend(dev);

-       ret = pm_generic_suspend_noirq(dev);
+       ret = pm_generic_suspend(dev);

        if (!ret && !pm_runtime_status_suspended(dev)) {
                if (pm_generic_runtime_suspend(dev) == 0) {
@@ -604,7 +604,7 @@ static int _od_resume_noirq(struct device *dev)
        struct omap_device *od = to_omap_device(pdev);

        if (od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND)
-               return pm_generic_resume_noirq(dev);
+               return pm_generic_resume(dev);

        if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
            !pm_runtime_status_suspended(dev)) {
@@ -613,7 +613,7 @@ static int _od_resume_noirq(struct device *dev)
                pm_generic_runtime_resume(dev);
        }

-       return pm_generic_resume_noirq(dev);
+       return pm_generic_resume(dev);
 }
 #endif

--
Thanks,
Govindraj.R
