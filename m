From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: 2.6.29 PM and CPUIDLE
Date: Fri, 10 Apr 2009 16:11:35 -0700
Message-ID: <8763hc2jfc.fsf@deeprootsystems.com>
References: <200904101654.58917.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:40444 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbZDJXLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 19:11:38 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1255328wff.4
        for <linux-omap@vger.kernel.org>; Fri, 10 Apr 2009 16:11:38 -0700 (PDT)
In-Reply-To: <200904101654.58917.jpihet@mvista.com> (Jean Pihet's message of "Fri\, 10 Apr 2009 16\:54\:58 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jean Pihet <jpihet@mvista.com> writes:

> I am having problems using CPUIDLE PM_SLEEP on Beagleboard with the
> latest pm tree.  It looks like CPUIDLE prevents the system to go
> into retention mode, while it works fine without CPUIDLE enabled:

It's a feature. ;)

> root@beagleboard:~# echo 1 > /sys/power/clocks_off_while_idle
> root@beagleboard:~# echo mem > /sys/power/state

Try this:

# echo 1 > /sys/power/sleep_while_idle

And then try to suspend.  I think this should work (you may have to
wait a little just so you hit the idle loop before trying suspend.)

What's happening is that without sleep_while_idle set, CPUidle will
not go into any other state than C1 (see the omap3_can_sleep() check.)
Recently, C1 was changed to keep the MPU and CORE ON to have the a
very fast wakeup latency.  So, with CPUidle running, the next power
states are set to ON in the idle path and never tested/changed in the
suspend path.

The bug is that the suspend path should always ensure that either RET
or OFF is set in the next states (depending on enable_off_mode.)  This
was not necessary before the new C1 was added because all of the idle
states at least tried for RET.

Kevin

> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.02 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (dss_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> Restarting tasks ... done.
>
> The registers dump shows the next power state in PM_PWSTCTRL is set to ON 
> instead of RET for MPU and CORE. Furthermore DSS is not reaching RET (stays 
> ON).
>
> Are the CPUIDLE and suspend/resume features compatible with each other? Am I 
> missing something, e.g. a way to change the behavior from /sys?
>
> Regards,
> Jean
