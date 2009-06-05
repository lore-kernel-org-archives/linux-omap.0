From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM error: Powerdomain (core_pwddm) didn't enter target state 1
Date: Fri, 05 Jun 2009 08:53:55 -0700
Message-ID: <87fxeebrsc.fsf@deeprootsystems.com>
References: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:65272 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZFEPx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 11:53:57 -0400
Received: by pzk1 with SMTP id 1so934379pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 08:53:58 -0700 (PDT)
In-Reply-To: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com> (Elvis Dowson's message of "Fri\, 05 Jun 2009 11\:32\:42 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

Elvis Dowson <elvis.dowson@mac.com> writes:

> Hi Kevin,
> 		  I managed to successfully incorporate all your PM
> patches to the  linux-omap-2.6 master branch, for the gumstix overo
> earth (TI OMAP  3503). I am currently using it with Tomi's DSS2 (not
> the full set, but  the dss2.patch that comes with the overo
> openembedded repository.

It's pretty difficult for me to know what you are actually running by
the description above.  You've taken a bunch of stuff, put them
together in some unspecified way, and are using an unspecified config.

> When the device goes to suspend mode, and I immediately touch the
> touch screen, to wake it up, two things happen:
>
> a. it wakes up and immediately goes back to suspend.
> b. if I touch it once more, a bit longer this time, it wakes up.
>
> However, in the console, I see the following error message:
>
> request_suspend_state: wakeup (3->0) at 14677886951 (2000-01-01
> 00:01:16.457611018 UTC)
> request_suspend_state: sleep (0->3) at 76534332261 (2000-01-01
> 00:02:18.314025810 UTC)
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: suspend devices took 0.226 seconds
> Powerdomain (mpu_pwrdm) didn't enter target state 1
> Powerdomain (neon_pwrdm) didn't enter target state 1
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (cam_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Powerdomain (usbhost_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend

Hmm, none of the powerdomains left active, so that suggests that none
of the clocks are being auto-disabled.  I'll take guess you don't have
CONFIG_OMAP_RESET_CLOCKS=y in your config.

> wakeup wake lock: mmc_delayed_work

Hmm, wake lock.  You've definitely applied android patches.

Kevin

> mmc1: mmc_rescan - card ocr from io_op=0x00000000, err = -110
> PM: resume devices took 0.531 seconds
> Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
> done.
> suspend: exit suspend, ret = 0 (2000-01-01 00:02:24.561462403 UTC)
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>
>
> What do these error messages indicate ?
