From: Kevin Hilman <khilman@ti.com>
Subject: calling runtime PM from system PM methods
Date: Wed, 01 Jun 2011 17:05:31 -0700
Message-ID: <87k4d55c8k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:45679 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754288Ab1FBAFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 20:05:36 -0400
Received: by mail-pw0-f48.google.com with SMTP id 16so274825pwi.7
        for <linux-omap@vger.kernel.org>; Wed, 01 Jun 2011 17:05:34 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org

Hi Rafael,

Once again, I'm back to some problems with using runtime PM from system
PM methods.  On OMAP, many drivers don't need to do anything different
for runtime PM compared to system PM, so the system PM methods can
simply use runtime PM.

The obvious complication arises when runtime PM is disabled from
userspace, preventing system PM.

Taking into consideration that runtime PM can be disabled from
userspace, the system PM methods need to manually call the subsystems
runtime PM callbask. An example of the resulting system PM methods can
be found in the currenty OMAP I2C driver (excerpt below[1])

This was working, but now we have device power domains which complicate
the story.  My first take was to change the system PM methods to check
the device power domain callbacks as well[2], and take care of the
precedence.  That seems OK, but it's starting to feel like extra work
for each driver that is easy to screw up, and includes some assumptions
about how the PM core works (e.g. power domain precedence.)

It also has the disadvantage of not taking into consideration the
IRQ-safe capabilities of the PM core.

Rather than adding this additional logic to every driver, what would be
best is if we could just take advantage of all the existing logic in the
runtime PM core, rather than duplicating some of it in the drivers.

The ideal case would be for system PM methods to be able to simply call
pm_runtime_get_sync/_put_sync as well, but somehow force the
transitions, even when pm_runtime_forbid() has been called.

I suspect you won't like that idea, but am curious about your opinions.

In the process of experimenting with other solutions, I found an
interesting discovery:

In the driver's ->suspend() hook, I did something like this:

	priv->forced_suspend = false;
	if (!pm_runtime_suspended(dev)) {
		pm_runtime_put_sync(dev);
		priv->forced_suspend = true;
	}

and in the resume hook I did this:

	if (priv->forced_suspend)
		pm_runtime_get_sync(dev);

Even after disabling runtime PM from userspace via
/sys/devices/.../power/control, the ->suspend() hook triggered an actual
transition.  This is because pm_runtime_forbid() just uses the usage
counter, so the _put_sync() in the ->suspend callback decrements the
counter and triggers an rpm_idle().   Is this expected behavior?

If I can count on this behavior, then the above solution seems better
than my workaround below[2], although I kinda don't like making
assumptions about how pm_runtime_forbid() is implemented.

Kevin

[1] from drivers/i2c/busses/i2c-omap.c

static int omap_i2c_suspend(struct device *dev)
{
	if (!pm_runtime_suspended(dev))
		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
			dev->bus->pm->runtime_suspend(dev);

	return 0;
}

static int omap_i2c_resume(struct device *dev)
{
	if (!pm_runtime_suspended(dev))
		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
			dev->bus->pm->runtime_resume(dev);

	return 0;
}




[2] 
static int omap_i2c_suspend(struct device *dev)
{
	int (*callback)(struct device *) = NULL;
	int ret = 0;

	if (!pm_runtime_suspended(dev)) {
		if (dev->pwr_domain)
			callback = dev->pwr_domain->ops.runtime_suspend;
		else if (dev->bus && dev->bus->pm)
			callback = dev->bus->pm->runtime_suspend;

		ret = callback(dev);
	}

	return ret;
}

static int omap_i2c_resume(struct device *dev)
{
	int (*callback)(struct device *) = NULL;
	int ret = 0;

	if (!pm_runtime_suspended(dev)) {
		if (dev->pwr_domain)
			callback = dev->pwr_domain->ops.runtime_resume;
		else if (dev->bus && dev->bus->pm)
			callback = dev->bus->pm->runtime_resume;

		ret = callback(dev);
	}

	return ret;
}

