From: Kevin Hilman <khilman@ti.com>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Mon, 11 Jul 2011 12:24:03 -0700
Message-ID: <87fwmcy624.fsf@ti.com>
References: <871uy0733n.fsf@ti.com> <201107091219.06089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46909 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757201Ab1GKTYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 15:24:08 -0400
Received: by mail-gw0-f44.google.com with SMTP id 20so1975324gwb.31
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 12:24:07 -0700 (PDT)
In-Reply-To: <201107091219.06089.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 9 Jul 2011 12:19:05 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Hi,
>
> On Saturday, July 09, 2011, Kevin Hilman wrote:
>> Hi Rafael,
>> 
>> Just curious why pm_runtime_suspended() requires the device to be
>> enabled for it to return true:
>> 
>> static inline bool pm_runtime_suspended(struct device *dev)
>> {
>> 	return dev->power.runtime_status == RPM_SUSPENDED
>> 		&& !dev->power.disable_depth;
>> }
>> 
>> I must be misunderstanding something, but I would consider a device that
>> has been runtime suspended before runtime PM was disabled to still be
>> runtime suspended.
>
> The problem is that while the runtime PM of the device is disabled
> (ie. dev->power.disable_depth > 0), its status may be switched from
> RPM_SUSPENDED to RPM_ACTIVE on the fly, using pm_runtime_set_active()
> (and the other way around) and it doesn't reflect the real status in
> principle.  

OK, I guess this is the root of the confusion.  Namely, that
dev->power.runtime_status doesn't necessarily reflect the actual device
state.

> So it was a tough choice what to do about that and I decided
> to go with returning false (in many cases runtime PM disabled means the
> device is always operational).

And with your recent changes (pm_runtime_disable() in suspend path), it
also be very common that 

>> I just noticed this when testing with your pm-domains branch.  when I
>> noticed that an 'if (pm_runtime_suspended(dev))' check in my PM domain's
>> ->suspend_noirq() was always failing since it's after the PM core calls
>> pm_runtime_disable().  I had to change my PM domain code to only check
>> dev->power.runtime_status for it to work.
>
> Well, at this point I'm kind of cautious about changing pm_runtime_suspended(),
> so perhaps we need a separate callback returnig true in the status is
> RPM_SUSPENDED regardless of the value of power.disable_depth, like
> pm_runtime_status_suspended() or something similar.

OK, but documentation would probably be needed to describe why you might
use one vs. the other.

However, based on the pm_runtime_set_active() problem you mentioned
above, I'm not sure this will help either, since what the PM domain's
noirq callback will want to do will be based on the actual device
hardware state, not on the PM core's view of the device state.

Kevin
