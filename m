From: Kevin Hilman <khilman@ti.com>
Subject: Re: pm_runtime_suspended() can be false if RPM_SUSPENDED
Date: Mon, 11 Jul 2011 13:14:58 -0700
Message-ID: <874o2sy3p9.fsf@ti.com>
References: <871uy0733n.fsf@ti.com> <201107091219.06089.rjw@sisk.pl>
	<87fwmcy624.fsf@ti.com> <201107112202.48280.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42187 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794Ab1GKUPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 16:15:03 -0400
Received: by mail-iw0-f171.google.com with SMTP id 34so5130896iwn.2
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 13:15:02 -0700 (PDT)
In-Reply-To: <201107112202.48280.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon, 11 Jul 2011 22:02:48 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux OMAP <linux-omap@vger.kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

>> 
>> However, based on the pm_runtime_set_active() problem you mentioned
>> above, I'm not sure this will help either, since what the PM domain's
>> noirq callback will want to do will be based on the actual device
>> hardware state, not on the PM core's view of the device state.
>
> Yes.  For devices whose runtime PM is never enabled, this is quite clear
> (we must assume they are operational).  For devices whose runtime PM is
> temporarily disabled and the reenabled, it's not that clear, but at
> least for the system suspend case we may require drivers not to use
> pm_runtime_set_active/suspended() in their callbacks, so that we may
> assume that the status hasn't changed between .suspend() and .resume().
>
> So, I think your approach (to check power.runtime_status) is correct in this
> respect.

OK, I'll just directly check power.runtime_status in the noirq methods,
since at that point I always know that disable_depth > 0.

Kevin
