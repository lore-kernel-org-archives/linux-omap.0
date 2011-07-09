From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Sat, 9 Jul 2011 12:19:05 +0200
Message-ID: <201107091219.06089.rjw@sisk.pl>
References: <871uy0733n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40897 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab1GIKSO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Jul 2011 06:18:14 -0400
In-Reply-To: <871uy0733n.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

Hi,

On Saturday, July 09, 2011, Kevin Hilman wrote:
> Hi Rafael,
> 
> Just curious why pm_runtime_suspended() requires the device to be
> enabled for it to return true:
> 
> static inline bool pm_runtime_suspended(struct device *dev)
> {
> 	return dev->power.runtime_status == RPM_SUSPENDED
> 		&& !dev->power.disable_depth;
> }
> 
> I must be misunderstanding something, but I would consider a device that
> has been runtime suspended before runtime PM was disabled to still be
> runtime suspended.

The problem is that while the runtime PM of the device is disabled
(ie. dev->power.disable_depth > 0), its status may be switched from
RPM_SUSPENDED to RPM_ACTIVE on the fly, using pm_runtime_set_active()
(and the other way around) and it doesn't reflect the real status in
principle.  So it was a tough choice what to do about that and I decided
to go with returning false (in many cases runtime PM disabled means the
device is always operational).

> I just noticed this when testing with your pm-domains branch.  when I
> noticed that an 'if (pm_runtime_suspended(dev))' check in my PM domain's
> ->suspend_noirq() was always failing since it's after the PM core calls
> pm_runtime_disable().  I had to change my PM domain code to only check
> dev->power.runtime_status for it to work.

Well, at this point I'm kind of cautious about changing pm_runtime_suspended(),
so perhaps we need a separate callback returnig true in the status is
RPM_SUSPENDED regardless of the value of power.disable_depth, like
pm_runtime_status_suspended() or something similar.

Thanks,
Rafael
