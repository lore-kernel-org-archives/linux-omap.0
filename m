From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Suspend broken on 3.3?
Date: Thu, 22 Mar 2012 11:09:46 +0000
Message-ID: <WC20120322110946.6413AA@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:53925 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964788Ab2CVMOe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Mar 2012 08:14:34 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id q2MB9o40029355
	for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 11:09:56 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.3)
	with ESMTP id md50002196489.msg
	for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 11:09:51 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Is system suspend broken on stock 3.3?

I have a working stock 3.2 (with patches to fix runtime_pm for DSS2), and system suspend works just fine!

This is running on a variety of GUMSTIX boards (both OMAP3530 and AM3703-based).

I've just updated to stock 3.3 and suspend returns immediately when entered:

# echo mem > /sys/power/state
[   72.391693] PM: Syncing filesystems ... done.
[   72.397003] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   72.425201] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   72.456451] Suspending console(s) (use no_console_suspend to debug)
[   72.581695] PM: suspend of devices complete after 115.977 msecs
[   72.584594] PM: late suspend of devices complete after 2.868 msecs
[   72.612060] Successfully put all powerdomains to target state
[   72.613983] PM: early resume of devices complete after 1.770 msecs
[   72.941894] PM: resume of devices complete after 326.630 msecs
[   72.975677] Restarting tasks ... done.

I've looked in the debugfs and see:
# cat suspend_stats
success: 1
fail: 0
failed_freeze: 0
failed_prepare: 0
failed_suspend: 0
failed_suspend_noirq: 0
failed_resume: 0
failed_resume_noirq: 0
failures:
  last_failed_dev:

  last_failed_errno:    0
                        0
  last_failed_step:

# cat wakeup_sources
name            active_count    event_count     hit_count       active_since    total_time      max_time        last_change
gpio-keys       0               0               0               0               0               0               0
(null)          0               0               0               0               0               0               0
(null)          0               0               0               0               0               0               0
1-0048          0               0               0               0               0               0               0
omap_uart.3     0               0               0               0               0               0               0
omap_uart.2     0               0               0               0               0               0               0

So have no idea what is causing the wakeup.

How should I go about debugging this further?

Has anyone else tried suspend on 3.3?

I've tried this both with my custom defconfig and omap2plus_defconfig.

I do have some modifications to the GUMSTIX overo board file (minor changes like defining some extra buttons, and setting the correct LCD parameters), but I'm fairly certain these shouldn't be causing any problems...

Cheers,
Joe


